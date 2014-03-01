package Simpler.Game
{
	// Flash Classes \/ //
	import flash.utils.getTimer; // Import the getTimer Class
	// Custom Classes \/ //
	import Simpler.Display.IRObject; // Import the IRObject Class
	import Simpler.Game.IRGlobal; // Import the IRGlobal Class
	public class IRScene extends IRObject
	{
		private var m_aEndTime:Array = new Array(); // Store the Time to Wait Till
		private var m_aRunOnce:Array = new Array(); // Store Run Once value for Wait
		
		public function IRScene():void
		{
			ClassName = "IRScene"; // Set the Class Name
		} // Constructor
		
		protected function SetState(new_:String):void
		{
			Global.NEWSTATE = new_; // Set the Change State
			m_aEndTime = new Array(); // Wipe Wait List Clean
			m_aRunOnce = new Array(); // Wipe Wait List Clean
		} // Change GameState
		
		protected function Create(object_:*,x_:Number = -1,y_:Number = -1):void
		{
			if(object_ != null)
			{
				Global.Create(object_,x_,y_);
			} // Check object exists
		} // Create an Object
		
		protected function Wait(length_:int,uid_:int,once_:Boolean = true):Boolean
		{
			if(uid_ >= m_aEndTime.length)
			{
				m_aEndTime[uid_] = length_ + getTimer(); // Store Future Time
				m_aRunOnce[uid_] = once_; // Run Once or Not
			}
			if(uid_ < m_aEndTime.length && m_aEndTime[uid_] != 0 && m_aEndTime[uid_] <= getTimer())
			{
				if(m_aRunOnce[uid_] == true)
				{
					m_aEndTime[uid_] = 0; // Reset to 0
				}
				return true;
			}
			return false;
		} // Return true when x amount of time has passed since start!
		
		protected function StopWait(uid_:int):void
		{
			m_aRunOnce[uid_] = true; // Run only once
			m_aEndTime[uid_] = 0; // Reset to 0
		} // Stop a Wait call, normally a looping one
	} // Class
} // Package