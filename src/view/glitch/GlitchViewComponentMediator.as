package view.glitch 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author LoneWolfWilliams
	 */
	public class GlitchViewComponentMediator extends Mediator 
	{
		override public function onRegister():void 
		{	
			addViewListener(GlitchViewComponentEvent.SEQUENCE_COMPLETED, handleSequenceCompleted, null, false, 0, true);
		}
		
		private function handleSequenceCompleted(e:GlitchViewComponentEvent):void 
		{
			//re dispatch into framework
			dispatch(e);
		}
	}
}