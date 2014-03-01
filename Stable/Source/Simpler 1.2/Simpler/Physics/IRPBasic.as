package Simpler.Physics
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Common.b2Settings;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FilterData;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import Simpler.Display.IRObject;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	
	public class IRPBasic extends IRObject
	{
		public static const SHAPE_SQAURE:String = "Sqaure";
		public static const SHAPE_CIRCLE:String = "Circle";
		public static const SHAPE_POLYGON:String = "Polygon";
		
		private var m_vBodyDef:b2BodyDef; // Store the Body Definition
		private var m_vBody:b2Body; // Store the Body
		private var m_vFixtureDef:b2FixtureDef; // Store the Fixture Definition
		private var m_vFixture:b2Fixture; // Store the Fixture
		protected var MtoPX:Number = 30; // Meters to Pixels
		protected var PXtoM:Number = 1 / MtoPX; // Pixels to Meters
		protected var m_nMass:Number = 10; // Store the Mass
		protected var m_nBounce:Number = 5; // Store the Bounce
		protected var m_nFriction:Number = 10; // Store the Friction
		protected var m_bSensor:Boolean = false; // Is a sensor
		protected var m_dDisplay:Sprite = new Sprite(); // Display Object, Display List
		protected var m_sShape:String = SHAPE_SQAURE; // The shape of the physics object
		
		public function IRPBasic():void
		{
			ClassName = "IRPBasic";
		} // Constructor
		
		protected function CreateGraphic(graphic_:Sprite):void
		{
			this.addChild(m_dDisplay); // Add Display to this
			m_dDisplay.addChild(graphic_); // Add the Graphic to this
			m_dDisplay.x = (width * 0.5) * -1; // Set the x
			m_dDisplay.y = (height * 0.5) * -1; // Set the y
		} // Create the Physics Graphic
		
		protected function CreatePhysics():void
		{
			CreateBodyDef();
			CreateFixtureDef();
			CreateBody();
			CreateFixture();
		} // Create the Physics
		
		protected function CreateBodyDef():void
		{
			m_vBodyDef = new b2BodyDef(); // Set the Body Definition
			if(m_nMass != 0 && m_nMass != -1)
			{
				m_vBodyDef.type = b2Body.b2_dynamicBody; // Make the Object Dynamic
			} // Make Static or Dynamic
			else if(m_nMass == -1)
			{
				m_vBodyDef.type = b2Body.b2_kinematicBody; // Make the Object Kinematic
			} // Make Kinematic
			m_vBodyDef.position.Set(x * PXtoM, y * PXtoM); // Set the Position
		} // Create the Body Def
		
		protected function CreateFixtureDef():void
		{
			m_vFixtureDef = new b2FixtureDef(); // Create the Fixture Definition
			m_vFixtureDef.restitution = m_nBounce * PXtoM; // Set the Bouncyness
			m_vFixtureDef.friction = m_nFriction * PXtoM; // Set the Friction
			m_vFixtureDef.density = m_nMass * PXtoM; // Set the Mass
			m_vFixtureDef.isSensor = m_bSensor; // Set to Sensor
			
			var vPShape:b2Shape; // Using Shape which can be override with the required types
			switch(m_sShape)
			{
				case SHAPE_SQAURE:
					vPShape = new b2PolygonShape(); // Create a Square Shape
					(vPShape as b2PolygonShape).SetAsBox((width * 0.5) * PXtoM, (height * 0.5) * PXtoM); // Create a Box
					break;
				case SHAPE_CIRCLE:
					vPShape = new b2CircleShape(); // Create a Circle Shape
					(vPShape as b2CircleShape).SetRadius((Math.max(width, height) * 0.5) * PXtoM); // Create a Circle
					break;
				case SHAPE_POLYGON:
					vPShape = CreateComplexShape();
					break;
				default:
					trace("[Simpler] Error 1009: You are miss using 'CreateFixtureDef()', You tried to create a '" + m_sShape + "', try using the Physics Shape Definitions... Ashley.");
					break;
			}
			m_vFixtureDef.shape = vPShape; // Assign the Shape to the Fixture Definition
		} // Create the Fixture Def
		
		/**
		 * Override in a sub class and return a shape, the shape can be any Box2d Shape.
		 * Use this function to create non-standard shapes.
		 * You should not use super.CreateComplexShape in this function.
		 */
		protected function CreateComplexShape():b2Shape
		{
			trace("[Simpler] Error 1010: You used CreateComplexShape() but didn't override the function with any functionality.");
			return null;
		} // Create a Complex Shape with Polygons
		
		protected function CreateFixture():void
		{
			m_vFixture = m_vBody.CreateFixture(m_vFixtureDef); // Create the Fixture
		} // Create the Fixture
		
		protected function CreateBody():void
		{
			m_vBody = Global.PHYSICSWORLD.CreateBody(m_vBodyDef); // Add the Body to the World
			x = m_vBody.GetPosition().x * MtoPX; // Set the X
			y = m_vBody.GetPosition().y * MtoPX; // Set the Y
			m_vBody.SetUserData(this); // Store reference to self
		} // Create the Body
		
		/**Body returns the Physics Body.<br />
		 * You can use Body to access the Physics Body and change properties or call functions<br /><br />
		 */
		public function get Body():b2Body
		{
			return m_vBody;
		} // Return the Body
		
		/**BodyDef returns the Physics Body Definition.<br />
		 */
		public function get BodyDef():b2BodyDef
		{
			return m_vBodyDef;
		} // Return the Body Definition
		
		/**FixtureDef returns the Physics Fixture Definition.<br />
		 */
		public function get FixtureDef():b2FixtureDef
		{
			return m_vFixtureDef;
		} // Return the Fixture Definition
		
		/**Fixture returns the Physics Fixture.<br />
		 */
		public function get Fixture():b2Fixture
		{
			return m_vFixture;
		} // Return the Fixture
		
		/**Graphic gives access to the child.<br />
		 */
		public function get Graphic():DisplayObject
		{
			return m_dDisplay.getChildAt(0);
		} // Return the Graphic
		public function set Graphic(graphic_:DisplayObject):void
		{
			m_dDisplay.removeChildAt(0);
			m_dDisplay.addChild(graphic_);
		} // Return the Graphic
		
		/**CollisionFilter sets the Category and Mask Bits.<br />
		 * You can use this function to determine what collides with what, the cat_ is effectively "I am ..." and the mask_ is "I collide with ...".<br />
		 * C++ Box2D Collision Filtering - http://www.iforce2d.net/b2dtut/collision-filtering<br /><br />
		 */
		public function CollisionFilter(cat_:uint = 1, mask_:uint = 15):void
		{
			var tempFilter:b2FilterData = m_vFixture.GetFilterData();
			tempFilter.categoryBits = cat_;
			tempFilter.maskBits = mask_;
			m_vFixture.SetFilterData(tempFilter);
		} // Set the Collision Filters
		
		public override function Update():void
		{
			x = m_vBody.GetPosition().x * MtoPX; // Set the X
			y = m_vBody.GetPosition().y * MtoPX; // Set the Y
			rotation = m_vBody.GetAngle(); // Set the rotation
		} // Run every frame
		
		public override function Destroy():void
		{
			m_vBody.SetUserData(null); // Set user data to null
			Global.PHYSICSWORLD.DestroyBody(m_vBody); // Delete body from the world
			for(var i:int = 0; i < m_dDisplay.numChildren; i++)
			{
				m_dDisplay.removeChildAt(0, true);
			} // Remove objects from Display
			this.removeChild(m_dDisplay); // Remove Display from this
			m_dDisplay = null; // Null Display
			super.Destroy(); // Super Deconstructor
		} // Destroy Body
	} // Class
} // Package