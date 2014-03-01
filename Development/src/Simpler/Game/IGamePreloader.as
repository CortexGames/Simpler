package Simpler.Game
{
	import flash.display.Stage;

	public interface IGamePreloader
	{
		function get ProgramClass():Class;
		function ActivateGame():void;
		function DeactivateGame():void;
		function onAdded(stage_:Stage):void;
		function get isReady():Boolean;
	}
}