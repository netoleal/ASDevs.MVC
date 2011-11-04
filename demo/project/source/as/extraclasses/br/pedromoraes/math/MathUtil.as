package br.pedromoraes.math
{
	
	import flash.geom.Point;
	
	public class MathUtil
	{
		public static var rad2deg:Number = 57.2957795;
		public static var deg2rad:Number = 0.0174532925;
		
		public static function abs(x:Number):Number
		{
			return (x ^ (x >> 31)) - (x >> 31);
		}

		public static function pointInsideTriangle(p:Point, pTriA:Point, pTriB:Point, pTriC:Point):Boolean
		{
			/* var triA:Point2D = pTriA.sub(p);
			var triB:Point2D = pTriB.sub(p);
			var triC:Point2D = pTriC.sub(p);
			var lnAngle:Number = triA.getAngleToPoint(triB) +
									triB.getAngleToPoint(triC) +
									triC.getAngleToPoint(triA);
			return abs(lnAngle) >= Math.PI; */
			var oneOverDenom:Number = (1 /
		        (((pTriA.y - pTriC.y) * (pTriB.x - pTriC.x)) +
		        ((pTriB.y - pTriC.y) * (pTriC.x - pTriA.x))));
		    var b1:Number = (oneOverDenom *
		        (((p.y - pTriC.y) * (pTriB.x - pTriC.x)) +
		        ((pTriB.y - pTriC.y) * (pTriC.x - p.x))));
		    var b2:Number = (oneOverDenom *
		        (((p.y - pTriA.y) * (pTriC.x - pTriA.x)) +
		        ((pTriC.y - pTriA.y) * (pTriA.x - p.x))));
		    var b3:Number = (oneOverDenom *
		        (((p.y - pTriB.y) * (pTriA.x - pTriB.x)) +
		        ((pTriA.y - pTriB.y) * (pTriB.x - p.x))));
		 
		    return ((b1 > 0) && (b2 > 0) && (b3 > 0));  
		}
		
		public static function sign(pValue:Number):int
		{
			return pValue == 0 ? 0 : (pValue < 0 ? -1 : 1);
		}
	}

}