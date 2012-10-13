package com.esrichina.tm.utils
{
	import flash.geom.Point;


	public class SarrowUtil
	{
		public function SarrowUtil()
		{
		}

		/**
		 *已知一个起点加一个终点，形成一个军标箭头的算法-----这个是很关键的一个函数，很多都是依赖他来算的.
		 * @param st_point
		 * @param end_point
		 * @return
		 *
		 */
		public static function getHeanGBJ(st_point:Point, middle_point:Point, end_point:Point):Array
		{
			var points:Array=new Array();
			//直线长
			var dis:Number=ASUtil.getDIS(st_point, end_point);
			//箭头底部长
			var bottom_d:Number=dis / 5;
			//箭头大斜边长
			var top_x:Number=dis / 4;
			//箭头顶部的夹角
			var angle:Number=Math.PI / 12;
			//箭头下部的夹角
			var b_angle:Number=Math.PI / 8;
			//箭头斜边长
			var top_d:Number=(Math.tan(angle) * top_x) / (Math.tan(angle) + Math.tan(b_angle)) / Math.cos(b_angle);

			//1号位左边的点
			var left_1_point:Point=new Point();
			//1号位右边的点
			var right_1_point:Point=new Point();
			//3号位左边的外点
			var left_w3_point:Point=new Point();
			//3号位左边的内点
			var left_n3_point:Point=new Point();
			//3号位最顶点:
			var top_3_point:Point=new Point();
			//3号位右边的外点
			var right_w3_point:Point=new Point();
			//3号位右边的内点
			var right_n3_point:Point=new Point();
			left_1_point=getThreePoint(st_point, end_point, Math.PI / 2, bottom_d, "left");
			right_1_point=getThreePoint(st_point, end_point, Math.PI / 2, bottom_d, "right");
			//如果没有中间点则按照常规来计算3号位上的点
			if (middle_point == null)
			{
				left_w3_point=getThreePoint(end_point, left_1_point, angle, top_x, "right");
				left_n3_point=getThreePoint(left_w3_point, end_point, b_angle, top_d, "right");

				right_w3_point=getThreePoint(end_point, right_1_point, angle, top_x, "left");
				right_n3_point=getThreePoint(right_w3_point, end_point, b_angle, top_d, "left");
			}
			else
			{
				dis=ASUtil.getDIS(st_point, middle_point) + ASUtil.getDIS(middle_point, end_point) / 2;
				bottom_d=dis / 5;
				top_x=dis / 5;
				top_d=(Math.tan(angle) * top_x) / (Math.tan(angle) + Math.tan(b_angle)) / Math.cos(b_angle);
				var left_2_point:Point=getThreePoint(middle_point, end_point, Math.PI / 2, bottom_d, "left");
				var right_2_point:Point=getThreePoint(middle_point, end_point, Math.PI / 2, bottom_d, "right");
				left_w3_point=getThreePoint(end_point, left_2_point, angle, top_x, "right");
				left_n3_point=getThreePoint(left_w3_point, end_point, b_angle, top_d, "right");
				right_w3_point=getThreePoint(end_point, right_2_point, angle, top_x, "left");
				right_n3_point=getThreePoint(right_w3_point, end_point, b_angle, top_d, "left");
			}
			//一次按照顺序加入，注意先加内端点再加外端点
			points.push(left_1_point); /* 最左边下边点 ----0----*/
			points.push(left_n3_point); /* 最左边上边内点 ------1---*/
			points.push(left_w3_point); /* 最左边外边点 -----2----*/
			points.push(end_point); /*终点  ------3-----*/
			points.push(right_w3_point); /* 右边外边点 ----4-----*/
			points.push(right_n3_point); /*右边内边点 ------5------*/
			points.push(right_1_point); /* 最右边下边点 ----6------*/
			return points;
		}

		/**
		 *已知两点坐标和方位角球第三点的方法
		 * 从标准方向的北端起,顺时针方向到直线的水平角称为该直线的方位角。方位角的取值范围为0~360度。
		 * @param st_point
		 * @param end_point
		 * @param angle
		 * @param d
		 * @param direction
		 * @return
		 * 这个公式非常重要啊
		 */
		public static function getThreePoint(st_point:Point, end_point:Point, angle:Number, d:Number, direction:String):Point
		{

			var xa:Number=end_point.x;
			var ya:Number=end_point.y;
			var xb:Number=st_point.x;
			var yb:Number=st_point.y;
			//求已知两点的方位角
			var kab:Number=Math.atan((ya - yb) / (xa - xb));
			var xbc:Number=0;
			var ybc:Number=0;
			//分类
			if ("left" == direction)
			{
				angle=(Math.PI - angle);
				if (xa < xb)
				{
					xbc=xb + d * Math.cos(kab + angle);
					ybc=yb + d * Math.sin(kab + angle);
				}
				else if (xa >= xb)
				{
					xbc=xb - d * Math.cos(kab + angle);
					ybc=yb - d * Math.sin(kab + angle);
				}
			}
			else if ("right" == direction)
			{
				angle=Math.PI + angle;
				if (xa < xb)
				{
					xbc=xb + d * Math.cos(kab + angle);
					ybc=yb + d * Math.sin(kab + angle);
				}
				else if (xa >= xb)
				{
					xbc=xb - d * Math.cos(kab + angle);
					ybc=yb - d * Math.sin(kab + angle);
				}
			}
			return new Point(xbc, ybc);
		}

		/**
		 *应用二次贝塞尔曲线来得到线上的所有点
		 * @param st_point
		 * @param middle
		 * @param end_point
		 * @return
		 *
		 */
		public static function usebezier(st_point:Point, middle_point:Point, end_point:Point):Array
		{
			var ps:Array=[];

			var pos_x:Number;
			var pos_y:Number;
			for (var j:Number=0; j <= 1; j=j + 0.05)
			{
				pos_x=Math.pow((1 - j), 2) * st_point.x + 2 * j * (1 - j) * middle_point.x + Math.pow(j, 2) * end_point.x;
				pos_y=Math.pow((1 - j), 2) * st_point.y + 2 * j * (1 - j) * middle_point.y + Math.pow(j, 2) * end_point.y;
				ps.push(new Point(pos_x, pos_y));
			}
			return ps;
		}

		/**
		 *应用三次贝塞尔曲线来得到线上的所有点
		 * @param st_1_p
		 * @param st_2_p
		 * @param st_3_p
		 * @param st_4_p
		 * @return
		 *
		 */

		public static function useFourBezier(st_1_p:Point, st_2_p:Point, st_3_p:Point, st_4_p:Point):Array
		{
			var four_array:Array=[];
			var pos_x:Number;
			var pos_y:Number;

			for (var k:Number=0; k < 1; k=k + 0.05)
			{
				pos_x=st_1_p.x * Math.pow((1 - k), 3) + 3 * st_2_p.x * k * Math.pow((1 - k), 2) + 3 * st_3_p.x * Math.pow(k, 2) * (1 - k) + st_4_p.x * Math.pow(k, 3);
				pos_y=st_1_p.y * Math.pow((1 - k), 3) + 3 * st_2_p.y * k * Math.pow((1 - k), 2) + 3 * st_3_p.y * Math.pow(k, 2) * (1 - k) + st_4_p.y * Math.pow(k, 3);
				//中心轴的添加
				four_array.push(new Point(pos_x, pos_y));
			}
			return four_array;
		}


		/**
		 *应用四次贝塞尔曲线来得到线上的曲线
		 * @param st_1_p
		 * @param st_2_p
		 * @param st_3_p
		 * @param st_4_p
		 * @param st_5_p
		 * @return
		 *
		 */
		public static function useFiveBezier(st_1_p:Point, st_2_p:Point, st_3_p:Point, st_4_p:Point, st_5_p:Point):Array
		{
			var five_array:Array=[];
			var pos_x:Number;
			var pos_y:Number;
			for (var k:Number=0; k < 1; k=k + 0.05)
			{
				pos_x=st_1_p.x * Math.pow((1 - k), 4) + 4 * st_2_p.x * k * Math.pow((1 - k), 3) + 6 * st_3_p.x * Math.pow(k, 2) * Math.pow((1 - k), 2) + 4 * st_4_p.x * Math.pow(k, 3) * (1 - k) + st_5_p.x * Math.pow(k, 4);
				pos_y=st_1_p.y * Math.pow((1 - k), 4) + 4 * st_2_p.y * k * Math.pow((1 - k), 3) + 6 * st_3_p.y * Math.pow(k, 2) * Math.pow((1 - k), 2) + 4 * st_4_p.y * Math.pow(k, 3) * (1 - k) + st_5_p.y * Math.pow(k, 4);

				//中心轴的添加
				five_array.push(new Point(pos_x, pos_y));
			}
			return five_array;
		}

		/**
		 *根据三点来确定一个角度
		 * @param startpoint
		 * @param sencodpoint
		 * @param endpoint
		 * @return
		 *
		 */
		public static function getAngle(startpoint:Point, sencodpoint:Point, endpoint:Point):Number
		{
			var angle:Number;
			var k1:Number=(startpoint.y - sencodpoint.y) / (startpoint.x / sencodpoint.x);
			var k2:Number=(sencodpoint.y - endpoint.y) / (sencodpoint.x - endpoint.x);
			angle=Math.atan(k2) - Math.atan(k1);
			return angle;
		}

		/**
		 *已知参数进行插值
		 * @param start_point
		 * @param end_point
		 * @param click_points,点击的数组，默认第一个点是两直线的中点
		 * @return 返回的是构造多边形的所有点
		 *
		 */
		public static function makeMiddlePoints(click_points:Array, equal:Boolean=false, tailsarrow:Boolean=false):Array
		{
			var click_num:Number=click_points.length;
			var sum_l:Number=0;
			for (var i:int=0; i < click_num - 1; i++)
			{
				sum_l+=ASUtil.getDIS(click_points[i], click_points[i + 1]);
			}
			//制定拟合后返回的点的数组
			var n_points:Array=new Array();
			//分段拟合曲线(首先以三个点为例来求的曲线)
			var m_points:Array=useNbezier(click_points);
			m_points.push(sum_l);
			n_points=drawLRCurves(m_points, equal, tailsarrow);
			return n_points;
		}

		/**
		 * 用于确定两边界限的方法，注意不同点（已知起始点了）
		 * @param curvepoints  中轴线上的所有点，
		 * @param dis 初始的两个点的距离
		 * @param st_point 初始直线的始点
		 * @param end_point初始直线的终点
		 * @return 返回两边拟合的点数组
		 *
		 */
		public static function drawLRCurves(curvepoints:Array, equal:Boolean, tailsarrow:Boolean=false):Array
		{

			//定义左边曲线的点的数组
			var left_points:Array=new Array();
			//定义右边界点的数组
			var right_points:Array=new Array();
			//计算开始线段的始点和终点的坐标

			var c_length:Number=curvepoints.length;
			var dis:Number=curvepoints[c_length - 1];
			dis=dis / 15;
			curvepoints.splice(c_length - 1, 1);
			var m_point:Point;
			var pos_x:Number;
			var pos_y:Number;
			var pre_point:Point;
			var pre_pos_x:Number;
			var pre_pos_y:Number;
			var slope:Number;
			var bb:Number;
			var cos_number:Number;
			var sin_number:Number;
			var top_pos_x:Number=0.0;
			var top_pos_y:Number=0.0;
			//下半部分
			var bottom_pos_x:Number;
			var bottom_pos_y:Number;
			for (var u:int=1; u < c_length - 1; u++)
			{
				m_point=curvepoints[u];
				pos_x=m_point.x;
				pos_y=m_point.y;
				//先求上一点的坐标
				pre_point=curvepoints[u - 1];
				//进行计算取的上下边的点
				pre_pos_x=pre_point.x;
				pre_pos_y=pre_point.y;
				slope=(pos_y - pre_pos_y) / (pos_x - pre_pos_x);
				//上边点确定

				if (!equal)
					bb=dis * (1 - u / c_length * 0.9);
				else
					bb=dis/2;
				cos_number=Math.cos(Math.atan(slope) - Math.PI / 2);
				sin_number=Math.sin(Math.atan(slope) - Math.PI / 2);


				//下面分四种情况画线。

				if (pre_pos_x <= pos_x && pre_pos_y <= pos_y)
				{
					top_pos_x=pre_pos_x + ((bb * cos_number) < 0 ? (-bb * cos_number) : (bb * cos_number));
					top_pos_y=pre_pos_y - ((bb * sin_number) < 0 ? (-bb * sin_number) : (bb * sin_number));
				}
				else if (pre_pos_x <= pos_x && pre_pos_y > pos_y)
				{
					top_pos_x=pre_pos_x - ((bb * cos_number) < 0 ? (-bb * cos_number) : (bb * cos_number));
					top_pos_y=pre_pos_y - ((bb * sin_number) < 0 ? (-bb * sin_number) : (bb * sin_number));
				}
				else if (pre_pos_x >= pos_x && pre_pos_y >= pos_y)
				{
					top_pos_x=pre_pos_x - ((bb * cos_number) < 0 ? (-bb * cos_number) : (bb * cos_number));
					top_pos_y=pre_pos_y + ((bb * sin_number) < 0 ? (-bb * sin_number) : (bb * sin_number));
				}
				else if (pre_pos_x >= pos_x && pre_pos_y <= pos_y)
				{
					top_pos_x=pre_pos_x + ((bb * cos_number) < 0 ? (-bb * cos_number) : (bb * cos_number));
					top_pos_y=pre_pos_y + ((bb * sin_number) < 0 ? (-bb * sin_number) : (bb * sin_number));
				}
				left_points.push(new Point(top_pos_x, top_pos_y));
				if (pre_pos_x <= pos_x && pre_pos_y <= pos_y)
				{
					bottom_pos_x=pre_pos_x - ((bb * cos_number) < 0 ? (-bb * cos_number) : (bb * cos_number));
					bottom_pos_y=pre_pos_y + ((bb * sin_number) < 0 ? (-bb * sin_number) : (bb * sin_number));
				}
				else if (pre_pos_x <= pos_x && pre_pos_y > pos_y)
				{
					bottom_pos_x=pre_pos_x + ((bb * cos_number) < 0 ? (-bb * cos_number) : (bb * cos_number));
					bottom_pos_y=pre_pos_y + ((bb * sin_number) < 0 ? (-bb * sin_number) : (bb * sin_number));
				}
				else if (pre_pos_x >= pos_x && pre_pos_y >= pos_y)
				{
					bottom_pos_x=pre_pos_x + ((bb * cos_number) < 0 ? (-bb * cos_number) : (bb * cos_number));
					bottom_pos_y=pre_pos_y - ((bb * sin_number) < 0 ? (-bb * sin_number) : (bb * sin_number));
				}
				else if (pre_pos_x >= pos_x && pre_pos_y <= pos_y)
				{
					bottom_pos_x=pre_pos_x - ((bb * cos_number) < 0 ? (-bb * cos_number) : (bb * cos_number));
					bottom_pos_y=pre_pos_y - ((bb * sin_number) < 0 ? (-bb * sin_number) : (bb * sin_number));
				}
				right_points.push(new Point(bottom_pos_x, bottom_pos_y));
			}
			//箭头部分
			var leftpoint:Point=sarrowALG(left_points[left_points.length - 2], curvepoints[curvepoints.length - 1], "left", dis);
			var rightpoint:Point=sarrowALG(right_points[right_points.length - 2], curvepoints[curvepoints.length - 1], "right", dis);
			left_points.splice(left_points.length - 1, 1);
			left_points.push(leftpoint);
			left_points.push(curvepoints[curvepoints.length - 1]);
			right_points.splice(right_points.length - 1, 1);
			left_points.push(rightpoint);
			var rlength:Number=right_points.length;
			for (var k:int=rlength - 1; k > 0; k--)
			{
				left_points.push(right_points[k]);
			}
			if (tailsarrow)
			{
				left_points.push(curvepoints[4]);
			}
			left_points.push(left_points[0]);
			return left_points;
		}

		public static function sarrowALG(st_point:Point, end_point:Point, direction:String, d:Number):Point
		{
			var angle:Number=Math.PI * 0.7;
			var dir_w3_p:Point=getThreePoint(st_point, end_point, angle, d, direction);
			return dir_w3_p;
		}

		/**
		 *当点击的点数是2的时候测试画出来的曲线
		 * @param dx
		 * @param dy
		 * @return
		 *
		 */
		public static function drawXMiddleCurves(ps:Array):Array
		{
			var points:Array=new Array();
			var n:Number=ps.length;
			var st_point:Point=ps[n - 3];
			var end_point:Point=ps[n - 1];
			var middle_point:Point=ps[n - 2];
			var z_points:Array=getHeanGBJ(st_point, middle_point, end_point);
			var left_point:Point=z_points[0];
			var top_nleft_point:Point=z_points[1];
			var top_wleft_point:Point=z_points[2];
			var top_wright_point:Point=z_points[4];
			var top_nright_point:Point=z_points[5];
			var right_point:Point=z_points[6];
			var left_ps:Array=usebezier(left_point, middle_point, top_nleft_point);
			var right_ps:Array=usebezier(top_nright_point, middle_point, right_point);
			points.push(st_point);
			for (var i:Number=0; i < left_ps.length; i++)
			{
				points.push(left_ps[i]);
			}
			points.push(top_nleft_point);
			points.push(top_wleft_point);
			points.push(end_point);
			points.push(top_wright_point);
			points.push(top_nright_point);
			for (var j:Number=0; j < right_ps.length; j++)
			{
				points.push(right_ps[j]);
			}
			points.push(st_point);
			return points;
		}

		/**
		 *利用n次贝塞尔曲线进行计算
		 * @param ps
		 * @return
		 *
		 */
		public static function useNbezier(ps:Array):Array
		{
			if (ps.length <= 2)
				return ps;
			var n:int=ps.length;
			var sum_n:int=10 * (n - 1);
			var rs:Array=[];
			var x:Number;
			var y:Number;
			//获得方程的系数
			for (var i:Number=0; i < 1 || i == 1; i=i + 1 / sum_n)
			{
				x=0;
				y=0;
				for (var j:int=0; j < n; j++)
				{
					x+=getRount(j, n) * Math.pow(1 - i, n - 1 - j) * Math.pow(i, j) * ps[j].x;
					y+=getRount(j, n) * Math.pow(1 - i, n - 1 - j) * Math.pow(i, j) * ps[j].y;
				}
				rs.push(new Point(x, y));
			}
			return rs;
		}

		/**
		 *系数计算
		 * @param i
		 * @param n:为点击的次数
		 * @return
		 *
		 */
		public static function getRount(i:int, n:int):Number
		{
			if (n < 2)
				return 1;
			if (i == 0)
				return 1;
			n=n - 1;
			var sum_i:int=1;
			for (var j:int=1; j < i + 1; j++)
			{
				sum_i=sum_i * j;
			}
			var sum_n:int=1;
			for (var k:int=n - i + 1; k < n + 1; k++)
			{
				sum_n=sum_n * k;
			}
			return sum_n / sum_i;
		}
	}
}