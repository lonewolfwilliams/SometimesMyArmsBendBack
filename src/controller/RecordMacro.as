package controller 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.robotlegs.mvcs.Command;
	import service.IAudioService;
	
	/**
	 * ...
	 * @author Gaz Williams
	 * 
	 * record 5 seconds of audio
	 */
	public class RecordMacro extends Command 
	{
		[Inject]
		public var audioService:IAudioService
		
		private var timer:Timer = new Timer(Constants.RECORD_DURATION_MS, 1);
		
		override public function execute():void
		{
			audioService.record();
			
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, handleTimerComplete);
			timer.start();
		}
		
		private function handleTimerComplete(e:TimerEvent):void 
		{
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, handleTimerComplete);
			timer.reset();
			
			commandMap.execute(StopRecording);
			commandMap.execute(TransferBufferToModel);
			
			//buffer will let the framework know it has been updated
		}
		
	}

}