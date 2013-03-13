package view.buttons 
{
	import flash.display.Graphics;
	import flash.display.SimpleButton;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Gaz Williams
	 */
	public class RecordButton extends AbstractButtonWrapper 
	{
		[Embed(source="../../../embedded/assetts.swf", symbol="RecordButton")]
		private var _RecordButton:Class;
		private var m_canvas:Sprite;
		
		public function RecordButton() 
		{
			super(new _RecordButton());
			
			addEventListener(MouseEvent.CLICK, handleClick);
		}
		
		private function handleClick(e:MouseEvent):void 
		{
			doRecordState();
		}
		
		override protected function initialise():void 
		{
			addChild(_wraps);
			m_canvas = new Sprite();
			addChild(m_canvas);
		}
		
		public function doRecordState():void 
		{
			lock();
			_wraps.alpha = 0.5;
			
			var gfx:Graphics = m_canvas.graphics;
			
			gfx.beginFill(0xFF0000, 0.5);
				gfx.drawCircle(0, 0, 20);
			gfx.endFill();
		}
	}
}