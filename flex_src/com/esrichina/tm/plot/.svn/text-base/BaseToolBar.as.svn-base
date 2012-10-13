package com.esrichina.tm.plot
{
	import com.esri.ags.Map;
	import com.esri.ags.layers.GraphicsLayer;
	import com.esri.ags.layers.Layer;
	
	import flash.events.EventDispatcher;

	public class BaseToolBar extends EventDispatcher
	{
		private var _mapNavState:Object;
        private var _map:Map;
		public function BaseToolBar(map:Map)
		{
			super(null);
			_map = map;
		}
		public function set map(map:Map):void
		{
			_map = map;
		}
		public function get map():Map
		{
			return _map;
		}
		  protected function deactivateMapTools(mapNavigationEnabled:Boolean, zoomSliderVisible:Boolean, panArrowsVisible:Boolean, isSetGraphicsLayersMouseChildren:Boolean) : void
        {
			if (!_map)
            {
                return;
            }
            if (mapNavigationEnabled)
            {
                _mapNavState = {isDoubleClickZoom:map.doubleClickZoomEnabled, isClickRecenter:map.clickRecenterEnabled, isPan:map.panEnabled, isRubberbandZoom:map.rubberbandZoomEnabled, isKeyboardNavigation:map.keyboardNavigationEnabled, isScrollWheelZoom:map.scrollWheelZoomEnabled};
                map.mapNavigationEnabled = false;
            }// end if
            if (zoomSliderVisible)
            {
                map.zoomSliderVisible = false;
            }// end if
            if (panArrowsVisible)
            {
                map.panArrowsVisible = false;
                map.panEnabled=false;
            }// end if
            if (isSetGraphicsLayersMouseChildren)
            {
  //              setGraphicsLayersMouseChildren(false);
            }// end if
            return;
        }// end function

        private function setGraphicsLayersMouseChildren(enable:Boolean) : void
        {
            if (!_map)
            {
            	return;
            }
            if (_map.layers)
            {
                for each(var tLayer:Layer in _map.layers)
                {
                   
                    if (tLayer is GraphicsLayer)
                    {
                        tLayer.mouseChildren=enable;
                    }
                }
            }
            return;
        }

        protected function activateMapTools(mapNavigationEnabled:Boolean, zoomSliderVisible:Boolean, panArrowsVisible:Boolean, isSetGraphicsLayersMouseChildren:Boolean) : void
        {
			if (!_map)
            {
                return;
            }// end if
            if (mapNavigationEnabled)
            {
	            if (_mapNavState)
	            {
	                if (_mapNavState.isDoubleClickZoom)
	                {
	                    map.doubleClickZoomEnabled = true;
	                }// end if
	                if (_mapNavState.isClickRecenter)
	                {
	                    map.clickRecenterEnabled = true;
	                }// end if
	                if (_mapNavState.isPan)
	                {
	                    map.panEnabled = true;
	                }// end if
	                if (_mapNavState.isRubberbandZoom)
	                {
	                    map.rubberbandZoomEnabled = true;
	                }// end if
	                if (_mapNavState.isKeyboardNavigation)
	                {
	                    map.keyboardNavigationEnabled = true;
	                }// end if
	                if (_mapNavState.isScrollWheelZoom)
	                {
	                    map.scrollWheelZoomEnabled = true;
	                }// end if
	            }// end if
	        }
            if (zoomSliderVisible)
            {
                map.zoomSliderVisible = true;
            }// end if
            if (panArrowsVisible)
            {
                map.panArrowsVisible = true;
            }// end if
//            if (isSetGraphicsLayersMouseChildren)
//            {
//                setGraphicsLayersMouseChildren(true);
//            }// end if
            return;
        }// end function		
	}
}