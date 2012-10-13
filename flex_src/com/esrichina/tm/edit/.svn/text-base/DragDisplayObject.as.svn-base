package com.esrichina.tm.edit
{
	import com.esri.ags.Map;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.core.BitmapAsset;
	import mx.core.DragSource;
	import mx.core.UIComponent;
	import mx.events.DragEvent;
	import mx.managers.DragManager;

	public class DragDisplayObject
	{
		private var xoffset:Number;
		private var yoffset:Number;
		private static const FORMAT:String="Map";
		private static var instance:DragDisplayObject=null;

		public function DragDisplayObject(map:Map, disObject:DisplayObject)
		{
			if (instance != null)
			{
				Alert.show("仅仅需要一个实例，不能通过new创建！！", "ERROR TIP！");
			}
			map.mapNavigationEnabled=false;
			disObject.addEventListener(MouseEvent.MOUSE_MOVE, object_mouseDownHandler, false, 0, true);
			map.addEventListener(DragEvent.DRAG_ENTER, map_DragEnterHandler, false, 0, true);
			map.addEventListener(DragEvent.DRAG_DROP, map_DragDropHandler, false, 0, true);
		}

		public static function getDragObjectInstance(map:Map, disObject:DisplayObject):DragDisplayObject
		{
			if (instance == null)
			{
				instance=new DragDisplayObject(map, disObject);
			}
			return instance;
		}

		public static function clearDrag():void
		{
			instance=null;
		}

		public function object_mouseDownHandler(event:MouseEvent):void
		{

			xoffset=event.localX;
			yoffset=event.localY;
			var initiator:UIComponent=event.currentTarget as UIComponent;
			var proxyCanvas:BitmapAsset=new BitmapAsset();
			proxyCanvas.bitmapData=new BitmapData(initiator.width, initiator.height);
			proxyCanvas.bitmapData.draw(initiator);
			var dragSource:DragSource=new DragSource();
			dragSource.addData(initiator, FORMAT);
			
			DragManager.doDrag(initiator, dragSource, event, proxyCanvas, 0, 0, 0.5);
		}

		public function map_DragEnterHandler(evt:DragEvent):void
		{
			if (evt.dragSource.hasFormat(FORMAT))
			{
				DragManager.acceptDragDrop(Map(evt.currentTarget));
			}
		}

		public function map_DragDropHandler(evt:DragEvent):void
		{
			var g:UIComponent=UIComponent(evt.dragInitiator);
			g.x=evt.localX - xoffset;
			g.y=evt.localY - yoffset;
			g.visible=true;
		}

	}
}
