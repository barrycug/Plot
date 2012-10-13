package com.esrichina.tm.symbol
{
	import com.esri.ags.Map;
	import com.esri.ags.geometry.Geometry;
	import com.esrichina.tm.geometry.RectFlag;

	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;



	public class RectFlagSymbol extends CustomFillSymbol
	{
		public function RectFlagSymbol(type:String)
		{
			super(type);
			this.type=type;
			this.color=0xF08080;
			this.alpha=0.8;
		}

		override public function draw(sprite:Sprite, geometry:Geometry, attributes:Object, map:Map):void
		{
			if (geometry is RectFlag)
			{
				drawRectFlag(sprite, map, geometry as RectFlag);
			}
		}

		private function drawRectFlag(sprite:Sprite, map:Map, rectflag:RectFlag):void
		{
			if (rectflag.rings == null || rectflag.rings.length == 0)
			{
				return;
			}
			sprite.width=1;
			sprite.height=1;
			var graphic:Graphics=sprite.graphics;
			graphic.clear();
			graphic.beginFill(color);
			graphic.lineStyle(5, color, alpha);
			var mps:Array=(rectflag.rings)[0] as Array;
			var srcps:Array=new Array();
			for (var j:int=0; j < mps.length; j++)
			{
				srcps.push(new Point(toScreenX(map, mps[j].x), toScreenY(map, mps[j].y)));
			}
			if (srcps == null || srcps.length == 0)
				return;
			var n:int=srcps.length;
			graphic.moveTo(srcps[0].x, srcps[0].y);
			for (var i:int=1; i < n; i++)
			{
				graphic.lineTo(srcps[i].x, srcps[i].y);
			}
			graphic.endFill();
			if (iseditor)
			{
				var ps:Array=rectflag.ps;
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