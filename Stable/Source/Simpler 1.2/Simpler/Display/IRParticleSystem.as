package Simpler.Display
{
	// Flash Classes \/ //
	import flash.geom.Point; // Import the Point Class
	// Starling Classes \/ //
	import starling.core.Starling; // Import the Starling Class
	import starling.display.Sprite; // Import the Sprite Class
	import starling.extensions.PDParticleSystem; // Import the PDParticleSystem Class
	import starling.textures.Texture; // Import the Texture Class
	// Simpler Classes \/ //
	import Simpler.Display.IRObject;
	import Simpler.Game.IRAssets;

 // Import the IRObject Class
	
	/**IRParticleSystem creates a particle system.<br />
	 * IRParticleSystem can be used to create particle systems which can be attached to a parent
	 * object which will move the particle system.<br /><br />
	 * @see IRObject
	 * @see PDParticleSystem
	 */
	public class IRParticleSystem extends IRObject
	{
		public static var MaxParticles:int = 1000; // Store the Max Particle Count
		private var m_pParticle:PDParticleSystem; // Store the m_pParticle
		private var m_dParent:Sprite = null; // Store a Parent
		private var m_nOffX:Number = 0; // Store the X Offset
		private var m_nOffY:Number = 0; // Store the Y Offset
		private var m_bRelease:Boolean = false; // Stop instant deletion
		
		public function IRParticleSystem(x_:Number, y_:Number,name_:String,scale_:Number = 1,length_:Number = -1,texture_:String = ""):void
		{
			ClassName = "IRParticleSystem"; // Set the Class Name
			var assets : IRAssets = Global.ASSETS() as IRAssets;
			if(texture_ == "")
			{
				m_pParticle = assets.getParticle(name_); // Get the Particle
			}
			else
			{
				m_pParticle = new PDParticleSystem(XML(assets.getParticlePex(name_)), assets.getTexture(texture_+"Tex"));
			}
			m_pParticle.startSize += scale_; // Set the Scale
			m_pParticle.endSize += scale_; // Set the Scale
			m_pParticle.emitterX = x_; // Set the x
			m_pParticle.emitterY = y_; // Set the y
			if(m_pParticle.maxNumParticles > MaxParticles)
			{
				m_pParticle.maxNumParticles = MaxParticles;
			} // Limit Particle Count to Max Particle Limit!
			this.addChild(m_pParticle); // Add Particle to this
			Starling.juggler.add(m_pParticle); // Add to Number Cruncher
			if(length_ != -1)
			{
				m_pParticle.start(length_); // Start Particle
			}
			else
			{
				m_pParticle.start(); // Start Particle
			} // Start for specified duration else start anyway
		} // Constructor
		
		/**Attach sets the position based on parents position.<br />
		 * Use Attach to move this to a parents position every loop.<br /><br />
		 */
		public function Attach(parent_:IRObject,xoff_:Number = 0,yoff_:Number = 0):void
		{
			m_dParent = parent_; // Set the Parent
			m_nOffX = xoff_; // Set the xOffSet
			m_nOffY = yoff_; // Set the yOffSet
			m_pParticle.emitterX = m_dParent.x + m_nOffX; // Set the Emitter X
			m_pParticle.emitterY = m_dParent.y + m_nOffY; // Set the Emitter Y
		} // Attach to parent
		
		public override function Update():void
		{
			if(null != m_dParent)
			{
				m_pParticle.emitterX = m_dParent.x + m_nOffX; // Update the Emitter X
				m_pParticle.emitterY = m_dParent.y + m_nOffY; // Update the Emitter Y
			}
			if(null != m_pParticle && m_bRelease && m_pParticle.numParticles == 0)
			{
				Delete();
			}
			m_bRelease = true;
		} // Run every frame
		
		/**particle returns the ParticleSystem.<br />
		 * Use this function to directly manipulate a particle system.<br /><br />
		 */
		public function get particle():PDParticleSystem
		{
			return m_pParticle;
		} // Get the Particle
		public function set particle(particle_:PDParticleSystem):void
		{
			m_pParticle = particle_;
		} // Set the Particle
		
		public override function Destroy():void
		{
			m_pParticle.stop(false); // Stop Particle
			Starling.juggler.remove(m_pParticle); // Remove from Number Cruncher
			this.removeChild(m_pParticle,true); // Remove from this
			m_pParticle = null; // Set to null
			m_dParent = null; // Set to null
			super.Destroy(); // Super Deconstructor
		} // Destructor
	} // Class
} // Package