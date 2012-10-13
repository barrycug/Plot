package com.esri.dynamicplot.object;

import java.io.Serializable;

/*
 * 单纯的点对象。
 */
public class MapPoint implements Serializable {
	public Number x;
	public Number y;

	public Number getX() {
		return x;
	}

	public void setX(Number x) {
		this.x = x;
	}

	public Number getY() {
		return y;
	}

	public void setY(Number y) {
		this.y = y;
	}

}
