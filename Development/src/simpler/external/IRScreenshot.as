package simpler.external
{
	// Flash Classes \/ //
	import flash.display.BitmapData; // Import the BitmapData Class
	// Starling Classes \/ //
	import starling.core.RenderSupport; // Import the RenderSupport Class
	import starling.core.Starling; // Import the Starling Class
	import starling.display.Image; // Import the Image Class
	import starling.textures.Texture; // Import the Texture Class
	// Simpler Classes \/ //
	import simpler.display.IRObject; // Import the IRObject Class
	
	/**IRScreenshot will take a Screenshot unpon Creation.<br />
	 * Use this class to take a Screenshot of the stage.<br /><br />
	 */
	public class IRScreenshot extends IRObject
	{
		private var m_dScreenShot:BitmapData = null; // Store the Screen Shot
		private var m_rSupport:RenderSupport; // Store the Render Support
		
		public function IRScreenshot():void
		{
			m_rSupport = new RenderSupport(); // Create a new Render Support
			RenderSupport.clear(Global.STAGE.stage.color, 1.0); // Clear the Stage
			m_rSupport.setOrthographicProjection(0,0,Global.STAGEW,Global.STAGEH); // Set the Render Mode
			Global.STAGE.stage.render(m_rSupport, 1.0); // Force a render
			m_rSupport.finishQuadBatch(); // Process current Render
			m_dScreenShot = new BitmapData(Global.STAGEW,Global.STAGEH); // Create a new BitmapData Object
			Starling.context.drawToBitmapData(m_dScreenShot); // Draw Screen Shot
			this.addChild(new Image(Texture.fromBitmapData(m_dScreenShot))); // Add to this
			m_rSupport = null; // Set the Render Support to null
		} // Constructor
		
		/**Data will return the BitmapData that is the Screenshot.<br />
		 */
		public function get Data():BitmapData
		{
			return m_dScreenShot;
		} // Return the BitmapData
		
		public override function Destroy():void
		{
			this.removeChildAt(0,true); // Remove the Child
			m_dScreenShot = null; // Set the Bitmap data to null
			super.Destroy(); // Super Deconstructor
		} // Deconstructor
	} // Class
} // Package