package com.esrichina.tm.geometry
{
	import com.esri.ags.Map;
	import com.esri.ags.geometry.Polygon;
	import com.esrichina.tm.utils.ASUtil;

	public class CustomPolygon extends Polygon
	{
		include "../plot/DrawType.as";
		protected static var numberOfPoints:int=100;
		protected var _map:Map;
		public var ps:Array=[];
		public function CustomPolygon(_ps:Array, map:Map)
		{
			super();
			this._map=map;
			this.ps=changePsToMap(_ps);
			this.spatialReference=map.spatialReference;
			var ring:Array=createGeometryPoints(_ps);
			if (this.rings != null && this.rings.length != 0)
				this.rings.splice(0);
			this.addRing(ring);
		}

		public function clear():void
		{
			this.rings.splice(0);
		}

		public function changeRing(ring:Array):void
		{
			this.rings.splice(0);
			this.rings.push(ring);
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