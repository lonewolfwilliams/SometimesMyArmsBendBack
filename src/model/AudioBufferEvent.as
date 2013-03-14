package model 
{
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Gaz Williams
	 */
	public class AudioBufferEvent extends Event 
	{
		
		public static const UPDATED:String = "updated";
		
		public function AudioBufferEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new AudioBufferEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("AudioBufferEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}