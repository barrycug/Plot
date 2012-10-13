package com.esrichina.tm.utils
{
	import com.esri.ags.geometry.Extent;
	import com.esri.ags.geometry.MapPoint;
	import com.esri.ags.geometry.Polygon;
	import com.esri.ags.geometry.Polyline;

	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class RelationUtil
	{
		public function RelationUtil()
		{

		}

		public static function isPoint(point:Point, extent_point:Point):Boolean
		{
			var range:uint=4;
			var extent:Rectangle=new Rectangle(extent_point.x - range, extent_point.y - range, 2 * range, 2 * range);
			if (extent.contains(point.x, point.y))
				return true;
			else
				return false;
		}

		/**
		 *判断点是否在多变形内部
		 * @param point
		 * @param polygon
		 * @return
		 *
		 */
		public static function isInPolygon(point:MapPoint, polygon:Polygon):Boolean
		{
			var flag:Boolean=false;
			var extent:Extent=polygon.extent;
			if (!extent.contains(point))
				return flag;
			else
			{
				var count:int=0;
				var px:Number=point.x;
				//每一个Rings进行判断
				var rs:Array=polygon.rings;
				var ps:Array=[];
				var p0:Number;
				for (var r:int=0; r < rs.length; r++)
				{
					ps.splice(0);
					ps=rs[r];
					//判断每个rings和点到y轴的直线的交点数
					var n:int=ps.length;
					for (var k:int=0; k < n - 1; k++)
					{
						if (isOnLine(point, ps[k], ps[k + 1]))
						{
							break;
							return true;
						}
						if (((ps[k].y - point.y) * (ps[k + 1].y - point.y)) > 0)
						{
							continue;
						}
						else if (((ps[k].y - point.y) * (ps[k + 1].y - point.y)) <= 0)
						{
							p0=(ps[k].x * (ps[k + 1].y - point.y) - ps[k + 1].x * (ps[k].y - point.y)) / (ps[k + 1].y - ps[k].y);
							if (p0 <= px)
							{
								count++;
								continue;
							}
						}
					}
				}
				if (count % 2 != 0)
					flag=true;
				return flag;
			}
		}

		/**
		 *判断点是否在直线上，
		 * @param point
		 * @param polyline
		 * @return
		 *
		 */
		public static function isOnPolyline(point:MapPoint, polyline:Polyline):Boolean
		{
			var paths:Array=polyline.paths;
			var flag:Boolean=false;
			var ps:Array=[];
			var n:int=0;
			var p1:MapPoint;
			var p2:MapPoint;
			var m:int=paths.length;
			for (var p:int=0; p < m; p++)
			{
				ps.splice(0);
				ps=paths[p];
				n=ps.length;
				for (var k:int=0; k < n - 1; k++)
				{
					p1=ps[k];
					p2=ps[k + 1];
					if (isOnLine(point, p1, p2))
					{
						flag=true;
						return flag;
						break;
					}
				}
			}
			return flag;
		}

		public static function isOnLine(p0:MapPoint, p1:MapPoint, p2:MapPoint):Boolean
		{
			var vector:Number;
			var range:Number=30;
			if (((p0.x - p1.x) * (p0.x - p2.x) <= 0) && ((p0.y - p1.y) * (p0.y - p2.y) <= 0))
			{
				vector=Math.abs((p1.x - p0.x) * (p2.y - p0.y) - (p2.x - p0.x) * (p1.y - p0.y));
				return vector <= range;
			}
			else
				return false;
		}
	}

}