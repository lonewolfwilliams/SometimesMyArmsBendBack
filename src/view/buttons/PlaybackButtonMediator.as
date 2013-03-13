package view.buttons 
{
	import com.demonsters.debugger.MonsterDebugger;
	import flash.events.MouseEvent;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Gaz Williams
	 */
	public class PlaybackButtonMediator extends Mediator 
	{
		
		override public function onRegister():void
		{
			addViewListener(MouseEvent.CLICK, handleClick);
		}
		
		private function handleClick(e:MouseEvent):void 
		{
			dispatch(new ButtonEvent(ButtonEvent.PLAY_BACK));
		}
		
	}

}