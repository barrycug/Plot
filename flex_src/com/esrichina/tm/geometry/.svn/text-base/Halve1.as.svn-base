package com.esrichina.tm.geometry
{
	import com.esri.ags.Map;
	import com.esri.ags.geometry.MapPoint;
	import com.esrichina.tm.utils.ASUtil;

	public class Halve1 extends CustomPolygon
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

		public function Halve1(ps:Array, map:Map)
		{
			super(ps, map);
		}
			override public function get type():String
		{
			return HALVE1;
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
			var start_point:MapPoint=_map.toMap(ps[0]);
			var end_point:MapPoint=_map.toMap(ps[1]);
			var radius:Number=ASUtil.getMDIS(start_point, end_point);
			var cosinus:Number;
			var sinus:Number;
			var x:Number;
			var y:Number;
			var arrayOfPoints:Array=[];
			//求圆上的各个点 
			arrayOfPoints.push(start_point);
			var j:int=0;
			for (var i:Number=Math.PI / 6; i < Math.PI * 7 / 6; i=i + Math.PI / 100)
			{
				j++;
				x=start_point.x + radius * Math.cos(i);
				y=start_point.y + radius * Math.sin(i);
				arrayOfPoints[j]=new MapPoint(x, y);
			}
			arrayOfPoints.push(start_point);
			return arrayOfPoints;
		}
	}
}