package Simpler.UI
{
	// Simpler Classes \/ //
	import Simpler.UI.IRButton; // Import the IRButton Class
	import Simpler.Display.IRObject; // Import the IRObject Class
	// Starling Classes \/ //
	import starling.events.Touch; // Import the Touch Class
	import starling.events.TouchPhase; // Import the TouchPhase Class
	import starling.events.TouchEvent; // Import the TouchEvent Class
	// Flash Classes \/ //
	import flash.geom.Point; // Import the Point Class
	
	public class IRJoyStick extends IRObject
	{
		private var m_nVelocityX:Number = 0;
		private var m_nVelocityY:Number = 0;
		private var m_nMinOffsetX:Number;
		private var m_nMinOffsetY:Number;
		private var m_bTouched:Boolean = false;
		
		private var m_nMaxVelocityX:Number;
		private var m_nMaxVelocityY:Number;
		private var m_pPivotPoint:Point;
		private var m_oHolder:IRObject;
		private var m_nStick:IRObject;
		
		public function IRJoyStick(width_:Number, knobSizefactor_:Number, stickColour_:uint = 0xFF5000, holderColour_:uint = 0xFFFFFF, stickAlpha_:Number = 1, holderAlpha_:Number = 1)
		{
			m_oHolder = Assets.drawCircle(0,0,width_,holderColour_,holderAlpha_);
			m_nStick = Assets.drawCircle(0,0,(width_ * knobSizefactor_),stickColour_,stickAlpha_);
			m_nStick.pivotX = m_nStick.width * 0.5;
			m_nStick.pivotY = m_nStick.height * 0.5;
			
			ResetStick();
			
			addChild(m_oHolder);
			addChild(m_nStick);
			m_oHolder.touchable = false;
			
			pivotX = m_oHolder.width * 0.5;
			pivotY = m_oHolder.height * 0.5;
			
			m_nMaxVelocityX = m_oHolder.width / 2;
			m_nMaxVelocityY = m_oHolder.height / 2;
			m_nMinOffsetX = (m_oHolder.width / 2) + m_nStick.width / 2; 
			m_nMinOffsetY = (m_oHolder.height / 2) + m_nStick.height / 2; 
			
			m_pPivotPoint = new Point(pivotX, pivotY);
			m_nStick.addEventListener(TouchEvent.TOUCH, OnJoystickTouch);
		}
		
		private function OnJoystickTouch(e:TouchEvent):void
		{
			if(e.getTouches(this).length == 0)
			{
				return;
			}
			var touch:Touch = e.getTouches(this)[0];
			m_bTouched = true;
			switch(touch.phase)
			{
				case TouchPhase.BEGAN:
					m_pPivotPoint.x = touch.globalX - pivotX + m_nStick.x;
					m_pPivotPoint.y = touch.globalY - pivotY + m_nStick.y;
				case TouchPhase.MOVED:
					MoveJoystick(touch.globalX, touch.globalY);
					break;
				case TouchPhase.ENDED:
					ResetStick();
					break;
			}
			
			m_nVelocityX = (m_nStick.x - pivotX) / m_nMaxVelocityX;
			m_nVelocityY = (m_nStick.y - pivotY) / m_nMaxVelocityY;
		}
		
		private function MoveJoystick(touchX:Number, touchY:Number):void
		{
			var distX:Number = (touchX - m_pPivotPoint.x);
			var distY:Number = (touchY - m_pPivotPoint.y);
			m_nStick.x = distX + pivotX; m_nStick.y = distY + pivotY;
			
			var dis:Number = Math.sqrt((distX * distX) + (distY * distY));
			
			if(Math.abs(dis) > pivotX)
			{
				var force:Number = dis-pivotX;
				m_nStick.x -= distX/dis*force;
				m_nStick.y -= distY/dis*force;
			}
		}
		
		public function SetPosition(_x:Number, _y:Number):void
		{
			x = _x;
			y = _y;
		}
		
		public function get velocityY():Number
		{
			return m_nVelocityY;
		}
		
		public function get velocityX():Number
		{
			return m_nVelocityX;
		}		
		
		public function get minOffsetY():Number
		{
			return m_nMinOffsetY;
		}
		
		public function get minOffsetX():Number
		{
			return m_nMinOffsetX;
		}
		
		public function get isTouched():Boolean
		{
			if(velocityX == 0 && velocityY == 0) m_bTouched = false;
			return m_bTouched;
		}
		
		private function ResetStick():void
		{
			m_bTouched = false;
			m_nStick.x = m_oHolder.width * 0.5;
			m_nStick.y = m_oHolder.height * 0.5;
		}	
		
		public override function Destroy():void
		{
			if(m_oHolder != null)
			{
				this.removeChild(m_oHolder);
				m_oHolder.Destroy();
				m_oHolder = null;
			}
			if(m_nStick != null)
			{
				this.removeChild(m_nStick);
				m_nStick.Destroy();
				m_nStick = null;
			}
			super.Destroy();
		}
	}
}