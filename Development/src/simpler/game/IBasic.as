package simpler.game
{
	public interface IBasic
	{
		// Simpler Functions //
		function Update():void;
		function Delete():void;
		function Destroy():void;
		function get isDeleted():Boolean;
		function Zombie():void;
		function get Constant():Boolean;
		function set Constant(value_:Boolean):void;
		function get Global():IRGlobal;
		function get Assets():IRAssets;
		function get ClassName():String;
		function set ClassName(name_:String):void;
		function get Collisions():Array;
		function set Collisions(collisions_:Array):void;
		function get UID():int;
		function get totalObjects():int;
		
		// Common Display Functions //
		/*
		Look at Sprite and see what common functions are shared and add them all here!
		*/
	}
}