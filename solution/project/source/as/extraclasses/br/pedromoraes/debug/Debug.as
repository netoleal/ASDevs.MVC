package br.pedromoraes.debug
{

	import flash.system.fscommand;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.events.Event;
	import br.pedromoraes.util.StringUtils;
	import flash.utils.getTimer;
	import com.soenkerohde.logging.LogFactory;
	import mx.logging.ILogger;
	
	public class Debug
	{
		public static var TRACE:Number = 1;
		public static var SCREEN:Number = 2;
		public static var FLASHOUT:Number = 3;
		public static var FLASHCONNECT:Number = 4;
		public static var SOS:Number = 5;

		public static var OUTPUT_TYPE:Number = TRACE;

		public static var stage:Stage;
		
		public static const sos : ILogger = LogFactory.getLogger( "debug" );
		private static var outputTF:TextField;

		public static function log(... args:Array):void
		{
			var lsMsg:String = "";
			for each (var s:Object in args) lsMsg += s + ", ";
			lsMsg = lsMsg.substring(0, lsMsg.length - 2);

			switch (OUTPUT_TYPE)
			{
				case TRACE:
					trace(lsMsg);
					break;
				case SCREEN:
					sendToScreenOutput(lsMsg);
					break;
				case FLASHOUT:
					sendToFlashOut(lsMsg);
					break;
				case FLASHCONNECT:
					sendToFlashConnect(lsMsg);
					break;
				case SOS:
					sendToSOS(lsMsg);
					break;
			}
		}

		private static function sendToSOS(psMsg:String):void
		{
			sos.log(0, psMsg);
		}

		private static function sendToFlashOut(psMsg:String):void
		{
			fscommand("trace", psMsg);
		}

		private static function sendToFlashConnect(psMsg:String):void
		{
			sendToFlashOut("fc3");
			//FlashConnect3.trace(psMsg);
			//fscommand("trace", psMsg);
		}
		
		private static function sendToScreenOutput(psMsg:String):void
		{
			if (!outputTF)
			{
				createOutputTextField();
			}
			var d:Date = new Date();
			outputTF.appendText("\n" + StringUtils.lPad(Math.floor(getTimer()/1000), '0', 2) + psMsg);
			onTextChange();
		}
		
		private static function createOutputTextField():void
		{
			outputTF = new TextField();
			var tfmt:TextFormat = new TextFormat();
			tfmt.color = 0x666666;
			tfmt.font = "verdana";
			tfmt.size = 9;
			outputTF.multiline = true;
			outputTF.defaultTextFormat = tfmt;
			outputTF.width = stage.stageWidth;
			outputTF.selectable = false;
			outputTF.width = stage.stageWidth/5;
			outputTF.height = stage.stageHeight;
			outputTF.wordWrap = true;
			outputTF.x = stage.stageWidth - outputTF.width;
			stage.addEventListener(Event.RESIZE, onResize);
			stage.addChild(outputTF);
		}
		
		private static function onTextChange(evt:*=null):void
		{
			outputTF.scrollV = outputTF.maxScrollV;
		}
		
		private static function onResize(evt:*):void
		{
			outputTF.width = stage.stageWidth/5;
			outputTF.height = stage.stageHeight;
			outputTF.x = stage.stageWidth - outputTF.width;
			onTextChange();
		}

	}

}