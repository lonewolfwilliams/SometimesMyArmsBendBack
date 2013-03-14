package controller 
{
	import model.DisplayModel;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author Gaz Williams
	 */
	public class FirstScreen extends Command 
	{
		
		[Inject]
		public var _model:DisplayModel;
		
		override public function execute():void 
		{
			_model.firstScreen();
		}
		
	}

}