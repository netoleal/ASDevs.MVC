package br.pedromoraes.util
{
	import mx.utils.StringUtil;

	public class StringUtils
	{
		
		public static function lPad(pText:Object, psChar:String = '0', piLength:int = 2):String
		{
			var lsRes:String = pText.toString();
			for (var liChar:int = lsRes.length; liChar < piLength; liChar ++)
			{
				lsRes = psChar + lsRes;
			}
			return lsRes;
		}
		
		public static function trim(pText:Object):String
		{
			return StringUtil.trim(pText.toString());
		}

	}
}