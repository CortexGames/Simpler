package Simpler.Internet
{
	// Flash Classes \/ //
	import flash.display.Loader; // Import the Loader Class
	import flash.events.Event; // Import the Event Class
	import flash.net.URLRequest; // Import the URLRequest Class
	import flash.system.Security; // Import the Security Class
	import flash.display.DisplayObject; // Import the DisplayObject Class
	// Simpler Classes \/ //
	import Simpler.Display.IRObject; // Import the IRObject Class
	import Simpler.Game.IRGlobal; // Import the IRGlobal Class
	
	public class IRTube extends IRObject
	{
		private var m_sVideoID:String;
		private var m_cPlayer:Object;
		private var m_lLoader:Loader;
		private var m_nVideoWidth:Number = 0;
		private var m_nVideoHeight:Number = 0;
		private var m_bSound:Boolean = true;
		private var m_bLoaded:Boolean = false;
		
		public function IRTube(videoid_:String,sound_:Boolean = true,x_:Number = -1,y_:Number = -1,width_:Number = -1,height_:Number = -1):void
		{
			m_lLoader = new Loader();
			try
			{
				Security.allowDomain("youtube.com");
			}
			catch(e:Error)
			{
				// Mobile
			}
			m_sVideoID = videoid_;
			if(width_ == -1 && height_ == -1)
			{
				width_ = Global.STAGEW * 0.5;
				height_ = Global.STAGEH * 0.5;
			}
			if(x_ == -1 && y_ == -1)
			{
				x_ = Global.STAGEW * 0.5;
				y_ = Global.STAGEH * 0.5;
			}
			m_nVideoWidth = width_;
			m_nVideoHeight = height_;
			x = x_ - (m_nVideoWidth * 0.5);
			y = y_ - (m_nVideoHeight * 0.5);
			m_bSound = sound_;
			m_lLoader.load(new URLRequest("http://www.youtube.com/apiplayer?version=3"));
			m_lLoader.contentLoaderInfo.addEventListener(Event.INIT, onLoaderInit);
		} // Constructor
		
		private function onLoaderInit(e:Event):void
		{
			m_cPlayer = m_lLoader.content;
			m_cPlayer.addEventListener("onReady", onPlayerReady);
		} // Loader Initialized
		
		private function onPlayerReady(e:Event):void
		{
			m_cPlayer.setSize(m_nVideoWidth,m_nVideoHeight);
			m_cPlayer.x = x;
			m_cPlayer.y = y;
			m_cPlayer.loadVideoById(m_sVideoID,0);
			if(!m_bSound)
			{
				m_cPlayer.mute();
			}
			Global.FLASHSTAGE.addChild(m_cPlayer);
			m_bLoaded = true;
		} // Config Video
		
		public function get video():Object
		{
			return m_cPlayer;
		} // Return Video
		
		public override function Update():void
		{
			super.Update();
			if(m_bLoaded)
			{
				m_cPlayer.setSize(m_nVideoWidth,m_nVideoHeight);
				m_cPlayer.x = x;
				m_cPlayer.y = y;
				//m_cPlayer.rotation = rotation; <-- Think Radian - Degree conversion needed! 
			}
		} // Run Every Frame
		
		public override function Destroy():void
		{
			Global.FLASHSTAGE.removeChild(m_cPlayer);
			m_cPlayer.destroy();
			m_cPlayer = null;
			m_lLoader = null;
			super.Destroy();
		} // Deconstructor
	} // Class
} // Package