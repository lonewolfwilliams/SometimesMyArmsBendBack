package controller 
{
	import model.AudioLibrary;
	import org.robotlegs.mvcs.Command;
	import service.IAudioService;
	
	/**
	 * ...
	 * @author Gaz Williams
	 */
	public class Play extends Command 
	{
		[Inject]
		public var audioService:IAudioService;
		
		[Inject]
		public var _model:AudioLibrary;
		
		public function Play() 
		{
			super();
			
		}
		
		override public function execute():void 
		{
			audioService.playForward(_model.getAudio(0));
		}
		
	}

}