package view.characterInput 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	import model.FontLibrary;
	
	/**
	 * ...
	 * @author Gaz Williams
	 * a stylised character input box with some extra functionality
	 */
	public class CharacterInput extends Sprite 
	{	
		private var timer:Timer = new Timer(Constants.CHARACTER_INPUT_TIMEOUT_MS, 1);
		private var input:TextField = new TextField();
		
		private var isLocked:Boolean = false;
		
		private var m_width:int;
		private var m_height:int;
		
		public function CharacterInput(width:int, height:int) 
		{
			super();
			
			m_width = width;
			m_height = height;
			
			addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage, false, 0, true);
		}
		
		private function handleAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
			
			initialiseTextField(m_width, m_height);
			input.addEventListener(Event.CHANGE, handleCharacterInput);
			addChild(input);
			addChild(drawChrome(m_width, m_height));
		}
		
		private function drawChrome(width:int, height:int):Sprite 
		{
			var canvas:Sprite = new Sprite();
			var graphics:Graphics = canvas.graphics;
			graphics.beginFill(0xFFFFFF, 1);
				graphics.drawRect(0, height - 50, width, 50);
			graphics.endFill();
			
			return canvas;
		}
		
		private function initialiseTextField(width:int, height:int):void 
		{
			input.borderColor = 0xFFFFFF;
			input.border 	= true;
			
			input.backgroundColor = 0x000000;
			input.background = true;
			
			input.maxChars 	= 1;
			input.width 	= width;
			input.height 	= height;
			
			input.embedFonts = true;
			
			//input.textColor = 0xFFFFFF;
			var format:TextFormat = FontLibrary.createTextFormat();
			format.size  = 200;
			
			input.defaultTextFormat = format;
			//input.text = "X";
			
			input.mouseEnabled = true;
			input.type = TextFieldType.INPUT;
			
			stage.focus = input;
		}
		
		private function lock():void 
		{
			input.type 			= TextFieldType.DYNAMIC;
			input.selectable 	= false;
			input.alpha			= 0.5;
		}
		
		private function handleCharacterInput(e:Event):void 
		{
			if (input.text === "" || isLocked) return;
			
			lock();
			
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, handleTimerComplete);
			timer.start();
			
			//evaluate outcome on timer complete
		}
		
		private function handleTimerComplete(e:TimerEvent):void 
		{
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, handleTimerComplete);
			timer.reset();
			
			var inputToLower:String = input.text.toLowerCase();
			
			if (inputToLower === "x")
			{
				dispatchEvent(new CharacterInputEvent(CharacterInputEvent.CORRECT_CHARACTER_INPUT));
			}
			else
			{
				dispatchEvent(new CharacterInputEvent(CharacterInputEvent.INCORRECT_CHARACTER_INPUT));
			}
			
		}
		
	}

}