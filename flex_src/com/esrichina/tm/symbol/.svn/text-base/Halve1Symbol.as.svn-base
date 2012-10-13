package com.esrichina.tm.symbol
{
	import com.esri.ags.Map;
	import com.esri.ags.geometry.Geometry;
	import com.esrichina.tm.geometry.Halve1;

	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;

	public class Halve1Symbol extends CustomFillSymbol
	{
		public function Halve1Symbol(type:String)
		{
			super(type);
			this.type=type;
			this._radiu=radiu;
			this.color=0xF08080;
			this.alpha=0.8;
		}
		private var _radiu:Number=1;

		public function get radiu():Number
		{
			return _radiu;
		}

		public function set radiu(radiu:Number):void
		{
			this._radiu=radiu;
		}

		override public function draw(sprite:Sprite, geometry:Geometry, attributes:Object, map:Map):void
		{
			if (geometry is Halve1)
			{
				drawHalve1(sprite, map, geometry as Halve1);
			}
		}

		private function drawHalve1(sprite:Sprite, map:Map, halve:Halve1):void
		{
			if (halve.rings == null || halve.rings.length == 0)
			{
				return;
			}
			sprite.width=this.radiu;
			sprite.height=this.radiu;
			var graphic:Graphics=sprite.graphics;
			graphic.clear();
			graphic.beginFill(color);
			graphic.lineStyle(1, color, alpha);
			var rings:Array=(halve.rings)[0];
			if (rings == null || rings.length == 0)
				return;
			var start_point:Point=new Point(toScreenX(map, rings[0].x), toScreenY(map, rings[0].y));
			graphic.moveTo(start_point.x, start_point.y);
			var n:int=rings.length;
			for (var i:int=0; i < n; i++)
			{
				graphic.lineTo(toScreenX(map, rings[i].x), toScreenY(map, rings[i].y));
			}
			graphic.endFill();
			if (iseditor)
			{
				var ps:Array=halve.ps;
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