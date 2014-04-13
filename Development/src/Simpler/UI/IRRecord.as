package simpler.ui
{
	// Simpler Classes \/ //
	import simpler.display.IRObject; // Import the IRObject Class
	/**IRRecord allows input to be recorded.<br />
	 * Input can be recorded and played using this class, Input can also be saved as 
	 * text and loaded again. Using this class DOES take over input so it's not 
	 * always possible to stop the recording until it's done.<br /><br />
	 */
	public class IRRecord extends IRObject
	{
		private var m_bMouse:Boolean = true; // Record Mouse Controls
		private var m_bKeyboard:Boolean = true; // Record Keyboard Controls
		private var m_bRecord:Boolean = false; // Record the Actions
		private var m_bPlay:Boolean = false; // Play the Actions
		private var m_aMouseInput:Array = new Array(); // Store the Actions // ([Time Since Change],[MouseDown],[MouseReleased],[MouseX],[MouseY])
		private var m_iMouseChange:int = 0; // Store the Frames Since the Last Action
		private var m_iMouseIndex:int = 0; // Store the Mouse Index
		private var m_aKeyboardInput:Array = new Array(); // Store the Actions // ([Time Since Change],[True Key Values])
		private var m_iKeyboardChange:int = 0; // Store the Frames Since the Last Action
		private var m_iKeyboardIndex:int = 0; // Store the Keyboard Index
		private var MOUSEDOWN:Boolean = false; // Mouse is Pressed
		private var MOUSERELEASED:Boolean = false; // Mouse is Released
		private var MOUSEX:Number = -1; // Mouse X Position
		private var MOUSEY:Number = -1; // Mouse Y Position
		private var KEYS:Array = new Array(); // Store all key states
		
		public function IRRecord(mouse_:Boolean = true,keyboard_:Boolean = true,record_:Boolean = false):void
		{
			ClassName = "IRRecord";
			m_bMouse = mouse_; // Record the Mouse
			m_bKeyboard = keyboard_; // Record the Keyboard
			if(record_)
			{
				Record(mouse_,keyboard_); // Record
			} // Record Now?
		} // Constuctor
		/**isPlaying lets you know if input is being played.<br />
		 */
		public function get isPlaying():Boolean
		{
			return m_bPlay;
		} // Is Playing
		/**isRecording lets you know if input is being recorded.<br />
		 */
		public function get isRecording():Boolean
		{
			return m_bRecord;
		} // Is Recording
		/**isRunning lets you know if input is being played or recorded.<br />
		 */
		public function get isRunning():Boolean
		{
			if(isPlaying || isRecording)
			{
				return true;
			}
			return false;
		} // Is Playing or Recording
		
		/**Record lets you record mouse and/or keyboard input.<br />
		 */
		public function Record(mouse_:Boolean = true,keyboard_:Boolean = true):void
		{
			if(!m_bPlay && !m_bRecord)
			{
				m_iMouseChange = 0; // Reset Mouse FPS
				m_iKeyboardChange = 0; // Reset Keyboard FPS
				m_bMouse = mouse_; // Record the Mouse
				m_bKeyboard = keyboard_; // Record the Keyboard
				SetLocalMouse(); // Set the Mouse Values
				SetLocalKeys(); // Set the Keyboard Values
				m_bRecord = true; // Start Recording
			} // Only if not Playing or Recording
		} // Record Input
		
		/**Stop stops recording and playback of input.<br />
		 */
		public function Stop(mouse_:Boolean = true,keyboard_:Boolean = true):void
		{
			if(m_bPlay || m_bRecord)
			{
				if(mouse_)
				{
					m_bMouse = false;
				}
				if(keyboard_)
				{
					m_bKeyboard = false;
					Global.KEYS = new Array();
				}
				if(!m_bKeyboard && !m_bMouse)
				{
					Global.KEYS = new Array();
					m_bRecord = false; // Stop Recording
					m_bPlay = false; // Stop Playback
					m_iMouseChange = 0; // Reset Mouse FPS
					m_iKeyboardChange = 0; // Reset Keyboard FPS
				}
			} // If Playing / Recording
		} // Stop Recording / Playing
		
		/**Play will play any recorded input loaded.<br />
		 */
		public function Play(mouse_:Boolean = true,keyboard_:Boolean = true):void
		{
			if(!m_bPlay && !m_bRecord)
			{
				m_bMouse = mouse_; // Record the Mouse
				m_bKeyboard = keyboard_; // Record the Keyboard
				m_iMouseChange = 0; // Reset Mouse FPS
				m_iKeyboardChange = 0; // Reset Keyboard FPS
				m_bPlay = true;
			} // Only if not Playing or Recording
		} // Play Actions
		
		/**Clear can delete recorded data.<br />
		 */
		public function Clear(mouse_:Boolean = true,keyboard_:Boolean = true):void
		{
			if(!m_bPlay && !m_bRecord)
			{
				if(mouse_)
				{
					while(m_aMouseInput.length)
					{
						m_aMouseInput.pop();
					}
				}
				if(keyboard_)
				{
					while(m_aKeyboardInput.length)
					{
						m_aKeyboardInput.pop();
					}
				}
			} // Only if not Playing or Recording
		} // Clear Actions
		
		/**MouseRecording lets you access and set the mouse data.<br />
		 */
		public function get MouseRecording():String
		{
			var returnString:String = "";
			for(var i:int = 0;i < m_aMouseInput.length;i++)
			{
				returnString += m_aMouseInput[i][0] + ","; // Change Time
				returnString += asInt(m_aMouseInput[i][1]) + ","; // Mouse Down
				returnString += asInt(m_aMouseInput[i][2]) + ","; // Mouse Released
				returnString += m_aMouseInput[i][3] + ","; // Mouse X
				returnString += m_aMouseInput[i][4] + "&"; // Mouse Y
			}
			return Encrypt(returnString);
		} // Return the Mouse Recording
		public function set MouseRecording(record_:String):void
		{
			var recordArr:Array = Decrypt(record_).split("&");
			var inputArr:Array;
			for(var i:int = 0;i < recordArr.length-1;i++)
			{
				inputArr = new Array();
				inputArr.push(parseInt(recordArr[i].split(",")[0]));
				inputArr.push(asBool(recordArr[i].split(",")[1]));
				inputArr.push(asBool(recordArr[i].split(",")[2]));
				inputArr.push(parseInt(recordArr[i].split(",")[3]));
				inputArr.push(parseInt(recordArr[i].split(",")[4]));
				m_aMouseInput.push(inputArr.slice());
			}
		} // Load a Mouse Recording
		/**KeyboardRecording lets you access and set the keyboard data.<br />
		 */
		public function get KeyboardRecording():String
		{
			var returnString:String = "";
			var keyboardString:String = "";
			for(var i:int = 0;i < m_aKeyboardInput.length;i++)
			{
				keyboardString = "";
				returnString += m_aKeyboardInput[i][0] + ","; // Change Time
				for(var j:int = 0;j < m_aKeyboardInput[i][1].length;j++)
				{
					if(m_aKeyboardInput[i][1][j] == true)
					{
						keyboardString += j + ":";
					}
				} // For all Keys
				returnString += keyboardString + "&"; // Keys Down
			}
			return Encrypt(returnString);
		} // Return the Keyboard Recording
		public function set KeyboardRecording(record_:String):void
		{
			var recordArr:Array = Decrypt(record_).split("&");
			var inputArr:Array;
			for(var i:int = 0;i < recordArr.length-1;i++)
			{
				inputArr = new Array();
				for(var j:int = 0;j < recordArr[i].split(",")[1].split(":").length-1;j++)
				{
					inputArr[parseInt(recordArr[i].split(",")[1].split(":")[j])] = true;
				} // For all Keys
				m_aKeyboardInput.push(new Array(parseInt(recordArr[i].split(",")[0]),inputArr.slice()));
			}
		} // Load a Keyboard Recording
		
		public override function Update():void
		{
			if(m_bRecord)
			{
				UpdateRecord();
			}
			if(m_bPlay)
			{
				UpdatePlay();
			}
		} // Run Every Frame
		
		private function asInt(bool_:Boolean):int
		{
			if(bool_)
			{
				return 1;
			}
			return 0;
		} // Return an int
		
		private function asBool(string_:String):Boolean
		{
			if(string_ == "1")
			{
				return true;
			}
			return false;
		} // Return a Boolean
		
		private function UpdateRecord():void
		{
			if(m_bMouse)
			{
				if(MOUSEDOWN != Global.MOUSEDOWN || MOUSERELEASED != Global.MOUSERELEASED || MOUSEX != Global.MOUSEX || MOUSEY != Global.MOUSEY)
				{
					m_aMouseInput.push(new Array(m_iMouseChange,Global.MOUSEDOWN,Global.MOUSERELEASED,Global.MOUSEX,Global.MOUSEY)); // Push Recording to Array
					SetLocalMouse(); // Set Local Mouse Info
					m_iMouseChange = 0; // Reset Mouse FPS
				} // Input Changed
				m_iMouseChange++; // Increment FPS
			} // Record Mouse
			if(m_bKeyboard)
			{
				if(!isSameKeys())
				{
					m_aKeyboardInput.push(new Array(m_iKeyboardChange,Global.KEYS.slice())); // Push Recording to Array
					SetLocalKeys(); // Set Local Key Info
					m_iKeyboardChange = 0; // Reset Keyboard FPS
				} // Input Changed
				m_iKeyboardChange++; // Increment FPS
			} // Record Keyboard
		} // Update Recording
		
		private function UpdatePlay():void
		{
			if(m_bMouse)
			{
				if(m_aMouseInput.length == 0)
				{
					m_iMouseIndex = 0; // Reset the Index
					Stop(true,false); // Stop Playback
				}
				else if(m_aMouseInput[m_iMouseIndex][0] == m_iMouseChange)
				{
					SetGlobalMouse(); // Set Global Variables
					m_iMouseIndex++; // Increment the Index
					if(m_iMouseIndex == m_aMouseInput.length)
					{
						m_iMouseIndex = 0; // Reset the Index
						Stop(true,false); // Stop Playback
					} // End of Recording
					m_iMouseChange = 0; // Reset FPS Count
				} // Action Occured
				m_iMouseChange++; // Increment FPS Count
			} // Play Mouse Actions
			if(m_bKeyboard)
			{
				if(m_aKeyboardInput.length == 0)
				{
					m_iKeyboardIndex = 0; // Reset the Index
					Stop(false,true); // Stop Playback
				}
				else if(m_aKeyboardInput[m_iKeyboardIndex][0] == m_iKeyboardChange)
				{
					Global.KEYS = m_aKeyboardInput[m_iKeyboardIndex][1].slice(); // Set Global Variables
					m_iKeyboardIndex++; // Increment the Index
					if(m_iKeyboardIndex == m_aKeyboardInput.length)
					{
						m_iKeyboardIndex = 0; // Reset the Index
						Stop(false,true); // Stop Playback
					} // End of Recording
					m_iKeyboardChange = 0; // Reset FPS Count
				} // Action Occured
				m_iKeyboardChange++; // Increment FPS Count
			} // Play Keyboard Actions
		} // Update Play
		
		private function SetLocalMouse():void
		{
			MOUSEDOWN = Global.MOUSEDOWN;
			MOUSERELEASED = Global.MOUSERELEASED;
			MOUSEX = Global.MOUSEX;
			MOUSEY = Global.MOUSEY;
		} // Set Local Mouse Info
		
		private function SetGlobalMouse():void
		{
			Global.MOUSEDOWN = m_aMouseInput[m_iMouseIndex][1];
			Global.MOUSERELEASED = m_aMouseInput[m_iMouseIndex][2];
			Global.MOUSEX = m_aMouseInput[m_iMouseIndex][3];
			Global.MOUSEY = m_aMouseInput[m_iMouseIndex][4];
		} // Set Global Mouse Info
		
		private function isSameKeys():Boolean
		{
			if(Global.KEYS.length != KEYS.length)
			{
				return false; // Different
			}
			for(var i:int = 0;i < Global.KEYS.length;i++)
			{
				if(Global.KEYS[i] != KEYS[i])
				{
						return false; // Different
				}
			}
			return true; // Same
		} // Compare Local / Global Keys
		
		private function SetLocalKeys():void
		{
			KEYS = Global.KEYS.slice(); // Duplicate Array
		} // Set Keys to Global Keys
		
		private function Encrypt(raw_:String):String
		{
			var result:String = "";
			for(var i:int = 0;i < raw_.length;i++)
			{
				result += String.fromCharCode(raw_.charCodeAt(i)+10);
			}
			return result;
		} // Encrypt String
		
		private function Decrypt(raw_:String):String
		{
			var result:String = "";
			for(var i:int = 0;i < raw_.length;i++)
			{
				result += String.fromCharCode(raw_.charCodeAt(i)-10);
			}
			return result;
		} // Decrypt String
	} // Class
} // Package