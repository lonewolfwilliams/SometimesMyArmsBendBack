package view.glitch 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author LoneWolfWilliams
	 */
	public class GlitchViewComponentEvent extends Event 
	{
		public static const SEQUENCE_COMPLETED:String = "sequence completed";
		
		public function GlitchViewComponentEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new GlitchViewComponentEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("GlitchViewComponentEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}