package controller 
{
	import model.DisplayModel;
	import model.NarrativeModel;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author LoneWolfWilliams
	 */
	public class FailMacro extends Command 
	{
		[Inject]
		public var _model:DisplayModel;
		
		override public function execute():void 
		{
			NarrativeModel.isFirstRun = false;
			
			commandMap.execute(FirstScreen);
		}
	}

}