package controller 
{
	import org.robotlegs.mvcs.Command;
	import service.IAudioService;
	
	/**
	 * ...
	 * @author Gaz Williams
	 */
	public class StopRecording extends Command 
	{
		[Inject]
		public var _service:IAudioService;
		
		override public function execute():void 
		{
			_service.stopRecording();
		}
		
	}

}