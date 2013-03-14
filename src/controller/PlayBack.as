package controller 
{
	import model.AudioBuffer;
	import org.robotlegs.mvcs.Command;
	import service.IAudioService;
	
	/**
	 * ...
	 * @author Gaz Williams
	 */
	public class PlayBack extends Command 
	{
		
		[Inject]
		public var audioService:IAudioService;
		
		[Inject]
		public var _model:AudioBuffer;
		
		public function PlayBack() 
		{
			super();
		}
		
		override public function execute():void 
		{
			audioService.playBackward(_model.content);
		}
		
	}

}