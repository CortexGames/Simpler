package Simpler.Extensions.Scripting
{
	import flash.display.MovieClip;
	import com.newgonzo.scripting.events.CompilerEvent;
	import com.newgonzo.scripting.events.ScriptErrorEvent;
	import com.newgonzo.scripting.utils.CompilerLoader;
	import com.newgonzo.scripting.IScript;
	import com.newgonzo.scripting.ICompiler;
	import com.newgonzo.scripting.ScriptContext;
	import com.newgonzo.scripting.ecma.ESCompiler;
	import com.newgonzo.scripting.events.CompilerErrorEvent;
	import com.newgonzo.scripting.events.CompilerEvent;
	
	public class IRTest extends MovieClip
	{
		private var m_cCompiler:ICompiler;
		private var m_cScript:IScript;
		private var m_cScriptContext:ScriptContext;
		private var m_sInput:String = "";
		private var m_sOutput:String = "";
		private var m_bStarted:Boolean = false;
		
		public function IRTest()
		{
			m_sInput = "console.print('Starting!');";
			runCompiler();
		}
		
		private function runCompiler():void
		{
			if(m_cCompiler != null)
			{
				m_cCompiler.removeEventListener(CompilerErrorEvent.COMPILER_ERROR, compilerError);
				m_cCompiler.removeEventListener(CompilerEvent.INIT, compilerLoaded);
				m_cCompiler = null;
			}
			m_cCompiler = new ESCompiler();
			m_cCompiler.addEventListener(CompilerErrorEvent.COMPILER_ERROR, compilerError);
			m_cCompiler.addEventListener(CompilerEvent.INIT, compilerLoaded);
		}
		
		private function runScript():void
		{
			if(m_cScript)
			{
				m_cScript.unload();
			}
			m_cScriptContext = new ScriptContext(this);
			m_cScriptContext.exposeDefinition(consolePrint, "console.print");
			m_cScriptContext.exposeDefinition(consoleClear, "console.clear");
			try
			{
				m_cScript = m_cCompiler.compileAndLoad(m_sInput, m_cScriptContext);
				m_cScript.addEventListener(ScriptErrorEvent.SCRIPT_ERROR, scriptError);
			}
			catch(e:Error)
			{
				consolePrint(e.toString());
			}
		}
		
		private function consolePrint(input:String):void
		{
			m_sOutput = input;
		}
		
		private function consoleClear():void
		{
			m_sOutput = "";
		}
		
		private function scriptError(event:ScriptErrorEvent):void
		{
			consolePrint(event.text);
		}
		
		private function compilerError(event:CompilerErrorEvent):void
		{
			consolePrint(event.text);
		}
		
		private function compilerLoaded(event:CompilerEvent):void
		{
			trace("Run");
			runScript();
		}
		
		public function Run(script_:String):void
		{
			m_sInput = script_;
			runCompiler();
		}
		
		public function get Output():String
		{
			return m_sOutput;
		}
	}
}