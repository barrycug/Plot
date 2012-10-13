package com.esrichina.tm.graphics
{
	import com.esri.ags.Graphic;
	import com.esri.ags.Map;

	import mx.controls.Alert;

	public class GraphicFactory
	{
		include "../plot/DrawType.as";
		private static var instance:GraphicFactory;

		public static function getInstance():GraphicFactory
		{
			if (instance == null)
			{
				instance=new GraphicFactory();
			}
			return instance;
		}

		public function GraphicFactory()
		{
			if (instance != null)
			{
				Alert.show("仅仅需要一个实例，不能通过new创建！！", "ERROR TIP！");
			}
		}
		public static var g:BaseGraphic;

		public function createGraphic(args:Array):Graphic
		{
			if (args == null)
				return null;
			var graphic_type:String=args[0];
			var map:Map=args[1] as Map;
			switch (graphic_type)
			{
				case CIRCLE:
				case BASE:
				case MOON:
				case HALVE:
				case HALVE1:
				case ELLIPSE:
				case RECTANGLE:
				case CURVEFLAG:
				case RECTFLAG:
				case TRIANGLEFLAG:
				{
					g=new CircleBaseGraphic(map, graphic_type);
					break;
				}
				case ARC:
				case EQUALSARROW:
				case LSARROW:
				case XARROWS:
				case SARROW:
				case TAILSARROW:
				case DOUBLESARROW:
				{
					g=new SarrowGraphic(map, graphic_type);
					break;
				}
			}
			return g;
		}

		public function deactivate():void
		{
			if (g != null)
				g.deactivate();
		}
	}
}