package com.esrichina.tm.symbol
{
	import com.esri.ags.Map;
	import com.esri.ags.geometry.Geometry;
	import com.esrichina.tm.geometry.Base;

	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;

	public class BaseSymbol extends CustomFillSymbol
	{

		private var _radiu:Number=1;

		public function get radiu():Number
		{
			return _radiu;
		}

		public function set radiu(radiu:Number):void
		{
			this._radiu=radiu;
		}


		public function BaseSymbol(type:String, radiu:Number=1, iseditor:Boolean=false)
		{
			super(type);
			this.type=type;
			this.radiu=radiu;
			this.color=0xF08080;
			this.alpha=0.8;
		}

		override public function draw(sprite:Sprite, geometry:Geometry, attributes:Object, map:Map):void
		{
			if (geometry is Base)
			{
				drawPoint(sprite, map, geometry as Base);
			}
		}

		private function drawPoint(sprite:Sprite, map:Map, base:Base):void
		{
			if (base.rings == null || base.rings.length == 0)
			{
				return;
			}
			sprite.width=this.radiu;
			sprite.height=this.radiu;
			var graphic:Graphics=sprite.graphics;
			graphic.clear();
			graphic.beginFill(color);
			graphic.lineStyle(1, color, alpha);
			var rings:Array=(base.rings)[0];
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
			//如果可以编辑则画出控制点
			if (iseditor)
			{
				var ps:Array=base.ps;
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