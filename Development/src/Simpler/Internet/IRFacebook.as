package Simpler.Internet
{
	// Facebook Classes \/ //
	import Simpler.Game.IRGlobal;
	import Simpler.Internet.IRFBObject;
	
	import com.adobe.serialization.json.JSON;
	import com.facebook.graph.FacebookMobile;

 // Import the IRFBObject Class
	
	public class IRFacebook
	{
		private var m_sAppID:String = "YOUR_APP_ID"; // Place your application id here
		private var m_bLoggedIn:Boolean = false; // Is the User Logged in?
		private var m_cYourself:IRFBObject; // This represents the user
		private var m_sRequestType:String = ""; // The request being made
		private var m_aFriends:Array = new Array(); // Store all Friends
		
		public function IRFacebook(appid_:String = ""):void
		{
			trace("[Simpler] Created!");
			m_sAppID = appid_;
			FacebookMobile.init(m_sAppID, onInit);
		} // Constructor
		
		protected function onInit(result:Object, fail:Object):void
		{
			if(result)
			{
				m_bLoggedIn = true;
				trace("[Simpler] Logged In");
				LoginSucceeded(result);
			} // Logged in already
			else
			{
				m_bLoggedIn = false;
				trace("[Simpler] Attempt Failed");
				AttemptLogin();
			} // Not logged in
		} // Login Attempted (Application Loaded)
		
		protected function AttemptLogin():void
		{
			if(!m_bLoggedIn)
			{
				//var opts:Object = {scope:"publish_stream, user_photos"};
				FacebookMobile.login(onLogin, IRGlobal.getInstance().FLASHSTAGE, new Array("read_stream"));
				//FacebookMobile.login(onLogin, "read_stream"); //, opts);
			} // Prompt for Login
		} // Handle Login Request
		
		protected function onLogin(result:Object, fail:Object):void
		{
			if(result)
			{
				m_bLoggedIn = true;
				trace("[Simpler] Logged In");
				LoginSucceeded(result);
			} // Login Successful
			else
			{
				m_bLoggedIn = false;
				trace("[Simpler] Attempt Failed");
			} // Login Failed
		} // Login Attempted (User Attempted)
		
		protected function LoginSucceeded(result_:Object):void
		{
			SetSelf(result_);
			m_sRequestType = "Friends";
			SendGet(m_cYourself.ID + "/friends/");
			//SendGet(m_cYourself.ID + "/feed/");
		} // Login Succeeded
		
		protected function AttemptLogout():void
		{
			if(m_bLoggedIn)
			{
				FacebookMobile.logout(onLogout);
			} // Logout
		} // Handle Logout Request
		
		protected function onLogout(success:Boolean):void
		{
			if(success)
			{
				m_bLoggedIn = false;
			} // Successfully Logged Out
			else
			{
				m_bLoggedIn = true;
			} // Failed to Log Out (Still Logged In?)
		} // Logout Attempted
		
		protected function SendPost(method_:String,parameters_:String):void
		{
			var params:Object = null;
			try
			{
				params = com.adobe.serialization.json.JSON.decode(parameters_);
			}
			catch (e:Error)
			{
				trace("[Simpler] JSON Error: " + e.message);
			}
			FacebookMobile.api(method_, onCallApi, params, "POST");
		} // POST to Facebook
		
		protected function SendGet(method_:String):void
		{
			FacebookMobile.api(method_, onCallApi, null, "GET");
		} // GET to Facebook
		
		protected function onCallApi(result:Object, fail:Object):void
		{
			if(result)
			{
				switch(m_sRequestType)
				{
					case "Friends":
						for(var i:int = 0;i < result.length;i++)
						{
							m_aFriends.push(new IRFBObject(result[i].name.split(" ")[0],result[i].name.split(" ")[1],"",result[i].id));
						}
						break;
					case "Feed":
						// News Feed Happens Here!
						break;
					default:
						trace("[Simpler] Request: " + com.adobe.serialization.json.JSON.encode(result));
				}
				m_sRequestType = "";
			} // Success
			else
			{
				trace("[Simpler] Error: " + com.adobe.serialization.json.JSON.encode(fail)); 
			} // Failed
		} // Response from Request
		
		private function SetSelf(result_:Object):void
		{
			m_cYourself = new IRFBObject(result_.user.first_name,result_.user.last_name,result_.user.username,result_.user.id,result_.user.gender);
		} // Set Self
		
		public function get Friends():Array
		{
			return m_aFriends;
		} // Return all Facebook Friends
		
		public function get GameFriends():Array
		{
			return new Array();
		} // Return all Facebook Friends with the Game
		
		public function get YourSelf():IRFBObject
		{
			return m_cYourself;
		} // Return information about you
		
		public function get LoginStatus():Boolean
		{
			return m_bLoggedIn;
		} // Return the Login Status
	} // Class
} // Package