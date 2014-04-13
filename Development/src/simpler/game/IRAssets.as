package simpler.game
{
	// Flash Classes \/ //
	import flash.display.Bitmap; // Import the Bitmap Class
	import flash.display.BitmapData; // Import the BitmapData Class
	import flash.display.Sprite; // Import the Sprite Class
	import flash.media.Sound; // Import the Sound Class
	import flash.media.SoundChannel; // Import the SoundChannel Class
	import flash.media.SoundTransform; // Import the SoundTransform Class
	import flash.media.SoundMixer; // Import the SoundMixer Class
	import flash.utils.Dictionary; // Import the Dictionary Class
	// Starling Classes \/ //
	import starling.display.Image; // Import the Image Class
	import starling.extensions.PDParticleSystem; // Import the PDParticleSystem Class
	import starling.textures.Texture; // Import the Texture Class
	import starling.textures.TextureAtlas; // Import the TextureAtlas Class
	import starling.display.Quad; // Import the Quad Class
	import starling.display.MovieClip; // Import the MovieClip Class
	import starling.text.TextField; // Import the TextField Class
	import starling.text.BitmapFont; // Import the BitmapFont Class
	// Simpler Classes \/ //
	import simpler.display.IRConvert; // Import the IRConvert Class
	import simpler.display.IRObject; // Import the IRObject Class
	import simpler.display.IRAnimation; // Import the IRAnimation Class
	import simpler.game.IRSound; // Import the IRSound Class
	import flash.geom.Point; // Import the Point Class
	
	public class IRAssets
	{
		private static var s_sInstance:IRAssets; // Store the Instance
		private static var m_tTextureAtlas:TextureAtlas; // Store the Texture Atlas
		private static var m_dAssets:Dictionary = new Dictionary(); // Store Weak References
		public static var AssetClass:Class; // Store the Asset Class
		
		public function IRAssets(loader_:Class)
		{
			AssetClass = loader_;
		} // Constructor
		
		public static function get INSTANCE():IRAssets
		{
			return s_sInstance;
		} // Return the Instance
		public static function set INSTANCE(value:IRAssets):void
		{
			s_sInstance = value;
		} // Set the Instance
		
		// Asset Loading Functions \/ //
		
		/**
		 * getBitmapFontByName returns the full name of a bitmap font.
		 */
		public function getBitmapFontByName(name_:String):String
		{
			return getBitmapFont(name_).name;
		}
		
		/**
		 * getBitmapFont returns a BitmapFont.
		 */
		public function getBitmapFont(name_:String):BitmapFont
		{
			if(m_dAssets[name_ + "Font"])
			{
				return m_dAssets[name_ + "Font"] as BitmapFont;
			}
			var fontTexture:Texture = getTexture(name_ + "Tex");
			var fontXML:XML = XML(new AssetClass[name_ + "XML"]());
			var font:BitmapFont = new BitmapFont(fontTexture, fontXML);
			TextField.registerBitmapFont(font, name_);
			m_dAssets[name_ + "Font"] = font;
			return font;
		}
		
		/**
		 * getTexture returns a texture of a given name.
		 */
		public function getTexture(name_:String):Texture
		{
			if(m_dAssets[name_] == undefined)
			{
				try
				{
					var bitmap:Bitmap = new AssetClass[name_]();
					m_dAssets[name_] = Texture.fromBitmap(bitmap);
				}
				catch(e:Error)
				{
					trace("[Simpler] Error 1003: You are miss using 'getTexture()', You probably didnt include '" + name_ + "', or you spelt it wrong... Daniel.");
				}
			}
			return m_dAssets[name_];
		} // Get a Texture
		
		/**
		 * getImage returns an Image of a certain name.
		 */
		public function getImage(name_:String):Image
		{
			return new Image(getTexture(name_));
		} // Get an Image
		
		/**
		 * getAtlasObject returns an Object from the texture atlas.
		 */
		public function getAtlasObject(name_:String):IRObject
		{
			return new IRConvert(new Image(getTextureAtlas().getTexture(name_)));
		} // Get a Texture IRObject from an Atlas
		
		/**
		 * getAtlasAnimation returns an animation from an atlas.
		 */
		public function getAtlasAnimation(name_:String,fps_:int = 60):IRAnimation
		{
			var TempMovie:MovieClip = new MovieClip(getTextureAtlas().getTextures(name_),fps_); // Create the MovieClip
			return new IRAnimation(TempMovie); // Return the MovieClip
		} // Get a MovieClip from a Texture Atlas
		
		/**
		 * getTextureAtlas returns the texture atlas, named Sprites.
		 */
		public function getTextureAtlas():TextureAtlas
		{
			if(m_tTextureAtlas == null)
			{
				var TempTexture:Texture = getTexture("SpritesTex"); // Get the Texture Atlas Texture
				var TempXML:XML = XML(new AssetClass["SpritesXML"]()); // Get the Texture Atlas XML
				m_tTextureAtlas = new TextureAtlas(TempTexture,TempXML);
			} // Check if Texture Atlas Exists
			return m_tTextureAtlas; // Return the Texture Atlas
		} // Get a Texture Atlas
		
		public function getObject(name_:String):IRObject
		{
			return new IRConvert(new Image(getTexture(name_)));
		} // Get a Textured IRObject
		
		public function getParticle(name_:String):PDParticleSystem
		{
			return new PDParticleSystem(XML(new AssetClass[name_+"Pex"]()),getTexture(name_+"Tex"));
		} // Get a Particle
		
		public function getParticlePex(name_:String):XML
		{
			return XML(new AssetClass[name_+"Pex"]());
		} // Get Particle XML
		
		public function drawQuad(x_:Number,y_:Number,width_:Number,height_:Number,color_:uint = 0x000000,alpha_:Number = 1):IRObject
		{
			var TempQuad:IRObject = new IRConvert(new Quad(width_,height_,color_)); // Create the Quad
			TempQuad.x = x_; // Set the X
			TempQuad.y = y_; // Set the Y
			TempQuad.alpha = alpha_; // Set the alpha
			return TempQuad; // Return the Quad
		} // Draw a Quad
		
		public function drawCircle(x_:Number,y_:Number,radius_:Number,color_:uint = 0x000000,alpha_:Number = 1):IRObject
		{
			var TempSprite:Sprite = new Sprite(); // Create a Sprite
			TempSprite.graphics.beginFill(color_, alpha_); // Begin Filling Sprite
			TempSprite.graphics.drawCircle(x_+(radius_*0.5),y_+(radius_*0.5),radius_*0.5); // Draw Rectangle
			TempSprite.graphics.endFill(); // End Filling Sprite
			var TempBitmap:BitmapData = new BitmapData(radius_, radius_, true, color_); // Create Bitmap Data
			TempBitmap.draw(TempSprite); // Draw Sprite as BitmapData
			return new IRConvert(new Image(Texture.fromBitmapData(TempBitmap))); // Return IRConvert
		} // Draw a Circle
		
		public function getTiledObject(name_:String,width_:Number,height_:Number,rw_:Number,rh_:Number):IRObject
		{
			var tempTexture:Texture = getTexture(name_); // Get a Texture
			tempTexture.repeat = true; // Allow tiling
			var tempImage:Image = new Image(getTexture(name_)); // Get an Image
			tempImage.width = width_; // Set the Width
			tempImage.height = height_; // Set the Height
			tempImage.setTexCoords(1,new Point(rw_,0)); // Set Texture Coordinate
			tempImage.setTexCoords(2,new Point(0,rh_)); // Set Texture Coordinate
			tempImage.setTexCoords(3,new Point(rw_,rh_)); // Set Texture Coordinate
			return new IRConvert(tempImage); // Return image
		} // Get a Textured IRObject with Tiling
		
		public function getIRSound(name_:String,volume_:int = 100,loops_:int = 0):IRSound
		{
			if(loops_ == -1)
			{
				loops_ = int.MAX_VALUE; // Loop FOREVER
			}
			return new IRSound(getSound(name_),volume_,loops_); // Create the Sound
		} // Play a Sound File
		
		public function getSound(name_:String):Sound
		{
			return new AssetClass[name_]() as Sound;
		} // Return a Sound
	} // Class
} // Package