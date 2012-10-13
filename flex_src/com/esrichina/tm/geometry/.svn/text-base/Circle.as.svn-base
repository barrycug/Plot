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
	 * @说明：这个主要是自定义图形圆的构建类。
	 *
	 */
	public class Circle extends CustomPolygon
	{
		private var _radiu:Number=0.1; //圆的半径
		private var _center_point:MapPoint; //属于仅读属性

		public function get center_point():MapPoint
		{
			return _center_point;
		}
		private var _end_point:MapPoint=new MapPoint();

		public function get end_point():MapPoint
		{
			return _end_point;
		}

		public function Circle(ps:Array, map:Map)
		{
			this._center_point=map.toMap(ps[0]);
			this._end_point=map.toMap(ps[1]);
			super(ps, map);
		}

		override public function get type():String
		{
			return CIRCLE;
		}

		/**
		 *产生圆多边形，
		 * @return 返回的是多边形的点数组
		 *
		 */
		override public function createGeometryPoints(ps:Array):Array
		{
			if (ps.length < 2)
				return null;
			/* 			var start_point:MapPoint=_map.toMap(ps[0]);
			 var end_point:MapPoint=_map.toMap(ps[1]); */
			var radius:Number=ASUtil.getMDIS(center_point, end_point);
			var cosinus:Number;
			var sinus:Number;
			var x:Number;
			var y:Number;
			var arrayOfPoints:Array=[];
			//求圆上的各个点 
			for (var i:int=0; i < numberOfPoints; i++)
			{
				sinus=Math.sin((Math.PI * 2.0) * (i / numberOfPoints));
				cosinus=Math.cos((Math.PI * 2.0) * (i / numberOfPoints));
				x=center_point.x + radius * cosinus;
				y=center_point.y + radius * sinus;
				arrayOfPoints[i]=new MapPoint(x, y);
			}
			arrayOfPoints.push(arrayOfPoints[0]);
			return arrayOfPoints;
		}

	}
}