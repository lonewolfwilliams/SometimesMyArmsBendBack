package view.visualisers 
{
	import flash.utils.ByteArray;
	import model.AudioBufferEvent;
	import org.robotlegs.mvcs.Mediator;
	import service.AudioServiceEvent;
	import service.SimpleAudioService;
	/**
	 * ...
	 * @author LoneWolfWilliams
	 */
	public class AudioVisualiserMediator extends Mediator
	{
		[Inject]
		public var m_view:AudioVisualiser;
		
		override public function onRegister():void 
		{
			eventMap.mapListener(eventDispatcher, AudioServiceEvent.RECORDING_FFT_DATA, handleRecordingBufferUpdated);	
		}
		
		private function handleRecordingBufferUpdated(e:AudioServiceEvent):void 
		{
			var magnitudes:Vector.<Number>   = e.payload["magnitudes"] as Vector.<Number>;
			var frequencies:Vector.<Number>  = e.payload["frequencies"] as Vector.<Number>;
			m_view.ProcessAudioBuffer(magnitudes, frequencies);
		}
		
	}

}