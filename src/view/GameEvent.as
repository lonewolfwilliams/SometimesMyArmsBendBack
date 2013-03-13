package view 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author LoneWolfWilliams
	 */
	public class GameEvent extends Event 
	{
		public static var START_GAME:String = "start game";
		
		public function GameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new GameEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("GameEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}