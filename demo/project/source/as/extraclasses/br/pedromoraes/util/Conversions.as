package br.pedromoraes.util
{
	public class Conversions
	{

		public static var deg2rad:Number = 0.0174532925;

		public static function hexToInt(psValue:String):int
		{
			return psValue ? int(psValue.replace('#','0x')) : 0;
		}

	}
}