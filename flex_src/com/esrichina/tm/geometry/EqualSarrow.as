package com.esrichina.tm.geometry
{
	import com.esri.ags.Map;
	import com.esrichina.tm.utils.ASUtil;
	import com.esrichina.tm.utils.SarrowUtil;

	import flash.geom.Point;

	public class EqualSarrow extends CustomPolygon
	{
		public function EqualSarrow(ps:Array, map:Map)
		{
			super(ps, map);
		}

		override public function get type():String
		{
			return EQUALSARROW;
		}

		override public function createGeometryPoints(ps:Array):Array
		{
			if (ps.length < 2)
			{
				return null;
			}
			var rs:Array=[];
			if (ps.length == 2)
			{
				var dis:Number=ASUtil.getDIS(ps[0], ps[1]);
				var left_point:Point=SarrowUtil.getThreePoint(ps[0], ps[1], Math.PI / 2, dis / 10, "left");
				var right_point:Point=SarrowUtil.getThreePoint(ps[0], ps[1], Math.PI / 2, dis / 10, "right");
				var left_n_point:Point=SarrowUtil.getThreePoint(left_point, ps[0], Math.PI / 2, dis * 4 / 5, "left");
				var right_n_point:Point=SarrowUtil.getThreePoint(right_point, ps[0], Math.PI / 2, dis * 4 / 5, "right");
				var left_w_point:Point=SarrowUtil.getThreePoint(ps[1], left_n_point, Math.PI / 8, dis / 2.8, "right");
				var right_w_point:Point=SarrowUtil.getThreePoint(ps[1], right_n_point, Math.PI / 8, dis / 2.8, "left");
				rs.push(left_point);
				rs.push(left_n_point);
				rs.push(left_w_point);
				rs.push(ps[1]);
				rs.push(right_w_point);
				rs.push(right_n_point);
				rs.push(right_point);
				rs.push(left_point);
			}
			if (ps.length > 2)
			{
				rs=SarrowUtil.makeMiddlePoints(ps, true);
			}
			var mrs:Array=ASUtil.changeScreenToMap(rs, _map);
			return mrs;
		}
	}
}