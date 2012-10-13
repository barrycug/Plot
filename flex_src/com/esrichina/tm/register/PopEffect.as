package com.esrichina.tm.register
{
	import flash.display.DisplayObject;
	
	import mx.core.IFlexDisplayObject;
	import mx.effects.Iris;
	import mx.events.TweenEvent;
	import mx.managers.PopUpManager;
	

	public class PopEffect
	{
		public function PopEffect()
		{
		}

		public static function Show(control:IFlexDisplayObject, parent:DisplayObject, modal:Boolean=true):void
		{
			var mShowEffect:Iris=new Iris();
			mShowEffect.target=control;
			mShowEffect.duration=1000;
			mShowEffect.showTarget=true;
			PopUpManager.addPopUp(control, parent, modal);
			PopUpManager.centerPopUp(control);
			mShowEffect.play();
		}

		public static function Hide(control:IFlexDisplayObject):void
		{

			var mHideEffect:Iris=new Iris();
			mHideEffect.duration=1000;
			mHideEffect.showTarget=false;
			mHideEffect.addEventListener(TweenEvent.TWEEN_END, function():void
				{
					PopUpManager.removePopUp(control);
				});
			mHideEffect.duration=1000;
			mHideEffect.target=control;
			mHideEffect.play();
		}

	}
}