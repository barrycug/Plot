package com.esrichina.tm.symbol
{
	import com.esri.ags.Map;
	import com.esri.ags.geometry.Geometry;
	import com.esrichina.tm.geometry.CurveFlag;

	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;

	public class CurveFlagSymbol extends CustomFillSymbol
	{
		public function CurveFlagSymbol(type:String)
		{
			super(type);
			this.type=type;
			this.color=0xF08080;
			this.alpha=0.8;
		}


		override public function draw(sprite:Sprite, geometry:Geometry, attributes:Object, map:Map):void
		{
			if (geometry is CurveFlag)
			{
				drawCurveFlag(sprite, map, geometry as CurveFlag);
			}
		}

		private function drawCurveFlag(sprite:Sprite, map:Map, curveflag:CurveFlag):void
		{
			if (curveflag.rings == null || curveflag.rings.length == 0)
			{
				return;
			}

			sprite.width=1;
			sprite.height=1;
			var graphic:Graphics=sprite.graphics;
			graphic.clear();
			graphic.beginFill(color);
			graphic.lineStyle(5, color, alpha);
			var rings:Array=(curveflag.rings)[0] as Array;
			var n:int=rings.length;
			var screenps:Array=[];
			for (var j:int=0; j < n; j++)
			{
				screenps.push(new Point(toScreenX(map, rings[j].x), toScreenY(map, rings[j].y)));
			}

			if (screenps == null || screenps.length == 0)
				return;
			var point:Point=screenps[0];
			var point2:Point=screenps[1];
			var xdis:Number=point2.x - point.x;

			var control1:Point=new Point((point.x) + (xdis) / 6, (point.y) + (xdis) / 9);
			var mid_point:Point=new Point(point.x + (xdis) * 0.5, point.y);
			var control11:Point=new Point(point.x + (xdis) * 0.75, point.y - (xdis) / 9);

			graphic.moveTo(point.x, point.y);
			graphic.curveTo(control1.x, control1.y, mid_point.x, mid_point.y);
			graphic.curveTo(control11.x, control11.y, point2.x, point2.y);
			var point3:Point=screenps[2];
			var point4:Point=screenps[3];
			graphic.lineTo(point3.x, point3.y);
			var control21:Point=new Point(point.x + (xdis) * 0.75, point3.y - xdis / 9);
			var mid_point2:Point=new Point(point.x + xdis * 0.5, point3.y);
			graphic.curveTo(control21.x, control21.y, mid_point2.x, mid_point2.y);
			var control22:Point=new Point(point.x + xdis * 0.25, point3.y + xdis / 9);
			graphic.curveTo(control22.x, control22.y, point4.x, point4.y);
			var point5:Point=screenps[4];
			graphic.lineTo(point5.x, point5.y);

			sprite.graphics.endFill();
			if (iseditor)
			{
				var ps:Array=curveflag.ps;
				var m:int=ps.length;
				graphic.lineStyle(5, 0xFF0000, 1.0);
				graphic.beginFill(0xFF0000);
				for (var i:int=0; i < m; i++)
				{
					graphic.drawCircle(toScreenX(map,ps[i].x), toScreenY(map,ps[i].y), 1);
				}
				graphic.endFill();
			}
		}

	}
}