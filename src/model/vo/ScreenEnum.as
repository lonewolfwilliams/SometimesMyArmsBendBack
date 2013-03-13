package model.vo 
{
	/**
	 * ...
	 * @author Gaz Williams
	 * simulated enum
	 */
	public class ScreenEnum 
	{
		public static const PLAY_SCREEN:uint 			= 0;
		public static const RECORD_SCREEN:uint 			= 1;
		public static const PLAY_BACK_SCREEN:uint 		= 2;
		public static const CHARACTER_ENTRY_SCREEN:uint = 3;
		public static const SUCCESS_SCREEN:uint 		= 4;
		public static const INTRO_SCREEN:uint 			= 5;
		static public const GLITCH_SCREEN:uint			= 6;
		
		private var _type:uint = 0;
		public function get type():uint 
		{
			return _type;
		}
		
		public function ScreenEnum(type:uint) 
		{
			_type = type;
		}
		
	}

}