package Simpler.Game
{
	// Flash Classes \/ //
	import flash.desktop.NativeApplication; // Import the NativeApplication Class
	import flash.sensors.Accelerometer; // Import the Accelerometer Class
	import flash.events.AccelerometerEvent; // Import the AccelerometerEvent Class
	import flash.system.Capabilities; // Import the Capabilities Class
	// Starling Classes \/ //
	import starling.events.Event; // Import the Event Class
	// Simpler Classes \/ //
	import Simpler.Display.IRObject; // Import the IRObject Class
	import Simpler.Game.IRScene; // Import the IRScene Class
	import Simpler.Game.IRProgram; // Import the IRProgram Class
	
	public class IRMobile extends IRProgram
	{
		private var m_sAccel:Accelerometer; // Store the Accelerometer
		
		public function IRMobile():void
		{
			ClassName = "IRMobile"; // Set the Class Name
			Global.ACCELX = 0; // Set the Accel X
			Global.ACCELY = 0; // Set the Accel Y
			Global.ACCELZ = 0; // Set the Accel Z
			Global.ORIENT = "Normal"; // Set the Orientation
			Global.OS = "Android" // Store OS Information
			if(Capabilities.os.toLowerCase().charAt(0) == "i")
			{
				Global.OS = "Apple"; // lOL But really they suck
			}
			else
			{
				Global.OS = "Android"; // This is true
			}
			trace("[Simpler]",Global.OS);
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAdded); // Add Added To Stage Event Listener
		} // Constructor
		
		private function onAdded(e:starling.events.Event):void
		{
			stage.removeEventListener(starling.events.Event.ADDED_TO_STAGE,onAdded); // Remove Added To Stage Event listener
			if(Accelerometer.isSupported)
			{
				m_sAccel = new Accelerometer(); // Store the Accelerometer
				m_sAccel.addEventListener(AccelerometerEvent.UPDATE, onAccUpdate); // Add Accelerometer Event
			}
		} // Added to stage function
		
		public function exit():void
		{
			NativeApplication.nativeApplication.exit();
		} // Close Application
		
		private function onAccUpdate(e:AccelerometerEvent):void
		{
			Global.ACCELX = e.accelerationX;
			Global.ACCELY = e.accelerationY;
			Global.ACCELZ = e.accelerationZ;
			var calc:Number = Math.sin(Math.PI/4);
			if(e.accelerationX > 0 && e.accelerationY > -calc && e.accelerationY < calc)
			{
				Global.ORIENT = "LEFT";
			}
			else if(e.accelerationY >= calc)
			{
				Global.ORIENT = "NORMAL";
			}
			else if(e.accelerationX < 0 && e.accelerationY > -calc && e.accelerationY < calc)
			{
				Global.ORIENT = "RIGHT";
			}
			else if(e.accelerationY <= calc)
			{
				Global.ORIENT = "INVERTED";
			} 
		} // Accelerometer Event
		/*
		protected override function UpdateStage(width_:Number = 0,height_:Number = 0):void
		{
			if(Capabilities.screenResolutionX > 100)
			{
				Global.STAGEW = Capabilities.screenResolutionX; // Set the Stage Width
			}
			else
			{
				Global.STAGEW = width_; // Set the Stage Width
			}
			if(Capabilities.screenResolutionY > 100)
			{
				Global.STAGEH = Capabilities.screenResolutionY; // Set the Stage Height
			}
			else
			{
				Global.STAGEH = height_; // Set the Stage Height
			}
		} // Set the Stage Width and Height
		*/
	} // Class
} // Package