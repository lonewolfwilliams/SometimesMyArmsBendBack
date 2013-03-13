package view.screens 
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import model.FontLibrary;
	import model.NarrativeModel;
	import model.vo.ScreenEnum;
	import view.buttons.AbstractButtonWrapper;
	import view.buttons.PlayBackButton;
	import view.buttons.PlayButton;
	import view.buttons.RecordButton;
	import view.characterInput.CharacterInput;
	import view.glitch.GlitchViewComponent;
	import view.microphone.MicrophonePermissionsDialogue;
	import view.visualisers.AudioVisualiser;
	import view.visualisers.IAudioVisualiser;
	/**
	 * ...
	 * @author Gaz Williams
	 * create views for the different screens in the game
	 */
	public class ScreenFactory 
	{	
		private static var instance:ScreenFactory;
		
		public static function getInstance():ScreenFactory 
		{
			if (instance == null) 
			{
				instance = new ScreenFactory(new SingletonBlocker());
			}
			return instance;
		}
		
		public function ScreenFactory(p_key:SingletonBlocker):void 
		{
			if (p_key == null) 
			{
				throw new Error("Error: Instantiation failed: Use ScreenFactory.getInstance() instead of new.");
			}
		}
		
		//rest of implementation
		
		public function create(screen:ScreenEnum):Screen
		{
			var screenToDecorate:Screen = new Screen();
			switch (screen.type) 
			{
				default:
				case ScreenEnum.INTRO_SCREEN:
					addIntroDecorationsTo(screenToDecorate);
				break;
				case ScreenEnum.RECORD_SCREEN:
					addRecordingDecorationsTo(screenToDecorate);
				break;
				case ScreenEnum.PLAY_SCREEN:
					addPlayDecorationsTo(screenToDecorate);
				break;
				case ScreenEnum.PLAY_BACK_SCREEN:
					addPlayBackDecorationsTo(screenToDecorate);
				break;
				case ScreenEnum.CHARACTER_ENTRY_SCREEN:
					addCharacterEntryDecorationsTo(screenToDecorate);
				break;
				case ScreenEnum.SUCCESS_SCREEN:
					addSuccessDecorationsTo(screenToDecorate);
				break;
				case ScreenEnum.GLITCH_SCREEN:
					addGlitchDecorationsTo(screenToDecorate);
				break;
			}
			
			return screenToDecorate;
		}
		
		private function addSuccessDecorationsTo(screenToDecorate:Screen):void 
		{
			var feedbackText:TextField = FontLibrary.CreateTextfield();
			feedbackText.defaultTextFormat = FontLibrary.createTextFormat();
			feedbackText.text = "And now you understand";
			screenToDecorate.addChild(feedbackText);
			
			feedbackText.x = (Constants.APP_WIDTH  - feedbackText.width) 	* 0.5;
			feedbackText.y = (Constants.APP_HEIGHT - feedbackText.height) 	* 0.5;
		}
		
		private function addCharacterEntryDecorationsTo(screen:Screen):void 
		{
			var input:CharacterInput = new CharacterInput(200, 200);
			
			screen.addChild(input);
			
			input.x = (Constants.APP_WIDTH - 200) * 0.5;
			input.y = (Constants.APP_HEIGHT - 200) * 0.5;
		}
		
		private function addPlayBackDecorationsTo(screen:Screen):void 
		{
			var _playBackButton:PlayBackButton = new PlayBackButton();
			
			screen.addChild(_playBackButton);
			
			_playBackButton.x = Constants.APP_WIDTH * 0.5;
			_playBackButton.y = Constants.APP_HEIGHT * 0.5;
		}
		
		private function addPlayDecorationsTo(screen:Screen):void 
		{
			var _playButton:PlayButton = new PlayButton();
			
			screen.addChild(_playButton);
			
			_playButton.x = Constants.APP_WIDTH * 0.5;
			_playButton.y = Constants.APP_HEIGHT * 0.5;
		}
		
		private function addRecordingDecorationsTo(screen:Screen):void 
		{
			var _recordButton:RecordButton = new RecordButton();
			screen.addChild(_recordButton);
			_recordButton.x = Constants.APP_WIDTH * 0.5;
			_recordButton.y = Constants.APP_HEIGHT * 0.5;
			
			var _microphoneVisualiser:AudioVisualiser = new AudioVisualiser();
			screen.addChild(_microphoneVisualiser);
			_microphoneVisualiser.x = _recordButton.x;
			_microphoneVisualiser.y = _recordButton.y;
		}
		
		private function addIntroDecorationsTo(screen:Screen):void 
		{
			var feedbackText:TextField = FontLibrary.CreateTextfield();
			feedbackText.defaultTextFormat = FontLibrary.createTextFormat();
			feedbackText.text = NarrativeModel.Next();
			
			var microphoneDialogue:MicrophonePermissionsDialogue = new MicrophonePermissionsDialogue();
			screen.addChild(microphoneDialogue);
			
			screen.addChild(feedbackText);
			
			feedbackText.x = (Constants.APP_WIDTH  - feedbackText.width) 	* 0.5;
			feedbackText.y = (Constants.APP_HEIGHT - feedbackText.height) 	* 0.5;
		}
		
		private function addGlitchDecorationsTo(screenToDecorate:Screen):void 
		{
			screenToDecorate.addChild(new GlitchViewComponent());
		}
		
	}
}
internal class SingletonBlocker {}