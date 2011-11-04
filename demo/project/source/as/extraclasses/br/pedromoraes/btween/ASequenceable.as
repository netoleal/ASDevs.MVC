package br.pedromoraes.btween
{
	import flash.events.EventDispatcher;

	public class ASequenceable extends EventDispatcher implements ISequenceable
	{

		public function start( ... params : Array ) : ISequenceable
		{
			return null;
		}

		public function change( params : Object ) : ISequenceable
		{
			for ( var prop : String in params )
			{
				this[ prop ] = params[ prop ];
			}
			return this;
		}

		public function back( transition : Function = undefined ) : ISequenceable
		{
			return null;
		}
		
		public function stop() : ISequenceable
		{
			return null;
		}
	
		public function queue( obj : Object = null, ... params : Array ) : ISequenceable
		{
			if ( obj is ISequenceable )
			{
				addEventListener( BTweenEvent.COMPLETE, obj.start );
				return obj as ISequenceable;
			}
			else if ( obj is Function )
			{
				var call:Call = new Call( obj as Function, params );
				addEventListener( BTweenEvent.COMPLETE, call.start );
				return call;
			}
			else if ( obj is Number )
			{
				var delay:Delay = new Delay( obj as Number );
				addEventListener( BTweenEvent.COMPLETE, delay.start );
				return delay;
			}
			return null;
		}

		public function listen( event : String, listener : Function ) : ISequenceable
		{
			addEventListener( event, listener );
			return this;
		}

	}
}