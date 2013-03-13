package view.buttons 
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Gaz Williams
	 * simple wrapper class for swf assets of type simplebutton
	 */
	public class AbstractButtonWrapper extends Sprite 
	{
		
		protected var _wraps:SimpleButton
		public function get wraps():SimpleButton 
		{
			return _wraps;
		}
		
		public function AbstractButtonWrapper(wraps:SimpleButton) 
		{
			super();
			
			this.mouseChildren = true;
			this.mouseEnabled = false;
			
			_wraps = wraps;
			
			initialise();
		}
		
		protected function initialise():void 
		{
			throw new Error("abstract method");
		}
		
		//eventlisteners used by mediator 
		
		override public function addEventListener (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_wraps.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		override public function removeEventListener (type:String, listener:Function, useCapture:Boolean = false):void
		{
			_wraps.removeEventListener(type, listener, useCapture);
		}
		
		override public function hasEventListener (type:String):Boolean
		{
			return _wraps.hasEventListener(type);
		}
		
		
		//naughty... should be abstracted higher up
		protected function lock():void 
		{
			_wraps.mouseEnabled = false;
		}
		
		protected function unlock():void 
		{
			_wraps.mouseEnabled = true;
		}
		
	}

}