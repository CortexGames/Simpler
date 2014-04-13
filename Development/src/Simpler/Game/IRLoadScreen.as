package simpler.game
{
	// Starling Classes \/ //
	import starling.events.Event; // Import the Event Class
	// Simpler Classes \/ //
	import simpler.display.IRObject; // Import the IRBasic Class
	
	public dynamic class IRLoadScreen
	{
		private static var s_sInstance:IRLoadScreen; // Store the Instance
		private var m_gGraphic:IRObject = null; // Store the Load Screen Graphic
		private var m_iMinTime:int = 0; // Store the Minimum Load Time
		private var m_gLoadAni:IRObject = null; // Store a Loading Animation
		
		public function IRLoadScreen(LOCK_:IRLockTwo):void
		{
			
		} // Constructor
		
		public static function Load(graphic_:IRObject,minLength_:int):void
		{
			//getInstance()
		} // Load the Graphic
		
		public static function getInstance():IRLoadScreen
		{
			if(!s_sInstance)
			{
				s_sInstance = new IRLoadScreen(new IRLockTwo());
			}
			return s_sInstance;
		} // Return Instance
	} // Class
} // Package
internal class IRLockTwo
{
	
} // Internal Class