package br.pedromoraes.btween.properties.movieclip
{
	import br.pedromoraes.btween.BTween;
	import br.pedromoraes.btween.properties.BaseProperty;
	
	import flash.display.MovieClip;

	public class FrameProperty extends BaseProperty
	{

		public function FrameProperty(pTarget:MovieClip, ... paFrames:Array):void
		{
			super(pTarget, (paFrames.length == 2) ? { init : paFrames[0], frame : paFrames[1] } : { frame : paFrames[0] });
		}

		public override function update(pTween:BTween, piElapsed:int):void
		{
			if (!startValues) init();
			index = pTween.getValue(0, 1, piElapsed);

			target.gotoAndStop(startValues.frame + Math.floor((properties.frame - startValues.frame)*index));
		}
		
		public override function init():void
		{
			if (properties.init) target.gotoAndStop(properties.init);
			startValues = new Object();
			startValues.frame = target.currentFrame;
		}

	}

}