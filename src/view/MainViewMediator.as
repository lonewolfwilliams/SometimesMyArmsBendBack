package view 
{
	import model.AudioBufferEvent;
	import model.DisplayModelEvent;
	import model.vo.ScreenEnum;
	import org.robotlegs.mvcs.Mediator;
	import service.AudioServiceEvent;
	import view.characterInput.CharacterInputEvent;
	import view.glitch.GlitchViewComponentEvent;
	
	/**
	 * ...
	 * @author Gaz Williams
	 */
	public class MainViewMediator extends Mediator 
	{
		[Inject]
		public var _view:MainView;
		
		override public function onRegister():void 
		{
			_view.initialise();
			
			eventMap.mapListener(eventDispatcher, GameEvent.START_GAME, handleGameStart);
			eventMap.mapListener(eventDispatcher, AudioServiceEvent.PLAYBACK_COMPLETE, handlePlaybackCompleted);
			eventMap.mapListener(eventDispatcher, AudioBufferEvent.UPDATED, handleBufferUpdate);
			eventMap.mapListener(eventDispatcher, DisplayModelEvent.DISPLAY_UPDATED, handleDisplayUpdated);
			
			eventMap.mapListener(eventDispatcher, CharacterInputEvent.CORRECT_CHARACTER_INPUT, 	 handleCorrectCharacterInput);
			eventMap.mapListener(eventDispatcher, CharacterInputEvent.INCORRECT_CHARACTER_INPUT, handleIncorrectCharacterInput);
			
			eventMap.mapListener(eventDispatcher, GlitchViewComponentEvent.SEQUENCE_COMPLETED, handleSequenceCompleted);
			
			dispatch(new MainViewEvent(MainViewEvent.VIEW_INITIALISED));
		}
		
		//---------
		//out
		//---------
		
		private function handleIncorrectCharacterInput(e:CharacterInputEvent):void 
		{
			trace("incorrect character entered");
			
			dispatch(new MainViewEvent(MainViewEvent.SCREEN_FAILED));
		}
		
		private function handleCorrectCharacterInput(e:CharacterInputEvent):void 
		{
			trace("correct character entered");
			
			dispatch(new MainViewEvent(MainViewEvent.SCREEN_COMPLETED));
		}
		
		private function handleBufferUpdate(e:AudioBufferEvent):void 
		{
			trace("buffer updated");
			
			dispatch(new MainViewEvent(MainViewEvent.SCREEN_COMPLETED));
		}
		
		private function handleGameStart(e:GameEvent):void 
		{
			trace("game started");
			
			dispatch(new MainViewEvent(MainViewEvent.SCREEN_COMPLETED));
		}
		
		private function handleSequenceCompleted(e:GlitchViewComponentEvent):void 
		{
			trace("glitch sequence completed");
			
			dispatch(new MainViewEvent(MainViewEvent.SCREEN_COMPLETED));
		}
		
		//---------
		//in
		//---------
		
		private function handlePlaybackCompleted(e:AudioServiceEvent):void 
		{
			dispatch(new MainViewEvent(MainViewEvent.SCREEN_COMPLETED));
		}
		
		private function handleDisplayUpdated(e:DisplayModelEvent):void 
		{
			_view.displayScreen(e.toScreen);
		}
		
	}

}