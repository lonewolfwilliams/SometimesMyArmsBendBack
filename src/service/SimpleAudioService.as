package service 
{
	import flash.events.Event;
	import flash.events.SampleDataEvent;
	import flash.events.TimerEvent;
	import flash.media.Microphone;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import org.robotlegs.mvcs.Actor;
	/**
	 * ...
	 * @author Gaz Williams
	 * 
	 * concrete implementation wraps the flash Audio API for microphone recording and playback
	 * 
	 * uses pitch playback implemntation from Andre Michelle
	 * added FFT implementation from Gary Beaureguard
	 * 
	 */
	public class SimpleAudioService extends Actor implements IAudioService
	{
		private static var m_bufferEvent:AudioServiceEvent = new AudioServiceEvent(AudioServiceEvent.RECORDING_FFT_DATA);
		private static var BLOCK_SIZE:uint = 4096;
		
		private var mic:Microphone;
		
		//------------------------------------------------------------------------------------------------
		//FFT implmentation: http://gerrybeauregard.wordpress.com/2010/08/06/real-time-spectrum-analysis/
		//------------------------------------------------------------------------------------------------
		
		private const SAMPLE_RATE:Number = 44100;	// Actual microphone sample rate (Hz)
		private const LOGN:uint = 11;				// Log2 FFT length
		private const N:uint = 1 << LOGN;			// FFT Length
		private const BUF_LEN:uint = N;				// Length of buffer for mic audio
		
		private const UPDATE_PERIOD:int = 50;		// Period of spectrum updates (ms)
		private var m_timer:Timer;					// Timer for updating spectrum
		
		private var m_fft:FFT2;						// FFT object
		
		private var m_tempRe:Vector.<Number>;		// Temporary buffer - real part
		private var m_tempIm:Vector.<Number>;		// Temporary buffer - imaginary part
		private var m_mag:Vector.<Number>;			// Magnitudes (at each of the frequencies below)
		private var m_freq:Vector.<Number>;			// Frequencies (for each of the magnitudes above)
		private var m_win:Vector.<Number>;			// Analysis window (Hanning)

		private var m_writePos:uint = 0;            // Position to write new audio from mic
		private var m_buf:Vector.<Number> = null; // Buffer for mic audio
		
		//------------------------------------------------------------------------------------------------
		
		//------------------------------------------------------------------------------------------------
		//sine wave generator
		//------------------------------------------------------------------------------------------------
		
		private var m_toneFrequency:Number = 12000;
		private var m_toneAmplitude:Number = 0.1;
		
		//------------------------------------------------------------------------------------------------
		
		private var _internalRecordBuffer:ByteArray = null;
		private var internalPlaybackBuffer:ByteArray = null;
		public function get internalRecordBuffer():ByteArray 
		{
			return _internalRecordBuffer;
		}
		
		private var api:Sound;
		
		private var isForward:Boolean = true;
		
		public function SimpleAudioService() 
		{
			InitialiseMicrophone();
			api = new Sound();
		}
		
		private function InitialiseVisualiser():void
		{
			var i:uint;
			
			// Set up the FFT
			m_fft = new FFT2();
			m_fft.init(LOGN);
			m_tempRe = new Vector.<Number>(N);
			m_tempIm = new Vector.<Number>(N);
			m_mag = new Vector.<Number>(N/2);
			//m_smoothMag = new Vector.<Number>(N/2);
			
			// Vector with frequencies for each bin number. Used
			// in the graphing code (not in the analysis itself).
			m_freq = new Vector.<Number>(N/2);
			for ( i = 0; i < N/2; i++ )
				m_freq[i] = i*SAMPLE_RATE/N;
			
			// Hanning analysis window
			m_win = new Vector.<Number>(N);
			for ( i = 0; i < N; i++ )
				m_win[i] = (4.0/N) * 0.5*(1-Math.cos(2*Math.PI*i/N));
			
			// Create a buffer for the input audio
			m_buf = new Vector.<Number>(BUF_LEN);
			for ( i = 0; i < BUF_LEN; i++ )
				m_buf[i] = 0.0;
		}
		
		/* INTERFACE service.IaudioService */
		
		public function record():void 
		{
			InitialiseMicrophone();
			
			if (_internalRecordBuffer === null)
			{
				_internalRecordBuffer = new ByteArray();
			}
			_internalRecordBuffer.clear();
			mic.addEventListener(SampleDataEvent.SAMPLE_DATA, recordHandler);
			
			if (m_buf === null)
			{
				InitialiseVisualiser();
			}
			
			if (m_timer === null) 
			{
				m_timer = new Timer(UPDATE_PERIOD);
			}
			m_timer.addEventListener(TimerEvent.TIMER, updateSpectrum);
			m_timer.start();
		}
		
		private function recordHandler(e:SampleDataEvent):void 
		{
			trace(e.data.length);
			while (e.data.bytesAvailable > 0)
			{
				//32bit mono
				var left:Number  = e.data.readFloat();
				var right:Number = left;
				
				//add to circular buffer for visualiser
				m_buf[m_writePos] = left;
				m_writePos = (m_writePos+1)%BUF_LEN;
				
				//32bit interleaved stereo
				_internalRecordBuffer.writeFloat(left);
				_internalRecordBuffer.writeFloat(right);
			}
		}
		
		public function stopRecording():void
		{
			trace("stopping recording");
			
			mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, recordHandler);
			m_timer.stop();
			m_timer.removeEventListener(TimerEvent.TIMER, updateSpectrum);
		}
		
		public function playForward(fromBuffer:ByteArray):void 
		{
			trace("playing forward");
			
			isForward = true;
			
			internalPlaybackBuffer = fromBuffer;
			internalPlaybackBuffer.position = 0;
			
			api.addEventListener(SampleDataEvent.SAMPLE_DATA, this.handleSampleData);
			api.play();
		}
		
		public function playBackward(fromBuffer:ByteArray):void 
		{
			trace("playing backward");
			
			isForward = false;
			
			internalPlaybackBuffer = fromBuffer;
			internalPlaybackBuffer.position = internalPlaybackBuffer.length - 8;
			
			api.addEventListener(SampleDataEvent.SAMPLE_DATA, handleSampleData);
			api.play();
		}
		
		public function stopFilePlaying():void 
		{
			trace("stopping playback");
			
			api.removeEventListener(SampleDataEvent.SAMPLE_DATA, handleSampleData);
			dispatch(new AudioServiceEvent(AudioServiceEvent.PLAYBACK_COMPLETE));
			//api.close();
		}
		public function stopTonePlaying():void 
		{
			trace("stopping tone");
			
			api.removeEventListener(SampleDataEvent.SAMPLE_DATA, generateSampleData);
			//api.close();
		}
		
		public function playToneAt(frequencyInHZ:int, amplitude:Number):void 
		{
			m_toneFrequency = frequencyInHZ;
			m_toneAmplitude = amplitude;
			api.addEventListener(SampleDataEvent.SAMPLE_DATA, generateSampleData);
			api.play();
		}
		
		/* INTERFACE service.IAudioService */
		
		private function generateSampleData(event:SampleDataEvent):void 
		{
			//from adobe docs
			for ( var c:int = 0; c < BLOCK_SIZE; c++ ) 
			{	
				var phase:Number = Number(c + event.position) / 44100 * Math.PI * 2;
				
				event.data.writeFloat(Math.sin(phase * m_toneFrequency) * m_toneAmplitude);
				event.data.writeFloat(Math.sin(phase * m_toneFrequency) * m_toneAmplitude);
			}
		}
		
		private function handleSampleData(e:SampleDataEvent):void 
		{
			var playbackBuffer:ByteArray = e.data;
			
			trace( internalPlaybackBuffer.position + " / " + internalPlaybackBuffer.length);
			
			var isError:Boolean = false;
			
			var c:int;
			var left:Number;
			var right:Number;
			
			if (true == isForward)
			{
				for ( c = 0; c < BLOCK_SIZE; c++ ) //what is the significance of 8192  it's the maximum... ?
				{		
					try
					{
						left = internalPlaybackBuffer.readFloat();
						right = internalPlaybackBuffer.readFloat();
						
						//32bit interleaved stereo
						playbackBuffer.writeFloat(left);
						playbackBuffer.writeFloat(right);
					}
					catch (err:Error)
					{
						//MonsterDebugger.trace(this, err, null, null, 0xFF0000);
						
						//write zeros
						playbackBuffer.writeFloat(0);
						playbackBuffer.writeFloat(0);
						
						isError = true;
					}
				}
			}
			else
			{
				for ( c = 0; c < BLOCK_SIZE; c++ ) //what is the significance of 8192  it's the maximum... ?
				{
					try 
					{	
						left = internalPlaybackBuffer.readFloat();
						right = internalPlaybackBuffer.readFloat();
						
						//32bit interleaved stereo
						playbackBuffer.writeFloat(left);
						playbackBuffer.writeFloat(right);
					}
					catch (err:Error)
					{
						//MonsterDebugger.trace(this, err, null, null, 0xFF0000);
						
						//write zeros
						playbackBuffer.writeFloat(0);
						playbackBuffer.writeFloat(0);
						
						isError = true;
					}
					
					internalPlaybackBuffer.position -= 16;	
				}	
			}
			
			if (isError)
			{
				this.stopFilePlaying();
			}
		}
		
		private function updateSpectrum( event:Event ):void
		{
			// Copy data from circular microphone audio
			// buffer into temporary buffer for FFT, while
			// applying Hanning window.
			var i:int;
			var pos:uint = m_writePos;
			for ( i = 0; i < N; i++ )
			{
				m_tempRe[i] = m_win[i]*m_buf[pos];
				pos = (pos+1)%BUF_LEN;
			}
			
			// Zero out the imaginary component
			for ( i = 0; i < N; i++ )
				m_tempIm[i] = 0.0;
				
			// Do FFT and get magnitude spectrum
			m_fft.run( m_tempRe, m_tempIm );
			for ( i = 0; i < N/2; i++ )
			{
				var re:Number = m_tempRe[i];
				var im:Number = m_tempIm[i];
				m_mag[i] = Math.sqrt(re*re + im*im);
			}
			
			// Convert to dB magnitude
			const SCALE:Number = 20/Math.LN10;
			for ( i = 0; i < N/2; i++ )
			{
				// 20 log10(mag) => 20/ln(10) ln(mag)
				// Addition of MIN_VALUE prevents log from returning minus infinity if mag is zero
				m_mag[i] = SCALE*Math.log( m_mag[i] + Number.MIN_VALUE );
			}
			
			// Draw the graph (reuse event to reduce overhaed in critical section)
			m_bufferEvent.payload = { magnitudes:m_mag, frequencies:m_freq };
			dispatch(m_bufferEvent);
		}	
		
		//http://suzhiyam.wordpress.com/2011/04/14/as3-microphone-record-and-save-as-wave-file/
		private function InitialiseMicrophone():void 
		{
			mic = Microphone.getMicrophone();
			mic.gain = 100;
			mic.rate = SAMPLE_RATE / 1000;
			mic.setSilenceLevel(0); //never switch off
		}
	}
}