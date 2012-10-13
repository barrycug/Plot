package com.esrichina.tm.event
{
	import flash.events.Event;
	public class PlotDrawEvent extends Event
	{
		public static const PLOT_DRAW_END:String = "PlotDrawEnd";
	 	public static const PLOT_DRAW_START:String = "PlotDrawStart";
		public function PlotDrawEvent(type:String,data:Object=null)
		{
			if (data != null) _data = data;
			super(type, false, false);
		}

	    private var _data:Object;
		public function get data():Object
		{
			return _data;
		}
		public function set data(data:Object):void
		{
			_data = data;
		}
	}
}