package com.esrichina.tm.utils
{
	import com.esri.ags.Map;
	import com.esri.ags.geometry.MapPoint;

	import flash.display.Graphics;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class ASUtil
	{
		public function ASUtil()
		{

		}

		/**
		 *求屏幕两点的距离
		 * @param startp 起始点，
		 * @param endp 终止点。
		 * @return 两点的距离
		 *
		 */
		public static function getDIS(startp:Point, endp:Point):Number
		{
			var dis:Number=0;
			dis=Math.sqrt(Math.pow((endp.x - startp.x), 2) + Math.pow((endp.y - startp.y), 2));
			return dis;
		}

		/**
		 *地图两点的距离
		 * @param startp
		 * @param endp
		 * @return
		 *
		 */
		public static function getMDIS(startp:MapPoint, endp:MapPoint):Number
		{
			var dis:Number=0;
			dis=Math.sqrt(Math.pow((endp.x - startp.x), 2) + Math.pow((endp.y - startp.y), 2));
			return dis;
		}

		/**
		 *求两点的中点
		 * @param st_point 直线的起始点
		 * @param end_point 直线的终止点
		 * @return 返回一个中间点
		 *
		 */
		public static function getMiddlePoint(st_point:Point, end_point:Point):Point
		{
			var middlepoint:Point=new Point((end_point.x + st_point.x) / 2, (end_point.y + st_point.y) / 2);
			return middlepoint;
		}

		/**
		 *这个函数是用于转化一组屏幕坐标到地图坐标
		 * @param _screenpoints
		 * @return 地图坐标
		 *
		 */
		public static function changeScreenToMap(_screenpoints:Array, map:Map):Array
		{
			var map_points:Array=[];
			if (_screenpoints == null || _screenpoints.length == 0)
				return null;
			var n:int=_screenpoints.length;
			for (var i:int=0; i < n; i++)
			{
				map_points.push(map.toMapFromStage(_screenpoints[i].x, _screenpoints[i].y));
			}

			return map_points;
		}

		/**
		 *这个函数是用于转化一组屏幕坐标到地图坐标
		 * @param _screenpoints
		 * @return 地图坐标
		 *
		 */
		public static function changeMapToScreen(mpoints:Array, map:Map):Array
		{
			var screen_points:Array=[];
			if (mpoints == null || mpoints.length == 0)
				return null;
			var n:int=mpoints.length;
			for (var i:int=0; i < n; i++)
			{
				screen_points.push(map.toScreen(mpoints[i]));
			}
			return screen_points;
		}

		/**
		 * 这个函数的作用是把一个屏幕坐标转化为一个地图坐标。
		 * @param st_point
		 * @return
		 *
		 */
		public static function changeScreenTOMap(st_point:Point, map:Map):MapPoint
		{
			if (map == null || st_point == null)
				return null;
			return map.toMap(st_point);
		}

		public static function changeMapPToScreen(st_point:MapPoint, map:Map):Point
		{
			if (map == null || st_point == null)
				return null;
			return map.toScreen(st_point);
		}

		/**
		 *根据传过来的点数组来得到图形的Extent,切记，不可改变原有数组的值
		 * @param points
		 * @return
		 *
		 */
		public static function createRectangle(points:Array):Rectangle
		{
			var xs:Array=[], ys:Array=[];
			var width:Number;
			var height:Number;
			var n:int=points.length;
			for (var i:int=0; i < n; i++)
			{
				xs.push(points[i].x);
				ys.push(points[i].y);
			}
			xs.sort(Array.NUMERIC, Array.DESCENDING);
			ys.sort(Array.NUMERIC, Array.DESCENDING);
			width=xs[0] - xs[n - 1];
			height=ys[0] - ys[n - 1];
			return new Rectangle(xs[n - 1], ys[n - 1], width, height);
		}

		/**
		 *求点到两点连线的距离
		 * @param st_point
		 * @param m_point
		 * @param end_point
		 * @return
		 *
		 */
		public static function getDisToTwoPoints(st_point:Point, m_point:Point, end_point:Point):Number
		{
			var k:Number=(end_point.y - st_point.y) / (end_point.x - st_point.x);
			var c:Number=st_point.y - k * st_point.x;
			var dis:Number=Math.abs(k * m_point.x - m_point.y + c) / Math.sqrt(k * k + 1);
			return dis;
		}

		public static function findSite(st_point:Point, m_point:Point, end_point:Point):String
		{
			var flag:String="";
			var a:Number=end_point.y - st_point.y;
			var b:Number=st_point.x - end_point.x;
			var c:Number=end_point.x * st_point.y - end_point.y * st_point.x;
			var d:Number=a * m_point.x + b * m_point.y + c;
			if (d > 0)
				flag="right";
			if (d < 0)
				flag="left";
			return flag;
		}

		/**
		 *这个是在Sprite上画虚线的方法
		 * @param sprite
		 * @param rectangle
		 *
		 */
		public function drawDottedRect(graphics:Graphics, rect:Rectangle):void
		{
			var sizeOfDash:Number=5; //size of each dash
			graphics.clear();
			graphics.lineStyle(1, 0x000000, 100);
			var iterations:Number=Math.ceil(Math.abs(rect.right - rect.left) / (sizeOfDash * 2));
			var moveDist:Number;
			var dash:Number;
			for (var i:int=0; i < iterations; i++)
			{ //Draw top
				if (rect.right < rect.left)
				{
					moveDist=-(sizeOfDash * 2 * i);
					dash=-(sizeOfDash);
				}
				else
				{
					moveDist=sizeOfDash * 2 * i;
					dash=sizeOfDash;
				}
				graphics.moveTo(rect.left + moveDist, rect.top);
				if (i == iterations - 1)
				{
					graphics.lineTo(rect.right, rect.top);
				}
				else
				{
					graphics.lineTo(rect.left + moveDist + dash, rect.top);
				}
			}
			for (i=0; i < iterations; i++)
			{ //Draw Bottom
				if (rect.right < rect.left)
				{
					moveDist=-(sizeOfDash * 2 * i);
					dash=-(sizeOfDash);
				}
				else
				{
					moveDist=sizeOfDash * 2 * i;
					dash=sizeOfDash;
				}
				graphics.moveTo(rect.left + moveDist, rect.bottom);
				if (i == iterations - 1)
				{
					graphics.lineTo(rect.right, rect.bottom);
				}
				else
				{
					graphics.lineTo(rect.left + moveDist + dash, rect.bottom);
				}
			}
			iterations=Math.ceil(Math.abs(rect.bottom - rect.top) / (sizeOfDash * 2));
			for (i=0; i < iterations; i++)
			{ //Draw left
				if (rect.top > rect.bottom)
				{
					moveDist=-(sizeOfDash * 2 * i);
					dash=-(sizeOfDash);
				}
				else
				{
					moveDist=sizeOfDash * 2 * i;
					dash=sizeOfDash;
				}
				graphics.moveTo(rect.left, rect.top + moveDist);
				if (i == iterations - 1)
				{
					graphics.lineTo(rect.left, rect.bottom);
				}
				else
				{
					graphics.lineTo(rect.left, rect.top + moveDist + dash);
				}
			}
			for (i=0; i < iterations; i++)
			{ //Draw right
				if (rect.top > rect.bottom)
				{
					moveDist=-(sizeOfDash * 2 * i);
					dash=-(sizeOfDash);
				}
				else
				{
					moveDist=sizeOfDash * 2 * i;
					dash=sizeOfDash;
				}
				graphics.moveTo(rect.right, rect.top + moveDist);
				if (i == iterations - 1)
				{
					graphics.lineTo(rect.right, rect.bottom);
				}
				else
				{
					graphics.lineTo(rect.right, rect.top + moveDist + dash);
				}
			}
		}
	}
}