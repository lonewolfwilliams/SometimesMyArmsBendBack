package model 
{
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author Gaz Williams
	 * stores the static audio data for the application
	 */
	public class AudioLibrary extends Actor 
	{
		[Embed(source="../../embedded/em_ssik_female.mp3", mimeType = "audio/mpeg")]
		private var ReverseClueOne:Class;
		
		private var library:Vector.<Sound> = new Vector.<Sound>(1, false);
		
		[PostConstruct]
		public function initialise():void
		{
			library[0] = new ReverseClueOne();
		}
		
		public function getAudio(id:uint):ByteArray
		{
			var bufferedAudio:ByteArray;
			
			trace(library);
			
			switch (id) 
			{
				default:
				case 0:
					bufferedAudio = streamToByteArray(library[0]);
				break;
			}
			
			return bufferedAudio;
		}
		
		private function streamToByteArray(mp3:Sound):ByteArray
		{
			var data:ByteArray = new ByteArray();
			mp3.extract(data, mp3.length * 44.1, 0);
			
			trace(mp3);
			
			return data;
		}
		
	}

}