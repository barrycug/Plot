package com.esrichina.tm.graphics
{
	import com.esri.ags.Graphic;
	
	import mx.collections.ArrayCollection;


	public class GraphicPool
	{
		public function GraphicPool()
		{
		}

		private static var cache:ArrayCollection;
		private static const preCache:int=100;

		public static function getGraphic():Graphic
		{
			var graphic:Graphic;

			if (cache == null)
			{
				cache=new ArrayCollection();

				for (var x:Number=0; x < preCache; x++)
				{
					graphic=new Graphic();
					cache.addItem(graphic);
				}
			}

			if (cache.length <= 0)
				graphic=new Graphic();
			else
				graphic=cache.removeItemAt(0) as Graphic;
			return graphic;
		}

		public static function setGraphic(graphic:Graphic):void
		{
			cache.addItem(graphic);
		}

	}
}