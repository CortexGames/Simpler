package Simpler.Internet
{
	// Flash Classes \/ //
	import flash.events.Event; // Import the Event Class
	import flash.events.EventDispatcher; // Import the EventDispatcher Class
	import flash.net.*; // Import the net Classes
	import flash.events.IOErrorEvent; // Import the IOErrorEvent Class
	import flash.external.ExternalInterface; // Import the ExternalInterface Class
	/**IRConnect allows for connections to a server.<br />
	 * You can send and recv data to a server, to send data simply specify the data with the url 
	 * and then you can access the data via the post request under the name of DATA. ($_POST['DATA'])<br /><br />
	 * You can also recieve data from the server, this is any text outputted by the server which is accessible via
	 * the RecvData get function. <br /><br />
	 * @see URLLoader
	 * @see URLRequest
	 */
	public class IRConnect extends EventDispatcher
	{
		private var m_sURL:String; // Store URL
		private var m_sData:String; // Store Sent Data
		private var m_sRecv:String; // Store Recieved Data
		private var m_sStat:String; // Store Status
		private var m_uReq:URLRequest; // Create a new URLRequest
		private var m_uLoa:URLLoader = new URLLoader(); // Create a new URLLoader
		private var m_uVar:URLVariables = new URLVariables(); // Create a new URLVariable
		public static const SUCCESS:String = "success"; // Event Listener Constant
		
		public function IRConnect(url_:String = "",data_:String = ""):void
		{
			Load(url_,data_); // Load URL	
		} // Constructor
		
		public function Load(url_:String = "",data_:String = ""):void
		{
			if(url_.length > 0)
			{
				m_sStat = "Connecting!"; // Set the Status
				m_sURL = url_; // Store the URL
				m_sData = data_; // Store sent data
				m_uReq = new URLRequest(url_); // Set URLRequest Location
				m_uReq.method = URLRequestMethod.POST; // Set URLRequest Method
				m_uLoa.addEventListener(Event.COMPLETE,onConnect); // Add Event Listener
				m_uLoa.addEventListener(IOErrorEvent.IO_ERROR,onError);
				m_uVar.DATA = data_; // Set the Data
				data_ += "&" + ExternalInterface.call("window.location.href.toString");
				m_uReq.data = m_uVar; // Add the Data
				m_uLoa.load(m_uReq); // Load the URL
			}
		} // Load URL
		
		private function onConnect(e:Event):void
		{
			if(String(e.target.data).length > 0)
			{
				m_sRecv = String(e.target.data); // Store Data
				m_sStat = "SuccessData"; // Data Returned
			}
			else
			{
				m_sStat = "Success"; // Successful Connection
			}
			dispatchEvent(new Event(SUCCESS)); // Dispatch Success Event
		} // Loaded URL
		
		private function onError(e:IOErrorEvent):void
		{
			trace("[Simpler] Error 1005: " + e.errorID);
			m_sStat = "Error";
		} // Error Occured
		
		public function get URL():String
		{
			return m_sURL;
		} // Return URL
		
		public function get SentData():String
		{
			return m_sData;
		} // Return Sent Data
		
		public function get RecvData():String
		{
			return m_sRecv;
		} // Return Recieved Data
		
		public function get Status():String
		{
			return m_sStat;
		} // Return Status
	} // Class
} // Package