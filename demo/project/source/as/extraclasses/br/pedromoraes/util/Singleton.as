package br.pedromoraes.util
{

	public function Singleton(pClass:Class, arg:*=null):*
	{
		if (!Storage.instances[pClass])
		{
			if (arg == null)
			{
				Storage.instances[pClass] = new pClass();
			}
			else
			{
				Storage.instances[pClass] = new pClass(arg);
			}
		}
		return Storage.instances[pClass];
	}
	

}

import flash.utils.Dictionary;

class Storage
{
	public static var instances:Dictionary = new Dictionary();
}