package com.esrichina.tm.graphics
{
	import com.esri.ags.Graphic;
	import com.esri.ags.Map;
	import com.esri.ags.geometry.Geometry;
	import com.esri.ags.symbol.SimpleFillSymbol;
	import com.esri.ags.symbol.SimpleLineSymbol;
	import com.esri.ags.symbol.SimpleMarkerSymbol;
	import com.esri.ags.symbol.Symbol;
	import com.esrichina.tm.ginterface.IBaseGraphic;

	import flash.events.MouseEvent;

	public class BaseGraphic extends Graphic implements IBaseGraphic
	{
		private var _type:String;

		public function get type():String
		{
			return _type;
		}
		private var _map:Map;

		public function BaseGraphic(map:Map, type:String, geometry:Geometry=null, symbol:Symbol=null, attributes:Object=null)
		{
			super(geometry, symbol, attributes);
			this._type=type;
			this._map=map;
			active();
		}

		/**
		 *定义各个属性
		 * @return
		 *
		 */

		public function get map():Map
		{
			return _map;
		}


		public function active():void
		{
			//trace("active");
		}

		public function deactivate():void
		{
             
		}

		public function map_mouseDownHandler(event:MouseEvent):void
		{

		}

		public function map_mouseMoveHandler(event:MouseEvent):void
		{
			//trace("ddd");
		}

		public function map_mouseClickHandler(event:MouseEvent):void
		{
			//trace("ddd");
		}

		public function map_mouseDoubleHandler(event:MouseEvent):void
		{
			//trace("ddd");
		}

		public function map_mouseUpHandler(event:MouseEvent):void
		{
			//trace("ddd");
		}
	}
}