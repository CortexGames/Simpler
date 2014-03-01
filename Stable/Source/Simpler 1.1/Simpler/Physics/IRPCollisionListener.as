package Simpler.Physics
{
	// Box2D Classes \/ //
	import Box2D.Dynamics.b2ContactListener; // Import the b2ContactListener Class
	import Box2D.Dynamics.Contacts.b2Contact; // Import the b2Contact Class
	// Simpler Classes \/ //
	import Simpler.Display.IRObject; // Import the IRObject Class
	
	public class IRPCollisionListener extends b2ContactListener
	{
		public override function BeginContact(contact:b2Contact):void
		{
			var ContactA:IRObject = contact.GetFixtureA().GetBody().GetUserData();
			var ContactB:IRObject = contact.GetFixtureB().GetBody().GetUserData();
			ContactA.Collisions.push(ContactB);
			ContactB.Collisions.push(ContactA);
		}
		
		public override function EndContact(contact:b2Contact):void
		{
			var ContactA:IRObject = contact.GetFixtureA().GetBody().GetUserData();
			var ContactB:IRObject = contact.GetFixtureB().GetBody().GetUserData();
			if(ContactA != null && ContactB != null)
			{
				for(var i:int = 0;i < ContactA.Collisions.length; i++)
				{
					if(ContactA.Collisions[i] == ContactB)
					{
						ContactA.Collisions.splice(i,1);
					}
				}
				for(i = 0;i < ContactB.Collisions.length; i++)
				{
					if(ContactB.Collisions[i] == ContactA)
					{
						ContactB.Collisions.splice(i,1);
					}
				}
			}
		}
	} // Class
} // Package