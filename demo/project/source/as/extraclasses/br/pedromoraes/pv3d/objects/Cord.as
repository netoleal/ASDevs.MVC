package br.pedromoraes.pv3d.objects
{
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.core.proto.GeometryObject3D;
	import org.papervision3d.core.proto.SceneObject3D;
	import org.papervision3d.core.geom.Vertex3D;
	import org.papervision3d.core.Number3D;
	import flash.display.Sprite;
	import org.papervision3d.core.geom.Vertex2D;
	import org.papervision3d.core.geom.Vertices3D;
	import org.papervision3d.core.proto.CameraObject3D;
	
	public class Cord extends Vertices3D
	{

		public var color:uint;
		public var segments:int;
		public var points:Array;
		public var edgeA:Vertex3D;
		public var edgeB:Vertex3D;

		public function Cord(pPointA:Number3D, pPointB:Number3D, piSegments:int, puColor:int, psName:String, pInit:Object = null)
		{
			edgeA = new Vertex3D(pPointA.x, pPointA.y, pPointA.z);
			edgeB = new Vertex3D(pPointB.x, pPointB.y, pPointB.z);
			color = puColor;
			segments = piSegments;
			points = new Array();
			for (var lnV:Number = 0; lnV < piSegments; lnV ++)
			{
				points.push(new Vertex2D(0,0,0));
			}
			super(new Array(edgeA, edgeB), psName, pInit );
		}
				
		public override function project(parent:DisplayObject3D, camera:CameraObject3D, sorted:Array = null):Number
		{
			super.project(parent, camera, sorted);
			var a:Vertex2D = edgeA.vertex2DInstance;
			var b:Vertex2D = edgeB.vertex2DInstance;
			var vert:Vertex2D;
			var lnSegmentSizeX:Number = (b.x - a.x) / segments;
			var lnSegmentSizeY:Number = (b.y - a.y) / segments;
			var lnSegmentSizeZ:Number = (b.z - a.z) / segments;
			points[0] = a;
			for (var lnV:Number = 1; lnV < segments - 1; lnV ++)
			{
				vert = points[lnV];
				vert.x = a.x+lnSegmentSizeX*lnV;
				vert.y = a.y+lnSegmentSizeY*lnV;
				vert.z = a.z+lnSegmentSizeZ*lnV;
			}
			points[points.length-1] = b;			
			return lnV;
		}
				
		public override function render(scene:SceneObject3D):void
		{
			var vert:Vertex2D;
			container.graphics.lineStyle(1, color);
			container.graphics.moveTo(points[0].x, points[0].y);
			for (var lnV:Number = 1; lnV < segments; lnV ++)
			{
				vert = points[lnV] as Vertex2D;
				container.graphics.lineTo(vert.x, vert.y);
			}
		}

	}
}