package com.esrichina.tm.geometry
{
	import com.esri.ags.Map;
	import com.esrichina.tm.utils.ASUtil;
	import com.esrichina.tm.utils.SarrowUtil;

	import flash.geom.Point;


	public class Xarrows extends CustomPolygon
	{
		public function Xarrows(ps:Array, map:Map)
		{
			super(ps, map);
		}

		override public function get type():String
		{
			return XARROWS;
		}

		override public function createGeometryPoints(ps:Array):Array
		{
			if (ps.length < 2)
				return null;
			var returnps:Array=[];
			var n:int=ps.length;
			if (n == 2)
			{
				returnps=SarrowUtil.getHeanGBJ(ps[0], null, ps[1]);
			}
			if (n == 3)
			{
				returnps=SarrowUtil.drawXMiddleCurves(ps);
			}
			if (n > 3)
			{
				var left_point1:Array=[]; //左一号位数组，
				var left_n_point2:Array=[]; //左二号内位数组
				var left_w_point2:Array=[]; //左二号位外数组
				var m_point3:Array=[]; //顶点数组
				var right_w_point2:Array=[]; //右二号外位数组
				var right_n_point2:Array=[]; //右二号内位数组
				var right_point1:Array=[]; //右一位数组
				var m_point2:Array=[]; //中间2号位的点
				var m_point1:Array=[]; //中间一号位，也就是点击的一号位
				var point1:Point=new Point();
				var point2:Point=new Point();
				var point3:Point=new Point();
				var arrows:Array=[]; //最左边拟合点的数组

				var m:int=n / 3; //含有箭头数
				if (n % 3 == 0)
				{

					for (var i:int=0; i < n - 2; i=i + 3)
					{
						point1=ps[i] as Point;
						point2=ps[i + 1] as Point;
						point3=ps[i + 2] as Point;
						arrows=SarrowUtil.getHeanGBJ(point1, point2, point3);
						m_point1.push(point1);
						m_point2.push(point2);
						left_point1.push(arrows[0]);
						left_n_point2.push(arrows[1]);
						left_w_point2.push(arrows[2]);
						m_point3.push(arrows[3]);
						right_w_point2.push(arrows[4]);
						right_n_point2.push(arrows[5]);
						right_point1.push(arrows[6]);
					}
					var sum:int=0;
					for (var j:int=0; j < m; j++)
					{
						if (j == 0)
						{
							arrows=SarrowUtil.usebezier(left_point1[j], m_point2[j], left_n_point2[j]);

							returnps=returnps.concat(arrows);
							returnps.push(left_n_point2[j]);
							returnps.push(left_w_point2[j]);
							returnps.push(m_point3[j]);
							returnps.push(right_w_point2[j]);
							returnps.push(right_n_point2[j]);
							continue;
						}
						arrows=SarrowUtil.useFiveBezier(right_n_point2[j - 1], m_point2[j - 1], m_point1[j], m_point2[j], left_n_point2[j]);

						returnps=returnps.concat(arrows);
						returnps.push(left_n_point2[j]);
						returnps.push(left_w_point2[j]);
						returnps.push(m_point3[j]);
						returnps.push(right_w_point2[j]);
						returnps.push(right_n_point2[j]);
					}
					arrows=SarrowUtil.usebezier(right_n_point2[m - 1], m_point2[m - 1], right_point1[m - 1]);
					returnps=returnps.concat(arrows);

				}
				if (n % 3 == 1)
				{
					for (var i:int=0; i < n - 3; i=i + 3)
					{
						point1=ps[i] as Point;
						point2=ps[i + 1] as Point;
						point3=ps[i + 2] as Point;
						arrows=SarrowUtil.getHeanGBJ(point1, point2, point3);
						m_point1.push(point1);
						m_point2.push(point2);
						left_point1.push(arrows[0]);
						left_n_point2.push(arrows[1]);
						left_w_point2.push(arrows[2]);
						m_point3.push(arrows[3]);
						right_w_point2.push(arrows[4]);
						right_n_point2.push(arrows[5]);
						right_point1.push(arrows[6]);
					}
					for (var j:int=0; j < m; j++)
					{
						if (j == 0)
						{
							arrows=SarrowUtil.usebezier(left_point1[j], m_point2[j], left_n_point2[j]);
							returnps=returnps.concat(arrows);
							returnps.push(left_n_point2[j]);
							returnps.push(left_w_point2[j]);
							returnps.push(m_point3[j]);
							returnps.push(right_w_point2[j]);
							returnps.push(right_n_point2[j]);
							continue;
						}
						arrows=SarrowUtil.useFiveBezier(right_n_point2[j - 1], m_point2[j - 1], m_point1[j], m_point2[j], left_n_point2[j]);
						returnps=returnps.concat(arrows);
						returnps.push(left_n_point2[j]);
						returnps.push(left_w_point2[j]);
						returnps.push(m_point3[j]);
						returnps.push(right_w_point2[j]);
						returnps.push(right_n_point2[j]);

					}
					arrows=SarrowUtil.usebezier(right_n_point2[m - 1], m_point2[m - 1], right_point1[m - 1]);
					returnps=returnps.concat(arrows);
					returnps.push(ps[n - 1]);
				}
				if (n % 3 == 2)
				{
					for (var i:int=0; i < n - 4; i=i + 3)
					{

						point1=ps[i] as Point;
						point2=ps[i + 1] as Point;
						point3=ps[i + 2] as Point;
						arrows=SarrowUtil.getHeanGBJ(point1, point2, point3);
						m_point1.push(point1);
						m_point2.push(point2);
						left_point1.push(arrows[0]);
						left_n_point2.push(arrows[1]);
						left_w_point2.push(arrows[2]);
						m_point3.push(arrows[3]);
						right_w_point2.push(arrows[4]);
						right_n_point2.push(arrows[5]);
						right_point1.push(arrows[6]);
					}
					for (var j:int=0; j < m; j++)
					{
						if (j == 0)
						{
							arrows=SarrowUtil.usebezier(left_point1[j], m_point2[j], left_n_point2[j]);
							returnps=returnps.concat(arrows);
							returnps.push(left_n_point2[j]);
							returnps.push(left_w_point2[j]);
							returnps.push(m_point3[j]);
							returnps.push(right_w_point2[j]);
							returnps.push(right_n_point2[j]);
							continue;
						}
						arrows=SarrowUtil.useFiveBezier(right_n_point2[j - 1], m_point2[j - 1], m_point1[j], m_point2[j], left_n_point2[j]);
						returnps=returnps.concat(arrows);
						returnps.push(left_n_point2[j]);
						returnps.push(left_w_point2[j]);
						returnps.push(m_point3[j]);
						returnps.push(right_w_point2[j]);
						returnps.push(right_n_point2[j]);

					}
					//2,4,5号位确定最右边
					var _m_point:Point=ps[n - 5];
					var _m_point2:Point=ps[n - 4];
					var _m_point1:Point=ps[n - 2];
					var _m_point22:Point=ps[n - 1];
					arrows=SarrowUtil.getHeanGBJ(_m_point1, null, _m_point22);
					var _left_n_point2:Point=arrows[1];
					var _right_n_point2:Point=right_n_point2[m - 1];
					var _rights:Array=SarrowUtil.useFourBezier(_right_n_point2, _m_point2, _m_point1, _left_n_point2);
					returnps=returnps.concat(_rights);
					arrows.splice(0, 1);
					returnps=returnps.concat(arrows);
				}
			}
			returnps.push(returnps[0]);
			var mps:Array=ASUtil.changeScreenToMap(returnps, _map);
			return mps;
		}

	}
}