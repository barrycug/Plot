package com.esrichina.tm.graphics
{
	import com.esri.ags.Map;
	import com.esri.ags.geometry.Geometry;
	import com.esri.ags.symbol.Symbol;
	import com.esrichina.tm.geometry.GeometryFactory;
	import com.esrichina.tm.symbol.SymbolFactory;

	import flash.events.MouseEvent;
	import flash.geom.Point;

	public class SarrowGraphic extends BaseGraphic
	{
		public function SarrowGraphic(map:Map, type:String, geometry:Geometry=null, symbol:Symbol=null, attributes:Object=null)
		{
			super(map, type, geometry, symbol, attributes);
		}
		private var coords:Array=new Array();
		[Bindable]
		private var clicknum:int=0;

		override public function active():void
		{
			if (!map.hasEventListener(MouseEvent.CLICK))
				map.addEventListener(MouseEvent.CLICK, map_mouseClickHandler);
		}

		override public function deactivate():void
		{
			if (map.hasEventListener(MouseEvent.CLICK))
				map.removeEventListener(MouseEvent.CLICK, map_mouseClickHandler);
		}

		override public function map_mouseClickHandler(event:MouseEvent):void
		{
			if (!map.hasEventListener(MouseEvent.MOUSE_MOVE))
			{
				map.addEventListener(MouseEvent.MOUSE_MOVE, map_mouseMoveHandler);
			}
			if (!map.hasEventListener(MouseEvent.DOUBLE_CLICK))
			{
				map.addEventListener(MouseEvent.DOUBLE_CLICK, map_mouseDoubleHandler);
			}
			var fx:Number=event.stageX;
			var fy:Number=event.stageY;
			var c_point:Point=new Point(fx, fy);
			coords.push(c_point);
			clicknum++;
		}

		override public function map_mouseMoveHandler(event:MouseEvent):void
		{
			var dx:Number=event.stageX;
			var dy:Number=event.stageY;
			var ps:Array=[];
			ps.push(this.type);
			ps.push(map);
			ps=ps.concat(coords);
			if (type.toString() == "DOUBLESARROW" && clicknum>2)
			{
				map.removeEventListener(MouseEvent.CLICK, map_mouseClickHandler);
 				 map.removeEventListener(MouseEvent.MOUSE_MOVE, map_mouseMoveHandler);
				map.removeEventListener(MouseEvent.DOUBLE_CLICK, map_mouseDoubleHandler);  
			}
			else
			{
				ps.push(new Point(dx, dy));
			}
			this.geometry=GeometryFactory.getInstance().createGeometry(ps);
			//创建符号
			var args:Array=[];
			args.push(this.type);
			this.symbol=SymbolFactory.getInstance().createSymbol(args);

		}

		override public function map_mouseDoubleHandler(event:MouseEvent):void
		{
			map.removeEventListener(MouseEvent.CLICK, map_mouseClickHandler);
			map.removeEventListener(MouseEvent.MOUSE_MOVE, map_mouseMoveHandler);
			map.removeEventListener(MouseEvent.DOUBLE_CLICK, map_mouseDoubleHandler);
	
		}
	}
}