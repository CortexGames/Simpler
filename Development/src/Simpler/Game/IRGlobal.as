package Simpler.Game
{
	// Flash Classes \/ //
	import flash.display.Stage; // Import the Stage Class
	// Starling Classes \/ //
	import starling.events.Touch; // Import the Touch Class
	// Simpler Classes \/ //
	import Simpler.Display.IRObject; // Import the IRBasic Class
	import Simpler.Game.IRCollisionBase; // Import the IRCollisionBase Class
	
	public class IRGlobal
	{
		private static var s_sInstance:IRGlobal; // Store the Instance
		// Input \/ //
		public var MOUSEDOWN:Boolean = false; // Mouse is Pressed
		public var MOUSERELEASED:Boolean = false; // Mouse is Released
		public var MOUSEX:Number = -1; // Mouse X Position
		public var MOUSEY:Number = -1; // Mouse Y Position
		public var TOUCHES:Vector.<Touch> = new Vector.<Touch>(); // Store All Touches
		public var KEYS:Array = []; // Store all key states
		// Stage \/ //
		public var STAGEW:Number = 0; // Store Stage W
		public var STAGEH:Number = 0; // Store Stage H
		public var STAGE:IRObject = new IRObject(); // Store Display Objects
		public var FLASHSTAGE:flash.display.Stage; // Store the Flash Stage
		public var STARLINGSTAGE:IRObject = new IRObject(); // Store a link to the Starling Stage
		// Game \/ //
		public var GAMESTATE:String = "Loading"; // Store the Game State
		public var NEWSTATE:String = "Loading"; // Store the New Game State
		public var PAUSE:Boolean; // Is the Game Paused?
		public var PAUSESTATE:IRObject; // Store the Pause State
		public var GAMEITEMS:Vector.<IRObject> = new Vector.<IRObject>(); // Store Game Items
		public var DELTATIME:Number; // Store the Delta Time
		public var ACCURACY:int; // Store Game Accuracy
		public var GAMELOADED:Boolean = false; // Used for the preloaded when one is used
		// Additional \/ //
		public var COLLISION:IRCollisionBase; // Calculate Collision
		public var ASSETS:Function; // Store AssetLoader.getInstance();
		public var PHYSICSWORLD:*; // Store Box 2D World
		
		public function IRGlobal(LOCK_:IRLock)
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
		
		public function Create(object_:*,x_:Number = -1,y_:Number = -1):IRObject
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
				if(s_sInstance.COLLISION != null)
				{
					s_sInstance.COLLISION.addItem(s_sInstance.GAMEITEMS[s_sInstance.GAMEITEMS.length-1]); // Add to Collision
				} // Check collision class
				return object_;
			} // Check object_ exists
			return null;
		} // Create an Object
	} // Class
} // Package
internal class IRLock
{
	
} // Internal Class