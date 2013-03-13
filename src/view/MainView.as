package view 
{
	import com.demonsters.debugger.MonsterDebugger;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import model.vo.ScreenEnum;
	import view.glitch.GlitchViewComponent;
	import view.screens.Screen;
	import view.screens.ScreenFactory;
	
	/**
	 * ...
	 * @author Gaz Williams
	 * container for view objects
	 */
	public class MainView extends Sprite 
	{
		private var currentScreen:Screen = null;
		
		//called by mediator onRegister
		public function initialise():void 
		{
			trace("initialising");
		}

		//todo:manage simple transitions...
		
		public function displayScreen(screen:ScreenEnum):void 
		{
			if (currentScreen != null)
			{
				currentScreen.dispose();
				removeChild(currentScreen);
			}
			
			var factory:ScreenFactory = ScreenFactory.getInstance();
			var nextScreen:Screen = factory.create(screen);
			
			addChild(nextScreen);
			
			currentScreen = nextScreen;
		}
		
	}
	
}