package com.esrichina.tm.graphics
{
	import com.esri.ags.Map;
	import com.esri.ags.geometry.Geometry;
	import com.esri.ags.geometry.MapPoint;
	import com.esri.ags.symbol.Symbol;
	import com.esrichina.tm.geometry.GeometryFactory;
	import com.esrichina.tm.symbol.SymbolFactory;
	
	import flash.events.MouseEvent;

	internal class CircleBaseGraphic extends BaseGraphic
	{
		include "../plot/DrawType.as";
		private var center_point:MapPoint=new MapPoint();

		/**
		 *定义一个圆符号
		 * @param map
		 * @param type
		 * @param graphicsLayer
		 * @param geometry
		 * @param symbol
		 * @param attributes
		 *
		 */
		public function CircleBaseGraphic(map:Map, type:String, geometry:Geometry=null, symbol:Symbol=null, attributes:Object=null)
		{
			super(map, type, geometry, symbol, attributes);
		}

		override public function active():void
		{

			map.addEventListener(MouseEvent.MOUSE_DOWN, map_mouseDownHandler);
		}

		override public function deactivate():void
		{
			if (map.hasEventListener(MouseEvent.MOUSE_DOWN))
				map.removeEventListener(MouseEvent.MOUSE_DOWN, map_mouseDownHandler);
		}

		override public function map_mouseDownHandler(event:MouseEvent):void
		{
			map.removeEventListener(MouseEvent.MOUSE_DOWN, map_mouseDownHandler);
			const mappoint:MapPoint=map.toMapFromStage(event.stageX, event.stageY);
			center_point=mappoint;
			map.addEventListener(MouseEvent.MOUSE_MOVE, map_mouseMoveHandler);
			map.addEventListener(MouseEvent.MOUSE_UP, map_mouseUpHandler);
		}

		override public function map_mouseMoveHandler(event:MouseEvent):void
		{
			var point:MapPoint=map.toMapFromStage(event.stageX, event.stageY);
			//创建symbol
			var args:Array=[];
			args.push(this.type);
			args.push(false);
			//创建geometry
			var args1:Array=[];
			args1.push(this.type);
			args1.push(map);
			args1.push(map.toScreen(center_point));
			args1.push(map.toScreen(point));

			this.geometry=GeometryFactory.getInstance().createGeometry(args1);
			this.symbol=SymbolFactory.getInstance().createSymbol(args);
		}

		/**
		 *触发鼠标抬起事件
		 * @param event
		 *
		 */
		override public function map_mouseUpHandler(event:MouseEvent):void
		{
			map.removeEventListener(MouseEvent.MOUSE_DOWN,map_mouseDownHandler);
			map.removeEventListener(MouseEvent.MOUSE_MOVE, map_mouseMoveHandler);
			map.removeEventListener(MouseEvent.MOUSE_UP, map_mouseUpHandler);
		}
	}
}