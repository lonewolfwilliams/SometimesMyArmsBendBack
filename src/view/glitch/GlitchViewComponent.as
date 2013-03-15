package view.glitch 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author LoneWolfWilliams
	 * 
	 * displays a short slide show of glitchy images disposes when done
	 */
	public class GlitchViewComponent extends Sprite
	{
		private var m_timer:Timer;		
		private var m_glitch:Glitchmap;
		private var m_random_seed:int = 0;
		
		[Embed(source = "../../../embedded/imagen-011.jpg", mimeType = "application/octet-stream")]
		private var ImageOne:Class;
		
		[Embed(source = "../../../embedded/skippy-is-ddead.jpg", mimeType = "application/octet-stream")] 
		private var ImageTwo:Class;
		
		[Embed(source = "../../../embedded/vs-pink-poloroids_905.jpeg", mimeType = "application/octet-stream")] 
		private var ImageThree:Class;
		
		[Embed(source = "../../../embedded/sd533810.jpg", mimeType = "application/octet-stream")] 
		private var ImageFour:Class;
		
		[Embed(source = "../../../embedded/IMG_1030.JPG", mimeType = "application/octet-stream")] 
		private var ImageFive:Class;
		
		public function GlitchViewComponent() 
		{
			m_random_seed = Math.floor(Math.random() * 1000);
			
			var imageData:Array = [new ImageOne(), new ImageTwo(), new ImageThree(), new ImageFour(), new ImageFive()];
			var randomIndex:int = Math.round(Math.random() * 4);
			
			m_glitch = Glitchmap.CreateGlitch(imageData[randomIndex] as ByteArray);
			addChild(m_glitch);
			
			m_glitch.width = Constants.APP_WIDTH;
			m_glitch.height = Constants.APP_HEIGHT;
			
			m_timer = new Timer(Constants.GLITCH_DURATION_MS, 1);
			m_timer.addEventListener(TimerEvent.TIMER_COMPLETE, handleTimerComplete, false, 0, true);
			m_timer.start();
			
			addEventListener(Event.ENTER_FRAME, handleEnterFrame, false, 0, true);
		}
		
		private function handleTimerComplete(e:TimerEvent):void 
		{
			m_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, handleTimerComplete);
			m_timer.stop();
			
			dispatchEvent(new GlitchViewComponentEvent(GlitchViewComponentEvent.SEQUENCE_COMPLETED));
		}
		
		private function handleEnterFrame(e:Event):void 
		{
			m_glitch.glitchiness = 0.03;
			m_glitch.maxIterations = 400;
			if (Math.random() > Constants.GLITCHINESS)
			{
				m_glitch.seed = m_random_seed++ % 1000;
			}
		}
		
		public function dispose():void 
		{
			while (this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
		}
	}
}