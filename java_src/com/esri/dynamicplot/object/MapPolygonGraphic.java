package com.esri.dynamicplot.object;

import java.io.Serializable;

/*
 * 这个对应前台的点的MapPolylineGraphic，
 * 要和后台形成一一对应的对象关系：他包含的属性有：points:含有点的，rings:含有rings的，alpha：透明度，color：颜色，style:样式，width；宽度
 * @author:张德品
 * @Time:2009-12-17
 */
public class MapPolygonGraphic implements Serializable {
	public MapPoint points[];
	public Object rings[];
	public Number alpha;
	public Number color;
	public String style;
	public Number width;

	public MapPoint[] getPoints() {
		return points;
	}

	public void setPoints(MapPoint[] points) {
		this.points = points;
	}

	public Object[] getRings() {
		return rings;
	}

	public void setRings(Object[] rings) {
		this.rings = rings;
	}

	public Number getAlpha() {
		return alpha;
	}

	public void setAlpha(Number alpha) {
		this.alpha = alpha;
	}

	public Number getColor() {
		return color;
	}

	public void setColor(Number color) {
		this.color = color;
	}

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public Number getWidth() {
		return width;
	}

	public void setWidth(Number width) {
		this.width = width;
	}
}
