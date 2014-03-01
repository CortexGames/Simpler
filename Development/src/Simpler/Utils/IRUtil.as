package Simpler.Utils
{
	// Simpler Classes \/ //
	import Simpler.Game.IRGlobal; // Import the IRGlobal Class
	
	public class IRUtil
	{
		public static var OriginalStageWidth:int = 960; // Store the Original Stage Width
		public static var OriginalStageHeight:int = 540; // Store the Original Stage Height
		
		/**ScaleWithStageWidth will scale the value provided in relation to the new stage width.<br />
		 * Assuming OriginalStageWidth is set this will scale the width using provided in relation to
		 * OriginalStageWidth and the new Global.STAGEW.<br /><br />
		 */
		public static function ScaleWithStageWidth(width_:Number,round_:Boolean = false):Number
		{
			if(OriginalStageWidth != 0)
			{
				var percent:Number = width_ / OriginalStageWidth; // Scale with Original Stage Width
				if(round_)
				{
					percent = Math.round(percent * 100) / 100; // Move to 2 decimal places
				}
				return IRGlobal.getInstance().STAGEW * percent; // Return the new Width
			}
			return width_;
		}
		
		/**ScaleWithStageHeight will scale the value provided in relation to the new stage height.<br />
		 * Assuming OriginalStageHeight is set this will scale the height using provided in relation to
		 * OriginalStageHeight and the new Global.STAGEH.<br /><br />
		 */
		public static function ScaleWithStageHeight(height_:Number,round_:Boolean = false):Number
		{
			if(OriginalStageHeight != 0)
			{
				var percent:Number = height_ / OriginalStageHeight; // Scale with Original Stage Height
				if(round_)
				{
					percent = Math.round(percent * 100) / 100; // Move to 2 decimal places
				}
				return IRGlobal.getInstance().STAGEH * percent; // Return the new Height
			}
			return height_;
		}
	} // Class
} // Package