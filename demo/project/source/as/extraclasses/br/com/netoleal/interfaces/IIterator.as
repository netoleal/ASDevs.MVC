package br.com.netoleal.interfaces
{
	public interface IIterator
	{
		function next( ):*;
		function first( ):*;
		function current( ):*;
		function hasNext( ):Boolean;
	}
}