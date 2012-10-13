package com.esrichina.tm.geometry
{
	import com.esri.ags.Map;
	import com.esrichina.tm.utils.ASUtil;
	import com.esrichina.tm.utils.SarrowUtil;

	public class Arc extends CustomPolyline
	{
		public function Arc(ps:Array, map:Map)
		{
			super(ps, map);
		}

		override public function get type():String
		{
			return ARC;
		}

		override public function createGeometryPoints(ps:Array):Array
		{
			if (ps.length < 2)
				return null;
			var rs:Array=SarrowUtil.useNbezier(ps);
			var mrs:Array=ASUtil.changeScreenToMap(rs, map);
			return mrs;
		}
	}
}