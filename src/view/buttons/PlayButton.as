package view.buttons 
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Gaz Williams
	 */
	public class PlayButton extends AbstractButtonWrapper 
	{
		[Embed(source="../../../embedded/assetts.swf", symbol="PlayButton")]
		private var _playButton:Class;
		
		public function PlayButton() 
		{
			super(new _playButton());
			
			addEventListener(MouseEvent.CLICK, handleClick);
		}
		
		override protected function initialise():void 
		{
			addChild(_wraps);
		}
	
		private function handleClick(e:MouseEvent):void 
		{
			lock();
			this.alpha = 0.5;
		}
		
	}

}