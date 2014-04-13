package simpler.physics
{
	// Box2D Classes \/ //
	import Box2D.Dynamics.Contacts.b2Contact; // Import the b2Contact Class
	import Box2D.Dynamics.b2World; // Import the b2World Class
	// Simpler Classes \/ //
	import simpler.display.IRObject; // Import the IRObject Class
	import simpler.physics.IRPCollisionListener; // Import the IRCollisionListener2D
	import simpler.game.IRCollisionBase; // Import the IRCollisionBase Class
	
	public class IRPCollision extends IRCollisionBase
	{
		private var m_cContactListener:IRPCollisionListener;
		private var m_bPhysicsRunning:Boolean = false;
		
		public function IRPCollision():void
		{
			ClassName = "IRPCollision";
		} // Constructor
		
		public override function GetCollisions(mc_:IRObject):Array
		{
			return mc_.Collisions;
		} // Return Neighbours
		
		public override function addItem(mc_:IRObject):void
		{
			
		} // Add Collision Item
		
		public override function removeItem(mc_:IRObject):void
		{
			
		} // Remove Collision Item
		
		public override function Update():void
		{
			if(!m_bPhysicsRunning && Global.PHYSICSWORLD != null)
			{
				m_cContactListener = new IRPCollisionListener();
				Global.PHYSICSWORLD.SetContactListener(m_cContactListener);
				m_bPhysicsRunning = true;
			}
		} // Calulate Collision
	} // Class
} // Package