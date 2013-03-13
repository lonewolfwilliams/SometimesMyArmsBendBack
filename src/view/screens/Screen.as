package view.screens 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Gaz Williams
	 * a self describing sprite
	 */
	public class Screen extends Sprite 
	{
		public function dispose():void 
		{
			while (this.numChildren > 0)
			{
				removeChildAt(0);
			}
		}
	}
}