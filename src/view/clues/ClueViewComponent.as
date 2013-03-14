package view.clues 
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import model.ClueModel;
	import model.FontLibrary;
	
	/**
	 * ...
	 * @author LoneWolfWilliams
	 */
	public class ClueViewComponent extends Sprite 
	{
		private var m_icon:Sprite;
		
		public function ClueViewComponent()
		{
			this.mouseChildren = true;
			this.mouseEnabled = false;
			
			m_icon = CreateIconSprite();
			addChild(m_icon);
		}
		
		public function CreateIconSprite():Sprite
		{
			var icon:Sprite = new Sprite();
			
			var gfx:Graphics = icon.graphics;
			gfx.lineStyle(1, 0xFFFFFF, 1);
			gfx.beginFill(0, 1);
				gfx.drawCircle(30, 30, 30);
			gfx.endFill();
			
			icon.buttonMode = true;
			icon.useHandCursor = true;
			icon.mouseChildren = false;
			
			var iconLabel:TextField = FontLibrary.CreateTextfield();
			var baseFormat:TextFormat = FontLibrary.createTextFormat();
			baseFormat.size = 40;
			//baseFormat.align = TextFormatAlign.LEFT;
			iconLabel.defaultTextFormat = baseFormat;
			iconLabel.autoSize = TextFieldAutoSize.LEFT;
			iconLabel.text = "i";
			
			icon.addChild(iconLabel);
			iconLabel.x = (icon.width - iconLabel.width) * 0.5 - 2; // shim
			iconLabel.y = (icon.height - iconLabel.height) * 0.5;
			
			return icon;
		}
		
		public function DisplayClue(content:String):void 
		{
			var feedbackText:TextField = FontLibrary.CreateTextfield();
			feedbackText.mouseEnabled = false;
			var baseFormat:TextFormat = FontLibrary.createTextFormat();
			baseFormat.size = 50;
			feedbackText.defaultTextFormat = baseFormat;
			feedbackText.text = content;
			
			addChild(feedbackText);
			feedbackText.y = 0;
			feedbackText.x = (Constants.APP_WIDTH - feedbackText.width) * 0.5;
			
			//create the timeline and add an onComplete call to myFunction when the timeline completes
			var fadeInAndOut:TimelineMax = new TimelineMax({onStart:Lock, onComplete:UnLock});
			fadeInAndOut.append(new TweenMax(feedbackText, 1, { startAt:{alpha:0}, alpha:1}));
			fadeInAndOut.append(new TweenMax(feedbackText, 1, { delay:2, alpha:0 } ));
		}
		
		private function Lock():void 
		{
			m_icon.alpha = 0.5;
			m_icon.mouseEnabled = false;
		}
		
		private function UnLock():void 
		{
			m_icon.alpha = 1;
			m_icon.mouseEnabled = true;
		}
	}
}