package Simpler.Game
{
	// Flash Classes \/ //
	import flash.display.Stage; // Import the Stage Class
	// Simpler Classes \/ //
	import Simpler.Display.IRObject; // Import the IRBasic Class
	import Simpler.Game.IRCollisionBase; // Import the IRCollisionBase Class
	
	public class IRGlobal
	{
		private static var s_sInstance:IRGlobal; // Store the Instance
		public var MOUSEDOWN:Boolean = false; // Mouse is Pressed
		public var MOUSERELEASED:Boolean = false; // Mouse is Released
		public var MOUSEX:Number = -1; // Mouse X Position
		public var MOUSEY:Number = -1; // Mouse Y Position
		public var KEYS:Array = new Array(); // Store all key states
		public var TOUCHES:Array = new Array(); // Store All Touches
		public var MOUSEDATA:String = ""; // Mouse Data
		public var STAGEW:Number = 0; // Store Stage W
		public var STAGEH:Number = 0; // Store Stage H
		public var STAGE:IRObject = new IRObject(); // Store Display Objects
		public var FLASHSTAGE:flash.display.Stage; // Store the Flash Stage
		public var STARLINGSTAGE:IRObject = new IRObject(); // Store a link to the Starling Stage
		public var GAMESTATE:String = "Loading"; // Store the Game State
		public var NEWSTATE:String = "Loading"; // Store the New Game State
		public var GAMEITEMS:Array = new Array(); // Store Game Items
		public var DELTATIME:int = 0; // Store the Delta Time
		public var ACCURACY:int = 0; // Store Game Accuracy
		public var COLLISION:IRCollisionBase; // Calculate Collision
		public var ASSETS:*; // Reference the Assets Class
		public var PHYSICSWORLD:*; // Store Box 2D World
		public var USER:* = null; // Space for user data
		
		public function IRGlobal(LOCK_:IRLock):void
		{
			
		} // Constructor
		
		public static function getInstance():IRGlobal
		{
			if(!s_sInstance)
			{
				s_sInstance = new IRGlobal(new IRLock());
			}
			return s_sInstance;
		} // Return Instance
		
		public function Create(object_:*,x_:Number = -1,y_:Number = -1):void
		{
			if(null != object_)
			{
				if(-1 != x_)
				{
					object_.x = x_; // Set the X
				}
				if(-1 != y_)
				{
					object_.y = y_; // Set the Y
				}
				s_sInstance.GAMEITEMS.push(object_); // Add to GameItem Array
				if("Flash" != object_.name)
				{
					s_sInstance.STAGE.addChild(s_sInstance.GAMEITEMS[s_sInstance.GAMEITEMS.length-1]); // Add to Stage
				} // Add to starling stage
				else if("Flash" == object_.name)
				{
					s_sInstance.FLASHSTAGE.addChild(s_sInstance.GAMEITEMS[s_sInstance.GAMEITEMS.length-1]); // Add to Stage
				} // Add to flash stage
				if(s_sInstance.COLLISION != null)
				{
					s_sInstance.COLLISION.addItem(s_sInstance.GAMEITEMS[s_sInstance.GAMEITEMS.length-1]); // Add to Collision
				} // Check collision class
			} // Check object_ exists
		} // Create an Object
	} // Class
} // Package
internal class IRLock
{
	
} // Internal Class