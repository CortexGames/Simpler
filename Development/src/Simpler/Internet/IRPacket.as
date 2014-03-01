package Simpler.Internet
{
	public class IRPacket
	{
		public var All:Boolean = false; // For all users?
		public var To:String = null; // Someone Specific
		public var From:String = null; // User ID
		public var XPos:Number = 0; // X Position
		public var YPos:Number = 0; // Y Position
		public var Message:String = null; // A Message
		public var Unique:int = 0; // Duplicate Message Protection
		public var Sender:String = null; // For NetGroup Stuffs
		
		public function IRPacket():void
		{
			
		} // Constructor
	} // Class
} // Package
// This class represent's a Packet of data