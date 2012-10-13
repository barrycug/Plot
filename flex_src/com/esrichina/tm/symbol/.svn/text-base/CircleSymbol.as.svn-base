package com.esrichina.tm.symbol
{
	import com.esri.ags.Map;
	import com.esri.ags.geometry.Geometry;
	import com.esri.ags.geometry.MapPoint;
	import com.esrichina.tm.geometry.Circle;

	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;

	public class CircleSymbol extends CustomFillSymbol
	{
		private var _sprite:Sprite;
		private var _map:Map;
		private var mp:MapPoint;


		public function CircleSymbol(type:String, radiu:Number=1, iseditor:Boolean=false)
		{
			super(type);
			this.type=type;
			this._radiu=radiu;
			this.iseditor=iseditor;
			this.color=0xF08080;
			this.alpha=0.8;
		}
		private var _radiu:Number;

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
			if (geometry is Circle)
			{
				drawPoint(sprite, map, geometry as Circle);
			}
		}

		private function drawPoint(sprite:Sprite, map:Map, circle:Circle):void
		{
			sprite.width=this._radiu;
			sprite.height=this._radiu;
			if (circle.rings == null || circle.rings.length == 0)
			{
				return;
			}
			var graphic:Graphics=sprite.graphics;
			graphic.clear();
			graphic.beginFill(color);
			graphic.lineStyle(1, color, alpha);
			var center_point:MapPoint=circle.center_point;
			if (center_point == null)
				return;
			var screen_point:Point=new Point(toScreenX(map, center_point.x), toScreenY(map, center_point.y));
			//下面是确定半径的
			var radiu:Number=0;
			var rings:Array=(circle.rings)[0];
			var end_point:Point=new Point(toScreenX(map, circle.end_point.x), toScreenY(map, circle.end_point.y));
			const dx:Number=end_point.x - screen_point.x;
			const dy:Number=end_point.y - screen_point.y;
			radiu=Math.sqrt(dx * dx + dy * dy);
			graphic.drawCircle(screen_point.x, screen_point.y, radiu);
			graphic.endFill();
			if (iseditor)
			{
				graphic.lineStyle(5, 0xFF0000, 1.0);
				graphic.beginFill(0xFF0000);
				graphic.drawCircle(screen_point.x, screen_point.y, 1);
				graphic.drawCircle(end_point.x, end_point.y, 1);
				graphic.endFill();
			}
		}

	}
}