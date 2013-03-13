package view.characterInput 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Gaz Williams
	 */
	public class CharacterInputEvent extends Event 
	{
		
		public static const CORRECT_CHARACTER_INPUT:String = "correct character input";
		public static const INCORRECT_CHARACTER_INPUT:String = "incorrect character input";
		
		public function CharacterInputEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new CharacterInputEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("CharacterInputEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}