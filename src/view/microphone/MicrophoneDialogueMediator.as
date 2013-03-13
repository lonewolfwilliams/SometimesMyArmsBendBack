package view.microphone 
{
	import flash.events.MouseEvent;
	import flash.media.Microphone;
	import org.robotlegs.mvcs.Mediator;
	import view.buttons.ButtonEvent;
	import view.GameEvent;
	
	/**
	 * ...
	 * @author LoneWolfWilliams
	 */
	public class MicrophoneDialogueMediator extends Mediator 
	{
		[Inject]
		public var m_view:MicrophonePermissionsDialogue;
		
		private var m_gameCanStart:Boolean;
		
		public override function onRegister():void 
		{
			var mic:Microphone = Microphone.getMicrophone();
			if (mic != null)
			{
				m_gameCanStart = ! mic.muted;
			}
			else
			{
				m_gameCanStart = false;
			}
			
			m_view.addEventListener(ButtonEvent.START_GAME, handleStartGameButton, false, 0, true);
			m_view.addEventListener(MicrophoneDialogueEvent.MICROPHONE_ACCEPTED, handleMicrophoneAccepted);
			m_view.addEventListener(MicrophoneDialogueEvent.MICROPHONE_REJECTED, handleMicrophoneRejected);
		}
		
		private function handleStartGameButton(e:ButtonEvent):void 
		{
			if (m_gameCanStart)
			{
				dispatch(new GameEvent(GameEvent.START_GAME));
			}
		}
		private function handleMicrophoneAccepted(e:MicrophoneDialogueEvent):void 
		{
			m_gameCanStart = true;
		}
		private function handleMicrophoneRejected(e:MicrophoneDialogueEvent):void 
		{
			m_gameCanStart = false;
		}
	}
}