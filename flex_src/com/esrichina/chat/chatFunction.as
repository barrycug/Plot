import flash.events.ContextMenuEvent;
import flash.events.TimerEvent;
import flash.ui.ContextMenu;
import flash.ui.ContextMenuItem;
import flash.utils.Timer;
import flash.utils.setTimeout;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.core.UITextField;
import mx.effects.easing.*;
import mx.messaging.ChannelSet;
import mx.messaging.channels.AMFChannel;
import mx.messaging.channels.StreamingAMFChannel;
import mx.messaging.events.MessageFaultEvent;
import mx.messaging.messages.AsyncMessage;
import mx.messaging.messages.IMessage;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
//聊天框的是否显示
[Bindable]
private var showCanves:Boolean=false;
[Bindable]
private var ulist:ArrayCollection=new ArrayCollection();
private var timer:Timer=new Timer(10000);
private var itemContextMenu:ContextMenuItem;
public var itemTextFiled:UITextField;

/**
 *控制聊天框,实现其特效
 *
 */
private function showCanvas():void
{
	if (cooperateMove.isPlaying)
		cooperateMove.end();
	if (!showCanves)
	{
		chatButton.styleName="btxxt";
		cooperateMove.duration=1000;
		cooperateMove.xTo=this.x - chatCanvas.width;
		cooperateMove.play();
	}
	if (showCanves)
	{
		chatButton.styleName="btxxt1";
		cooperateMove.duration=1000;
		cooperateMove.xTo=this.x + chatCanvas.width;
		cooperateMove.play();
	}
	showCanves=!showCanves;
}

/**
 *其他客户端接受传过来的信息
 * @param message
 *
 */
private function messageHandler(message:IMessage):void
{
	if (message.body.chatMessage != null)
	{
		var chatcontent:String=message.body.chatMessage.toString();
		acceptplotcontent.editable=true;
		var str:String=main.so.data.username + ":" + "\n" + "       " + chatcontent + "\n";
		acceptplotcontent.text+=str;
		setTimeout(function():void
			{
				acceptplotcontent.verticalScrollPosition=acceptplotcontent.maxVerticalScrollPosition
			}, 2000);
		acceptplotcontent.editable=false;
	}
}

/**
 *生产者发送消息
 *
 */
private function sendcontent():void
{
	if ("" != sendplotcontent.text)
	{
		var message:IMessage=new AsyncMessage();
		message.body.chatMessage=sendplotcontent.text;
		producer.send(message);
		sendplotcontent.text="";
	}
}

/**
 *消除内容框的内容
 *
 */
private function cancelcontent():void
{
	sendplotcontent.text="";
}

/**
 *实现Enter事件的方法,
 * @param event
 *
 */
private function send(event:KeyboardEvent):void
{
	if (event.keyCode == 13)
	{
		sendcontent();
	}
}

/**
 *展示错误信息
 * @param event
 *
 */
private function showfault(event:MessageFaultEvent):void
{
	Alert.show(event.message.toString(), "dd");
}

/**
 *消息传递实现聊天对跨框
 *
 */
private function subscribe():void
{
	var myStreamingAMF:AMFChannel=new StreamingAMFChannel("my-streaming-amf", "messagebroker/streamingamf");
	var myPollingAMF:AMFChannel=new AMFChannel("my-polling-amf", "messagebroker/amfpolling");
	myPollingAMF.pollingEnabled=true;
	myPollingAMF.pollingInterval=2000;
	var channelSet:ChannelSet=new ChannelSet();
	channelSet.addChannel(myStreamingAMF);
	channelSet.addChannel(myPollingAMF);
	consumer.channelSet=channelSet;
	producer.channelSet=channelSet;
	producer.destination="chat";
	consumer.destination="chat";
	//consumer.subscribe();
	//向后台发送请求请求列表
	//timer.addEventListener(TimerEvent.TIMER, sendToDB, false, 0, true);
	//timer.start();
}

/**
 *请求在线用户数
 * @param event
 *
 */
private function sendToDB(event:TimerEvent):void
{
	requestUsers.getUsers();
}

/**
 *得到错误信息
 * @param event
 *
 */
private function getFault(event:FaultEvent):void
{
	Alert.show(event.message.toString(), "ERROR TIP");
}

/**
 *返回用户列表
 * @param event
 *
 */
private function backUser(event:ResultEvent):void
{
	var us_lt:ArrayCollection=event.result as ArrayCollection;
	var n:int=us_lt.length;
	if (us_lt != null && n > 0)
	{
		ulist=us_lt;
	}
}

/**
 * 如果具有limits权利则赋予权限的权利
 *
 */

public function addRightEvent():void
{
	if (main.so.data.limits == "admin")
	{
		var contextMenu:ContextMenu=new ContextMenu();
		contextMenu.hideBuiltInItems();
		itemContextMenu=new ContextMenuItem("赋予权限");
		contextMenu.customItems.push(itemContextMenu);
		itemContextMenu.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, endrow, false, 0, true);
		users.contextMenu=contextMenu;
	}
}

/**
 *赋予别人权利以后自己要发生变化，消失权利
 * @param event
 *
 */
private function endrow(event:ContextMenuEvent):void
{
	itemTextFiled=event.mouseTarget as UITextField;

	if (itemTextFiled != null)
	{
		var endrowuser:String=itemTextFiled.text.toString();
		requestUsers.changeLimits(endrowuser);
		main.so.data.limits="guest";
		main.so.flush();
	}
	itemContextMenu.removeEventListener(ContextMenuEvent.MENU_ITEM_SELECT, endrow);
}

/**
 *更改权限后返回,显示是否更改权利成功
 * @param event
 *
 */
private function backStatus(event:ResultEvent):void
{
	var status:Boolean=event.result as Boolean;
	if (status == true)
	{
		//Alert.show("权限更改成功", "INFO TIP");
		//动态生成菜单...实现页面的刷新
		//ExternalInterface.call("eval", "location.reload();");
		var requestURL:URLRequest=new URLRequest();
		requestURL.url="Main.html";
		navigateToURL(requestURL, "_self");

	}
	else
		Alert.show("权限未改成功!", "INFO TIP");
}