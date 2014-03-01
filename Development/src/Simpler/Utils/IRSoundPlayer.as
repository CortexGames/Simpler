package Simpler.Utils
{
	// Flash Classes \/ //
	import flash.media.SoundChannel; // Import the SoundChannel Class
	import flash.media.SoundTransform; // Import the SoundTransform Class
	import flash.media.Sound; // Import the Sound Class
	// Simpler Classes \/ //
	import Simpler.Game.IRSound; // Import the IRSound Class
	
	public class IRSoundPlayer
	{
		private static var s_sInstance:IRSoundPlayer; // Store the Instance
		
		private var m_tSChannel:SoundChannel = new SoundChannel(); // Create the Sound Channel (Sound)
		private var m_tSTransform:SoundTransform = new SoundTransform(); // Create the Sound Transform (Sound)
		private var m_nSoundVolume:Number = 0; // Set the Sound Volume
		
		private var m_tMChannel:SoundChannel = new SoundChannel(); // Create the Sound Channel (Music)
		private var m_tMTransform:SoundTransform = new SoundTransform(); // Create the Sound Transform (Music)
		private var m_nMusicVolume:Number = 0; // Set the Music Volume
		
		private var m_sMusicName:String = ""; // Store the Music Name
		
		public function IRSoundPlayer(LOCK_:IRLock):void
		{
			
		} // Constructor
		
		public static function getInstance():IRSoundPlayer
		{
			if(!s_sInstance)
			{
				s_sInstance = new IRSoundPlayer(new IRLock());
			}
			return s_sInstance;
		} // Return Instance
		
		
		// Sound Operations for Sounds \/ //
		
		public function playSound(sound_:Sound):void
		{
			m_tSChannel.soundTransform = m_tSTransform; // Apply sound transform
			m_tSChannel = sound_.play(0,0,m_tSTransform); // Play the sound
		}
		
		public function playControllableSound(sound_:Sound, volume_:int = 100, loops_:int = 0):IRSound
		{
			return new IRSound(sound_, volume_, loops_, false);
		}
		
		public function get soundVolume():Number
		{
			return m_nSoundVolume;
		}
		public function set soundVolume(value:Number):void
		{
			m_nSoundVolume = value;
		}
		
		public function get soundMuted():Boolean
		{
			return IRSound.soundMuted;
		}
		public function set soundMuted(value:Boolean):void
		{
			IRSound.soundMuted = value;
		}
		
		
		// Sound Operations for Music \/ //
		
		public function playMusic(sound_:Sound, name_:String):void
		{
			if(m_sMusicName != name_)
			{
				m_sMusicName = name_;
				m_tMChannel.soundTransform = m_tMTransform; // Apply sound transform
				m_tMChannel = sound_.play(0,int.MAX_VALUE,m_tMTransform); // Play the sound
			} // Stop track playing multiple times
		}
		
		public function playControllableMusic(sound_:Sound, volume_:int = 100, loops_:int = 0):IRSound
		{
			return new IRSound(sound_, volume_, loops_, true);
		}
		
		public function get musicVolume():Number
		{
			return m_nMusicVolume;
		}
		public function set musicVolume(value:Number):void
		{
			m_nMusicVolume = value;
		}
		public function get musicMuted():Boolean
		{
			return IRSound.musicMuted;
		}
		public function set musicMuted(value:Boolean):void
		{
			IRSound.musicMuted = value;
			m_tSTransform.volume = value ? 0 : 1;
			m_tMChannel.soundTransform = m_tSTransform;
		}
		
		
		// Sound Operations for All \/ //
		
		public function get allMuted():Boolean
		{
			if(IRSound.musicMuted && IRSound.soundMuted)
			{
				return true;
			}
			return false
		}
		public function set allMuted(value:Boolean):void
		{
			musicMuted = value;
			soundMuted = value;
		}
		public function get killAll():Boolean
		{
			return IRSound.killAll;
		}
		public function set killAll(value_:Boolean):void
		{
			IRSound.killAll = value_;
		}
	}
}
internal class IRLock
{
	
} // Internal Class