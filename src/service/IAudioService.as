package service 
{
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Gaz Williams
	 */
	public interface IAudioService
	{
		function record():void;
		function stopRecording():void;
		
		function playForward(fromBuffer:ByteArray):void;	
		function playBackward(fromBuffer:ByteArray):void;
		function stopFilePlaying():void;
		
		function playToneAt(frequencyInHZ:int, amplitude:Number):void;
		function stopTonePlaying():void;
		
		function get internalRecordBuffer():ByteArray;
	}
	
}