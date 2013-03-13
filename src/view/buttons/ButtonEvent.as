package view.buttons 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Gaz Williams
	 */
	public class ButtonEvent extends Event 
	{
		public static const START_GAME:String = "start game";	
		public static const STOP:String = "stop";
		public static const PLAY:String = "play";
		public static const PLAY_BACK:String = "play back recorded";
		public static const RECORD:String = "record";
		
		public function ButtonEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ButtonEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ButtonEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}