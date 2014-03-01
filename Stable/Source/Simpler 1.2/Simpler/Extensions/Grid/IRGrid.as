package Simpler.Extensions.Grid
{
	// Simpler Classes \/ //
	import Simpler.Game.IRScene; // Import the IRScene Class
	import Simpler.Display.IRObject; // Import the IRObject Class
	// IRGrid Extension Classes \/ //
	import Simpler.Extensions.Grid.IRTile; // Import the IRTile Class
	
	public class IRGrid extends IRScene
	{
		private var m_iTileSize:int = 20; // Store the Tile Size
		private var m_iGridWidth:Number = 0; // Store the Grid Width
		private var m_iGridHeight:Number = 0; // Store the Grid Height
		private var m_iStartX:int = 0; // Store the Start X
		private var m_iStartY:int = 0; // Store the Start Y
		private var TileClass:Class = IRTile; // Store a Tile Reference
		
		public function IRGrid(tileTemplate_:Class = null):void
		{
			if(tileTemplate_ != null)
			{
				TileClass = tileTemplate_; // Set the Tile Template
			}
			m_iGridWidth = Global.STAGEW; // Set the Grid Width
			m_iGridHeight = Global.STAGEH; // Set the Grid Height
		} // Constructor
		
		public function Config(tileSize_:int,startX_:int,startY_:int,gridWidth_:int = 0,gridHeight_:int = 0):void
		{
			if(tileSize_ > 0)
			{
				m_iTileSize = tileSize_; // Set the Tile Size
			}
			m_iStartX = startX_; // Set the Start X
			m_iStartY = startY_; // Set the Start Y
			if(gridWidth_ > 0)
			{
				m_iGridWidth = gridWidth_; // Set the Grid Width
			}
			if(gridHeight_ > 0)
			{
				m_iGridHeight = gridHeight_; // Set the Grid Height
			}
		} // Config the Grid
		
		public function LoadLevel(level_:String):void
		{
			var levelData:Array = level_.split("&"); // Store the level data
			var tempX:Number = 0; // Store the tempX
			var tempY:Number = 0; // Store the tempY
			var tempID:int = 0; // Store a Tiles ID
			for(var i:int = 0;i < levelData.length;i++)
			{
				if(levelData[i].split(",")[0] != "0")
				{
					Create(new TileClass(tempID,tempX,tempY,levelData[i])); // Create a tile
				}
				tempID++; // Increment the TileID
				tempX += m_iTileSize; // Increment the X
				if(tempX > m_iGridWidth)
				{
					tempX = 0; // Reset the x
					tempY += m_iTileSize; // Increment the y
					if(tempY > m_iGridHeight)
					{
						break;
					}
				}
			}
		} // Load a level
		
		public function SaveLevel():String
		{
			var tempReturn:String = "";
			return tempReturn;
		} // Save a level
	} // Class
} // Package