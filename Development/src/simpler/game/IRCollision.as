/**
* ProximityManager (AS3 Version) by Grant Skinner. Jan 4, 2008
* Visit www.gskinner.com/blog for documentation, updates and more free code.
*
* You may distribute and modify this class freely, provided that you leave this header intact,
* and add appropriate headers to indicate your changes. Credit is appreciated in applications
* that use this code, but is not required.
*
* Please contact info@gskinner.com for more information.
* Entirely reformatted for Collision Detection
* Bitches!
*/
package simpler.game
{
	// Flash Classes \/ //
	import flash.utils.Dictionary; // Import the Dictionary Class
	// Starling Classes \/ //
	import starling.display.DisplayObject; // Import the DisplayObject Class
	// Simpler Classes \/ //
	import simpler.display.IRObject; // Import the IRObject Class
	import simpler.game.IRCollisionBase; // Import the IRCollisionBase Class
	
	public class IRCollision extends IRCollisionBase
	{
		private var m_iGrid:uint; // Proximity Size
		private var m_iGridFactor:uint; // Grid Factor
		private var m_iGridTotal:uint; // Total Size
		private var m_dDisplayList:Dictionary; // Display Dictionary
		private var m_aPositions:Array; // Store Positions
		private var m_aCached:Array; // Cache Positions
		private var m_iType:int = 0; // Store the Collision Type
		
		public function IRCollision(grid_:uint = 25,type_:int = 0)
		{
			m_iType = type_;
			m_iGrid = grid_;
			m_iGridFactor = 2048;
			m_iGridTotal = grid_ * (m_iGridFactor * 0.5);
			m_dDisplayList = new Dictionary(true);
			m_aPositions = [];
			m_aCached = [];
		} // Constructor
		
		public override function GetCollisions(mc_:IRObject):Array
		{
			var index:uint = ((mc_.x + m_iGridTotal) / m_iGrid) << 11 | ((mc_.y + m_iGridTotal) / m_iGrid); // max of +/- 2^10 (1024) rows and columns.
			if(m_aCached[index])
			{
				return m_aCached[index];
			}
			var p:Array = m_aPositions;
			var r:Array = p[index];
			if(r == null)
			{
				r = [];
			}
			if(p[index-m_iGridFactor-1])
			{
				r = r.concat(p[index-m_iGridFactor-1]);
			}
			if(p[index-1])
			{
				r = r.concat(p[index-1]);
			}
			if(p[index+m_iGridFactor-1])
			{
				r = r.concat(p[index+m_iGridFactor-1]);
			}
			if(p[index-m_iGridFactor])
			{
				r = r.concat(p[index-m_iGridFactor]);
			}
			if(p[index+m_iGridFactor])
			{
				r = r.concat(p[index+m_iGridFactor]);
			}
			if(p[index-m_iGridFactor+1])
			{
				r = r.concat(p[index-m_iGridFactor+1]);
			}
			if(p[index+1])
			{
				r = r.concat(p[index+1]);
			}
			if(p[index+m_iGridFactor+1])
			{
				r = r.concat(p[index+m_iGridFactor+1]);
			}
			var ra:Array = new Array();
			for(var i:int = 0;i < r.length;i++)
			{
				if(m_iType == 0)
				{
					if(hitTestObject(mc_,r[i]))
					{
						if(r[i] != mc_)
						{
							ra.push(r[i]);
						}
					}
				}
				else if(m_iType == 1)
				{
					if(RectangleCollision(mc_,r[i]))
					{
						if(r[i] != mc_)
						{
							ra.push(r[i]);
						}
					}
				}
				else
				{
					if(RadialCollision(mc_,r[i]))
					{
						if(r[i] != mc_)
						{
							ra.push(r[i]);
						}
					}
				}
			}
			m_aCached[index] = ra;
			return ra;
		} // Return Neighbours
		
		private function RadialCollision(object_:DisplayObject,otherObject_:DisplayObject):Boolean
		{
			var distanceX:Number = (object_.x - otherObject_.x);
			var distanceY:Number = (object_.y - otherObject_.y);
			
			var totalRadius:Number = (object_.width + otherObject_.width) * 0.4;
			
			if(((distanceX * distanceX) + (distanceY * distanceY)) < (totalRadius * totalRadius))
			{
				return true;
			}
			return false;
		} // Radial Collision Check
		
		private function RectangleCollision(object_:DisplayObject,otherObject_:DisplayObject):Boolean
		{			
			if((object_.x + object_.width) < (otherObject_.x - otherObject_.width))
			{
				return false;
			}
			else if((object_.x - object_.width) > (otherObject_.x + otherObject_.width))
			{
				return false;
			}
			else if((object_.y + object_.height) < (otherObject_.y - otherObject_.height))
			{
				return false;
			}
			else if((object_.y - object_.height) > (otherObject_.y + otherObject_.height))
			{
				return false;
			}
			return true;
		} // Radial Collision Check
		
		private function hitTestObject(object_:DisplayObject,otherObject_:DisplayObject):Boolean
		{
			return object_.getBounds(object_.parent).intersects(otherObject_.getBounds(otherObject_.parent));
		} // Hit Test Object
		
		public override function addItem(mc_:IRObject):void
		{
			m_dDisplayList[mc_] = -1;
		} // Add Collision Item
		
		public override function removeItem(mc_:IRObject):void
		{
			delete(m_dDisplayList[mc_]);
		} // Remove Collision Item
		
		public override function Update():void
		{
			var m:Dictionary = m_dDisplayList;
			var p:Array = [];
			var gs:uint = m_iGrid;
			for(var o:Object in m)
			{
				var mc_:DisplayObject = o as DisplayObject;
				var index:uint = ((mc_.x + m_iGridTotal) / m_iGrid) << 11 | ((mc_.y + m_iGridTotal) / m_iGrid); // max of +/- 2^10 (1024) rows and columns.
				if(p[index] == null)
				{
					p[index] = [o];
					continue;
				}
				(p[index] as Array).push(o);
			}
			m_aCached = [];
			m_aPositions = p;
		} // Calulate Collision
	} // Class
} // Package

