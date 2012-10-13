package com.esrichina.tm.register
{
	/**
	 *这个主要是进行注册时密码验证。
	 */
	import mx.validators.ValidationResult;
	import mx.validators.Validator;

	public class PassWordValidator extends Validator
	{
		public function PassWordValidator()
		{
			super();
		}
		// Define Array for the return value of doValidation().
		private var results:Array;
		private var password:String;

		// 设置要比较的密码
		public function set Password(s:String):void
		{
			password=s;
		}

		override protected function doValidation(value:Object):Array
		{
			// Convert value to a Number.
			var inputValue:String=String(value);
			results=[];
			results=super.doValidation(value);
			if (results.length > 0)
				return results;
			if (inputValue == "" || !value)
			{
				results.push(new ValidationResult(true, null, "NaN", "你必须输入第二密码."));
				return results;
			}
			//如果少于12位
			if ((inputValue.length) > 12)
			{
				results.push(new ValidationResult(true, null, "太长了", "帐号要小于十二位."));
				return results;
			}
			if (inputValue != password)
			{
				results.push(new ValidationResult(true, null, "输入错误", "与第一次输入不相符"));
				return results;
			}
			return results;

		}
	}
}