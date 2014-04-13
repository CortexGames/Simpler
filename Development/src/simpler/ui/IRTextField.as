package simpler.ui
{
	import simpler.display.IRObject;
	import starling.text.TextField;
	
	public class IRTextField extends IRObject
	{
		private var m_tTextField:TextField;
		
		public function IRTextField(width_:Number, height_:Number, text_:String, color_:uint = 0xFFFFFF)
		{
			super();
			m_tTextField = new TextField(width_, height_, text_, "Verdana", height_ * 0.48, color_, false);
			addChild(m_tTextField);
		}
		
		public override function Destroy():void
		{
			removeChild(m_tTextField);
			m_tTextField.dispose();
			m_tTextField = null;
		}
		
		public function get text():String { return m_tTextField.text; }
		public function set text(value:String):void { m_tTextField.text = value; }
		public function get color():uint { return m_tTextField.color; }
		public function set color(value:uint):void { m_tTextField.color = value; }
		public function get fontName():String { return m_tTextField.fontName; }
		public function set fontName(value:String):void { m_tTextField.fontName = value; }
		public function get fontSize():Number { return m_tTextField.fontSize; }
		public function set fontSize(value:Number):void { m_tTextField.fontSize = value; }
	}
}