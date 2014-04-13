package simpler.physics
{
	// Box2d Classes \/ //
	import Box2D.Dynamics.b2DebugDraw; // Import the b2DebugDraw Class
	// Flash Classes \/ //
	import flash.display.Sprite; // Import the Sprite Class
	// Simpler Classes \/ //
	import simpler.display.IRObject; // Import the IRObject Class

	public class IRPDebug extends IRObject
	{
		private static var s_iDebugCount:int = 0; // Store the Debug Count
		private static var s_sDebugSprite:Sprite = null; // Store the Sprite
		private var m_iCount:int = 0; // Store the ID
		
		public function IRPDebug():void
		{
			ClassName = "IRPDebug";
			if(s_iDebugCount > 1)
			{
				Delete();
			}
			else
			{
				debugDraw();
			}
			s_iDebugCount++; // Increment Count
			m_iCount = s_iDebugCount; // Store Count Locally
		} // Constructor
		
		public override function Update():void
		{
			if(m_iCount == 1 && Global.PHYSICSWORLD != null)
			{
				Global.PHYSICSWORLD.DrawDebugData();
			} // Check variables
		} // Run every frame
		
		private function debugDraw():void
		{
			if(Global.PHYSICSWORLD != null && Global.FLASHSTAGE != null)
			{
				var debugDraw:b2DebugDraw = new b2DebugDraw();
				s_sDebugSprite = new Sprite();
				Global.FLASHSTAGE.addChild(s_sDebugSprite);
				debugDraw.SetSprite(s_sDebugSprite);
				debugDraw.SetDrawScale(30);
				debugDraw.SetFlags(b2DebugDraw.e_shapeBit|b2DebugDraw.e_jointBit);
				debugDraw.SetFillAlpha(0.5);
				Global.PHYSICSWORLD.SetDebugDraw(debugDraw);
			} // Check Globals
		} // Debug draw physics
		
		public override function Destroy():void
		{
			if(s_iDebugCount == 1)
			{
				Global.FLASHSTAGE.removeChild(s_sDebugSprite);
				s_sDebugSprite = null;
			} // Last Instance
			s_iDebugCount--; // Decrement Count
		} // Deconstructor
	} // Class
} // Package