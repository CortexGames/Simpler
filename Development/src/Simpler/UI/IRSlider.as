package Simpler.UI
{
	// Simpler Classes \/ //
	import Simpler.UI.IRButton; // Import the IRButton Class
	import Simpler.Display.IRObject; // Import the IRObject Class
	
	public class IRSlider extends IRObject
	{
		private var m_bSliderButton:IRButton = null;
		private var m_bSliderHead:IRObject = null;
		private var m_gSliderBar:IRObject = null;
		private var m_nY:Number;
		private var m_nM:Number;
		private var m_nC:Number;
		
		private var m_iSliderBarHeight:int = 10;
		private var m_iSliderHeadHeight:int = 25;
		private var m_iSliderHeadWidth:int = 25;
		
		public function IRSlider(MinValue_:Number, MaxValue_:Number, SliderWidth_:Number, square_:Boolean)
		{
			var x1:Number = 0;
			var x2:Number = SliderWidth_;
			var y1:Number = MinValue_;
			var y2:Number = MaxValue_;
			
			if(y2 < y1)
			{
				var temp:Number = y1;
				y1 = y2;
				y2 = temp;
			}
			
			m_nC = y1 - x1;
			m_nM = (y2 - y1) / (x2 - x1);
			
			m_gSliderBar = Assets.drawQuad(0,0,x2,m_iSliderBarHeight,0xFFFFFF, 0.8);
			this.addChild(m_gSliderBar);
			
			if(square_)
			{
				m_bSliderHead = Assets.drawQuad(0,0,m_iSliderHeadWidth,m_iSliderHeadHeight,0xFFFFFF);
			}
			else
			{
				m_bSliderHead = Assets.drawCircle(0,0,m_iSliderHeadHeight,0xFFFFFF);
			}
			m_bSliderHead.x = (m_gSliderBar.width * 0.5);
			m_bSliderHead.y = (m_gSliderBar.y + (m_gSliderBar.height * 0.5)) - (m_bSliderHead.height * 0.5);
			this.addChild(m_bSliderHead);
			
			m_bSliderButton = new IRButton(0, 0, Assets.drawQuad(0,0,m_gSliderBar.width + 40,m_gSliderBar.height + 40,0xFFFFFF, 1),Assets.drawQuad(0,0,m_gSliderBar.width + 40,m_gSliderBar.height + 40,0xFFFFFF, 1));;
			m_bSliderButton.x = m_gSliderBar.x - 20;
			m_bSliderButton.y = m_gSliderBar.y - 20;
			this.addChild(m_bSliderButton);
			m_bSliderButton.visible = false;
		}
		
		public override function Update():void
		{
			m_bSliderButton.Update();
			
			if(m_bSliderButton.isDown)
			{
				m_bSliderHead.x = (Global.MOUSEX - x) - (m_bSliderHead.width * 0.5);
				
				if(m_bSliderHead.x + (m_bSliderHead.width * 0.5) > (m_gSliderBar.x + m_gSliderBar.width))
				{
					m_bSliderHead.x = (m_gSliderBar.x + m_gSliderBar.width) - (m_bSliderHead.width * 0.5);
				}
				
				if((m_bSliderHead.x + (m_bSliderHead.width * 0.5)) < m_gSliderBar.x)
				{
					m_bSliderHead.x = (m_gSliderBar.x - (m_bSliderHead.width * 0.5));
				}
				
				m_nY = m_nM * ((m_bSliderHead.x + (m_bSliderHead.width * 0.5)) + m_nC);
			}
		}
		
		public function SetPercentage(percentage_:Number = 0.5):void
		{
			if(percentage_ > 1)
			{
				percentage_ = 1;
			}
			if(percentage_ < 0)
			{
				percentage_ = 0;
			}
			
			m_bSliderHead.x = ((m_gSliderBar.width * percentage_) - (m_bSliderHead.width * 0.5)) ;
		}
		
		public function get Percentage():Number
		{
			return m_nM;
		}
		
		public function get Result():Number
		{
			return m_nY;
		}
		
		public override function Destroy():void
		{
			if(m_gSliderBar != null)
			{
				this.removeChild(m_gSliderBar);
				m_gSliderBar.Destroy();
				m_gSliderBar = null;
			}
			
			if(m_bSliderHead != null)
			{
				this.removeChild(m_bSliderHead);
				m_bSliderHead.Destroy();
				m_bSliderHead = null;
			}
			
			if(m_bSliderButton != null)
			{
				this.removeChild(m_bSliderButton);
				m_bSliderButton.Destroy();
				m_bSliderButton = null;
			}
			super.Destroy();
		}
	}
}