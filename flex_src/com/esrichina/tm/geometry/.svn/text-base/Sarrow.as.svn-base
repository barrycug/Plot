package com.esrichina.tm.geometry
{
	import com.esri.ags.Map;
	import com.esrichina.tm.utils.ASUtil;
	import com.esrichina.tm.utils.SarrowUtil;

	public class Sarrow extends CustomPolygon
	{

		private var _ratio:Number;

		public function get ratio():Number
		{
                 return this._ratio;
		}

		public function Sarrow(ps:Array, map:Map)
		{
			super(ps, map);
		}

		override public function get type():String
		{
			return SARROW;
		}

		override public function createGeometryPoints(ps:Array):Array
		{
			if (ps.length < 2)
				return null;
			var returnps:Array=[];
			if (ps.length == 2)
			{
				//形成军标箭头
				var _ps:Array=SarrowUtil.getHeanGBJ(ps[0], null, ps[1]);

				var rs:Array=[];
				var m:int=_ps.length;
				for (var u:int=0; u < m; u++)
				{
					rs.push(_ps[_ps.length - 1 - u]);
				}
				rs.push(rs[0]);
				returnps=rs;
				_ratio=Math.abs(Math.atan((ps[1].y-ps[0].y)/(ps[1].x-ps[0].x)));
			}
			if (ps.length > 2)
			{
				var d:Number=0;
				var n:int=ps.length;
				for (var g:int=0; g < n - 1; g++)
				{
					d+=ASUtil.getDIS(ps[g], ps[g + 1]) * (n - g - 1) / n;
				}
				_ratio=Math.abs(Math.atan((ps[n-1].y-ps[0].y)/(ps[n-1].x-ps[0].x)));
				var n_coords:Array=SarrowUtil.makeMiddlePoints(ps, false);
				returnps=n_coords;
			}
			var mps:Array=ASUtil.changeScreenToMap(returnps, _map);
			return mps;
		}

	}
}