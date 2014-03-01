package Simpler.Display
{
	// Starling Classes \/ //
	import starling.display.MovieClip; // Import the MovieClip Class
	import starling.core.Starling; // Import the Starling Class
	// Simpler Classes \/ //
	import Simpler.Display.IRObject; // Import the IRObject Class
	
	/**
	 * IRAnimation stores an animation.<br />
	 */
	public class IRAnimation extends IRObject
	{
		protected var m_cMovieClip:MovieClip; // Store the MovieClip
		
		public function IRAnimation(movie_:MovieClip):void
		{
			m_cMovieClip = movie_; // Set the Movie Clip
			this.addChild(m_cMovieClip); // Add to this
			Starling.juggler.add(m_cMovieClip); // Add to Number Cruncher
		} // Constructor
		
		public override function Destroy():void
		{
			Starling.juggler.remove(m_cMovieClip); // Remove from Number Cruncher
			this.removeChild(m_cMovieClip,true); // Remove from this
			m_cMovieClip = null; // Null Reference
			super.Destroy(); // Super Deconstructor
		} // Deconstructor
	} // Class
} // Package