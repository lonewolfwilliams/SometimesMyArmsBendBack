package service 
{
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Gaz Williams
	 */
	public class AudioServiceEvent extends Event 
	{
		public static const RECORDING_FFT_DATA:String = "fft data produced from recording data";
		public static const PLAYBACK_COMPLETE:String = "playback complete";
		
		public var payload:Object;
		
		public function AudioServiceEvent(type:String, payload:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this.payload = payload;
		} 
		
		public override function clone():Event 
		{ 
			return new AudioServiceEvent(type, payload, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("AudioServiceEvent", "type", "payload", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}