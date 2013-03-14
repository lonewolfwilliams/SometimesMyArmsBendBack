package 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import view.MainView;
	
	/**
	 * ...
	 * @author Gaz Williams
	 * bootstrap for robotlegs project
	 */
	public class Main extends Sprite 
	{
		private var context:AppContext;
		private var _view:MainView;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			stage.displayState = StageDisplayState.FULL_SCREEN;
			
			trace("Sometimes My Arms Bend Back v0.1");
			
			context = new AppContext(this);
			_view = new MainView();
			
			addChild(_view);
		}
		
	}
	
}