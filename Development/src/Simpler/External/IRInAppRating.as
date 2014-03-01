package Simpler.External
{
	import Simpler.Display.IRObject;
	import Simpler.UI.IRButton;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.Capabilities;
	
	public class IRInAppRating extends IRObject
	{
		private static const ANDROID_STORE:String= "market://details?id="; 
		private static const PLAY_REVIEW:String= "&reviewId=0";
		private static const APPLE_STORE:String= "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?onlyLatestVersion=false&type=Purple+Software&id=";
		
		private var m_gBackground:IRObject;
		private var m_bRateBTN:IRButton;
		private var m_bCloseBTN:IRButton;
		
		private var m_sAppleID:String= ""; // Id Provided by Apple App Store
		private var m_sAndroidID:String= ""; // Package name as seen on Google Play Store
		
		public function IRInAppRating(androidAppID:String = "", iOSAppID:String = "")
		{
			super();
			if(isSupported)
			{
				m_sAndroidID = androidAppID;
				m_sAppleID = iOSAppID;
				init();
			}
			else
			{
				trace("[Simpler] Error 1???: IRInAppRating is not supported on this device!");
			}
		}
		
		private function init():void
		{
			m_gBackground = Assets.drawQuad(0, 0, Global.STAGEW, Global.STAGEH, 0x000000, 0.6);
			addChild(m_gBackground);
		} // Show rating dialog here!
		
		private function Rate():void
		{
			var appUrl:String = APPLE_STORE + m_sAppleID;
			
			if(isAndroid())
			{
				appUrl = ANDROID_STORE + m_sAndroidID + PLAY_REVIEW;
			}
			
			var req : URLRequest = new URLRequest(appUrl);
			navigateToURL(req);
		} // Rate
		
		private function get isAndroid():Boolean
		{
			return Capabilities.manufacturer.indexOf('Android') > -1;
		}
		
		private function get isIOS():Boolean
		{
			return Capabilities.manufacturer.indexOf('iOS') > -1;
		}
		
		private function get isSupported():Boolean
		{
			return !isAndroid && !isIOS;
		}
	}
}