package view.buttons 
{
	import com.demonsters.debugger.MonsterDebugger;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Gaz Williams
	 */
	public class PlayBackButton extends AbstractButtonWrapper 
	{
		
		[Embed(source="../../../embedded/assetts.swf", symbol="PlayBackButton")]
		private var _PlayBackButton:Class;
		
		public function PlayBackButton() 
		{
			super(new _PlayBackButton());
			
			addEventListener(MouseEvent.CLICK, handleClick);
		}
		
		private function handleClick(e:MouseEvent):void 
		{
			lock();
			this.alpha = 0.5;
		}
		
		override protected function initialise():void
		{
			trace("initialise");
			addChild(_wraps);
		}
		
	}

}