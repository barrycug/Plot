package com.esrichina.tm.symbol
{
	import com.esri.ags.symbol.SimpleFillSymbol;

	public class CustomFillSymbol extends SimpleFillSymbol
	{
		private var _type:String;

		public function get type():String
		{
			return this._type;
		}

		public function set type(type:String):void
		{
			this._type=type;
		}

		public function CustomFillSymbol(type:String=null)
		{
			this._type=type;
			super();
		}
		/**
		 *图形是否可以编辑
		 */
		private var _iseditor:Boolean=false;

		public function get iseditor():Boolean
		{
			return _iseditor;
		}

		public function set iseditor(iseditor:Boolean):void
		{
			this._iseditor=iseditor;
		}
	}
}