package com.esrichina.tm.geometry
{
	import com.esri.ags.Map;
	import com.esrichina.tm.utils.ASUtil;
	import com.esrichina.tm.utils.SarrowUtil;

	import flash.geom.Point;

	public class TailSarrow extends CustomPolygon
	{
		public function TailSarrow(ps:Array, map:Map)
		{
			super(ps, map);
			
		}
		override public function get type():String
		{
			return TAILSARROW;
		}
		override public function createGeometryPoints(ps:Array):Array
		{
			if (ps.length < 2)
				return null;
			var returnps:Array=[];
			if (ps.length == 2)
			{
				var m_point:Point=new Point((ps[0].x + ps[1].x) * 0.5, (ps[0].y + ps[1].y) * 0.5);
				//形成军标箭头
				var _ps:Array=SarrowUtil.getHeanGBJ(ps[0], m_point, ps[1]);
				var dis:Number=ASUtil.getDIS(ps[0], ps[1]);
				var angle:Number=(ps[1].y - ps[0].y) / (ps[1].x - ps[0].x);
				var tail_point:Point=new Point(ps[0].x + dis * 0.2 * Math.cos(Math.atan(angle)), ps[0].y + dis * 0.2 * Math.sin(Math.atan(angle)));
				var rs:Array=[];
				var m:int=_ps.length;
				for (var u:int=0; u < m; u++)
				{
					rs.push(_ps[_ps.length - 1 - u]);
				}
				rs.push(tail_point);
				rs.push(rs[0]);
				returnps=rs;
			}
			else if (ps.length > 2)
			{
				var d:Number=0;
				var n:int=ps.length;
				for (var g:int=0; g < n - 1; g++)
				{
					d+=ASUtil.getDIS(ps[g], ps[g + 1]) * (n - g - 1) / n;
				}
				var n_coords:Array=SarrowUtil.makeMiddlePoints(ps,false,true);
				returnps=n_coords;
			}
			var mps:Array=ASUtil.changeScreenToMap(returnps, _map);
			return mps;

		}
	}
}