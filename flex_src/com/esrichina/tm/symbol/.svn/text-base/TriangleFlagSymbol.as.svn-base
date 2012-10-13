package com.esrichina.tm.symbol
{
	import com.esri.ags.Map;
	import com.esri.ags.geometry.Geometry;
	import com.esrichina.tm.geometry.TriangleFlag;

	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;

	public class TriangleFlagSymbol extends CustomFillSymbol
	{
		public function TriangleFlagSymbol(type:String)
		{

			super(type);
			this.type=type;
			this.color=0xF08080;
			this.alpha=0.8;
		}

		override public function draw(sprite:Sprite, geometry:Geometry, attributes:Object, map:Map):void
		{
			if (geometry is TriangleFlag)
			{
				drawTriangleFlag(sprite, map, geometry as TriangleFlag);
			}
		}

		private function drawTriangleFlag(sprite:Sprite, map:Map, triangleflag:TriangleFlag):void
		{
			if (triangleflag.rings == null || triangleflag.rings.length == 0)
			{
				return;
			}
			sprite.width=1;
			sprite.height=1;
			var graphic:Graphics=sprite.graphics;
			graphic.clear();
			graphic.beginFill(color);
			graphic.lineStyle(5, color, alpha);
			var mps:Array=(triangleflag.rings)[0] as Array;
			var screenps:Array=new Array();
			for (var j:int=0; j < mps.length; j++)
			{
				screenps.push(new Point(toScreenX(map, mps[j].x), toScreenY(map, mps[j].y)));
			}
			if (screenps == null || screenps.length == 0)
				return;
			graphic.moveTo(screenps[0].x, screenps[0].y);
			for (var i:int=1; i < screenps.length; i++)
			{
				graphic.lineTo(screenps[i].x, screenps[i].y);
			}
			graphic.endFill();
			if (iseditor)
			{
				var ps:Array=triangleflag.ps;
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