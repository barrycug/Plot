package com.esrichina.tm.geometry
{
	import com.esri.ags.Map;
	import com.esri.ags.geometry.MapPoint;


	public class CurveFlag extends CustomPolygon
	{
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

		override public function get type():String
		{
			return CURVEFLAG;
		}

		public function CurveFlag(ps:Array, map:Map)
		{
			super(ps, map);
			this._center_point=map.toMap(ps[0]);
			this._end_point=map.toMap(ps[1]);
		}

		/**
		 *旗标的核心算法
		 * @return
		 *
		 */
		override public function createGeometryPoints(ps:Array):Array
		{
			if (ps.length < 2)
				return null;
			var returnps:Array=[];
			var point:MapPoint=_map.toMap(ps[0]);
			var end_point:MapPoint=_map.toMap(ps[1]);
			returnps.push(point);
			//定义它占整个竖直线的2/5;
			var point2:MapPoint=new MapPoint(end_point.x, point.y);
			returnps.push(point2);
			var point3:MapPoint=new MapPoint(end_point.x, point.y - (point.y - end_point.y) * 2 / 5);
			returnps.push(point3);
			var point4:MapPoint=new MapPoint(point.x, point.y - (point.y - end_point.y) * 2 / 5);
			returnps.push(point4);
			var point5:MapPoint=new MapPoint(point.x, end_point.y);
			returnps.push(point5);
			returnps.push(point);
			return returnps;
		}
	}
}