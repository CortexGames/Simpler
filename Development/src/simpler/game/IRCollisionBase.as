package simpler.game
{
	// Starling Classes \/ //
	import starling.display.DisplayObject; // Import the DisplayObject Class
	// Simpler Classes \/ //
	import simpler.display.IRObject; // Import the IRObject Class
	
	public class IRCollisionBase extends IRObject
	{
		public function IRCollisionBase():void
		{
			
		} // Constructor
		
		public function GetCollisions(mc_:IRObject):Array
		{
			return new Array();
		} // Return Collisions for mc_
		
		public function addItem(mc_:IRObject):void
		{
			
		} // Add Collision Item
		
		public function removeItem(mc_:IRObject):void
		{
			
		} // Remove Collision Item
		
		public override function Update():void
		{
			
		} // Calulate Collision
	} // Class
} // Package

