package model 
{
	import de.polygonal.ds.SLinkedList;
	import de.polygonal.ds.SListIterator;
	import model.vo.ScreenEnum;
	import view.screens.Screen;
	/**
	 * ...
	 * @author Gaz Williams
	 * manages states of display model
	 */
	public class DisplayModel extends AudioBuffer 
	{
		private var screens:SLinkedList = new SLinkedList();
		private var currentScreen:SListIterator;
		private var preventRetrigger:Boolean = false;
		
		public function DisplayModel() 
		{
			super();
			
			initialiseScreens();
			
			currentScreen = screens.getListIterator();
		}
		
		private function initialiseScreens():void 
		{
			screens.append(new ScreenEnum(ScreenEnum.INTRO_SCREEN));
			screens.append(new ScreenEnum(ScreenEnum.PLAY_SCREEN));
			screens.append(new ScreenEnum(ScreenEnum.RECORD_SCREEN));
			screens.append(new ScreenEnum(ScreenEnum.PLAY_BACK_SCREEN));
			screens.append(new ScreenEnum(ScreenEnum.CHARACTER_ENTRY_SCREEN)); //branching skips to fail screen
			screens.append(new ScreenEnum(ScreenEnum.SUCCESS_SCREEN));
		}
		
		public function getCurrentScreen():ScreenEnum
		{
			return currentScreen.node.data;
		}
		
		public function nextScreen():void 
		{
			
			if (Math.random() > 0.7 && false == preventRetrigger)
			{
				dispatch(new DisplayModelEvent(DisplayModelEvent.DISPLAY_UPDATED, new ScreenEnum(ScreenEnum.GLITCH_SCREEN)));
				preventRetrigger = true;
				return;
			}
			
			//loop through
			if (currentScreen.hasNext())
			{
				currentScreen.next();
			}
			else
			{
				currentScreen.start();
			}
			
			preventRetrigger = false;
			
			dispatch(new DisplayModelEvent(DisplayModelEvent.DISPLAY_UPDATED, currentScreen.node.data));
		}
		
		public function firstScreen():void 
		{
			currentScreen.start();
			dispatch(new DisplayModelEvent(DisplayModelEvent.DISPLAY_UPDATED, currentScreen.node.data));
		}
		
		public function Screen():void 
		{
			currentScreen.start();
			currentScreen.next();
			dispatch(new DisplayModelEvent(DisplayModelEvent.DISPLAY_UPDATED, currentScreen.node.data));
		}
		
	}

}