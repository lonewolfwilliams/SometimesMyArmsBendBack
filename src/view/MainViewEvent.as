package view 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Gaz Williams
	 */
	public class MainViewEvent extends Event 
	{
		public static const VIEW_INITIALISED:String = "view initialised";
		public static const SCREEN_COMPLETED:String = "screen completed";
		public static const SCREEN_FAILED:String 	= "game completed";
		
		public function MainViewEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new MainViewEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("MainViewEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}