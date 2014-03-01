package Simpler.UI
{
	// Simpler Classes \/ //
	import Simpler.UI.IRButton; // Import the IRButton Class
	import Simpler.Display.IRObject; // Import the IRObject Class
	// Custom Classes \/ //
	import Games.ProjectS.Assets; // Import the Assets Class
	
	public class IRJoyStick extends IRObject
	{
		private var m_bJoystickButton:IRButton = null;
		private var m_gJoyStickHead:IRObject = null;
		private var m_gJoyStickBack:IRObject = null;
		private var distance:Number = 0;
		private var vecX:Number = 0;
		private var vecY:Number = 0;
		private var isActive:Boolean = true;
		private var StickMaxLimit:Number = 0;
		private var StickMinLimit:Number = 0;
		
		public function IRJoyStick(x_:Number, y_:Number, radius_:Number)
		{
			m_bJoystickButton = new IRButton(x_,y_,Assets.drawCircle(0,0,(radius_* 1.5),0xFFFFFF,1),Assets.drawCircle(0,0,(radius_* 1.5),0xFFFFFF,1));
			m_bJoystickButton.pivotX = (m_bJoystickButton.width * 0.5);
			m_bJoystickButton.pivotY = (m_bJoystickButton.width * 0.5);
			m_bJoystickButton.visible = false;
			this.addChild(m_bJoystickButton);
			
			m_gJoyStickBack = Assets.drawCircle(0,0,radius_,0xFFFFFF,0.6);
			m_gJoyStickBack.pivotX =  (m_gJoyStickBack.width * 0.5);
			m_gJoyStickBack.pivotY =  (m_gJoyStickBack.width * 0.5);
			m_gJoyStickBack.x = m_bJoystickButton.x;
			m_gJoyStickBack.y = m_bJoystickButton.y;
			this.addChild(m_gJoyStickBack);
			
			m_gJoyStickHead = Assets.drawCircle(0,0,(radius_ * 0.4),0xFFFFFF,0.8);
			m_gJoyStickHead.pivotX = (m_gJoyStickHead.width * 0.5);
			m_gJoyStickHead.pivotY = (m_gJoyStickHead.width * 0.5);
			m_gJoyStickHead.x = m_bJoystickButton.x;
			m_gJoyStickHead.y = m_bJoystickButton.y;
			this.addChild(m_gJoyStickHead);
			
			StickMaxLimit = (radius_ * 0.45);
			StickMinLimit = (radius_ * 0.05);
		}
		
		public override function Update():void
		{
			m_bJoystickButton.Update();
			distance = Math.sqrt((m_bJoystickButton.x - Global.MOUSEX)*(m_bJoystickButton.x - Global.MOUSEX) + (m_bJoystickButton.y - Global.MOUSEY)*(m_bJoystickButton.y - Global.MOUSEY));
			
			if(m_bJoystickButton.isDown)
			{
				isActive = true;
			}
			
			
			if(isActive)
			{
				vecX = ((m_bJoystickButton.x - Global.MOUSEX) * (1 / distance)); // Calculate x Vector
				vecY = ((m_bJoystickButton.y - Global.MOUSEY) * (1 / distance)); // Calculate y Vector
				
				if(distance < StickMaxLimit)
				{
					m_gJoyStickHead.x = Global.MOUSEX;
					m_gJoyStickHead.y = Global.MOUSEY;
				} // move head to mouse location
				else
				{
					m_gJoyStickHead.x = (m_bJoystickButton.x - (vecX * StickMaxLimit));
					m_gJoyStickHead.y = (m_bJoystickButton.y - (vecY * StickMaxLimit));
				} // Lock at maximum distance

				if(distance == 0)
				{
					vecX = 0;
					vecY = 0;
				} // Stop massive error crash
			}
			
			if(Global.MOUSEDOWN != true)
			{
				if(isActive)
				{
					m_gJoyStickHead.x = m_bJoystickButton.x;
					m_gJoyStickHead.y = m_bJoystickButton.y;
					vecX = 0;
					vecY = 0;
					distance = 0;
					isActive = false;
				}
			}
		} // Run every frame
		
		public function get VectorX():Number
		{
			return (vecX * -1);
		}
		
		public function get VectorY():Number
		{
			return (vecY * -1);
		}
		
		public function get Distance():Number
		{
			return distance;
		}
		
		public override function Destroy():void
		{
			if(m_bJoystickButton != null)
			{
				this.removeChild(m_bJoystickButton);
				m_bJoystickButton.Destroy();
				m_bJoystickButton = null;
			}
			if(m_gJoyStickBack != null)
			{
				this.removeChild(m_gJoyStickBack);
				m_gJoyStickBack.Destroy();
				m_gJoyStickBack = null;
			}
			if(m_gJoyStickHead != null)
			{
				this.removeChild(m_gJoyStickHead);
				m_gJoyStickHead.Destroy();
				m_gJoyStickHead = null;
			}
			super.Destroy();
		}
	}
}