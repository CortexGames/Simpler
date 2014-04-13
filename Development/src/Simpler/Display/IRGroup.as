package simpler.display
{
	// Starling Classes \/ //
	import starling.display.Sprite; // Import the Sprite Class
	// Simpler Classes \/ //
	import simpler.display.IRObject; // Import the IRObject Class
	/**IRGroup stores multiple instances of Display Objects<br />
	 * Use this class to group graphics together. Updates and other events
	 * will not be called on items in IRGroups.<br /><br />
	 * @see IRObject
	 */
	public class IRGroup extends IRObject
	{
		protected var m_aObjects:Array = new Array(); // Store Display Objects
		protected var m_dDisplay:Sprite = new Sprite(); // Display Object, Display List
		
		public function IRGroup(...objects_):void
		{
			ClassName = "IRGroup"; // Set the Class Name
			this.addChild(m_dDisplay); // Add Display Container to this
			for(var i:int = 0;i < objects_.length;i++)
			{
				m_aObjects.push(objects_[i]); // Add to the Array
				m_dDisplay.addChild(m_aObjects[m_aObjects.length-1]); // Add to the Display
			}
		} // Constructor
		
		/**push allows objects to be added to this IRGroup.<br />
		 * Use push like you would use push in an array, the only difference is this
		 * will add each item to the display list.<br /><br />
		 */
		public function push(...objects_):void
		{
			for(var i:int = 0;i < objects_.length;i++)
			{
				m_aObjects.push(objects_[i]);
				m_dDisplay.addChild(m_aObjects[m_aObjects.length-1]);
			}
		} // Add Objects
		
		/**pop will remove the last item from IRGroup<br />
		 * pop will remove and return the last item added to the IRGroup, it will return null
		 * if it is empty.<br /><br />
		 */
		public function pop():*
		{
			if(m_aObjects.length > 0)
			{
				m_dDisplay.removeChild(m_aObjects[m_aObjects.length-1]);
				var temp:IRObject = m_aObjects.pop();
				return temp;
			}
			return null;
		} // Remove Object
		
		public override function Destroy():void
		{
			while(m_aObjects.length)
			{
				m_aObjects.pop();
			} // Remove all objects from Array
			for(var i:int = 0;i < m_dDisplay.numChildren;i++)
			{
				m_dDisplay.removeChildAt(i,true);
			} // Remove objects from Display
			this.removeChild(m_dDisplay); // Remove Display from this
			m_dDisplay = null; // Null Display
			m_aObjects = null; // Null Array
			super.Destroy(); // Super Destructor
		} // Deconstructor
	} // Class
} // Package