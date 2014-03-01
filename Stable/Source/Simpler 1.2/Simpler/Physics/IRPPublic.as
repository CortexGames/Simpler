package Simpler.Physics
{
	// Starling Classes \/ //
	import starling.display.Sprite; // Import the Sprite Class
	// Simpler Classes \/ //
	import Simpler.Physics.IRPBasic; // Import the IRPBasic Class
	
	public class IRPPublic extends IRPBasic
	{
		public function IRPPublic(x_:Number,y_:Number,graphic_:Sprite,mass_:Number = 0,bounce_:Number = 5,friction_:Number = 10):void
		{
			ClassName = "IRPPublic"; // Set the ClassName
			x = x_; // Set the x
			y = y_; // Set the y
			CreateGraphic(graphic_); // Create the Graphic
			m_nMass = mass_; // Set the Mass
			m_nBounce = bounce_; // Set the Bounce
			m_nFriction = friction_; // Set the Friction
			CreatePhysics(); // Create the Physics
		} // Constructor
	} // Class
} // Package