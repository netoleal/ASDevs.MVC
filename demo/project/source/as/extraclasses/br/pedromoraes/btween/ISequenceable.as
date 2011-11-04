package br.pedromoraes.btween
{
	import flash.events.IEventDispatcher;
	
	public interface ISequenceable extends IEventDispatcher
	{

		function start( ... paParams:Array ) : ISequenceable

		function stop() : ISequenceable
		
		function queue( obj : Object = null, ... params : Array ) : ISequenceable
		
		function back( transition : Function = undefined ) : ISequenceable

		function change( params : Object ) : ISequenceable
		
		function listen( event : String, listener : Function ) : ISequenceable

	}
}