package controller 
{
	import model.AudioBuffer;
	import org.robotlegs.mvcs.Command;
	import service.IAudioService;
	
	/**
	 * ...
	 * @author Gaz Williams
	 * transfers the buffer from audio service to model
	 */
	public class TransferBufferToModel extends Command 
	{
		
		[Inject]
		public var _model:AudioBuffer;
		
		[Inject]
		public var _service:IAudioService;
		
		override public function execute():void 
		{
			trace("transfering buffer to model");
			
			_model.content = _service.internalRecordBuffer;
		}
		
	}

}