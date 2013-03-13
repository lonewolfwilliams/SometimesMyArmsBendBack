package model 
{
	import flash.utils.ByteArray;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author Gaz Williams
	 * stores last audio data recorded from the mic.
	 */
	public class AudioBuffer extends Actor 
	{	
		private var buffer:ByteArray
		
		public function get content():ByteArray
		{
			return buffer;
		}
		
		public function set content(to:ByteArray):void 
		{
			buffer = to;
			dispatch(new AudioBufferEvent(AudioBufferEvent.UPDATED));
		}
		
	}

}