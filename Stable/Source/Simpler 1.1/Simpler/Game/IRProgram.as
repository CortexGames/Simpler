package Simpler.Game
{
	// Flash Classes \/ //
	import flash.events.TimerEvent; // Import the TimerEvent Class
	import flash.utils.Timer; // Import the Timer Class
	import flash.events.Event; // Import the Event Class
	import flash.utils.getTimer; // Import the getTimer Class
	import flash.system.Capabilities; // Import the Capabilities Class
	// Starling Classes \/ //
	import starling.events.Event; // Import the Event Class
	import starling.events.KeyboardEvent; // Import the KeyboardEvent Class
	import starling.events.TouchEvent; // Import the TouchEvent Class
	import starling.events.TouchPhase; // Import the TouchPhase Class
	import starling.events.Touch; // Import the Touch Class
	import starling.text.TextField; // Import the TextField Class
	import starling.text.BitmapFont; // Import the BitmapFont Class
	import starling.display.Quad; // Import the Quad Class
	import starling.events.ResizeEvent; // Import the ResizeEvent Class
	// Simpler Classes \/ //
	import Simpler.Display.IRObject; // Import the IRObject Class
	import Simpler.Game.IRScene; // Import the IRScene Class
	import Simpler.Game.IRCollisionBase; // Import the IRCollisionBase Class
	
	public class IRProgram extends IRScene
	{
		private var m_tTimer:Timer = new Timer(20); // Define an Update Timer
		private var m_aStates:Array = new Array(); // Store Game States
		private var m_iAccuracy:int = 0; // Store Accuracy Count
		private var m_iFPSCount:int = 0; // Store the FPS Count
		private var m_iFPSTotal:int = 60; // Store the FPS
		private var m_uFPSTimer:uint = 0; // Store the Relative Time
		private var m_uFPSLast:uint = 0; // Store the Last Relative Time
		private var m_bFPSProtect:Boolean = false; // Stop if FPS is to low
		private var m_uDeltaLast:uint = 0; // Store the Time since last asked
		private var m_bMouseReleased:Boolean = false; // Mouse Release Tracker
		private var m_bShowStats:Boolean = false; // Show the stats
		private var m_tStats:TextField; // Store the Stats TextField
		private var m_qBack:Quad; // Store the Background for Stats
		protected var m_sState:IRObject = null; // Store the Game State
		
		public function IRProgram():void
		{
			ClassName = "IRProgram"; // Set the Class Name
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAdded); // Add Added To Stage Event Listener
		} // Constructor
		
		private function onAdded(e:starling.events.Event):void
		{
			stage.removeEventListener(starling.events.Event.ADDED_TO_STAGE,onAdded); // Remove Added To Stage Event listener
			m_uFPSTimer = getTimer(); // Store a relative time
			m_uFPSLast = m_uFPSTimer; // Store the relative time
			stage.addEventListener(TouchEvent.TOUCH,onTouch); // Add Touch Event Listener
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKDown); // Add Keyboard Down Event Listener
			stage.addEventListener(KeyboardEvent.KEY_UP,onKUp); // Add Keyboard Up Event Listener
			stage.addEventListener(starling.events.Event.ENTER_FRAME,FPSLoop); // Add Enter Frame Event Listener
			stage.addEventListener(ResizeEvent.RESIZE,onResize); // The Stage has been Resized
			Global.STAGEW = stage.stageWidth; // Set Stage Width
			Global.STAGEH = stage.stageHeight; // Set Stage Height
			stage.addChild(Global.STAGE); // Add Display Object STAGE
			stage.addChild(Global.STARLINGSTAGE); // Add Display Object STARLINGSTAGE
			m_tTimer.addEventListener(TimerEvent.TIMER,IRUpdate); // Set an Update Timer
			m_tTimer.start(); // Start the Timer
			Added(); // Added to stage
			trace("[Simpler] Initialization complete."); // Successful Start Message
		} // Added to stage function
		
		public function Added():void
		{
			// Show Stats Here?
		} // Added to stage function, override it!
		
		private function IRUpdate(e:flash.events.Event):void
		{
			Global.DELTATIME = getTimer() - m_uDeltaLast; // Set Delta Time
			m_uDeltaLast = getTimer(); // Store Time
			for(var i:int = 0;i < m_aStates.length;i++)
			{
				if(m_aStates[i] == Global.GAMESTATE)
				{
					this["State" + m_aStates[i]](); // Call Game State
				}
			}
			if(Global.COLLISION != null && Global.ACCURACY <= m_iAccuracy)
			{
				Global.COLLISION.Update();
				for(i = 0;i < Global.GAMEITEMS.length;i++)
				{
					Global.GAMEITEMS[i].Collisions = Global.COLLISION.GetCollisions(Global.GAMEITEMS[i]);
					Global.GAMEITEMS[i].Update(); // Call Game Updates
				}
			}
			else
			{
				for(i = 0;i < Global.GAMEITEMS.length;i++)
				{
					Global.GAMEITEMS[i].Update(); // Call Game Updates
				}
			}
			SwitchState(); // Change GameState
			if(Global.ACCURACY <= m_iAccuracy)
			{
				DeleteObjects();
				FPSProtection();
				m_iAccuracy = -1; // Reset to -1
			}
			m_iAccuracy++; // Increment m_iAccuracy
			if(Global.MOUSERELEASED)
			{
				Global.MOUSERELEASED = false; // Mouse is no longer released
			}
			if(m_bShowStats && m_tStats != null)
			{
				m_tStats.text = "FPS: " + FPS + "\nOBJ: " + Global.GAMEITEMS.length + "\nMX: " + Global.MOUSEX  + "\nMY: " + Global.MOUSEY; // Debug Info
			}
		} // Run Every Frame
		
		private function DeleteObjects():void
		{
			for(var i:int = 0; i < Global.GAMEITEMS.length;i++)
			{
				if(Global.GAMEITEMS[i].isDeleted)
				{
					if("Flash" != Global.GAMEITEMS[i].name)
					{
						Global.STAGE.removeChild(Global.GAMEITEMS[i]);
					} // Remove from Starling Stage
					else if("Flash" == Global.GAMEITEMS[i].name)
					{
						Global.FLASHSTAGE.removeChild(Global.GAMEITEMS[i]);
					} // Remove from Flash Stage
					if(Global.COLLISION != null)
					{
						Global.COLLISION.removeItem(Global.GAMEITEMS[i]);
					} // Check collision and remove item
					Global.GAMEITEMS[i].Zombie(); // Stores to variables will work more effectively
					Global.GAMEITEMS[i].Destroy(); // Call Deconstructor
					Global.GAMEITEMS.splice(i,1); // Remove Game Item from Array
					i--; // Decrement i
				} // Tagged for Deletion
			} // Delete Tagged GAMEITEMS
		} // Delete Objects
		
		protected function CreateState(...param):void
		{
			for(var i:int = 0;i < param.length;i++)
			{
				m_aStates.push(param[i]); // Store m_aStates
			}
		} // Create m_aStates
		
		private function SwitchState():void
		{
			if(Global.GAMESTATE != Global.NEWSTATE)
			{
				for(var i:int = 0;i < Global.GAMEITEMS.length;i++)
				{
					if(!Global.GAMEITEMS[i].Constant)
					{
						Global.GAMEITEMS[i].Delete(); // Remove all none constant Objects
					} // NEW Check Constant Property
				}
				DeleteObjects(); // Delete Stuff
				if(m_sState != null)
				{
					m_sState.Destroy(); // Destroy the State
					m_sState = null; // Format the State
				}
				m_iFPSTotal = 60; // Reset FPS
				Global.MOUSERELEASED = false; // Mouse is no longer released
				m_bMouseReleased = false; // Mouse is no longer released
				var Ran:Boolean = false; // Check Function Run
				for(i = 0;i < m_aStates.length;i++)
				{
					if(m_aStates[i] == Global.NEWSTATE)
					{
						this["StateBegin" + m_aStates[i]](); // Call Begin State
						Ran = true; // Function has run
					}
				}
				if(!Ran)
				{
					trace("[Simpler] Error: " + Global.NEWSTATE + " has no state function, check spellings!");
					trace("[Simpler] Info: These are the States you've defined " + m_aStates);
				}
				Global.GAMESTATE = Global.NEWSTATE; // Set Game State
			}
		} // Switch Game State
		
		public function Config(collision_:IRCollisionBase = null, assets_:* = null, physics_:* = null, user_:IRObject = null):void
		{
				Global.COLLISION = collision_; // Set the Collision
				Global.ASSETS = assets_; // Set the Assets
				Global.PHYSICSWORLD = physics_; // Set the Physics
				Global.USER = user_; // Set the User Data
		} // Set the Config
		
		private function onKDown(e:KeyboardEvent):void
		{
			Global.KEYS[e.keyCode] = true; // Set keyCode to true
		} // Key Pressed
		
		private function onKUp(e:KeyboardEvent):void
		{
			Global.KEYS[e.keyCode] = false; // Set keyCode to false
		} // Key Released
		
		private function onTouch(e:TouchEvent):void
		{
			while(Global.TOUCHES.length)
			{
				Global.TOUCHES.pop();
			} // Remove Touch Data
			for(var i:int = 0;i < e.touches.length;i++)
			{
				Global.TOUCHES.push(e.touches[i]);
			}
			var touch:Touch = e.getTouch(stage); // Store the Touch
			if(touch)
			{
				switch(touch.phase)
				{
					case TouchPhase.BEGAN:
						Global.MOUSEDOWN = true; // The Mouse is Down
						Global.MOUSEX = touch.globalX; // Set the Mouse x
						Global.MOUSEY = touch.globalY; // Set the Mouse y
						break;
					case TouchPhase.MOVED:
						Global.MOUSEX = touch.globalX; // Set the Mouse x
						Global.MOUSEY = touch.globalY; // Set the Mouse y
						//UpdateStage(stage.stageWidth,stage.stageHeight); // Set the Stage Size
						break;
					case TouchPhase.ENDED:
						Global.MOUSEDOWN = false; // The Mouse is Released
						Global.MOUSERELEASED = true; // The Mouse is Released
						break;
				}
			}
		} // Mouse / Touch Events
		
		private function onResize(e:ResizeEvent):void
		{
			Global.STAGEW = e.width;
			Global.STAGEH = e.height;
		} // Handle the Stage Resizing
		
		private function FPSLoop(e:starling.events.Event):void
		{
			m_uFPSTimer = getTimer();
			if(m_uFPSTimer - 1000 > m_uFPSLast)
			{
				m_uFPSLast = m_uFPSTimer;
				m_iFPSTotal = m_iFPSCount;
				m_iFPSCount = 0;
				if(m_iFPSTotal == 1)
				{
					trace("[Simpler] WARNING: The FPS is to low!");
				}
			}
			m_iFPSCount++;
		} // Track the FPS
		
		private function FPSProtection():void
		{
			if(m_iFPSTotal == 1 && m_bFPSProtect)
			{
				trace("[Simpler] WARNING: Launching new state " + m_aStates[0] + " due to low FPS!");
				SetState(m_aStates[0]);
			}
		} // Restart due to low FPS
		
		protected function get FPS():int
		{
			return m_iFPSTotal;
		} // Return the FPS
		
		protected function get Time():uint
		{
			return m_uFPSTimer;
		} // Return the Relative Time
		
		/*
		protected function get Delta():uint
		{
			return m_uDeltaTime;
		} // Return the Delta Time
		*/
		
		protected function set LOWFPS(fps_:Boolean):void
		{
			m_bFPSProtect = fps_;
		} // Restart if low FPS
		
		public function get showStats():Boolean
		{
			return m_bShowStats;
		} // Get Show Stats
		
		public function set showStats(value:Boolean):void
		{
			if(value)
			{
				if(!m_bShowStats)
				{
					m_qBack = new Quad(50,58,0x0); // Create the Background
					Global.STARLINGSTAGE.addChild(m_qBack); // Add to Starling Stage
					m_tStats = new TextField(50, 44, "FPS: 60\nOBJ: 0\nMX: 0\nMY: 0", BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xFFFFFF); // Create the TextField
					m_tStats.x = 2; // Set the x
					m_tStats.y = 18; // Set the y
					m_tStats.hAlign = "left"; // Set to left Align
					Global.STARLINGSTAGE.addChild(m_tStats); // Add to Starling Stage
				}
			} // Show Items
			else
			{
				if(m_bShowStats)
				{
					Global.STARLINGSTAGE.removeChild(m_tStats); // Remove from Starling Stage
					m_tStats = null; // Set to null
					Global.STARLINGSTAGE.removeChild(m_qBack); // Add to Starling Stage
					m_qBack = null; // Set to null
				}
			} // Hide Items
			m_bShowStats = value; // Set show stats
		} // Show Stats / Don't Show Stats
	} // Class
} // Package