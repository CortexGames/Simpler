package simpler.external
{
	// Flash Classes \/ //
	import flash.media.Camera; // Import the Camera Class
	import flash.media.Video; // Import the Video Class
	import flash.system.Capabilities; // Import the Capabilities Class
	// Simpler Classes \/ //
	import simpler.display.IRObject; // Import the IRObject Class
	
	public class IRCamera extends IRObject
	{
		private var m_cCamera:Video; // Store Camera Stream
		
		public function IRCamera(index_:String = null,width_:Number = 0,height_:Number = 0):void
		{
			name = "Flash";
			ClassName = "IRCamera";
			var Cam:Camera; // References the Hardware
			Cam = Camera.getCamera(); // Get a Camera
			if(Cam)
			{
				if(width_ == 0 || height_ == 0)
				{
					width_ = Global.STAGEW; // Set the Width
					height_ = Global.STAGEH; // Set the Height
				} // Default Width / Height
				Cam.setMode(width_, height_, 25); // Set the Display Mode
				Cam.setQuality(0,100); // Set the Quality
				m_cCamera = new Video(); // Create a Camera Stream
				m_cCamera.width = Cam.width; // Set the Width
				m_cCamera.height = Cam.height; // Set the Height
				m_cCamera.attachCamera(Cam); // Set Camera to Stream
				Global.FLASHSTAGE.addChild(m_cCamera);
			}
			else
			{
				trace("[Simpler] Error 1006: IRCamera could not locate a camera!");
			}
		} // Return a Camera Stream
		
		public override function Destroy():void
		{
			Global.FLASHSTAGE.removeChild(m_cCamera);
			m_cCamera = null;
			super.Destroy();
		} // Destroy This
	} // Class
} // Package