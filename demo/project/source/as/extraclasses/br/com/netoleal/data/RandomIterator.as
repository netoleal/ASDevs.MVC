package br.com.netoleal.data
{
	import br.com.netoleal.interfaces.IIterator;
	
	public class RandomIterator implements IIterator
	{
		private var data:*;
		private var index:uint;
		private var it:Iterator;
		
		public function RandomIterator( p_data:* )
		{
			data = [ ].concat( p_data );
			randomize( data);
			it = new Iterator( data );
		}
		
		private function randomize( target:* ):void
		{
			var t:uint = target.length; 
			var rand:uint;
			var temp:*;
			
			for ( var n:uint = 0; n < t; n++ )
			{
				rand = Math.floor( Math.random( ) * t ); 
				temp = target[ n ]; target[ n ] = target[ rand ]; 
				target[ rand ] = temp; 
			}
		}
		
		public function next():*
		{
			return it.next( );
		}
		
		public function first():*
		{
			return it.first( );
		}
		
		public function current():*
		{
			return it.current( );
		}
		
		public function hasNext():Boolean
		{
			return it.hasNext( );
		}
	}
}