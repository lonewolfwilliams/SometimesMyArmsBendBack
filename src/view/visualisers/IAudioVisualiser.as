package view.visualisers 
{
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author LoneWolfWilliams
	 */
	public interface IAudioVisualiser 
	{
		function ProcessAudioBuffer(magnitudes:Vector.<Number>, frequencies:Vector.<Number>):void 
	}
	
}