package model 
{
	import com.demonsters.debugger.MonsterDebugger;
	import flash.events.Event;
	import model.vo.ScreenEnum;
	
	/**
	 * ...
	 * @author Gaz Williams
	 */
	public class DisplayModelEvent extends Event 
	{
		private var _toScreen:ScreenEnum
		public function get toScreen():ScreenEnum 
		{
			return _toScreen;
		}
		
		public static const DISPLAY_UPDATED:String = "display updated";
		
		public function DisplayModelEvent(type:String, toScreen:ScreenEnum, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_toScreen = toScreen;
		} 
		
		public override function clone():Event 
		{ 
			return new DisplayModelEvent(type, _toScreen, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("DisplayModelEvent", "type", "_toScreen", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}