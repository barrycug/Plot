package com.esrichina.tm.geometry
{
	import com.esri.ags.Map;
	import com.esri.ags.geometry.MapPoint;
	import com.esrichina.tm.utils.ASUtil;


	/**
	 *
	 * @author 張德品
	 * @版本：1.0
	 * @2010-1月
	 * @说明：这个主要是自定义图形基地符號的构建类。
	 *
	 */
	public class Base extends CustomPolygon
	{
		private var _radiu:Number=0.1;
		private static const scale:Number=0.8; //这个比例是指基地的长轴和整个直径的比例
		private var _center_point:MapPoint=new MapPoint();

		public function get center_point():MapPoint
		{
			return _center_point;
		}
		private var _end_point:MapPoint=new MapPoint();

		public function get end_point():MapPoint
		{
			return _end_point;
		}

		private var left_point:MapPoint;


		public function Base(ps:Array, map:Map)
		{
			this._center_point=map.toMap(ps[0]);
			this._end_point=map.toMap(ps[1]);
			super(ps, map);
		}

		override public function get type():String
		{
			return BASE;
		}

		/**
		 *基地的核心算法
		 * @return
		 *
		 */
		override public function createGeometryPoints(ps:Array):Array
		{
			if (ps.length < 2)
				return null;
			var r:Number=ASUtil.getMDIS(center_point, end_point);
			var cosinus:Number;
			var sinus:Number;
			var x:Number;
			var y:Number;
			//下面确定上右小圆
			var x1:Number=center_point.x + r * 3 / 4;
			var y1:Number=center_point.y;
			var x0:Number=center_point.x - r / 4;
			var y0:Number=center_point.y;
			var arrayOfPoints:Array=[];
			for (var i:int=0; i < numberOfPoints; i++)
			{
				sinus=Math.sin((Math.PI) * (i / numberOfPoints));
				cosinus=Math.cos((Math.PI) * (i / numberOfPoints));
				x=center_point.x + r * cosinus;
				y=center_point.y - r * sinus * 0.7;
				arrayOfPoints[i]=new MapPoint(x, y);
			}
			for (var j:int=0; j < numberOfPoints; j++)
			{
				sinus=Math.sin(Math.PI * (j / numberOfPoints));
				cosinus=Math.cos(Math.PI * (j / numberOfPoints));
				x=x0 - 3 / 4 * r * cosinus;
				y=y0 + 3 / 4 * r * sinus * 0.7;
				arrayOfPoints.push(new MapPoint(x, y));
			}
			for (var k:int=0; k < numberOfPoints; k++)
			{
				sinus=Math.sin(Math.PI * (k / numberOfPoints));
				cosinus=Math.cos(Math.PI * (k / numberOfPoints));
				x=x1 - 1 / 4 * r * cosinus;
				y=y1 + 1 / 4 * r * sinus * 0.8;
				arrayOfPoints.push(new MapPoint(x, y));
			}
			arrayOfPoints.push(arrayOfPoints[0]);

			return arrayOfPoints;
		}
	}
}