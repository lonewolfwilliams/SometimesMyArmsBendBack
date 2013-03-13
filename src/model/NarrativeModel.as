package model 
{
	/**
	 * ...
	 * @author LoneWolfWilliams
	 * 
	 * drives the narrative for the game, mostly for incorrect guesses
	 */
	public class NarrativeModel 
	{
		public static var isFirstRun:Boolean = true;
		
		private static var m_index:int = -1;
		private static var m_narrativeSequence:Array = 
		[
			"I'm so cold",
			"everything's too bright",
			"why don't you understand me?",
			"I want to leave this place",
			"I am frightened",
			"why won't you help me?",
			"one last thing from you can set me free"
		];
		
		public static function Next():String
		{
			if (++m_index >= m_narrativeSequence.length)
			{
				m_index = 0;
			}
			
			return m_narrativeSequence[m_index];
		}
		
		/*
		public static function GetHint():String
		{
			
		}
		*/
	}
}