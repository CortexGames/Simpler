package Simpler.Internet{
	// Simpler Classes \/ //
	import Simpler.Internet.IRConnect; // Import the IRConnect Class
	import Simpler.Display.IRObject; // Import the IRObject Class
	public class IRScoreBoard extends IRObject
	{
		private var m_cConnection:IRConnect; // Store the Connection
		private var m_sURL:String; // Store the URL
		private var m_sGameName:String; // Store the Game Name
		private var m_sStatus:String = "Loading"; // Store the Status
		private var m_aDisplay:Array = new Array(); // Store TextFields and Buttons
		
		public function IRScoreBoard(url_:String,gamename_:String,username_:String = "",score_:String = ""):void
		{
			m_sURL = url_; // Set the URL
			m_sGameName = gamename_; // Set the Game Name
			SubmitScore(username_,score_); // Submit Score
		} // Constructor
		
		public override function Update():void
		{
			
		} // Run Every Frame
		
		private function CreateDisplay():void
		{
			
		} // Create the Display
		
		private function SubmitScore(username_:String,score_:String):void
		{
			var data_:String = "SUBMIT";
			if(m_sGameName.length > 1)
			{
				data_ += "&" + m_sGameName;
				if(username_.length > 1)
				{
					data_ += "&" + username_;
					if(score_.length > 1)
					{
						data_ += "&" + score_;	
					}
				}
				m_cConnection = new IRConnect(m_sURL,data_);
			}
		} // Submit a score
		
		private function GetScores(username_:String = ""):void
		{
			if(username_.length > 1)
			{
				if(m_sURL.length > 1)
				{
					if(m_sGameName.length > 1)
					{
						m_cConnection = new IRConnect(m_sURL,"GET&" + m_sGameName + "&" + username_);
					}
				}
			}
			else
			{
				if(m_sURL.length > 1)
				{
					if(m_sGameName.length > 1)
					{
						m_cConnection = new IRConnect(m_sURL,"GET&" + m_sGameName);
					}
				}
			}
		} // Get Scores
		
		private function get Status():void
		{
			return m_sStatus;
		} // Return the Status
	} // Class
} // Package