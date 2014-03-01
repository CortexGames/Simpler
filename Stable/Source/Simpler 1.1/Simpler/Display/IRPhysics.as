package Simpler.Display // DEPRECIATED, USE Simpler.Physics.IRPPublic OR SIMILAR INSTEAD!
{
	// Starling Classes \/ //
	import starling.display.DisplayObject; // Import the DisplayObject Class
	import starling.display.Sprite; // Import the Sprite Class
	// Box2D Classes \/ //
	import Box2D.Collision.Shapes.b2CircleShape; // Import the b2CircleShape Class
	import Box2D.Collision.Shapes.b2PolygonShape; // Import the b2PolygonShape Class
	import Box2D.Common.Math.b2Vec2; // Import the b2Vec2 Class
	import Box2D.Common.b2Settings; // Import the b2Settings Class
	import Box2D.Dynamics.b2Body; // Import the b2Body Class
	import Box2D.Dynamics.b2BodyDef; // Import the b2BodyDef Class
	import Box2D.Dynamics.b2Fixture; // Import the b2Fixture Class
	import Box2D.Dynamics.b2FixtureDef; // Import the b2FixtureDef Class
	import Box2D.Dynamics.b2World; // Import the b2World Class
	import Box2D.Dynamics.b2FilterData; // Import the b2FilterData Class
	// Simpler Classes \/ //
	import Simpler.Display.IRObject; // Import the IRObject Class
	
	/**IRPhysics is used to apply physics to an IRObject<br />
	 * Using Box2D any graphic can be given physics, groups of objects can be supplied and given physics.
	 * You'll need to create a b2World using the Config function in IRProgram or by setting 
	 * IRGlobal.PHYSICSWORLD.<br /><br />
	 * @see IRObject
	 * @see b2World
	 */
	public class IRPhysics extends IRObject
	{
		private var m_vBodyDef:b2BodyDef; // Store the Body Definition
		private var m_vBody:b2Body; // Store the Body
		private var m_vFixtureDef:b2FixtureDef; // Store the Fixture Definition
		private var m_vFixture:b2Fixture; // Store the Fixture
		private var MtoPX:Number = 30; // Meters to Pixels
		private var PXtoM:Number = 1 / MtoPX; // Pixels to Meters
		protected var m_nMass:Number = 0; // Store the Mass
		protected var m_nBounce:Number = 5; // Store the Bounce
		protected var m_nFriction:Number = 10; // Store the Friction
		protected var m_dDisplay:Sprite = new Sprite(); // Display Object, Display List
		
		public function IRPhysics(x_:Number,y_:Number,graphic_:DisplayObject,mass_:Number = 0,bounce_:Number = 5,friction_:Number = 10,rect_:Boolean = true,awake_:Boolean = true):void
		{
			ClassName = "IRPhysics"; // Set the Class Name
			m_nMass = mass_; // Set the Mass
			m_nBounce = bounce_; // Set the Bounce
			m_nFriction = friction_; // Set the Friction
			this.addChild(m_dDisplay); // Add Display to this
			m_dDisplay.addChild(graphic_); // Add the Graphic to this
			m_dDisplay.x = (width * 0.5) * -1; // Set the x
			m_dDisplay.y = (height * 0.5) * -1; // Set the y
			m_vBodyDef = new b2BodyDef(); // Set the Body Definition
			if(mass_ != 0 && mass_ != -1)
			{
				m_vBodyDef.type = b2Body.b2_dynamicBody; // Make the Object Dynamic
			} // Make Static or Dynamic
			else if(mass_ == -1)
			{
				m_vBodyDef.type = b2Body.b2_kinematicBody; // Make the Object Kinematic
			} // Make Kinematic
			m_vBodyDef.position.Set(x_ * PXtoM, y_ * PXtoM); // Set the Position
			m_vBody = Global.PHYSICSWORLD.CreateBody(m_vBodyDef); // Add the Body to the World
			m_vFixtureDef = new b2FixtureDef(); // Create the Fixture Definition
			m_vFixtureDef.restitution = bounce_ * PXtoM; // Set the Bouncyness
   			m_vFixtureDef.friction = friction_ * PXtoM; // Set the Friction
   			m_vFixtureDef.density = mass_ * PXtoM; // Set the Mass
			if(rect_)
			{
				var vPShape:b2PolygonShape = new b2PolygonShape(); // Create a Square Shape
				vPShape.SetAsBox((width*0.5) * PXtoM,(height*0.5) * PXtoM); // Create a Box
				m_vFixtureDef.shape = vPShape; // Assign the Shape to the Fixture Definition
				m_vFixture = m_vBody.CreateFixture(m_vFixtureDef); // Create the Fixture
			} // Make a Square
			else
			{
				/*
				var vCShape:b2CircleShape = new b2CircleShape(m_dDisplay.width * PXtoM); // Create a Circle Shape
				m_vFixtureDef.shape = vCShape; // Assign the Shape to the Fixture Definition
				m_vFixture = m_vBody.CreateFixture(m_vFixtureDef); // Create the Fixture
				m_dDisplay.width = ((m_vBody.GetFixtureList().GetShape() as b2CircleShape).GetRadius() * MtoPX) * 2; // Set the Width
				m_dDisplay.height = ((m_vBody.GetFixtureList().GetShape() as b2CircleShape).GetRadius() * MtoPX) * 2; // Set the Height
				*/
			} // Make a Circle
			x = m_vBody.GetPosition().x * MtoPX; // Set the X
			y = m_vBody.GetPosition().y * MtoPX; // Set the Y
			m_vBody.SetUserData(this); // Store reference to self
			if(!awake_)
			{
				Sleep();
			}
		} // Constructor
		
		public override function Update():void
		{
			x = m_vBody.GetPosition().x * MtoPX; // Set the X
			y = m_vBody.GetPosition().y * MtoPX; // Set the Y
			rotation = m_vBody.GetAngle();// * (180 / b2Settings.b2_pi); // Set the rotation
		} // Run every frame
		
		/**ApplyForce will apply a force using SetLinearVelocity.<br />
		 */
		public function ApplyForce(x_:Number,y_:Number):void
		{
			m_vBody.SetLinearVelocity(new b2Vec2(x_ * PXtoM, y_ * PXtoM)); // Apply Force
		} // Apply Force
		
		/**Awake this physics body.<br />
		 */
		public function Awake():void
		{
			m_vBody.SetAwake(true);
		} // Enable Physics
		
		/**Sleep puts this physics body to sleep.<br />
		*/
		public function Sleep():void
		{
			m_vBody.SetAwake(false);
		} // Disable Physics
		
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
		
		/**CollisionFilter sets the Category and Mask Bits.<br />
		 * You can use this function to determine what collides with what, the cat_ is effectively "I am ..." and the mask_ is "I collide with ...".<br />
		 * C++ Box2D Collision Filtering - http://www.iforce2d.net/b2dtut/collision-filtering<br /><br />
		 */
		public function CollisionFilter(cat_:uint = 1,mask_:uint = 15):void
		{
			var tempFilter:b2FilterData = Fixture.GetFilterData();
			tempFilter.categoryBits = cat_;
			tempFilter.maskBits = mask_;
			Fixture.SetFilterData(tempFilter);
		} // Set the Collision Filters
		
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
		
		/**Mass, returns the Mass initially set.<br />
		 */
		public function get Mass():Number
		{
			return m_nMass;
		} // Return the Mass
		
		/**Friction returns the Friction initially set.<br />
		 */
		public function get Friction():Number
		{
			return m_nFriction; 
		} // Return the Friction
		
		/**Bounce returns the Bounce initially set.<br />
		 */
		public function get Bounce():Number
		{
			return m_nBounce;
		} // Return the Bounce
		
		public override function Destroy():void
		{
			m_vBody.SetUserData(null); // Set user data to null
			Global.PHYSICSWORLD.DestroyBody(m_vBody); // Delete body from the world
			for(var i:int = 0;i < m_dDisplay.numChildren;i++)
			{
				m_dDisplay.removeChildAt(0,true);
			} // Remove objects from Display
			this.removeChild(m_dDisplay); // Remove Display from this
			m_dDisplay = null; // Null Display
			super.Destroy(); // Super Deconstructor
		} // Destroy Body
	} // Class
} // Package