package view.buttons 
{
	import flash.events.MouseEvent;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Gaz Williams
	 */
	public class PlayButtonMediator extends Mediator 
	{
		
		override public function onRegister():void
		{
			addViewListener(MouseEvent.CLICK, handleClick);
		}
		
		private function handleClick(e:MouseEvent):void 
		{
			dispatch(new ButtonEvent(ButtonEvent.PLAY));
		}
		
	}

}