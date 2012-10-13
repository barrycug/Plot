package com.esrichina.tm.geometry
{
	import com.esri.ags.Map;
	import com.esrichina.tm.utils.ASUtil;
	import com.esrichina.tm.utils.SarrowUtil;

	import flash.geom.Point;

	public class DoubleSarrow extends CustomPolygon
	{
		public function DoubleSarrow(ps:Array, map:Map)
		{
			super(ps, map);
		}

		override public function get type():String
		{
			return DOUBLESARROW;
		}

		override public function createGeometryPoints(ps:Array):Array
		{
			if (ps.length < 2)
				return null;
			var mrs:Array=[];
			if (ps.length == 2)
			{
				ps.push(ps[0]);
				mrs=ASUtil.changeScreenToMap(ps, this._map);
				return mrs;
			}
			if (ps.length == 3)
			{
				var end_point:Point=ps[2];
				var point2:Point=ps[1];
				var point1:Point=ps[0];
				//确定两个箭头
				var right_points:Array=SarrowUtil.getHeanGBJ(ps[1], null, ps[2]);
				//确定角度
				var l_dis:Number=ASUtil.getDIS(ps[1], ps[2]);
				var c_dis:Number=ASUtil.getDisToTwoPoints(ps[0], ps[2], ps[1]);
				var range:Number=Math.asin(c_dis / l_dis);
				//确定第三点
				var point0:Point;
				if (ASUtil.findSite(point1, end_point, point2) == "right")
					point0=SarrowUtil.getThreePoint(ps[0], ps[1], range, l_dis, "left");
				else
					point0=SarrowUtil.getThreePoint(ps[0], ps[1], range, l_dis, "right");
				//var point0:Point=new Point(ps[0].x + (ps[1].x - ps[2].x), ps[0].y + (ps[1].y - ps[2].y));
				var left_points:Array=SarrowUtil.getHeanGBJ(ps[0], null, point0);
				var radius:Number=0;
				var l_points:Array=[];
				var r_points:Array=[];
				var middle_points:Array=[];

				//拟合两边
				var left_n_point:Point;
				var right_n_point:Point;
				var left_w_point:Point;
				var right_w_point:Point;
				if (end_point.y > point1.y || end_point.y == point1.y)
				{
					left_n_point=left_points[5];
					right_n_point=right_points[1];
					left_w_point=left_points[1];
					right_w_point=right_points[5];
				}
				else
				{
					left_n_point=left_points[1];
					left_w_point=left_points[5];
					right_n_point=right_points[5];
					right_w_point=right_points[1];
				}
				var left_m_point:Point=new Point((point1.x + left_n_point.x) * 0.5, (point1.y + left_n_point.y) * 0.5);
				var right_m_point:Point=new Point((point2.x + right_n_point.x) * 0.5, (point2.y + right_n_point.y) * 0.5);
				var left_dis:Number=ASUtil.getDIS(point1, left_n_point);
				//坐标
				var x:Number;
				var y:Number;
				var left_angle:Number=0;
				var right_angle:Number=0;
				var point_m:Point;
				if (left_n_point.y != point1.y)
				{
					left_angle=Math.atan((left_n_point.x - point1.x) / (left_n_point.y - point1.y));
					right_angle=Math.atan((point2.x - right_n_point.x) / (point2.y - right_n_point.y));
				}
				if (end_point.y < point1.y)
				{
					for (var i:Number=0.5 * Math.PI; i < Math.PI * 1.5; i=i + Math.PI * 0.025)
					{
						x=Math.abs(left_dis) * 0.08 * Math.cos(i);
						y=Math.abs(left_dis) * 0.5 * Math.sin(i);
						l_points.push(changeCoords(x, y, left_angle, left_m_point.x, left_m_point.y));
					}
					for (i=-0.5 * Math.PI; i < Math.PI * 0.5; i+=Math.PI * 0.025)
					{
						x=Math.abs(left_dis) * 0.08 * Math.cos(i);
						y=Math.abs(left_dis) * 0.5 * Math.sin(i);
						r_points.push(changeCoords(x, y, right_angle, right_m_point.x, right_m_point.y));
					}
					//拟合中间的
					point_m=new Point((point1.x + point2.x) * 0.5, (point1.y + point2.y) * 0.5);
					middle_points=SarrowUtil.usebezier(left_w_point, point_m, right_w_point);

					l_points.push(left_points[1]);
					l_points.push(left_points[2]);
					l_points.push(left_points[3]);
					l_points.push(left_points[4]);
					l_points.push(left_points[5]);
					l_points=l_points.concat(middle_points);
					l_points.push(right_points[1]);
					l_points.push(right_points[2]);
					l_points.push(end_point);
					l_points.push(right_points[4]);
					l_points.push(right_points[5]);
					l_points=l_points.concat(r_points);
					l_points.push(point2);
					l_points.push(point1);
				}
				else
				{
					for (i=1.5 * Math.PI; i > Math.PI * 0.5; i=i - Math.PI * 0.025)
					{
						x=Math.abs(left_dis) * 0.08 * Math.cos(i);
						y=Math.abs(left_dis) * 0.5 * Math.sin(i);
						l_points.push(changeCoords(x, y, left_angle, left_m_point.x, left_m_point.y));
					}
					for (i=0.5 * Math.PI; i > Math.PI * -0.5; i-=Math.PI * 0.025)
					{
						x=Math.abs(left_dis) * 0.08 * Math.cos(i);
						y=Math.abs(left_dis) * 0.5 * Math.sin(i);
						r_points.push(changeCoords(x, y, right_angle, right_m_point.x, right_m_point.y));
					}
					//拟合中间的
					point_m=new Point((point1.x + point2.x) * 0.5, (point1.y + point2.y) * 0.5);
					middle_points=SarrowUtil.usebezier(left_w_point, point_m, right_w_point);

					l_points.push(left_points[5]);
					l_points.push(left_points[4]);
					l_points.push(left_points[3]);
					l_points.push(left_points[2]);
					l_points.push(left_points[1]);
					l_points=l_points.concat(middle_points);
					l_points.push(right_points[5]);
					l_points.push(right_points[4]);
					l_points.push(end_point);
					l_points.push(right_points[2]);
					l_points.push(right_points[1]);
					l_points=l_points.concat(r_points);
					l_points.push(point2);
					l_points.push(point1);
				}
				mrs=ASUtil.changeScreenToMap(l_points, this._map);
			}
			return mrs;
		}

		/**
		 *不同平面坐标系的转化
		 * @param x
		 * @param y
		 * @param angle
		 * @param x0
		 * @param y0
		 * @return
		 *
		 */
		private function changeCoords(x:Number, y:Number, angle:Number, x0:Number, y0:Number):Point
		{
			var x1:Number=x * Math.cos(angle) + y * Math.sin(angle) + x0;
			var y1:Number=y * Math.cos(angle) - x * Math.sin(angle) + y0;
			return new Point(x1, y1);
		}
	}
}