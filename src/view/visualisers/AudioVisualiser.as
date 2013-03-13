package view.visualisers 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author LoneWolfWilliams
	 */
	public class AudioVisualiser extends Sprite implements IAudioVisualiser
	{
		private var m_spectrum:ByteArray = new ByteArray();
		
		/* INTERFACE view.visualisers.IAudioVisualiser */
		public function ProcessAudioBuffer(magnitudes:Vector.<Number>, frequencies:Vector.<Number>):void 
		{
			if (magnitudes == null || frequencies == null)
			{
				return;
			}
			
			var binCount:int = magnitudes.length;
			var radius:Number = 160;
			var segment:Number = Math.PI * 2 / binCount;
			
			var gfx:Graphics = this.graphics;
			gfx.clear();
			gfx.lineStyle(2, 0xFF0000, 1);
			
			//magnitudes are in DB!
			var startX:Number;
			var startY:Number;	
			for (var i:int = 0; i < binCount; i++)
			{
				/*
				var clamped:Number = magnitudes[i];
				if (clamped < -60)
				{
					clamped = -60;
				}
				if (clamped > 0)
				{
					clamped = 0;
				}
				clamped = (-1 / -60) * clamped;
				
				var x:Number = Math.cos(segment * i) * (radius + clamped * 100);
				var y:Number = Math.sin(segment * i) * (radius + clamped * 100);
				*/
				
				var x:Number = Math.cos(segment * i) * (radius + magnitudes[i]);
				var y:Number = Math.sin(segment * i) * (radius + magnitudes[i]);
				
				if (i == 0)
				{
					startX = x;
					startY = y;
					gfx.moveTo(x, y);
				}
				gfx.lineTo(x, y);
				
				if (i == binCount - 1)
				{
					gfx.lineTo(startX, startY);
				}
			}
			
		}
		
	}

}