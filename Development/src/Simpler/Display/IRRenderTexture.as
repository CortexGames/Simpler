package simpler.display
{
	// Starling Classes \/ //
	import starling.textures.RenderTexture; // Import the RenderTexture Class
	import starling.display.Image; // Import the Image Class
	// Simpler Classes \/ //
	import simpler.display.IRObject; // Import the IRObject Class
	
	public class IRRenderTexture extends IRObject
	{
		private var m_rTexture:RenderTexture; // Store a Render Texture
		
		public function IRRenderTexture(width_:Number,height_:Number,object_:IRObject = null):void
		{
			m_rTexture = new RenderTexture(width_,height_); // Set the Render Texture Size
			if(object_ != null)
			{
				m_rTexture.draw(object_); // Draw the Object
			}
			this.addChild(new Image(m_rTexture)); // Add the Image to this
		} // Constructor
		
		public function DrawAt(x_:Number,y_:Number,object_:IRObject):void
		{
			object_.x = x_; // Set the X
			object_.y = y_; // Set the Y
			Draw(object_); // Draw the Object
		} // Draw to Texture at Location
		 
		public function Draw(object_:IRObject):void
		{
			m_rTexture.draw(object_); // Draw the Object to the Texture
		} // Draw to Texture
		
		public function Clear():void
		{
			m_rTexture.clear(); // Clear the Render Texture
		} // Clear the Render Texture
	} // Class
} // Package