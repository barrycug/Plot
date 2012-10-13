package com.esrichina.tm.plot
{
	import com.esri.ags.Graphic;
	import com.esri.ags.Map;
	import com.esri.ags.events.MapMouseEvent;
	import com.esri.ags.geometry.MapPoint;
	import com.esri.ags.geometry.Polygon;
	import com.esri.ags.geometry.Polyline;
	import com.esri.ags.layers.GraphicsLayer;
	import com.esri.ags.symbol.InfoSymbol;
	import com.esri.ags.symbol.SimpleFillSymbol;
	import com.esri.ags.symbol.SimpleLineSymbol;
	import com.esri.ags.symbol.Symbol;
	import com.esrichina.tm.event.PlotDrawEvent;
	import com.esrichina.tm.geometry.CustomPolygon;
	import com.esrichina.tm.geometry.CustomPolyline;
	import com.esrichina.tm.geometry.GeometryFactory;
	import com.esrichina.tm.graphics.BaseGraphic;
	import com.esrichina.tm.graphics.GraphicFactory;
	import com.esrichina.tm.symbol.CustomFillSymbol;
	import com.esrichina.tm.symbol.CustomLineSymbol;
	import com.esrichina.tm.utils.ASUtil;
	import com.esrichina.tm.utils.RelationUtil;

	import compontent.ChooseTool;

	import flash.events.MouseEvent;
	import flash.geom.Point;

	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	import mx.managers.CursorManager;

	[Event(name="DrawEvent", type="com.esrichina.tm.event.PlotDrawEvent")]
	[Event(name="DrawStart", type="com.esrichina.tm.event.PlotDrawEvent")]
	public class DynamicPlot extends BaseToolBar
	{
		//定义一个日志类
		public static const strcl:String="动态标绘--";

		include "DrawType.as";

		//定义画法种类
		private var m_drawType:String;
		//定义是否激活工具
		private var _active:Boolean=false;
		//定义标绘的符号参数
		private var _text_symbol:InfoSymbol;
		public var highlightSymbol:Symbol=new SimpleFillSymbol(SimpleFillSymbol.STYLE_SOLID, 0xDC143C, 0.5);
		public var outlineSymbol:Symbol=new SimpleLineSymbol(SimpleLineSymbol.STYLE_SOLID, 0x0000FF, 5.0);
		private var _graphicsLayer:GraphicsLayer;
		//属性框
		private var choseditor:ChooseTool;
		//两个属性跟踪者
		private var watcher1:ChangeWatcher;
		private var watcher2:ChangeWatcher;
		//移动的点
		private var down_points:Array;
		//按下时的点
		private var down_point:Point=new Point();
		//记录第几个按下的是第几个点
		private var _index:int;

		private var _graphic:BaseGraphic;

		public function get graphicsLayer():GraphicsLayer
		{
			return _graphicsLayer;
		}

		public function set graphicsLayer(graphicsLayer:GraphicsLayer):void
		{
			this._graphicsLayer=graphicsLayer;

		}

		public function DynamicPlot(map:Map=null)
		{

			super(map);
		}

		/**
		 * 激活画图工具
		 * @param drawType
		 * @param enableGraphicsLayerMouseEvents
		 *
		 */
		public function activate(drawType:String, enableGraphicsLayerMouseEvents:Boolean=false):void
		{
			deactivate();
			//如果地图和GraphicsLayer没有定义
			if (map == null)
			{
				throw new Error("地图在这个标绘类中没有定义!");
				return;
			}
			if (graphicsLayer == null)
			{
				throw new Error("临时层在这个标绘类中没有定义!");
				return;
			}
			if (!_active)
			{
				deactivateMapTools(true, false, false, true);
				_active=true;
			}
			m_drawType=drawType;
			var args:Array=new Array();
			args.push(drawType);
			args.push(map);
			args.push(graphicsLayer);
			//定义画法前事件
			var g:Graphic;
			this.dispatchEvent(new PlotDrawEvent(PlotDrawEvent.PLOT_DRAW_START, g));
			switch (drawType)
			{
				//圆标注
				case CIRCLE:
				//基地符号
				case BASE:
				case LSARROW:
				case SARROW:
				case XARROWS:
				case CURVEFLAG:
				case RECTFLAG:
				case TRIANGLEFLAG:
				case MOON:
				case HALVE:
				case HALVE1:
				case ELLIPSE:
				case RECTANGLE:
				case ARC:
				case EQUALSARROW:
				case TAILSARROW:
				case DOUBLESARROW:
				{
					g=GraphicFactory.getInstance().createGraphic(args);
					graphicsLayer.add(g);
					break;
				}
				case CLEAR:
				{
					map.addEventListener(MapMouseEvent.MAP_CLICK, map_mapmouseClickHandler, false, 0, true);
					break;
				}
				case HIGHLIGHT:
				{
					map.addEventListener(MapMouseEvent.MAP_CLICK, map_maphighlightClickHandler, false, 0, true);
					break;
				}
				case PROPEDIT:
				{
					map.addEventListener(MapMouseEvent.MAP_CLICK, map_mapeditClickHandler, false, 0, true);
					break;
				}
				case GRAPHICEDIT:
				{
					map.addEventListener(MapMouseEvent.MAP_CLICK, map_graphiceditorClickHandler, false, 0, true);
					break;
				}
				default:
				{
					return;
					break;
				}
			}
			this.dispatchEvent(new PlotDrawEvent(PlotDrawEvent.PLOT_DRAW_END, g));
			return;
		}

		/**
		 *删除函数
		 * @param event
		 *
		 */
		private function map_mapmouseClickHandler(event:MapMouseEvent):void
		{
			var point:MapPoint=event.mapPoint;
			var n:int=graphicsLayer.numGraphics;
			var g:Graphic;
			for (var i:int=0; i < n; i++)
			{
				g=graphicsLayer.getChildAt(i) as Graphic;
				if (g.geometry is Polygon && Polygon(g.geometry).contains(point))
				{
					graphicsLayer.remove(g);
					break;
				}
				if (g.geometry is Polyline && RelationUtil.isOnPolyline(point, Polyline(g.geometry)))
				{
					graphicsLayer.remove(g);
					break;
				}
			}
		}

		/**
		 *高亮函数
		 * @param event
		 *
		 */
		private function map_maphighlightClickHandler(event:MapMouseEvent):void
		{
			var point:MapPoint=event.mapPoint;
			var n:int=graphicsLayer.numGraphics;
			var g:Graphic;
			for (var i:int=0; i < n; i++)
			{
				g=graphicsLayer.getChildAt(i) as Graphic;
				if (g.geometry is Polygon && Polygon(g.geometry).contains(point))
				{
					SimpleFillSymbol(g.symbol).color=0x0000FF;
					break;
				}
				if (g.geometry is Polyline && RelationUtil.isOnPolyline(point, Polyline(g.geometry)))
				{
					g.symbol=outlineSymbol;
					break;
				}
			}
		}

		/**
		 *属性编辑函数
		 *
		 */
		private function map_mapeditClickHandler(event:MapMouseEvent):void
		{
			var mappoint:MapPoint=event.mapPoint;
			var n:int=map.numChildren;
			for (var i:int=0; i < n; i++)
			{
				if (map.getChildAt(i) is ChooseTool)
				{
					choseditor=map.getChildAt(i) as ChooseTool;
					break;
				}
			}
			/* 			if (watcher1 != null)
			   {
			   watcher1.unwatch();
			   watcher2.unwatch();
			 } */
			n=graphicsLayer.numGraphics;
			var isonPolyline:Boolean=false;
			var isonPolygon:Boolean=false;
			var g:Graphic;
			for (i=0; i < n; i++)
			{
				g=graphicsLayer.getChildAt(i) as Graphic;
				if (g.geometry is Polygon)
				{
					isonPolygon=Polygon(g.geometry).contains(mappoint);
				}

				else if (g.geometry is Polyline)
				{
					isonPolyline=RelationUtil.isOnPolyline(mappoint, Polyline(g.geometry));
				}

				if (isonPolygon || isonPolyline)
				{
					if (watcher1 != null)
					{
						watcher1.unwatch();
						watcher2.unwatch();
					}
					watcher1=BindingUtils.bindProperty(g, "alpha", choseditor.slider, "value");
					watcher2=BindingUtils.bindProperty(g.symbol, "color", choseditor.colorPicker, "selectedColor");
					break;
				}
			}
		}

		/**
		 *图形的编辑
		 * @param event
		 *
		 */
		private function map_graphiceditorClickHandler(event:MapMouseEvent):void
		{
			
			var mappoint:MapPoint=event.mapPoint;
			var n:int=graphicsLayer.numGraphics;
			var isonPolyline:Boolean=false;
			var isonPolygon:Boolean=false;
			var g:BaseGraphic;
			var i:int;
			_graphic=null;
			for (i=0; i < n; i++)
			{
				g=graphicsLayer.getChildAt(i) as BaseGraphic;
				if (g.hasEventListener(MouseEvent.MOUSE_DOWN))
				{
					g.removeEventListener(MouseEvent.MOUSE_DOWN, graphic_gMouseDownHanlder);
					map.removeEventListener(MouseEvent.MOUSE_MOVE, graphic_gMouseMoveHandler);
					map.removeEventListener(MouseEvent.MOUSE_UP, graphic_gMouseUpHandler);
				}
				if (g.geometry is Polygon)
				{
					CustomFillSymbol(g.symbol).iseditor=false;
					isonPolygon=Polygon(g.geometry).contains(mappoint);
				}
				else if (g.geometry is Polyline)
				{
					CustomLineSymbol(g.symbol).iseditor=false;
					isonPolyline=RelationUtil.isOnPolyline(mappoint, Polyline(g.geometry));
				}
				if (isonPolygon || isonPolyline)
				{
					//更改graphic的符号
					if (isonPolygon)
						CustomFillSymbol(g.symbol).iseditor=true;
					else
					{
						CustomLineSymbol(g.symbol).iseditor=true;
					}
					_graphic=g;

					//对其进行编辑
					_graphic.addEventListener(MouseEvent.MOUSE_DOWN, graphic_gMouseDownHanlder);
				}
				g.refresh();
			}
		}

		/**
		 *对其添加鼠标按下监听,如果是控制点则进行图形编辑，否则进行移动
		 * @param event
		 *
		 */
		private function graphic_gMouseDownHanlder(event:MouseEvent):void
		{
			down_point=new Point(event.stageX, event.stageY);
			var g:BaseGraphic=event.currentTarget as BaseGraphic;
			g.removeEventListener(MouseEvent.MOUSE_DOWN, graphic_gMouseDownHanlder);
			if (down_points != null)
				down_points.splice(0);
			else
			{
				down_points=[];
			}
			if (g.geometry is CustomPolygon)
			{
				var cuspolygon:CustomPolygon=g.geometry as CustomPolygon;
				var n:int, i:int;
				var ps:Array=ASUtil.changeMapToScreen(cuspolygon.ps, map);
				n=cuspolygon.ps.length;
				var isps:Boolean=false;
				for (i=0; i < n; i++)
				{
					isps=RelationUtil.isPoint(down_point, ps[i]);
					if (isps)
					{
						_index=i;
						continue;
					}
					down_points.push(ps[i]);
				}
			}
			else if (g.geometry is CustomPolyline)
			{
				var cuspolyline:CustomPolyline=g.geometry as CustomPolyline;
				var n:int, i:int;
				var ps:Array=ASUtil.changeMapToScreen(cuspolyline.ps, map);
				n=cuspolyline.ps.length;
				var isps:Boolean=false;
				for (i=0; i < n; i++)
				{
					isps=RelationUtil.isPoint(down_point, ps[i]);
					if (isps)
					{
						_index=i;
						continue;
					}
					down_points.push(ps[i]);
				}
			}
			//增加按下的监听和抬起的监听
			map.addEventListener(MouseEvent.MOUSE_MOVE, graphic_gMouseMoveHandler, false, 0, true);
			map.addEventListener(MouseEvent.MOUSE_UP, graphic_gMouseUpHandler, false, 0, true);
		}

		/**
		 *进行编辑时的鼠标移动事件，主要做的就是重新画图形
		 * @param event
		 *
		 */
		private function graphic_gMouseMoveHandler(event:MouseEvent):void
		{
			var point:Point=new Point(event.stageX, event.stageY);
			var type:String=_graphic.geometry.type;
			if (_graphic.geometry is CustomPolygon)
			{
				var cuspolygon:CustomPolygon=_graphic.geometry as CustomPolygon;
				var n:int=cuspolygon.ps.length;
				var ps:Array=ASUtil.changeMapToScreen(cuspolygon.ps, map);
				var m:int=down_points.length;
				if (m == n)
				{
					//图形移动
					var offx:Number=down_point.x - point.x;
					var offy:Number=down_point.y - point.y;
					for (var i:int=0; i < n; i++)
					{
						ps[i]=new Point(ps[i].x - offx, ps[i].y - offy);
					}
					ps.splice(0, 0, type);
					ps.splice(1, 0, map);
				}
				else
				{
					ps.splice(0);
					for (i=0; i < m; i++)
					{
						ps.push(down_points[i]);
					}
					ps.splice(_index, 0, point);
					ps.splice(0, 0, type);
					ps.splice(1, 0, map);
				}
				cuspolygon=GeometryFactory.getInstance().createGeometry(ps) as CustomPolygon;
				_graphic.geometry=cuspolygon;
			}
			else if (_graphic.geometry is CustomPolyline)
			{
				var cuspolyline:CustomPolyline=_graphic.geometry as CustomPolyline;
				var n:int=cuspolyline.ps.length;
				var ps:Array=ASUtil.changeMapToScreen(cuspolyline.ps, map);
				var m:int=down_points.length;
				if (m == n)
				{
					//图形移动
					var offx:Number=down_point.x - point.x;
					var offy:Number=down_point.y - point.y;
					for (var i:int=0; i < n; i++)
					{
						ps[i]=new Point(ps[i].x - offx, ps[i].y - offy);
					}
					ps.splice(0, 0, type);
					ps.splice(1, 0, map);
				}
				else
				{
					ps.splice(0);
					for (i=0; i < m; i++)
					{
						ps.push(down_points[i]);
					}
					ps.splice(_index, 0, point);
					ps.splice(0, 0, type);
					ps.splice(1, 0, map);
				}
				cuspolyline=GeometryFactory.getInstance().createGeometry(ps) as CustomPolyline;
				_graphic.geometry=cuspolyline;
			}
			_graphic.refresh();
			down_point=point;
		}

		/**
		 *鼠标抬起事件,增加mouse_down事件，消除mouse_move和mouse_up事件
		 * @param event
		 *
		 */
		private function graphic_gMouseUpHandler(event:MouseEvent):void
		{
			trace("进入鼠标抬起阶段!");
			map.removeEventListener(MouseEvent.MOUSE_MOVE, graphic_gMouseMoveHandler);
			map.removeEventListener(MouseEvent.MOUSE_UP, graphic_gMouseUpHandler);
			_graphic.addEventListener(MouseEvent.MOUSE_DOWN, graphic_gMouseDownHanlder);
		}

		/**
		 *这个是销毁函数
		 *
		 */
		public function deactivate():void
		{
			if (map == null)
			{
				throw new Error("地图在这个标绘类中没有定义!");
					//return;
			}
			if (watcher1 != null)
			{
				watcher1.unwatch();
				watcher2.unwatch();
			}
			CursorManager.removeAllCursors();
			_active=false;
			//map.mapNavigationEnabled=false;
			map.panEnabled=false;
			activateMapTools(true, false, false, true);
			GraphicFactory.getInstance().deactivate();
			map.removeEventListener(MapMouseEvent.MAP_CLICK, map_graphiceditorClickHandler);
			map.removeEventListener(MapMouseEvent.MAP_CLICK, map_mapeditClickHandler);
			map.removeEventListener(MapMouseEvent.MAP_CLICK, map_maphighlightClickHandler);
			map.removeEventListener(MapMouseEvent.MAP_CLICK, map_mapmouseClickHandler);

		}

	}
}