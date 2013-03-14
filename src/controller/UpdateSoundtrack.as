package controller 
{
	import model.DisplayModel;
	import model.DisplayModelEvent;
	import model.vo.ScreenEnum;
	import org.robotlegs.mvcs.Command;
	import service.IAudioService;
	import view.screens.Screen;
	/**
	 * ...
	 * @author LoneWolfWilliams
	 * 
	 * Currently the soundtrack is a high frequncy low amplitude 'dog whistle tone' 
	 * 
	 */
	public class UpdateSoundtrack extends Command
	{
		[Inject]
		public var audioService:IAudioService;
		
		[Inject]
		public var _model:DisplayModel;
		
		[Inject]
		public var _event:DisplayModelEvent;
		
		override public function execute():void 
		{
			var forScreen:ScreenEnum = _event.toScreen;
			
			var randomFrequency:Number = Constants.DISTURBING_TONE_BASE_FREQ + 
				Math.round(Math.random() * Constants.DISTURBING_TONE_FREQ_RANGE);
				
			if (forScreen.type == ScreenEnum.INTRO_SCREEN)
			{
				audioService.playToneAt(randomFrequency, 0.01);
			}
			else if (forScreen.type == ScreenEnum.GLITCH_SCREEN)
			{
				audioService.stopTonePlaying();
				audioService.playToneAt(randomFrequency, 0.01);
			}
			else 
			{
				audioService.stopTonePlaying();
			}
			
		}
		
	}
	
}