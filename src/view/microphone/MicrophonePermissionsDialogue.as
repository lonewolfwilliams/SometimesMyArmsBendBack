package view.microphone 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.StatusEvent;
	import flash.media.Microphone;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	import model.NarrativeModel;
	import view.buttons.ButtonEvent;
	
	/**
	 * ...
	 * @author LoneWolfWilliams
	 * 
	 * forces the audio permissions dialogue to display, otherwise it interferes with the recording process (recording is blocked whilst
	 * dialogue is visible and unresolved)
	 * 
	 */
	
	public class MicrophonePermissionsDialogue extends Sprite
	{
		private var m_dialogueShown:Boolean = false;
		public function get DialogueShown():Boolean
		{
			return m_dialogueShown;
		}
	
		public function MicrophonePermissionsDialogue()
		{
			addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage, false, 0, true);
			addEventListener(Event.REMOVED, handleRemoved, false, 0, true);
		}
		
		private function handleRemoved(e:Event):void 
		{
			stage.removeEventListener(MouseEvent.CLICK, handleMouseClick);
		}
		
		public function ShowDialogue():void
		{
			var mic:Microphone = Microphone.getMicrophone();
			if (mic != null)
			{
				mic.addEventListener(StatusEvent.STATUS, statusHandler); 
				Security.showSettings(SecurityPanel.PRIVACY);
				m_dialogueShown = true;
			}
			else
			{
				this.dispatchEvent(new MicrophoneDialogueEvent(MicrophoneDialogueEvent.MICROPHONE_REJECTED));
			}
		}
		
		private function handleAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
			stage.addEventListener(MouseEvent.CLICK, handleMouseClick, false, 0, true);
			
			if (NarrativeModel.isFirstRun)
			{
				ShowDialogue();
			}
		}
		
		private function handleMouseClick(e:MouseEvent):void 
		{
			//re dispatch event.
			this.dispatchEvent(new ButtonEvent(ButtonEvent.START_GAME));
		}
		
		//http://delfeld.wordpress.com/page/11/?archives-list=1
		//not a hack - as per asdocs recomendations...
		private function statusHandler(event:StatusEvent):void 
		{
			//var micAlreadyMuted = (event.target as Microphone).muted;
            if (event.code == "Microphone.Unmuted")
            {
                this.dispatchEvent(new MicrophoneDialogueEvent(MicrophoneDialogueEvent.MICROPHONE_ACCEPTED));
            }
            else if (event.code == "Microphone.Muted")
            {
                this.dispatchEvent(new MicrophoneDialogueEvent(MicrophoneDialogueEvent.MICROPHONE_REJECTED));
            }
        }
	}
}