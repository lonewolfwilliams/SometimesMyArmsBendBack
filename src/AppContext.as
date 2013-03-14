package  
{
	import controller.FailMacro;
	import controller.FirstScreen;
	import controller.NextScreen;
	import controller.Play;
	import controller.PlayBack;
	import controller.RecordMacro;
	import controller.ReleaseClue;
	import controller.UpdateSoundtrack;
	import flash.display.DisplayObjectContainer;
	import model.AudioBuffer;
	import model.AudioLibrary;
	import model.ClueModel;
	import model.DisplayModel;
	import model.DisplayModelEvent;
	import org.robotlegs.mvcs.Context;
	import service.IAudioService;
	import service.SimpleAudioService;
	import view.buttons.ButtonEvent;
	import view.buttons.PlayBackButton;
	import view.buttons.PlaybackButtonMediator;
	import view.buttons.PlayButton;
	import view.buttons.PlayButtonMediator;
	import view.buttons.RecordButton;
	import view.buttons.RecordButtonMediator;
	import view.characterInput.CharacterInput;
	import view.characterInput.CharacterInputMediator;
	import view.clues.ClueEvent;
	import view.clues.ClueViewComponent;
	import view.clues.ClueViewComponentMediator;
	import view.glitch.GlitchViewComponent;
	import view.glitch.GlitchViewComponentMediator;
	import view.MainView;
	import view.MainViewEvent;
	import view.MainViewMediator;
	import view.microphone.MicrophoneDialogueMediator;
	import view.microphone.MicrophonePermissionsDialogue;
	import view.visualisers.AudioVisualiser;
	import view.visualisers.AudioVisualiserMediator;
	
	/**
	 * ...
	 * @author Gaz Williams
	 */
	public class AppContext extends Context 
	{
		
		public function AppContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true) 
		{
			super(contextView, autoStartup);
			
		}
		
		//map bindings
		override public function startup():void 
		{
			injector.mapSingleton(AudioLibrary);
			injector.mapSingleton(AudioBuffer);
			
			injector.mapSingletonOf(IAudioService, SimpleAudioService);
			
			commandMap.mapEvent(ButtonEvent.PLAY,		Play,		 ButtonEvent);
			commandMap.mapEvent(ButtonEvent.RECORD,		RecordMacro, ButtonEvent);
			commandMap.mapEvent(ButtonEvent.PLAY_BACK,	PlayBack,	 ButtonEvent);
			
			mediatorMap.mapView(MicrophonePermissionsDialogue, 	MicrophoneDialogueMediator);
			mediatorMap.mapView(PlayButton, 					PlayButtonMediator);
			mediatorMap.mapView(RecordButton, 					RecordButtonMediator);
			mediatorMap.mapView(PlayBackButton,					PlaybackButtonMediator);
			mediatorMap.mapView(CharacterInput,					CharacterInputMediator);
			mediatorMap.mapView(AudioVisualiser, 				AudioVisualiserMediator);
			mediatorMap.mapView(GlitchViewComponent,			GlitchViewComponentMediator);
			mediatorMap.mapView(ClueViewComponent,				ClueViewComponentMediator);
			
			injector.mapSingleton(DisplayModel);
			
			var clueModelInstance:ClueModel = injector.instantiate(ClueModel);
			injector.mapValue(ClueModel, clueModelInstance);
			clueModelInstance.initialise();
			
			commandMap.mapEvent(DisplayModelEvent.DISPLAY_UPDATED, 	UpdateSoundtrack, DisplayModelEvent);
			commandMap.mapEvent(MainViewEvent.SCREEN_COMPLETED, 	NextScreen);
			commandMap.mapEvent(MainViewEvent.VIEW_INITIALISED, 	FirstScreen);
			commandMap.mapEvent(MainViewEvent.SCREEN_FAILED, 		FailMacro);
			
			commandMap.mapEvent(ClueEvent.CLUE_REQUESTED, ReleaseClue);
			
			mediatorMap.mapView(MainView, MainViewMediator);
			
		}
		
	}

}