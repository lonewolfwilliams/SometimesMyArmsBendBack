package view.characterInput 
{
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Gaz Williams
	 */
	public class CharacterInputMediator extends Mediator 
	{
		
		override public function onRegister():void 
		{	
			addViewListener(CharacterInputEvent.CORRECT_CHARACTER_INPUT, 	handleCorrectCharacterInput);
			addViewListener(CharacterInputEvent.INCORRECT_CHARACTER_INPUT, 	handleInCorrectCharacterInput);
		}
		
		private function handleCorrectCharacterInput(e:CharacterInputEvent):void 
		{
			
			trace("handleCorrectCharacterInput");
			
			//re dispatch event into framework bus
			dispatch(e);
		}
		
		private function handleInCorrectCharacterInput(e:CharacterInputEvent):void 
		{
			
			trace("handle*in*CorrectCharacterInput");
			
			//re dispatch event into framework bus
			dispatch(e);
		}
		
	}

}