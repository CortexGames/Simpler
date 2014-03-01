package Simpler.Display{ // Version 0.95
	// Starling Classes \/ //
	import starling.display.Sprite; // Import the Sprite Class
	// Simpler Classes \/ //
	import Simpler.Game.IRGlobal; // Import the IRGlobal Class
	/**IRObject is the most basic class of Simpler.<br />
	 * All Simpler / User Classes should extend this class if they are to be used in the 
	 * display list.<br /><br />
	 * @see Sprite
	 */
	public class IRObject extends Sprite
	{
		private var m_bDelete:Boolean = false; // Delete this instance
		private var m_bConstant:Boolean = false; // Protect from Deletion
		private var m_sClass:String = "IRObject"; // Store the Class Name
		private var m_aCollisions:Array = new Array(); // Store Collision Object References
		private static var s_iID:int = 0; // Track the Unique ID's
		protected var m_iUniqueID:int = 0; // Store the Unique ID
		protected static var OriginalStageWidth:int = 960; // Store the Original Stage Width NEW
		protected static var OriginalStageHeight:int = 540; // Store the Original Stage Height NEW
		
		public function IRObject():void
		{
			m_sClass = "IRObject"; // Set the Class Name
			m_iUniqueID = s_iID++; // Set the Unique ID
		} // Constructor
		
		/**Update is run once each program loop.<br />
		 * The update function is run every frame and should be used instead of the enter
		 * frame event<br /><br />
		 */
		public function Update():void
		{
			
		} // Run Every Frame
		
		/**Delete is used to remove an object.<br />
		 * All items maked with Delete will be removed at the end of the current update
		 * loop. Delete will invoke the Destroy function and removeChild will be called
		 * on the object.<br /><br />
		 * @see Destroy
		 * @see IsDeleted
		 * @see Zombie
		 */
		public function Delete():void
		{
			m_bDelete = true;
		} // Delete Instance
		
		/**Destroy is the deconstructor.<br />
		 * Use Destroy to remove references and perform any functions before an object is
		 * removed! Destroy should null all variables which store complex references.<br /><br />
		 * @see Destroy
		 * @see IsDeleted
		 */
		public function Destroy():void
		{
			for(var i:int = 0;i < this.numChildren;i++)
			{
				this.removeChildAt(i,true);
			} // Remove all Children
			this.dispose(); // Call Starling Dispose
		} // Deconstructor
		
		/**isDeleted checks if Delete was called.<br />
		 * If something isDeleted by the Delete function this will return true.
		 * Remember delete will remove something at the end of the current update.<br /><br />
		 * @see Delete
		 * @see IsDeleted
		 */
		public function get isDeleted():Boolean
		{
			return m_bDelete;
		} // Return Delete Status
		
		/**Zombie will save something from the Delete call.<br />
		 * The Zombie function might be needed where something was previously deleted
		 * but a reference was kept to recreate the object later. This function will
		 * untag an object marked with the Delete function.<br /><br />
		 * @see Delete
		 * @see IsDeleted
		 * @see Destroy
		 */
		public function Zombie():void
		{
			m_bDelete = false;
		} // Un-Delete this
		
		/**Constant lets you protect this between state changes.<br />
		 * If you define an object as Constant it will not be deleted by the engine
		 * when changing the game state by SetState().<br /><br />
		 * @see Delete
		 */
		public function get Constant():Boolean
		{
			return m_bConstant;
		} // Is this Constant
		public function set Constant(value_:Boolean):void
		{
			m_bConstant = value_;
		} // Set to Constant
		
		/**Global lets you access IRGlobal.<br />
		 * Using this call lets you access the IRGlobal singleton without needing to import
		 * the IRGlobal class.<br /><br />
		 * @see IRGlobal
		 */
		public function get Global():IRGlobal
		{
			return IRGlobal.getInstance();
		} // Get the Global Class
		
		/**ClassName lets you get or set the Class Name.<br />
		 * ClassName allows you to access certain variables based on thier names, class name
		 * doesn't need to represent the actual class name and is good for checking when the 
		 * class name is not known. For example in Collision.<br /><br />
		 */
		public function get ClassName():String
		{
			return m_sClass; // Return Class
		} // Get the Class Name
		public function set ClassName(name_:String):void
		{
			m_sClass = name_;
		} // Set the Class Name
		
		/**Collisions is used when using a Collision Class.<br />
		 * Collisions will return an array containing all collisions that are currently active.
		 * This function relies on a Collision Class being set within the Config function or by
		 * IRGlobal.COLLISION.<br /><br />
		 */
		public function get Collisions():Array
		{
			return m_aCollisions;
		} // Get the Collisions
		public function set Collisions(collisions_:Array):void
		{
			m_aCollisions = collisions_;
		} // Set the Collisions
		
		/**UID is this IRObject's Unique ID.<br />
		 * The UID counts all IRObject's and assigns each with a Unique ID, this is mainly used in
		 * Physics but can be helpful for counting the total objects.<br /><br />
		 */
		public function get UID():int
		{
			return m_iUniqueID;
		} // Return the Unique ID
		
		/**TotalObjects returns the total Objects.<br />
		 * This function will return all the objects that have been created since the application
		 * started, deleted objects count towards the total objects.<br /><br />
		 */
		public function get TotalObjects():int
		{
			return s_iID;
		} // Return the Total UID Count
		
		// NEW \/ //
		
		/**ScaleWithStageWidth will scale this object.<br />
		 * Assuming OriginalStageWidth is set this object will scale using this value as the original
		 * scale.<br /><br />
		 */
		protected function ScaleWithStageWidth(width_:Number,round_:Boolean = false):Number
		{
			if(OriginalStageWidth != 0)
			{
				var percent:Number = width_ / OriginalStageWidth; // Scale with Original Stage Width
				if(round_)
				{
					percent = Math.round(percent * 100) / 100; // Move to 2 decimal places
				}
				return Global.STAGEW * percent; // Return the new Width
			}
			return width_;
		}
		
		/**ScaleWithStageHeight will scale this object.<br />
		 * Assuming OriginalStageHeight is set this object will scale using this value as the original
		 * scale.<br /><br />
		 */
		protected function ScaleWithStageHeight(height_:Number,round_:Boolean = false):Number
		{
			if(OriginalStageHeight != 0)
			{
				var percent:Number = height_ / OriginalStageHeight; // Scale with Original Stage Height
				if(round_)
				{
					percent = Math.round(percent * 100) / 100; // Move to 2 decimal places
				}
				return Global.STAGEH * percent; // Return the new Height
			}
			return height_;
		}
	} // Class
} // Package