package  
{
	import controller.FailMacro;
	import controller.FirstScreen;
	import controller.NextScreen;
	import controller.Play;
	import controller.PlayBack;
	import controller.RecordMacro;
	import flash.display.DisplayObjectContainer;
	import model.AudioBuffer;
	import model.AudioLibrary;
	import model.DisplayModel;
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
			
			injector.mapSingleton(DisplayModel);
			
			commandMap.mapEvent(MainViewEvent.SCREEN_COMPLETED, NextScreen);
			commandMap.mapEvent(MainViewEvent.VIEW_INITIALISED, FirstScreen);
			commandMap.mapEvent(MainViewEvent.SCREEN_FAILED, 	FailMacro);
			
			mediatorMap.mapView(MainView, MainViewMediator);
			
		}
		
	}

}