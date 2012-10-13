package com.esrichina.tm.symbol
{
	import com.esri.ags.Map;
	import com.esri.ags.geometry.Geometry;
	import com.esrichina.tm.geometry.Arc;

	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;

	public class ArcSymbol extends CustomLineSymbol
	{
		public function ArcSymbol(type:String)
		{
			super();
			this.type=type;
			this.color=0xF08080;
			this.alpha=0.8;
		}

		override public function draw(sprite:Sprite, geometry:Geometry, attributes:Object, map:Map):void
		{
			if (geometry is Arc)
			{
				drawArc(sprite, map, geometry as Arc);
			}
		}

		private function drawArc(sprite:Sprite, map:Map, arc:Arc):void
		{
			sprite.width=1;
			sprite.height=1;
			if (arc.paths == null || arc.paths.length == 0)
				return;
			sprite.graphics.clear();
			sprite.graphics.beginFill(color);
			sprite.graphics.lineStyle(4, color, alpha);
			var mps:Array=(arc.paths)[0];
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
			var graphic:Graphics=sprite.graphics;
			graphic.moveTo(screen_point.x, screen_point.y);
			var mid_temp_screen:Point;
			for (var i:int=0; i < n; i++)
			{
				mid_temp_screen=screenps[i] as Point;
				graphic.lineTo(mid_temp_screen.x, mid_temp_screen.y);
				graphic.moveTo(mid_temp_screen.x, mid_temp_screen.y);
			}
			graphic.endFill();
			if (iseditor)
			{
			    graphic.lineStyle(5, 0xFF0000, 1.0);
				var ps:Array=arc.ps;
				var m:int=ps.length;
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