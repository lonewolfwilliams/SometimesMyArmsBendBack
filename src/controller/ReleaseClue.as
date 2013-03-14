package controller 
{
	import model.ClueModel;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author LoneWolfWilliams
	 */
	public class ReleaseClue extends Command 
	{
		[Inject]
		public var _model:ClueModel
		
		override public function execute():void 
		{
			trace("releasing clue");
			_model.DispatchNextHintForScreen();
		}
	}
}