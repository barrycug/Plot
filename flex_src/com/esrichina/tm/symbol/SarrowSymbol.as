package com.esrichina.tm.symbol
{
	import com.esri.ags.Map;
	import com.esri.ags.geometry.Geometry;
	import com.esrichina.tm.geometry.Sarrow;
	import com.esrichina.tm.utils.ASUtil;

	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import mx.graphics.GradientEntry;
	import mx.graphics.LinearGradient;

	public class SarrowSymbol extends CustomFillSymbol
	{
		public function SarrowSymbol(type:String)
		{
			super(type);
			this.type=type;
			this.color=0xB22222;
			this.alpha=0.8;
		}


		override public function draw(sprite:Sprite, geometry:Geometry, attributes:Object, map:Map):void
		{
			if (geometry is Sarrow)
			{
				drawSarrow(sprite, map, geometry as Sarrow);
			}
		}

		private function drawSarrow(sprite:Sprite, map:Map, sarrow:Sarrow):void
		{
			if (sarrow.rings == null || sarrow.rings.length == 0)
				return;
			var ring:Array=(sarrow.rings)[0];
			var rings:Array=[];
			for (var j:int=0; j < ring.length; j++)
			{
				rings.push(new Point(toScreenX(map, ring[j].x), toScreenY(map, ring[j].y)));
			}
			if (rings == null || rings.length == 0)
				return;
			var rectange:Rectangle=ASUtil.createRectangle(rings);

			sprite.width=rectange.width;
			sprite.height=rectange.height;
			var graphic:Graphics=sprite.graphics;
			graphic.clear();
			/* var gradientBoxMatrix:Matrix=new Matrix();
			   gradientBoxMatrix.createGradientBox(1400,1500, Math.PI / 2, 0, 0);
			 sprite.graphics.beginGradientFill(GradientType.LINEAR, [0xFF0000, 0x00FF00, 0xFFACD], [1, 0.35, 0.1], [0, 100, 255], gradientBoxMatrix, SpreadMethod.REFLECT); */
			graphic.lineStyle(1, 0x33CCFF, 1.0);
			var fill:LinearGradient=new LinearGradient();
			var ratio:Number=2 * sarrow.ratio / Math.PI;
			var g1:GradientEntry=new GradientEntry(0xFF0000, 0.0, 0.5);
			var g2:GradientEntry=new GradientEntry(0x00FF00,ratio*0.5, 0.5);
			var g3:GradientEntry=new GradientEntry(0xFFACD, ratio, 0.5);
			fill.entries=[g1,g2, g3];
			fill.begin(graphic, rectange);
			var start_point:Point=rings[0] as Point;
			var n:int=rings.length;
			graphic.moveTo(start_point.x, start_point.y);

			//开始点坐标
			for (var i:int=0; i < n; i++)
			{
				graphic.lineTo(rings[i].x, rings[i].y);
			}
			fill.end(graphic);
			graphic.lineStyle(2, 0xFF0000, 0.8);
			graphic.moveTo(rectange.x, rectange.y);
			graphic.lineTo(rectange.x + rectange.width, rectange.y);
			graphic.lineTo(rectange.x + rectange.width, rectange.y + rectange.height);
			graphic.lineTo(rectange.x, rectange.y + rectange.height);
			graphic.lineTo(rectange.x, rectange.y);
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