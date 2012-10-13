// ActionScript file
import flash.net.SharedObject;
import flash.net.URLRequest;
import flash.net.navigateToURL;

import mx.controls.Alert;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;



private function NavigateURL(event:ResultEvent):void
{
	var backstr:String=event.result.toString();
	if (backstr == "您的用户名和密码不正确，请重新输入！！")
	{
		Alert.show("您输入的用户名和密码有误！！", "Log IN TIP");
		return;
	}
	if(backstr=="这个用户已登录，请更换用户！"){
	  Alert.show(backstr,"Log IN TIP");
	  return ;
	}
	var strs:Array=backstr.split("-");
	if(strs.length!=2){
	Alert.show("登录错误！","Log IN TIP");
	}
	var username:String=strs[0] as String;
	var limits:String=strs[1] as String;
	var so:SharedObject=SharedObject.getLocal("user", "/");
	so.data.username=username;
	so.data.limits=limits;
	so.flush();
	var requestURL:URLRequest=new URLRequest();
	requestURL.url="Main.html";
	navigateToURL(requestURL,"_self");
}

private function BackError(event:FaultEvent):void
{
	Alert.show(event.message.toString(), "Error TIP");
}


