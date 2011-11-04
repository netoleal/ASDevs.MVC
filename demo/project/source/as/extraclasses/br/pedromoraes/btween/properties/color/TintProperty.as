package br.pedromoraes.btween.properties.color
{
	import br.pedromoraes.btween.BTween;
	import br.pedromoraes.btween.properties.IProperty;
	
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;

	public class TintProperty implements IProperty
	{
		
		public var startValues:ColorTransform;
		public var index:Number;
		public var tintColor:int;
		public var tintPercent:Number;

		private var finalTransform:ColorTransform;
		
		protected var _target:DisplayObject;
		public function get target():Object { return _target }
		public function set target(pTarget:Object):void { _target = pTarget as DisplayObject }
		
		public function TintProperty(pTarget:DisplayObject, piTintColor:int, pnTintPercent:Number = 100)
		{
			target = pTarget;
			tintColor = piTintColor;
			tintPercent = pnTintPercent;
			finalTransform = new ColorTransform(0,0,0,1,tintColor >> 16,tintColor >> 8 & 0xFF,tintColor & 0xFF,0);
		}

		public function update(pTween:BTween, piElapsed:int):void
		{
			if (!startValues) init();
			index = pTween.getValue(0, 1, piElapsed);

			if (index > 0)
			{
				var correctedIndex:Number = index/(100/tintPercent);
				var ct:ColorTransform = new ColorTransform();
				ct.redMultiplier = startValues.redMultiplier + (finalTransform.redMultiplier - startValues.redMultiplier) * correctedIndex;
				ct.greenMultiplier = startValues.greenMultiplier + (finalTransform.greenMultiplier - startValues.greenMultiplier) * correctedIndex;
				ct.blueMultiplier = startValues.blueMultiplier + (finalTransform.blueMultiplier - startValues.blueMultiplier) * correctedIndex;
				ct.redOffset = startValues.redOffset + (finalTransform.redOffset - startValues.redOffset) * correctedIndex;
				ct.greenOffset = startValues.greenOffset + (finalTransform.greenOffset - startValues.greenOffset) * correctedIndex;
				ct.blueOffset = startValues.blueOffset + (finalTransform.blueOffset - startValues.blueOffset) * correctedIndex;
				target.transform.colorTransform = ct;
			}
		}

		public function reverse():void
		{
			if (!startValues) init();
			var f:ColorTransform = finalTransform;
			finalTransform = startValues;
			startValues = f;
		}

		public function clone():IProperty
		{
			return new TintProperty(_target, tintColor, tintPercent);
		}

		private function init():void
		{
			if (target.transform.colorTransform)
			{
				startValues = target.transform.colorTransform;
			}
			else
			{
				startValues = new ColorTransform();
			}
		}

	}
}