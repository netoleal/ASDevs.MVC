package br.pedromoraes.math
{
	import flash.geom.Matrix;
	
	public class MatrixUtils
	{

		public static function getTranslation(pnX:Number = 0, pnY:Number = 0):Matrix
		{
			var mtx:Matrix = new Matrix();
			mtx.translate(pnX, pnY);
			return mtx;
		}

		public static function getGradientBox(pnWidth:Number = 0, pnHeight:Number = 0, pnRotation:Number = 0, pnTranslateX:Number = 0, pnTranslateY:Number = 0):Matrix
		{
			var mtx:Matrix = new Matrix();
			mtx.createGradientBox(pnWidth, pnHeight, pnRotation, pnTranslateX, pnTranslateY);
			return mtx;
		}

		public static function getScale(pnScaleX:Number, pnScaleY:Number):Matrix
		{
			var mtx:Matrix = new Matrix();
			mtx.scale(pnScaleX, pnScaleY);
			return mtx;
		}

	}
}