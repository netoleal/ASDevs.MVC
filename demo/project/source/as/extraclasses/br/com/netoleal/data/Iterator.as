package br.com.netoleal.data
{
	import br.com.netoleal.interfaces.IIterator;
	
	public class Iterator implements IIterator
	{
		private var data:*;
		private var index:uint;
		
		public function Iterator( p_data:* )
		{
			data = p_data;
			index = 0;
		}
		
		public function next( ):*
		{
			return data[ index ++ ];
		}
		
		public function first( ):*
		{
			return data[ index = 0 ];
		}
		
		public function current( ):*
		{
			return data[ index ];
		}
		
		public function hasNext( ):Boolean
		{
			return index < data.length;
		}
	}
}