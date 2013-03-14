package model 
{
	import flash.utils.Dictionary;
	import model.vo.ScreenEnum;
	import org.robotlegs.mvcs.Actor;
	import view.clues.ClueEvent;
	import view.screens.ScreenFactory;
	
	/**
	 * ...
	 * @author LoneWolfWilliams
	 * 
	 * hints to solve the puzzle are optionally available to the player to maintain flow.
	 * 
	 */
	
	 public class ClueModel extends Actor
	{	
		private var m_currentScreen:ScreenEnum;
		private var m_hints:Dictionary = new Dictionary();
		
		public function initialise():void 
		{
			m_hints[ScreenEnum.PLAY_SCREEN] = createPlayHints();
			m_hints[ScreenEnum.RECORD_SCREEN] = createRecordHints();
			m_hints[ScreenEnum.PLAY_BACK_SCREEN] = CreatePlaybackHints();
			m_hints[ScreenEnum.CHARACTER_ENTRY_SCREEN] = CreateCharacterEntryHints();
			
			eventMap.mapListener(eventDispatcher, DisplayModelEvent.DISPLAY_UPDATED, handleDisplayUpdated);
		}
		
		private function handleDisplayUpdated(e:DisplayModelEvent):void 
		{
			m_currentScreen = e.toScreen;
		}
		
		public function DispatchNextHintForScreen():void
		{
			var clue:String = "It seems there are no more clues...";
			if (m_hints[m_currentScreen.type].length > 0)
			{
				clue = m_hints[m_currentScreen.type].shift();
			}
			
			dispatch(new ClueEvent(ClueEvent.CLUE_RESPONSE, clue));
		}
		
		private function createPlayHints():Array
		{
			return [
				"There's something characteristic about this sound",
				"It's like each screen is a tool\n maybe I can use them to decode this?",
				"This speech is playing backward",
			];
		}
		
		private function createRecordHints():Array
		{
			return [
				"The outline of the button seems to be responding to something,\nonce you press on it",
				"That button looks like a record button",
				"When I press this button it records my voice"
			];
		}
		
		private function CreatePlaybackHints():Array
		{
			return [
				"Something is unusual about the symbol on this button",
				"This button looks like a back-to-front play button",
				"If I press this button it plays my recording backwards"
			];
		}
		
		private function CreateCharacterEntryHints():Array
		{
			return [
				"Only one letter? It must be some kind of code...",
				"If only I could work out what that voice said\n ... me?",
				"Was it Kiss me?"
			];
		}
	}
}
