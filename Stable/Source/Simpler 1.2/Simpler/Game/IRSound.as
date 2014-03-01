package Simpler.Game
{
	// Flash Classes \/ //
	import flash.media.Sound; // Import the Sound Class
	import flash.media.SoundChannel; // Import the SoundChannel Class
	import flash.media.SoundTransform; // Import the SoundTransform Class
	import flash.media.SoundMixer; // Import the SoundMixer Class
	import flash.events.Event; // Import the Event Class
	// Simpler Classes \/ //
	import Simpler.Display.IRObject; // Import the IRObject Class
	
	public class IRSound extends IRObject
	{
		private static var s_sMuteMusic:Boolean = false; // Static control for global volume (Music)
		private static var s_sMuteSound:Boolean = false; // Static control for global volume (Sound)
		private static var s_sKillAll:Boolean = false; // Static control for global sound
		
		private var m_tSound:Sound = null; // Store the Sound
		private var m_tChannel:SoundChannel = null; // Store the Sound Channel
		private var m_tTransform:SoundTransform = null; // Store the Sound Transform
		private var m_nTrackTime:Number = 0; // Store the track time
		private var m_iLoops:int = 0; // Does this track loop
		private var m_nVolume:Number = 1; // Store the volume
		private var m_bMute:Boolean = false; // Is this sound muted
		private var m_bIsSound:Boolean = true; // Is this a Sound or Music
		
		public function IRSound(sound_:Sound, volume_:int = 100, loops_:int = 0, music_:Boolean = false):void
		{
			ClassName = "IRSound"; // Set the Class Name
			m_bIsSound = !music_; // Is this a sound or music
			m_tSound = sound_; // Set the sound
			m_tChannel = new SoundChannel(); // Create the Sound Channel
			m_tTransform = new SoundTransform(); // Create the Sound Transform
			m_tTransform.volume = volume_ * 0.01; // Set the volume
			if(music_)
			{
				if(s_sMuteMusic)
				{
					m_tTransform.volume = 0; // Set the Volume
				} // Music Muted
			}
			else
			{
				if(s_sMuteSound)
				{
					m_tTransform.volume = 0; // Set the Volume
				} // Sounds Muted
			}
			m_tChannel.soundTransform = m_tTransform; // Apply sound transform
			m_tChannel = m_tSound.play(0,loops_,m_tTransform); // Play the sound
			m_nVolume = volume_ * 0.01; // Store the volume
			m_iLoops = loops_; // Store the Loops
			if(m_tChannel != null)
			{
				m_tChannel.addEventListener(Event.SOUND_COMPLETE, soundComplete); // Sound has finished
			}
			else
			{
				Delete(); // Delete the Sound
				trace("[Simpler] Error 1004: " + UID + " could not be created, too many sounds!"); // MAX 30 Sounds!
			}
		} // Constructor
		
		private function soundComplete(e:Event):void
		{
			m_tChannel.removeEventListener(Event.SOUND_COMPLETE, soundComplete); // Remove the Event Listener
			Delete(); // Delete the Sound
		} // Sound Completed
		
		public override function Update():void
		{
			if(m_tChannel != null)
			{
				if(isMuted)
				{
					m_tTransform.volume = 0; // Set the Volume
					m_tChannel.soundTransform = m_tTransform; // Set the Transform
				}
				else
				{
					m_tTransform.volume = m_nVolume; // Set the Volume
					m_tChannel.soundTransform = m_tTransform; // Set the Transform
				}
				if(s_sKillAll)
				{
					stop();
					m_tChannel.removeEventListener(Event.SOUND_COMPLETE, soundComplete); // Remove the Event Listener
					Delete(); // Delete the Sound
				}
			}
		} // Run every frame
		
		private function get isMuted():Boolean
		{
			if(m_bMute)
			{
				return true;
			}
			if(m_bIsSound)
			{
				if(s_sMuteSound)
				{
					return true;
				} // Sounds Muted
			}
			else
			{
				if(s_sMuteMusic)
				{
					return true;
				} // Music Muted
			}
			return false;
		}
		
		public function play():void
		{
			m_tSound.play(m_nTrackTime,m_iLoops,m_tTransform); // Play the sound
			m_tChannel.soundTransform = m_tTransform; // Set the Transform
			m_tChannel.addEventListener(Event.SOUND_COMPLETE, soundComplete); // Sound has finished
		} // Play the Sound
		
		public function pause():void
		{
			m_nTrackTime = m_tChannel.position; // Store the track Position
			m_tChannel.stop(); // Stop the sound
		} // Pause the Sound
		
		public function stop():void
		{
			if(m_tChannel != null)
			{
				m_nTrackTime = 0; // Reset the sound
				m_tChannel.stop(); // Stop the sound
			}
		} // Stop the Sound
		
		public function get volume():int
		{
			return m_nVolume * 100;
		} // Return the volume
		public function set volume(value_:int):void
		{
			if(value_ * 0.01 >= 0)
			{
				m_nVolume = value_ * 0.01;
				m_tTransform.volume = m_nVolume; // Set the Volume
				m_tChannel.soundTransform = m_tTransform; // Set the Transform
			}
		} // Set the Volume
		
		public function get thisMuted():Boolean
		{
			return m_bMute;
		} // Return mute
		public function set thisMuted(value:Boolean):void
		{
			m_bMute = value;
		} // Set mute
		
		public static function get musicMuted():Boolean
		{
			return s_sMuteMusic;
		}
		public static function set musicMuted(value:Boolean):void
		{
			s_sMuteMusic = value;
		}
		
		public static function get soundMuted():Boolean
		{
			return s_sMuteSound;
		}
		public static function set soundMuted(value:Boolean):void
		{
			s_sMuteSound = value;
		}
		
		public static function get killAll():Boolean
		{
			return s_sKillAll;
		} // Is sound killed?
		public static function set killAll(value_:Boolean):void
		{
			s_sKillAll = value_;
		} // Kill all or not
		
		public override function Destroy():void
		{
			stop(); // Stop the Sound
			m_tSound = null; // Null the Sound
			m_tChannel = null; // Null the Channel
			m_tTransform = null; // Null the Transform
			super.Destroy(); // Super Deconstructor
		} // Deconstructor
	} // Class
} // Package