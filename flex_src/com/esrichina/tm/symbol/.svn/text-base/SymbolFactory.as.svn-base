package com.esrichina.tm.symbol
{
	import com.esri.ags.symbol.Symbol;
	
	import mx.controls.Alert;

	/**
	 *这个主要的是实现创建符号的工厂
	 * @author esri
	 *
	 */
	public class SymbolFactory
	{
		include "../plot/DrawType.as";
		private static var instance:SymbolFactory;

		public function SymbolFactory()
		{
			if (instance != null)
			{
				Alert.show("仅仅需要一个实例，不能通过new创建！！", "ERROR TIP！");
			}
		}

		public static function getInstance():SymbolFactory
		{
			if (instance == null)
			{
				instance=new SymbolFactory();
			}
			return instance;
		}

		public function createSymbol(args:Array):Symbol
		{
			if (args == null)
				return null;
			var symbol:Symbol;
			var symbol_Type:String=args[0];
			switch (symbol_Type)
			{
				case CIRCLE:
				{
					symbol=new CircleSymbol(symbol_Type);
					break;
				}
				case BASE:
				{
					symbol=new BaseSymbol(symbol_Type);
					break;
				}
				case MOON:
				{
					symbol=new MoonSymbol(symbol_Type);
					break;
				}
				case HALVE:
				{
					symbol=new HalveSymbol(symbol_Type);
					break;
				}
				case HALVE1:
				{
					symbol=new Halve1Symbol(symbol_Type);
					break;
				}
				case ELLIPSE:
				{
					symbol=new EllipseSymbol(symbol_Type);
					break;
				}
				case RECTANGLE:
				{
					symbol=new RectangleSymbol(symbol_Type);
					break;
				}
				case ARC:
				{
					symbol=new ArcSymbol(symbol_Type);
					break;
				}
				case LSARROW:
				{
					symbol=new LsarrowSymbol(symbol_Type);
					break;
				}
				case SARROW:
				{
					symbol=new SarrowSymbol(symbol_Type);
					break;
				}
				case EQUALSARROW:
				{
					symbol=new EqualSarrowSymbol(symbol_Type);
					break;
				}
				case DOUBLESARROW:
				{
					symbol=new DoubleSarrowSymbol(symbol_Type);
					break;
				}
				case XARROWS:
				{
					symbol=new XarrowsSymbol(symbol_Type);
					break;
				}
				case TAILSARROW:{
				    symbol=new TailSarrowSymbol(symbol_Type);
				    break;
				}
				case TRIANGLEFLAG:
				{
					symbol=new TriangleFlagSymbol(symbol_Type);
					break;
				}
				case RECTFLAG:
				{
					symbol=new RectFlagSymbol(symbol_Type);
					break;
				}
				case CURVEFLAG:
				{
					symbol=new CurveFlagSymbol(symbol_Type);
					break;
				}
			}
			return symbol;
		}

	}
}