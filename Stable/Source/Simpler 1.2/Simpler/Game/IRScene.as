package Simpler.Game
{
	// Flash Classes \/ //
	import flash.utils.getTimer; // Import the getTimer Class
	// Custom Classes \/ //
	import Simpler.Display.IRObject; // Import the IRObject Class
	import Simpler.Game.IRGlobal; // Import the IRGlobal Class
	
	public class IRScene extends IRObject
	{
		public function IRScene():void
		{
			ClassName = "IRScene"; // Set the Class Name
		} // Constructor
		
		protected function SetState(new_:String):void
		{
			Global.NEWSTATE = new_; // Set the Change State
		} // Change GameState
		
		protected function Create(object_:*,x_:Number = -1,y_:Number = -1):IRObject
		{
			if(object_ != null)
			{
				return Global.Create(object_,x_,y_);
			} // Check object exists
			return null;
		} // Create an Object
	} // Class
} // Package