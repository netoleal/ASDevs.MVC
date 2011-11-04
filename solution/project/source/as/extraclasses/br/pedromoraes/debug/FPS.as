package br.pedromoraes.debug
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.System;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.utils.getTimer;

	public class FPS extends Sprite
	{
		private var txt:TextField;
		private var lastFrameTime:Number;
		private var _frames:Number = 0;
		
		function FPS( fontColor:String = "#000000" ):void
		{
			txt = new TextField();
			txt.width = 70;
			txt.height = 20;
			txt.selectable = false;
			var css:StyleSheet = new StyleSheet();
			css.parseCSS('p {font-family:verdana;font-size:12px;color:' + fontColor + '}');
			txt.styleSheet = css;
			lastFrameTime = getTimer();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addChild(txt);
			super();
		}
		
		private function onEnterFrame(evt:Event):void
		{
			_frames ++;
			var time:Number = getTimer( );
			if (time - lastFrameTime >= 1000)
			{
				var lsMem:String = ' - ' + Number( System.totalMemory / 1024 / 1024 ).toFixed( 1 ) + 'Mb';
				txt.htmlText = "<p>"+String(_frames)+lsMem+"</p>";
				_frames = 0;
				lastFrameTime = time;
			}
		}
	}
}