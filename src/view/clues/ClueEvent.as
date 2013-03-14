package view.clues 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author LoneWolfWilliams
	 */
	public class ClueEvent extends Event 
	{
		public static const CLUE_REQUESTED:String = "clue requested";
		public static const CLUE_RESPONSE:String = "clue response";
		
		public var payload:Object;
		
		public function ClueEvent(type:String, payload:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this.payload = payload;
		} 
		
		public override function clone():Event 
		{ 
			return new ClueEvent(type, payload, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ClueEvent", "type", "payload", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}