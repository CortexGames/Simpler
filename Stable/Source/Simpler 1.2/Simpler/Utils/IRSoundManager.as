package Simpler.Utils
{
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import Simpler.Game.IRAssets;

	public class IRSoundManager
	{
		private static var s_sInstance:IRSoundManager; // Store the Instance
		
		private var m_tSChannel:SoundChannel = new SoundChannel(); // Create the Sound Channel (Sound)
		private var m_tSTransform:SoundTransform = new SoundTransform(); // Create the Sound Transform (Sound)
		private var m_nSoundVolume:Number = 0; // Set the Sound Volume
		
		private var m_tMChannel:SoundChannel = new SoundChannel(); // Create the Sound Channel (Music)
		private var m_tMTransform:SoundTransform = new SoundTransform(); // Create the Sound Transform (Music)
		private var m_nMusicVolume:Number = 0; // Set the Music Volume
		
		public function IRSoundManager(lock_ : IRLock)
		{
			
		}
		
		public static function getInstance():IRSoundManager
		{
			if(!s_sInstance)
			{
				s_sInstance = new IRSoundManager(new IRLock());
			}
			return s_sInstance;
		} // Return Instance
		
		// Plays Sound Once!
		public function playSound(soundName_:String):void
		{
			m_tSChannel.soundTransform = m_tSTransform; // Apply sound transform
			m_tSChannel = IRAssets.INSTANCE.getSound(soundName_).play(0, 0, m_tSTransform); // Play the sound
		}
		
		// Set volume to 0 or lastVolume
		public function set muteSound(value:Boolean):void
		{
			if(m_tSTransform.volume == 0 && value)
			{
				return;
			}
			if(value)
			{
				m_nSoundVolume = m_tSTransform.volume;
			}
			m_tSTransform.volume = value ? 0 : m_nSoundVolume;
			m_tSChannel.soundTransform = m_tSTransform;
		}
		
		// Sound is muted
		public function get isSoundMuted():Boolean
		{
			return m_tSTransform.volume == 0;
		}
		
		// Loops Sound Forever!
		public function playMusic(musicName_:String):void
		{
			m_tMChannel.soundTransform = m_tMTransform; // Apply sound transform
			m_tMChannel = IRAssets.INSTANCE.getSound(musicName_).play(0, int.MAX_VALUE, m_tMTransform); // Play the sound
		}
		
		// Set volume to 0 or lastVolume
		public function set muteMusic(value:Boolean):void
		{
			if(m_tMTransform.volume == 0 && value)
			{
				return;
			}
			if(value)
			{
				m_nMusicVolume = m_tSTransform.volume;
			}
			m_tMTransform.volume = value ? 0 : m_nMusicVolume;
			m_tMChannel.soundTransform = m_tMTransform;
		}
		
		// Music is muted
		public function get isMusicMuted():Boolean
		{
			return m_tMTransform.volume == 0;
		}
		
		// Mute sound and music
		public function set muteAll(value:Boolean):void
		{
			muteMusic = value;
			muteSound = value;
		}
	}
}
internal class IRLock
{
	
} // Internal Class