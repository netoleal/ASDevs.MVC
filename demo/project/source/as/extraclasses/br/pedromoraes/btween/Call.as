package br.pedromoraes.btween
{
	
	public class Call extends ASequenceable implements ISequenceable
	{
		
		public var method:Function;
		public var params:Array;
		
		public function Call(pMethod:Function, paParams:Array = null)
 		{
 			method = pMethod;
 			params = paParams || new Array();
 			super();
 		}
		
		public override function start(... paParams:Array):ISequenceable
		{
			if (paParams[0] is BTweenEvent)
			{
				var caller:ISequenceable = (paParams[0] as BTweenEvent).target as ISequenceable;
				caller.removeEventListener(BTweenEvent.COMPLETE, start);
			}
			var result:Object = method.apply(this, params);
			if (result is ISequenceable)
			{
				var nextStep:ISequenceable = result as ISequenceable;
				nextStep.addEventListener(BTweenEvent.COMPLETE, onCalleeComplete);
				return nextStep;
			}
			else
			{
				dispatchEvent(new BTweenEvent(BTweenEvent.COMPLETE));
				return this;
			}
		}
		
		private function onCalleeComplete(pEvt:BTweenEvent):void
		{
			dispatchEvent(new BTweenEvent(BTweenEvent.COMPLETE));
		}
		
	}
}