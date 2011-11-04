package br.com.netoleal.data
{
	import br.com.netoleal.interfaces.IIterator;
	
	public class DescendingIterator implements IIterator
	{
		private var data:*;
		private var index:int;
		
		public function DescendingIterator( p_data:* )
		{
			data = p_data;
			index = data.length - 1;
		}
		
		public function next( ):*
		{
			return data[ index -- ];
		}
		
		public function first( ):*
		{
			return data[ index = data.length - 1 ];
		}
		
		public function current( ):*
		{
			return data[ index ];
		}
		
		public function hasNext( ):Boolean
		{
			return index >= 0;
		}
	}
}