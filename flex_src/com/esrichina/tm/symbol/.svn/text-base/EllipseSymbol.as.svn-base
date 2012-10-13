package com.esrichina.tm.symbol
{
	import com.esri.ags.Map;
	import com.esri.ags.geometry.Geometry;
	import com.esrichina.tm.geometry.Ellipse;
	
	import flash.display.Graphics;
	import flash.display.Sprite;

	public class EllipseSymbol extends CustomFillSymbol
	{
		public function EllipseSymbol(type:String)
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
			if (geometry is Ellipse)
			{
				drawEllipse(sprite, map, geometry as Ellipse);
			}
		}

		private function drawEllipse(sprite:Sprite, map:Map, ellipse:Ellipse):void
		{
			if (ellipse.rings == null || ellipse.rings.length == 0)
			{
				return;
			}
			sprite.width=this.radiu;
			sprite.height=this.radiu;
			var graphic:Graphics=sprite.graphics;
			graphic.clear();
			graphic.beginFill(color);
			graphic.lineStyle(1, color, alpha);
			var rings:Array=(ellipse.rings)[0];
			if (rings == null || rings.length == 0)
				return;
			var n:int=rings.length;
			sprite.graphics.moveTo(toScreenX(map, rings[0].x), toScreenY(map, rings[0].y));
			for (var i:int=1; i < n; i++)
			{
				sprite.graphics.lineTo(toScreenX(map, rings[i].x), toScreenY(map, rings[i].y));
			}
			sprite.graphics.endFill();
			if (iseditor)
			{
				var ps:Array=ellipse.ps;
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