package Simpler.Extensions.Grid
{
	// Simpler Classes \/ //
	import Simpler.Display.IRObject; // Import the IRObject Class
	
	public class IRTile extends IRObject
	{
		protected var m_iTileID:int = 0; // Store this tiles ID
		protected var m_iOtherTile:int = -1; // Store a reference ID to a tile
		protected var m_iProperties:int = -1; // Store this objects properties
		
		public function IRTile(id_:int,x_:Number,y_:Number,type_:String):void
		{
			ClassName = "IRTile"; // Set the Class Name
			x = x_; // Set the x
			y = y_; // Set the y
			SetProperties(type_); // Set the Properties
		} // Constructor
		
		protected function SetProperties(type_:String):void
		{
			if(type_.split(",").length > 0)
			{
				m_iOtherTile = parseInt(type_.split(",")[1]); // Set the Reference Tile
			}
			m_iProperties = parseInt(type_.split(",")[0]); // Set the Properties
		} // Set the Properties
			
		protected function getTileByID(id_:int):IRObject
		{
			for(var i:int = 0;i < Global.GAMEITEMS.length;i++)
			{
				if(Global.GAMEITEMS[i].ClassName == "IRTile" && id_ == Global.GAMEITEMS[i].TileID)
				{
					return Global.GAMEITEMS[i];
				}
			}
			return null;
		} // Return a Tile based on it's ID
		
		protected function getBinaryAt(property_:int,loc_:int):Boolean
		{
			return Boolean(parseInt(property_.toString(2).split("")[loc_]));
		} // Return a Binary Property
		
		public function get TileID():int
		{
			return m_iTileID;
		} // Return a TileID
	} // Class
} // Package