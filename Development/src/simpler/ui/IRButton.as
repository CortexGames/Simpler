package simpler.ui
{
	// Flash Classes \/ //
	import flash.geom.Point; // Import the Point Class
	// Starling Classes \/ //
	import starling.display.Sprite; // Import the Sprite Class
	// Custom Classes \/ //
	import simpler.game.IRGlobal; // Import the IRGlobal Class
	import simpler.display.IRObject; // Import the IRObject Class
	
	/**IRButton allows graphics to be clickable.<br />
	 * IRButton has functions for tracking different events.<br /><br />
	 */
	public class IRButton extends IRObject
	{
		private var m_dNormal:Sprite; // Normal State Display Object
		private var m_dDown:Sprite; // Down State Display Object
		private var m_sState:String = "Normal"; // Store the Current State
		private var m_bEnabled:Boolean = true; // Is this button enabled
		private var m_nScaleFactorW:Number = 0; // Store the Scaling Factor
		private var m_nScaleFactorH:Number = 0; // Store the Scaling Factor
		
		public function IRButton(x_:Number,y_:Number,normal_:IRObject,down_:IRObject = null):void
		{
			ClassName = "IRButton"; // Set the Class Name
			x = x_; // Set the X
			y = y_; // Set the Y
			m_dNormal = normal_; // Set the Normal Graphic
			m_dDown = down_; // Set the Down Graphic
			m_nScaleFactorW = m_dNormal.width; // Set the Scale Width
			m_nScaleFactorH = m_dNormal.height; // Set the Scale Height
			m_dNormal.scaleX = 0.9; // Scale to 1.2
			m_dNormal.scaleY = 0.9; // Scale to 1.2
			m_nScaleFactorW = (m_nScaleFactorW - m_dNormal.width) * 0.5;
			m_nScaleFactorH = (m_nScaleFactorH - m_dNormal.height) * 0.5;
			m_dNormal.scaleX = 1; // Scale to 1
			m_dNormal.scaleY = 1; // Scale to 1
			this.addChild(m_dNormal); // Add to stage
		} // Constructor
		
		public override function Update():void
		{
			if(m_bEnabled)
			{
				
				if(Global.MOUSEDOWN && CheckPoint())//temp.x > 0 && temp.x < width && temp.y > 0 && temp.y < height)
				{
					if(Global.MOUSEDOWN && "Down" != m_sState)
					{
						ChangeState("Down");
					}
				}
				else if(Global.MOUSERELEASED && "Normal" != m_sState)
				{
					if("Normal" != m_sState)
					{
						if("Released" == m_sState)
						{
							ChangeState("Normal");
						}
						else
						{
							ChangeState("Released");
						}
					}
				}
				else if("Normal" != m_sState)
				{
					if("Down" == m_sState)
					{
						ChangeState("ReleasedOutside");
					}
					else
					{
						ChangeState("Normal");
					}
				}
			}
		} // Run Every Frame
		
		private function CheckPoint():Boolean
		{
			var temp:Point = null;
			temp = globalToLocal(new Point(Global.MOUSEX,Global.MOUSEY));
			if(m_dNormal.scaleX == 1)
			{
				if(temp.x > 0 && temp.x < width && temp.y > 0 && temp.y < height)
				{
					return true;
				}
			}
			else
			{
				if(temp.x + m_nScaleFactorW > 0 && temp.x - (m_nScaleFactorW*2) < width && temp.y + m_nScaleFactorH > 0 && temp.y - (m_nScaleFactorH*2) < height)
				{
					return true;
				}
			}
			return false;
		} // Check the Button State
		
		private function ChangeState(state_:String):void
		{
			if(m_dDown != null)
			{
				if("Normal" == m_sState || "Released" == m_sState || "ReleasedOutside" == m_sState)
				{
					this.removeChild(m_dNormal); // Remove Normal Display Object
				}
				else
				{
					this.removeChild(m_dDown); // Remove Down Display Object
				}
				m_sState = state_; // Set the new State
				if("Normal" == m_sState || "Released" == m_sState || "ReleasedOutside" == m_sState)
				{
					this.addChild(m_dNormal); // Add Normal Display Object
				}
				else
				{
					this.addChild(m_dDown); // Add Down Display Object
				}
			}
			else
			{
				if("Normal" == state_ || "Released" == state_ || "ReleasedOutside" == state_)
				{
					if(m_dNormal.scaleX != 1)
					{
						m_dNormal.scaleX = 1;
						m_dNormal.scaleY = 1;
						m_dNormal.x -= m_nScaleFactorW;
						m_dNormal.y -= m_nScaleFactorH;
					}
				}
				else
				{
					m_dNormal.scaleX = 0.9;
					m_dNormal.scaleY = 0.9;
					m_dNormal.x += m_nScaleFactorW;
					m_dNormal.y += m_nScaleFactorH;
				}
				m_sState = state_; // Set the new State
			}
		} // Changing Button State
		
		/**Return the current State or IRButton.<br />
		 */
		public function get State():String
		{
			return m_sState; // Return Button State
		} // Return Button State
		
		/**Return true if the button is not pressed.<br />
		 */
		public function get isUp():Boolean
		{
			if("Normal" == m_sState || "Released" == m_sState)
			{
				return true; // Button is Down
			}
			else
			{
				return false; // Button isn't Down
			}
		} // Is Button Up?
		
		/**Return true if the button is pressed.<br />
		 */
		public function get isDown():Boolean
		{
			if("Down" == m_sState)
			{
				return true; // Button is Down
			}
			else
			{
				return false; // Button isn't Down
			}
		} // Is Button Down?
		
		/**Return true if the button is released.<br />
		 */
		public function get isReleased():Boolean
		{
			if("Released" == m_sState)
			{
				//m_sState = "Normal";
				return true; // Button is Down
			}
			else
			{
				return false; // Button isn't Down
			}
		} // Is Button Down?
		
		/**Set both graphics for this.<br />
		 */
		public function SetAll(normal_:*,down_:*):void
		{
			NormalImage = normal_; // Set the Graphic
			DownImage = down_; // Set the Graphic
		} // Change Display Objects
		
		/**Set the Normal graphic for this.<br />
		 */
		public function set NormalImage(normal_:*):void
		{
			if("Normal" == m_sState)
			{
				this.removeChild(m_dNormal); // Remove Normal from Display List
			}
			m_dNormal = normal_; // Set the Display Object
			if("Normal" == m_sState)
			{
				this.addChild(m_dNormal); // Add Normal to the Display List
			}
		} // Change Normal Display Object
		
		/**Set the Down graphic for this.<br />
		 */
		public function set DownImage(down_:*):void
		{
			if("Down" == m_sState)
			{
				this.removeChild(m_dDown); // Remove Down from Display List
			}
			m_dDown = down_; // Set the Display Object
			if("Down" == m_sState)
			{
				this.addChild(m_dDown); // Add Down to the Display List
			}
		} // Change Down Display Object
		
		/**Enable the button so it works.<br />
		 */
		public function Enable():void
		{
			m_bEnabled = true;
		} // Work as Button
		
		/**Disable the button.<br />
		 */
		public function Disable():void
		{
			m_bEnabled = false;
			ChangeState("Normal");
		} // Don't act like button
		
		public override function Destroy():void
		{
			m_dNormal = null; // Set to null
			m_dDown = null; // Set to null
			super.Destroy(); // Super Deconstructor
		} // Deconstructor
	} // Class
} // Package