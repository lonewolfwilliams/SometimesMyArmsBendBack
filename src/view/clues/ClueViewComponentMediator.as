package view.clues 
{
	import flash.events.MouseEvent;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author LoneWolfWilliams
	 */
	public class ClueViewComponentMediator extends Mediator 
	{
		[Inject]
		public var view:ClueViewComponent;
		
		override public function onRegister():void 
		{	
			//in
			eventMap.mapListener(eventDispatcher, ClueEvent.CLUE_RESPONSE, handleClueResponse);
			//out
			addViewListener(MouseEvent.CLICK, handleClick, null, false, 0, true);
		}
		
		private function handleClueResponse(e:ClueEvent):void 
		{
			var clue:String = e.payload as String;
			view.DisplayClue(clue);
		}
		
		private function handleClick(e:MouseEvent):void 
		{
			trace("handleclick - mediator");
			dispatch(new ClueEvent(ClueEvent.CLUE_REQUESTED));
		}
	}
}