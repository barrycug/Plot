package com.esrichina.tm.symbol
{
	import com.esri.ags.Map;
	import com.esri.ags.geometry.Geometry;
	import com.esrichina.tm.geometry.Rectangle;

	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Matrix;

	public class RectangleSymbol extends CustomFillSymbol
	{
		public function RectangleSymbol(type:String)
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
			if (geometry is Rectangle)
			{
				drawRectangle(sprite, map, geometry as Rectangle);
			}
		}

		private function drawRectangle(sprite:Sprite, map:Map, rectangle:Rectangle):void
		{
			if (rectangle.rings == null || rectangle.rings.length == 0)
			{
				return;
			}
			sprite.width=this.radiu;
			sprite.height=this.radiu;
			var graphic:Graphics=sprite.graphics;
			graphic.clear();
			var gradientBoxMatrix:Matrix=new Matrix();
			gradientBoxMatrix.createGradientBox(1200, 1000, 0, 0, 0);
			graphic.beginGradientFill(GradientType.LINEAR, [0xFF0000, 0x00FF00, 0x0000FF], [0.3, 0.6, 1], [0, 128, 255], gradientBoxMatrix, SpreadMethod.REFLECT);
			graphic.lineStyle(2);
			var rings:Array=(rectangle.rings)[0];
			var screens:Array=[];
			graphic.moveTo(toScreenX(map, rings[0].x), toScreenY(map, rings[0].y));
			for (var i:int=0; i < 4; i++)
			{
				graphic.lineTo(toScreenX(map, rings[i].x), toScreenY(map, rings[i].y));
			}
			graphic.endFill();
			if (iseditor)
			{
				var ps:Array=rectangle.ps;
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