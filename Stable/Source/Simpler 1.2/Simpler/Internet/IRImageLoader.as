package Simpler.Internet{ // Loads an image via a URL
	// Flash Classes \/ //
	import flash.display.Loader; // Import the Loader Class
	import flash.events.Event; // Import the Event Class
	import flash.net.URLRequest; // Import the URLRequest Class
	import flash.display.Bitmap; // Import the Bitmap Class
	import flash.events.IOErrorEvent; // Import the IOErrorEvent Class
	// Starling Classes \/ //
	import starling.textures.Texture; // Import the Texture Class
	import starling.display.Image; // Import the Image Class
	// Custom Classes \/ //
	import Simpler.Display.IRObject; // Import the IRObject Class
	public class IRImageLoader extends IRObject
	{
		private var m_uURLLoa:Loader = new Loader(); // Create the Loader
		private var m_uURLReq:URLRequest; // Loads the m_uURL
		private var m_sURL:String = ""; // Store the URL
		private var m_dData:Bitmap; // Store the Bitmap
		private var m_dImage:Image; // Store the Image
		private var m_nTempWidth:Number = 100; // Store the Temp Width
		private var m_nTempHeight:Number = 100; // Store the Temp Height
		
		public function IRImageLoader(x_:int,y_:int,url_:String = "",w_:Number = 100,h_:Number = 100):void
		{
			ClassName = "IRImageLoader"; // Set the Class Name
			m_sURL = url_; // Store Image URL
			m_uURLReq = new URLRequest(url_); // Set the m_uURL
			this.x = x_; // Set the X
			this.y = y_; // Set the Y
			m_nTempWidth = w_; // Set the Width
			m_nTempHeight = h_; // Set the Height
			m_uURLLoa.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError); // Add Event Listener
			m_uURLLoa.load(m_uURLReq); // Load m_uURL
			m_uURLLoa.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete); // Add Event Listener
		} // Constructor
		
		private function onError(e:IOErrorEvent):void
		{
			// Do Nothing
		}
		
		public function get URL():String
		{
			return m_sURL;
		} // Return the URL
		
		public function GetData():Bitmap
		{
			return new Bitmap(Bitmap(m_uURLLoa.content).bitmapData);
		} // Return the Image
		
		public function Load(url_:String):void
		{
			m_uURLReq = new URLRequest(url_); // Set the m_uURL
			m_uURLLoa.load(m_uURLReq); // Load m_uURL
		} // Load a new m_uURL
		
		private function onComplete(e:Event):void
		{
			m_dData = new Bitmap(Bitmap(m_uURLLoa.content).bitmapData); // Store the Image
			m_dImage = new Image(Texture.fromBitmap(m_dData));
			m_dImage = new Image(Texture.fromBitmap(new Bitmap(Bitmap(m_uURLLoa.content).bitmapData)));
			m_dImage.x = (m_nTempWidth * 0.5) * -1;
			m_dImage.y = (m_nTempHeight * 0.5) * -1;
			m_dImage.width = m_nTempWidth; // Set the Width
			m_dImage.height = m_nTempHeight; // Set the Height
			this.addChild(m_dImage); // Add the Image
		} // When Loaded
	} // Class
} // Package