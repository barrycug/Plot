package com.esrichina.tm.login
{

	[Bindable]
	[RemoteClass(alias="com.esri.user.login.User")]
	public class User extends Object
	{
		public function User()
		{
			super();
		}
		private var _user:String;
		private var _limits:String;

		public function get user():String
		{
			return this._user;
		}

		public function set user(user:String):void
		{
			this._user=user;
		}

		public function get limits():String
		{
			return this._limits;
		}

		public function set limits(limits:String):void
		{
			this._limits=limits;
		}
	}
}