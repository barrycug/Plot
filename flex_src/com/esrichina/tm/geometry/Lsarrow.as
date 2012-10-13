package com.esrichina.tm.geometry
{
	import com.esri.ags.Map;
	import com.esrichina.tm.utils.ASUtil;
	import com.esrichina.tm.utils.SarrowUtil;

	import flash.geom.Point;

	public class Lsarrow extends CustomPolyline
	{

		public function Lsarrow(ps:Array, map:Map)
		{
			super(ps, map);

		}

		override public function get type():String
		{
			return LSARROW;
		}

		/**
		 *确定箭头两点的算法
		 * @param point
		 * @param r
		 * @return
		 *
		 */
		override public function createGeometryPoints(ps:Array):Array
		{
			if (ps.length < 2)
				return null;
			var n:int=ps.length;
			var end_point:Point=ps[n - 1]; //结束点	
			var start_point:Point=ps[n - 2]; //开始点
			var dis:Number=ASUtil.getDIS(start_point, end_point);
			var left_three_point:Point=SarrowUtil.getThreePoint(end_point, start_point, Math.PI / 6, dis / 8, "right");
			var right_three_point:Point=SarrowUtil.getThreePoint(end_point, start_point, Math.PI / 6, dis / 8, "left");
			var rs:Array=[];
			rs=rs.concat(ps);
			rs.push(left_three_point);
			rs.push(right_three_point);
			var mps:Array=ASUtil.changeScreenToMap(rs, _map);
			return mps;
		}
	}
}