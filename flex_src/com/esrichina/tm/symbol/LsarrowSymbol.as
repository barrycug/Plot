package com.esrichina.tm.symbol
{
	import com.esri.ags.Map;
	import com.esri.ags.geometry.Geometry;
	import com.esrichina.tm.geometry.Lsarrow;

	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;

	public class LsarrowSymbol extends CustomLineSymbol
	{
		public function LsarrowSymbol(type:String)
		{
			super();
			this.type=type;
			this.color=0xF08080;
			this.alpha=0.8;
		}

		override public function draw(sprite:Sprite, geometry:Geometry, attributes:Object, map:Map):void
		{
			if (geometry is Lsarrow)
			{
				drawLine(sprite, map, geometry as Lsarrow);
			}
		}

		private function drawLine(sprite:Sprite, map:Map, lsarrow:Lsarrow):void
		{
			sprite.width=1;
			sprite.height=1;
			if (lsarrow.paths == null || lsarrow.paths.length == 0)
				return;
			var graphic:Graphics=sprite.graphics;
			graphic.clear();
			graphic.beginFill(color);
			graphic.lineStyle(6, color, alpha);
			var mps:Array=(lsarrow.paths)[0];
			if (mps == null)
				return;
			var n:int=mps.length;
			var screenps:Array=[];
			for (var j:int=0; j < n; j++)
			{
				screenps.push(new Point(toScreenX(map, mps[j].x), toScreenY(map, mps[j].y)));
			}
			if (screenps == null || screenps.length == 0)
				return;
			n=screenps.length;
			var screen_point:Point=screenps[0] as Point;
			graphic.moveTo(screen_point.x, screen_point.y);
			var mid_temp_screen:Point;
			for (var i:int=0; i < n - 2; i++)
			{
				mid_temp_screen=screenps[i] as Point;
				graphic.lineTo(mid_temp_screen.x, mid_temp_screen.y);
				graphic.moveTo(mid_temp_screen.x, mid_temp_screen.y);
			}
			var end_point:Point=screenps[n - 3] as Point;
			var left_point:Point=screenps[n - 2];
			var right_point:Point=screenps[n - 1];
			graphic.moveTo(left_point.x, left_point.y);
			graphic.lineTo(end_point.x, end_point.y);
			graphic.moveTo(end_point.x, end_point.y);
			graphic.lineTo(right_point.x, right_point.y);
			graphic.endFill();
			if (iseditor)
			{
				var ps:Array=lsarrow.ps;
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