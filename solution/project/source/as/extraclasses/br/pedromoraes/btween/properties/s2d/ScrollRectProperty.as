package br.pedromoraes.btween.properties.s2d
{
	import br.pedromoraes.btween.BTween;
	import br.pedromoraes.btween.properties.IProperty;
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;

	public class ScrollRectProperty implements IProperty
	{
		
		private var _target:DisplayObject;
		private var startValues:Rectangle;
		private var scrollRect:Rectangle;

		public function ScrollRectProperty(target:DisplayObject, scrollRect:Rectangle):void
		{
			_target = target;
			this.scrollRect = scrollRect;
			if (!_target.scrollRect) _target.scrollRect = new Rectangle();	
		}

		private function init():void
		{
			startValues = target.scrollRect;
		}

		public function get target():Object
		{
			return _target;
		}
		
		public function set target( value:Object ):void
		{
			_target = value as DisplayObject;
		}
		
		public function update(tween:BTween, time:int):void
		{
			if (!startValues) init();
			
			var index:Number = tween.getValue(0, 1, time);
			_target.scrollRect = new Rectangle(
				startValues.x + ( scrollRect.x - startValues.x ) * index,
				startValues.y + ( scrollRect.y - startValues.y ) * index,
				startValues.width + ( scrollRect.width - startValues.width ) * index,
				startValues.height + ( scrollRect.height - startValues.height ) * index
			);
		}

		public function reverse():void
		{
			if (!startValues) init();
			var s:Rectangle = scrollRect.clone();
			scrollRect = startValues;
			startValues = s;
		}

		public function clone():IProperty
		{
			return new ScrollRectProperty(_target, scrollRect);
		}

	}
}