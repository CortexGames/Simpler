package simpler.display
{
	// Starling Classes \/ //
	import starling.display.DisplayObject; // Import the DisplayObject Class
	// Simpler Classes \/ //
	import simpler.display.IRObject; // Import the IRObject Class
	
	/**IRConvert wraps a single graphic as an IRObject.<br />
	 * IRConvert is a memory conservative version of IRGroup and is recommended.<br /><br />
	 */
	public class IRConvert extends IRObject
	{
		public function IRConvert(object_:DisplayObject):void
		{
			this.addChild(object_); // Add the child to this
		} // Constructor
		
		/**Graphic gives access to the child.<br />
		 */
		public function get Graphic():DisplayObject
		{
			return this.getChildAt(0);
		} // Return the Graphic
		public function set Graphic(graphic_:DisplayObject):void
		{
			this.removeChildAt(0);
			this.addChild(graphic_);
		} // Return the Graphic
		
		public override function Destroy():void
		{
			this.removeChildAt(0,true); // Remove the child from this
			super.Destroy(); // Super Deconstructor
		} // Deconstructor
	} // Class
} // Package