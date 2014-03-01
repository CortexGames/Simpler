package Simpler.Utils
{
	import Simpler.Game.IRGlobal;
	import Simpler.Physics.IRPDebug;
	
	/**
	 * IRDebugger is used to perform debug operations on Simpler.
	 * Most functions in this class will cause performance problems.
	 * This class should only ever be used for debugging!
	 */
	public class IRDebugger
	{
		/**
		 * Delete all objects in GAMEITEMS using the deletion method.
		 */
		public static function deleteAll():void
		{
			for(var i:int = 0; i < IRGlobal.getInstance().GAMEITEMS.length; i++)
			{
				IRGlobal.getInstance().GAMEITEMS[i].Delete();
			}
		}
		
		/**
		 * Delete all objects in GAMEITEMS with a certain ClassName.
		 */
		public static function deleteClassName(className_:String):void
		{
			for(var i:int = 0; i < IRGlobal.getInstance().GAMEITEMS.length; i++)
			{
				if(IRGlobal.getInstance().GAMEITEMS[i].ClassName == className_)
				{
					IRGlobal.getInstance().GAMEITEMS[i].Delete();
				}
			}
		}
		
		/**
		 * Add IRPDebug to GAMEITEMS.
		 */
		public static function showPhysics():void
		{
			IRGlobal.getInstance().Create(new IRPDebug());
		}
		
		/**
		 * Delete IRPDebug from GAMEITEMS.
		 */
		public static function hidePhysics():void
		{
			for(var i:int = 0; i < IRGlobal.getInstance().GAMEITEMS.length; i++)
			{
				if(IRGlobal.getInstance().GAMEITEMS[i].ClassName == "IRPDebug")
				{
					IRGlobal.getInstance().GAMEITEMS[i].Delete();
				}
			}
		}
		
		/**
		 * Trace the display list showing child objects and class names.
		 */
		public static function traceDisplayList():void
		{
			
		}
		
		/**
		 * Trace class names.
		 */
		public static function traceClassNames():void
		{
			
		}
		
		/**
		 * Display the class name of an object inside of it.
		 */
		public static function displayClassNames():void
		{
			
		}
		
		/**
		 * Enable keyboard control of Debugger.
		 */
		public static function enableKeyboardControl():void
		{
			IRGlobal.getInstance().Create(new IRDebuggerObject());
		}
		
		/**
		 * Disable keyboard control of Debugger.
		 */
		public static function disableKeyboardControl():void
		{
			for(var i:int = 0; i < IRGlobal.getInstance().GAMEITEMS.length; i++)
			{
				if(IRGlobal.getInstance().GAMEITEMS[i].ClassName == "IRDebuggerObject")
				{
					IRGlobal.getInstance().GAMEITEMS[i].Delete();
				}
			}
		}
	}
}
import Simpler.Display.IRObject;
import Simpler.Utils.IRDebugger;

internal class IRDebuggerObject extends IRObject
{
	public function IRDebuggerObject()
	{
		ClassName = "IRDebuggerObject";
		Constant = true;
	}
	
	public override function Update():void
	{
		// Put keybaord controls here!
	}
}