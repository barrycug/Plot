package com.esrichina.tm.geometry
{
	import com.esri.ags.Map;
	import com.esri.ags.geometry.Polyline;
	import com.esrichina.tm.utils.ASUtil;

	public class CustomPolyline extends Polyline
	{
		protected static var numberOfPoints:int=100;
		protected var _map:Map;
		include "../plot/DrawType.as";

		protected function get map():Map
		{
			return this._map;
		}
		public var ps:Array=[];

		public function CustomPolyline(_ps:Array, map:Map)
		{
			super();
			this._map=map;
			this.ps=changePsToMap(_ps);
			this.spatialReference=map.spatialReference;
			var ring:Array=[];
			ring=createGeometryPoints(_ps);
			if (this.paths != null && this.paths.length != 0)
				this.paths.splice(0);
			this.addPath(ring);
		}

		public function createGeometryPoints(ps:Array):Array
		{
			return ps;
		}
		
		private function changePsToMap(ps:Array):Array
		{
			if (ps == null || ps.length == 0)
				return null;
			var n:int=ps.length;
			var mp:Array=[];
			mp=ASUtil.changeScreenToMap(ps,this._map);
			return mp;
		}
	}
}