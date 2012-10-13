package com.esrichina.tm.register
{
	import mx.validators.EmailValidator;
	import mx.validators.ValidationResult;

	public class EsriEmailValidator extends EmailValidator
	{
		public function EsriEmailValidator()
		{
			super();
		}
		private var results:Array;

		override protected function doValidation(value:Object):Array
		{
			var input:String=String(value);
			results=super.doValidation(value);
			if (results.length > 0)
				return results;
			var istr:Array=input.split("@");

			if (istr[1] != "esrichina-bj.cn")
			{
				results.push(new ValidationResult(true, null, "格式不对", "您必须用公司提供邮箱进行注册!"));
			}
			return results;
		}
	}
}