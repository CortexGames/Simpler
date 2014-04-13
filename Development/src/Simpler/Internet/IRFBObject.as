package simpler.internet
{
	public class IRFBObject
	{
		private var m_sFirstName:String = ""; // Store the First Name
		private var m_sLastName:String = ""; // Store the Last Name
		private var m_sUserName:String = ""; // Store the User Name
		private var m_sID:String = ""; // Store the ID
		private var m_sGender:String = ""; // Store the Gender
		private var m_sGameData:String = ""; // Store Some GameData
		
		public function IRFBObject(first_:String = "", last_:String = "", user_:String = "", id_:String = "", gender_:String = "", gamedata_:String = ""):void
		{
			m_sFirstName = first_; // Set the First Name
			m_sLastName = last_; // Set the Last Name
			m_sUserName = user_; // Set the User Name
			m_sID = id_; // Set the ID
			m_sGender = gender_; // Set the Gender
			m_sGameData = gamedata_; // Set Some GameData
		} // Constructor
		
		public function get FirstName():String
		{
			return m_sFirstName;
		} // Return the First Name
		
		public function get LastName():String
		{
			return m_sLastName;
		} // Return the Last Name
		
		public function get FullName():String
		{
			return m_sFirstName + " " + m_sLastName;
		} // Return the Full Name
		
		public function get UserName():String
		{
			return m_sUserName;
		} // Return the User Name
		
		public function get ID():String
		{
			return m_sID;
		} // Return User ID
		
		public function get Gender():String
		{
			return m_sGender;
		} // Return the Gender
		
		public function get GameData():String
		{
			return m_sGameData;
		} // Return Game Data
	} // Class
} // Package