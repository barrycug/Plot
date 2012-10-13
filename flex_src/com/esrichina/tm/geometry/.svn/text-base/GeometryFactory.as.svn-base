package com.esrichina.tm.geometry
{
	import com.esri.ags.Map;
	import com.esri.ags.geometry.Geometry;

	import mx.controls.Alert;

	public class GeometryFactory
	{
		include "../plot/DrawType.as";
		private static var instance:GeometryFactory;

		public function GeometryFactory()
		{
			if (instance != null)
			{
				Alert.show("仅仅需要一个实例，不能通过new创建！！", "ERROR TIP！");
			}
		}

		public static function getInstance():GeometryFactory
		{
			if (instance == null)
			{
				instance=new GeometryFactory();
			}
			return instance;
		}

		public function createGeometry(args:Array):Geometry
		{
			if (args == null || args.length == 0)
			{
				Alert.show("不能创建Geometry", "友情提示！");
				return null;
			}
			var geometry:Geometry;
			var geometry_Type:String=args[0];
			var map:Map=args[1];
			args.splice(0, 2);
			switch (geometry_Type)
			{
				case TRIANGLEFLAG:
				{
					geometry=new TriangleFlag(args, map);
					break;
				}
				case RECTFLAG:
				{
					geometry=new RectFlag(args, map);
					break;
				}
				case CURVEFLAG:
				{
					geometry=new CurveFlag(args, map);
					break;
				}
				case CIRCLE:
				{
					geometry=new Circle(args, map);
					break;
				}
				case HALVE:
				{
					geometry=new Halve(args, map);
					break;
				}
				case BASE:
				{
					geometry=new Base(args, map);
					break;
				}
				case MOON:
				{
					geometry=new Moon(args, map);
					break;
				}
				case HALVE1:
				{
					geometry=new Halve1(args, map);
					break;
				}
				case ELLIPSE:
				{
					geometry=new Ellipse(args, map);
					break;
				}
				case RECTANGLE:
				{
					geometry=new Rectangle(args, map);
					break;
				}
				case ARC:
				{
					geometry=new Arc(args, map);
					break;
				}

				case SARROW:
				{
					geometry=new Sarrow(args, map);
					break;
				}
				case DOUBLESARROW:
				{
					geometry=new DoubleSarrow(args, map);
					break;
				}
				case EQUALSARROW:
				{
					geometry=new EqualSarrow(args, map);
					break;
				}
				case TAILSARROW:
				{
					geometry=new TailSarrow(args, map);
					break;
				}
				case LSARROW:
				{
					geometry=new Lsarrow(args, map);
					break;
				}
				case XARROWS:
				{
					geometry=new Xarrows(args, map);
					break;
				}
			}
			return geometry;
		}

	}
}
