package view.microphone 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author LoneWolfWilliams
	 */
	public class MicrophoneDialogueEvent extends Event 
	{
		public static var MICROPHONE_ACCEPTED:String = "user accepted microphone use";
		public static var MICROPHONE_REJECTED:String = "user rejected microphone use";
		
		public function MicrophoneDialogueEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new MicrophoneDialogueEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("MicrophoneDialogueEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}