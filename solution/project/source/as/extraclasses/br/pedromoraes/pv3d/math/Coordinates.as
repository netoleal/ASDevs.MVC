package br.pedromoraes.pv3d.math
{
	import org.papervision3d.core.geom.renderables.Vertex3D;
	
	public class Coordinates
	{
		public static var ZERO:Vertex3D = new Vertex3D();

		public static function getPointOnSphere(radius:Number, phi:Number, theta:Number):Vertex3D
		{
			var x:int,y:int,z:int;	
			var sinPhi:Number = Math.sin(phi);
			x = radius*Math.cos(theta)*sinPhi;
			y = radius*Math.sin(theta)*sinPhi;
			z = radius*Math.cos(phi);
			return new Vertex3D(x, y, z);   
		}
	}
}