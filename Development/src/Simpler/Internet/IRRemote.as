package simpler.internet
{
	// Starling Classes \/ //
	import starling.text.TextField; // Import the TextField Class
	// Simpler Classes \/ //
	import simpler.internet.IRPeerToPeer; // Import the IRPeerToPeer Class // Multi
	
	public class IRRemote extends IRPeerToPeer
	{		
		private var m_bHost:Boolean = true; // Is the host // Multi
		private var m_bLoaded:Boolean = false; // Has the Game Loaded
		private var m_sKeyText:TextField; // Store the Display Text
		
		public function IRRemote():void
		{
			super(String(Math.round(Math.random()*100000)+121212)); // Super Constructor
			m_sKeyText = new TextField(200,50,m_sGroupName + "\nRemote Control Key\nhttp://www.cortex.tk/remote/","Verdana",12,0xFFFFFF); // Create the Display Text
			this.addChild(m_sKeyText); // Store the Display Text
		} // Constructor
		
		public function Load():void
		{
			
		} // Load the Game
		
		public override function Update():void
		{
			if(Status == "Connect!")
			{
				if(!m_bLoaded)
				{
					Load();
					m_sKeyText.text = "Connected!";
					m_bLoaded = true;
				}
			}
			else if(!m_bLoaded)
			{
				if(Global.GAMESTATE != Global.NEWSTATE)
				{
					this.removeChild(m_sKeyText);
					Delete();
				}
			}
		} // Run Every Frame
		
		protected override function receiveMessage(message_:Object):void
		{
			if(message_.key is int && message_.value is Boolean)
			{
				trace(message_.key,message_.value);
				Global.KEYS[message_.key] = message_.value;
			} // Handle Keyboard Events
		} // Handle Incoming Messages
	} // Class
} // Package