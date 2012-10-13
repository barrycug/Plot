package com.esrichina.tm.symbol
{
	import com.esri.ags.Map;
	import com.esri.ags.geometry.Geometry;
	import com.esrichina.tm.geometry.EqualSarrow;

	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;

	public class EqualSarrowSymbol extends CustomFillSymbol
	{
		public function EqualSarrowSymbol(type:String)
		{
			super(type);
			this.type=type;
			this.color=0xB22222;
			this.alpha=0.8;
		}

		override public function draw(sprite:Sprite, geometry:Geometry, attributes:Object, map:Map):void
		{
			if (geometry is EqualSarrow)
			{
				drawSarrow(sprite, map, geometry as EqualSarrow);
			}
		}

		private function drawSarrow(sprite:Sprite, map:Map, sarrow:EqualSarrow):void
		{
			if (sarrow.rings == null || sarrow.rings.length == 0)
				return;
			sprite.width=1;
			sprite.height=1;
			var graphic:Graphics=sprite.graphics;
			graphic.clear();
			var gradientBoxMatrix:Matrix=new Matrix();

			gradientBoxMatrix.createGradientBox(1400, 1500, Math.PI / 2, 0, 0);
			graphic.beginGradientFill(GradientType.LINEAR, [0xFF0000, 0x00FF00, 0xFFACD], [1, 0.35, 0], [0, 100, 255], gradientBoxMatrix, SpreadMethod.REFLECT);
			var ring:Array=(sarrow.rings)[0];

			var rings:Array=new Array();
			for (var j:int=0; j < ring.length; j++)
			{
				rings.push(new Point(toScreenX(map, ring[j].x), toScreenY(map, ring[j].y)));
			}
			if (rings == null || rings.length == 0)
				return;
			var start_point:Point=rings[0] as Point;
			var n:int=rings.length;
			graphic.moveTo(start_point.x, start_point.y);
			//开始点坐标
			for (var i:int=0; i < n; i++)
			{
				graphic.lineTo(rings[i].x, rings[i].y);
			}
			graphic.endFill();
			if (iseditor)
			{
				var ps:Array=sarrow.ps;
				var m:int=ps.length;
				graphic.lineStyle(5, 0xFF0000, 1.0);
				graphic.beginFill(0xFF0000);
				for (i=0; i < m; i++)
				{
					graphic.drawCircle(toScreenX(map,ps[i].x), toScreenY(map,ps[i].y), 1);
				}
				graphic.endFill();
			}
		}

	}
}