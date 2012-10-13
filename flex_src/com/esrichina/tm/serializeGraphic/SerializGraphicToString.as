package com.esrichina.tm.serializeGraphic
{
	import com.esri.ags.Graphic;
	import com.esri.ags.Map;
	import com.esri.ags.geometry.Extent;
	import com.esri.ags.geometry.Geometry;
	import com.esri.ags.geometry.MapPoint;
	import com.esri.ags.layers.GraphicsLayer;
	import com.esri.ags.symbol.SimpleLineSymbol;
	import com.esri.ags.symbol.Symbol;
	import com.esrichina.tm.geometry.CustomPolygon;
	import com.esrichina.tm.geometry.CustomPolyline;
	import com.esrichina.tm.geometry.GeometryFactory;
	import com.esrichina.tm.graphics.GraphicPool;
	import com.esrichina.tm.symbol.CustomFillSymbol;
	import com.esrichina.tm.symbol.CustomLineSymbol;
	import com.esrichina.tm.symbol.SymbolFactory;
	import com.esrichina.tm.utils.ASUtil;

	import flash.system.System;

	/**
	 *
	 * @author esri
	 * %time%
	 */
	public class SerializGraphicToString
	{

		/**
		 *这个函数很重要，是序列化要素的,把所有要素全部序列化成String形式的。
		 * @param glayer
		 * @return
		 *
		 */

		public static function SerializeGraphics(graphicsLayer:GraphicsLayer, map:Map):String
		{
			var xmlStr:String="<graphics>";
			//序列化地图范围
			var ext:Extent=map.extent;
			if (ext != null)
			{
				var xmin:Number=ext.xmin;
				var ymin:Number=ext.ymin;
				var xmax:Number=ext.xmax;
				var ymax:Number=ext.ymax;
				xmlStr+="<extent><xmin>" + xmin + "</xmin><ymin>" + ymin + "</ymin><xmax>" + xmax + "</xmax><ymax>" + ymax + "</ymax></extent>";
			}
			var n:Number=graphicsLayer.numGraphics;
			var color:uint=0xFF0000;
			var alpha:Number=0.8;
			var width:Number=3.0;
			var style:String="";
			var symbol:Symbol;
			var geom:Geometry;
			var g:Graphic;
			var pmappt:MapPoint;
			var rings:Array=[];
			for (var i:int=0; i < n; i++)
			{
				rings.splice(0);
				g=graphicsLayer.getChildAt(i) as Graphic;
				geom=g.geometry;
				if (geom is CustomPolygon)
				{
					rings=CustomPolygon(geom).ps;
					if (rings == null || rings.length == 0)
						continue;
					symbol=CustomFillSymbol(g.symbol);
					color=CustomFillSymbol(symbol).color;
					alpha=CustomFillSymbol(symbol).alpha;
					style=CustomFillSymbol(symbol).style;
					xmlStr+="<geometry>";
					xmlStr+="<geotype>" + "CustomPolygon" + "</geotype>";
					xmlStr+="<alpha>" + alpha + "</alpha>";
					xmlStr+="<color>" + color + "</color>";
					xmlStr+="<style>" + style + "</style>";
					xmlStr+="<width>" + width + "</width>";
					xmlStr+="<type>" + geom.type + "</type>";
					xmlStr+="<Array>";

					for (var h:int=0; h < rings.length; h++)
					{
						pmappt=rings[h] as MapPoint;
						xmlStr+="<MapPoint><x>" + pmappt.x.toString() + "</x>";
						xmlStr+="<y>" + pmappt.y.toString() + "</y></MapPoint>";
					}
					xmlStr+="</Array></geometry>";
					continue;
				}
				if (geom is CustomPolyline)
				{
					rings=CustomPolyline(geom).ps;
					if (rings == null || rings.length == 0)
						continue;
					symbol=SimpleLineSymbol(g.symbol);
					alpha=CustomLineSymbol(symbol).alpha;
					color=CustomLineSymbol(symbol).color;
					style=CustomLineSymbol(symbol).style;
					width=CustomLineSymbol(symbol).width;
					xmlStr+="<geometry>";
					xmlStr+="<geotype>" + "CustomPolyline" + "</geotype>";
					xmlStr+="<alpha>" + alpha + "</alpha>";
					xmlStr+="<color>" + color + "</color>";
					xmlStr+="<style>" + style + "</style>";
					xmlStr+="<width>" + width + "</width>";
					xmlStr+="<type>" + geom.type + "</type>";
					xmlStr+="<Array>"
					for (var j:int=0; j < rings.length; j++)
					{
						pmappt=rings[j] as MapPoint;
						xmlStr+="<MapPoint><x>" + pmappt.x + "</x>";
						xmlStr+="<y>" + pmappt.y + "</y></MapPoint>";
					}
					xmlStr+="</Array></geometry>";
					continue;
				}
			}
			xmlStr+="</graphics>";
			System.gc();
			//trace(xmlStr);
			return xmlStr;
		}

		/**
		 *反序列化graphicslayer，把一个字符串反序列化成一个GraphicsLayer
		 * @param xmlStr
		 *
		 */
		public static function deSerializeGraphics(xmlStr:String, graphicsLayer:GraphicsLayer, map:Map):void
		{
			if (xmlStr == "<graphic></graphic>")
				return;
			else
			{

				graphicsLayer.clear();
				//trace("fan" + xmlStr);
				var xml:XML=new XML(xmlStr);
				//下面是解析xml成graphic

				var list:XMLList=xml.elements();
				var alpha:Number=1.0;
				var color:uint=0xFF0000;
				var style:String="";
				var geom:Geometry;
				var fillsymbol:Symbol;
				var linesymbol:SimpleLineSymbol;

				for each (var element:XML in list)
				{
					if (element.name().toString()=="extent")
					{
						var xmin:Number=element.xmin;
						var ymin:Number=element.ymin;
						var xmax:Number=element.xmax;
						var ymax:Number=element.ymax;
						var ext:Extent=new Extent(xmin, ymin, xmax, ymax, map.spatialReference);
						map.extent=ext;
						continue;
					}
					var ps:Array=[];
					var symbols:Array=[];
					var ps_xmlist:XMLList;
					var g:Graphic=GraphicPool.getGraphic();
					if (element.alpha.toString() != null && element.color != null && element.style != null)
					{
						alpha=Number(element.alpha);
						color=uint(element.color);
						style=element.style;
					}
					if (XML(element.Array.toString()).elements() != null)
					{
						ps_xmlist=XML(element.Array.toString()).elements();
					}
					var geotype:String=element.geotype.toString();
					if (geotype != "CustomPolyline")
					{
						ps.push(element.type.toString());
						ps.push(map);
						for each (var rp:XML in ps_xmlist)
						{
							ps.push(map.toScreen(new MapPoint(rp.x, rp.y)));
						}
						//创建
						g.geometry=GeometryFactory.getInstance().createGeometry(ps);
						symbols.push(element.type.toString());
						g.symbol=SymbolFactory.getInstance().createSymbol(symbols);
						CustomFillSymbol(g.symbol).color=color;
						CustomFillSymbol(g.symbol).alpha=alpha;
						CustomFillSymbol(g.symbol).style=style;
						graphicsLayer.add(g);
					}
					if (geotype == "CustomPolyline")
					{
						var width:Number=Number(element.width);
						ps.push(element.type.toString());
						ps.push(map);
						for each (var pt:XML in ps_xmlist)
						{
							ps.push(ASUtil.changeMapPToScreen(new MapPoint(pt.x, pt.y), map));
						}
						g.geometry=GeometryFactory.getInstance().createGeometry(ps);
						symbols.push(element.type.toString());
						g.symbol=CustomLineSymbol(SymbolFactory.getInstance().createSymbol(symbols));
						CustomLineSymbol(g.symbol).color=color;
						CustomLineSymbol(g.symbol).alpha=alpha;
						CustomLineSymbol(g.symbol).width=width;
						graphicsLayer.add(g);
					}
				}
				/* 				trace("+++" + (CustomPolygon((graphicsLayer.getChildAt(0) as Graphic).geometry).ps)[0].x);
				 trace("+++" + (CustomPolygon((graphicsLayer.getChildAt(1) as Graphic).geometry).ps)[0].x); */
			}
		}

		/**
		 *
		 */
		public function SerializGraphicToString()
		{
		}
	}
}