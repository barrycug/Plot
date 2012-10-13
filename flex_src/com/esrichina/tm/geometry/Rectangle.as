package com.esrichina.tm.geometry
{
	import com.esri.ags.Map;
	import com.esri.ags.geometry.MapPoint;
	import com.esrichina.tm.utils.ASUtil;

	public class Rectangle extends CustomPolygon
	{
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

		override public function get type():String
		{
			return RECTANGLE;
		}

		public function Rectangle(ps:Array, map:Map)
		{
			super(ps, map);
		}

		/**
		 *产生矩型图形
		 * @param ps
		 * @return
		 *
		 */
		override public function createGeometryPoints(ps:Array):Array
		{
			if (ps.length < 2)
			{
				return null;
			}
			var start_point:MapPoint=_map.toMap(ps[0]);
			var end_point:MapPoint=_map.toMap(ps[1]);
			var arrayOfPoints:Array=[];
			var radiu:Number=ASUtil.getMDIS(start_point, end_point);
			//求矩形上的各个点 
			var point1:MapPoint=new MapPoint(start_point.x - (end_point.x - start_point.x), start_point.y - (end_point.y - start_point.y));
			var point2:MapPoint=new MapPoint(end_point.x, start_point.y - (end_point.y - start_point.y));
			var point4:MapPoint=new MapPoint(start_point.x - (end_point.x - start_point.x), end_point.y);
			arrayOfPoints.push(point1);
			arrayOfPoints.push(point2);
			arrayOfPoints.push(end_point);
			arrayOfPoints.push(point4);
			return arrayOfPoints;
		}
	}
}