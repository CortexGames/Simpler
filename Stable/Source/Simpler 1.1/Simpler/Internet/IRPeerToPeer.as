package Simpler.Internet
{
	// Flash Classes \/ //
	import flash.events.Event; // Import the Event Class
	import flash.net.NetConnection; // Import the NetConnection Class
	import flash.net.NetStream; // Import the NetStream Class
	import flash.net.GroupSpecifier; // Import the GroupSpecifier Class
	import flash.net.NetGroup; // Import the NetGroup Class
	import flash.net.SharedObject; // Import the SharedObject Class
	import flash.events.NetStatusEvent; // Import the NetStatusEvent Class
	// Simpler Classes \/ //
	import Simpler.Internet.IRConnect; // Import the IRConnect Class
	import Simpler.Internet.IRPacket; // Import the IRPacket Class
	import Simpler.Display.IRObject; // Import the IRObject Class
	
	public class IRPeerToPeer extends IRObject
	{
		protected const CirrusAddress:String = "rtmfp://p2p.rtmfp.net/"; // Address
		protected const DeveloperKey:String = "829249f4c11fcd8863f8ae4f-af624344022f"; // Developer Key
		protected var m_nConnect:IRConnect; // Store Connection to Server
		protected var m_nConnection:NetConnection; // Used for Communications
		protected var m_nNetGroup:NetGroup; // Used to share info
		protected var m_sUser:String = "UserID" + Math.round(Math.random()*10000); // User's Unique ID
		protected var m_bOnline:Boolean = false; // Are we connected
		protected var m_iMessageID:int = 0; // Store Message ID's DELETE
		protected var m_oMessage:IRPacket = new IRPacket(); // Store Data
		protected var m_cRemoteSO:SharedObject; // Store a Shared Object
		protected var m_sGroupName:String = ""; // Store the Group Name
		protected var m_sStatus:String = "Loading"; // Store the Status
		
		public function IRPeerToPeer(lobby_:String):void
		{
			m_sGroupName = lobby_; // The lobby / group you join!
			m_nConnection = new NetConnection(); // New NetConnection
			m_nConnection.addEventListener(NetStatusEvent.NET_STATUS, onNetEvent); // Listen for it
			m_nConnection.connect(CirrusAddress, DeveloperKey); // Connect to Adobe
		} // Constructor
		
		private function SetupGroup():void
		{
			var m_gSpecs:GroupSpecifier = new GroupSpecifier(m_sGroupName); // Create a Group Identifier
			m_gSpecs.serverChannelEnabled = true; // Use Server Channel
			m_gSpecs.postingEnabled = true; // Allow Posting
			m_nNetGroup = new NetGroup(m_nConnection,m_gSpecs.groupspecWithAuthorizations()); // Create a NetGroup
			m_nNetGroup.addEventListener(NetStatusEvent.NET_STATUS, onNetEvent); // Listen to the NetGroup
			//trace("Members:",String(m_nNetGroup.estimatedMemberCount));
		} // Create a Group Connection
		
		private function SetupShared():void
		{
			m_cRemoteSO = SharedObject.getRemote("TestObject", m_nConnection.uri, false);
			m_cRemoteSO.connect(m_nConnection);
			m_cRemoteSO.addEventListener(NetStatusEvent.NET_STATUS, onNetEvent);
		} // Create a Shared Object
		
		protected function onNetEvent(e:NetStatusEvent):void // HANDLE MORE STUFFS
		{
			//trace(e.info.code);
			switch(e.info.code){
				case "NetConnection.Connect.Success": // Handle new connection
					SetupGroup();
					break;
				case "NetGroup.Connect.Success": // Handle NetGroup Connection
					m_bOnline = true;
					var obj:Object = new Object();
					obj.text = "< That's my name!";
					sendMessage(obj);
					break;
				case "NetGroup.Posting.Notify": // Handle Message Recieval
					receiveMessage(e.info.message);
					break;
				case "NetGroup.Neighbor.Connect": // Handle New Neighbor
					//SetupShared();
					m_sStatus = "Connect!";
					break;
				case "NetGroup.Neighbor.Disconnect": // Handle Disconnected Neighbor
					
					break;
				default: // Handle Unknown Data
					
					break;
			}
		} // Connection Event
		
		public function sendMessage(message_:Object):void // MODIFY FUNCTION
		{
			//var m_oData:Object = new Object();
			message_.sender = m_nNetGroup.convertPeerIDToGroupAddress(m_nConnection.nearID);
			message_.user = m_sUser;
			message_.sequence = m_iMessageID++;
			m_nNetGroup.post(message_);
		} // Send a Message
		
		protected function receiveMessage(message_:Object):void // MODIFY FUNCTION
		{
			//trace(message_.user + ": " + message_.text);
		} // Handle Incoming Messages
		
		public function get Status():String
		{
			return m_sStatus;
		}
	}
} // Package