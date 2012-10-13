package com.esri.demo.dbconnection;

import java.io.IOException;
import java.net.UnknownHostException;

import com.esri.arcgis.server.GISServerConnection;
import com.esri.arcgis.server.IGISServerConnection;
import com.esri.arcgis.server.IServerContext;
import com.esri.arcgis.server.IServerObjectAdmin4;
import com.esri.arcgis.server.IServerObjectManager;
import com.esri.arcgis.server.ServerConnection;
import com.esri.arcgis.server.ServerContext;
import com.esri.arcgis.system.ServerInitializer;


//这个类的主要用途是连接gis server,并远程调用ao组件
public class ConnectGISServer {
	//参数提供:gis server的ip,mapServer服务名,
	public static IServerContext getcontext(String ip,String username,String userpwd,String mapname,String servicename) {
               IServerContext servercontext=null;
            try {
            	new ServerInitializer().initializeServer("dgsfgis","admin","admin");
				ServerConnection serverconn=new ServerConnection();
				serverconn.connect("dgsfgis");
				IServerObjectManager som=(IServerObjectManager)serverconn.getServerObjectManager();
			   servercontext=(IServerContext)som.createServerContext(servicename,"MapServer");
			   return servercontext;
			} catch (UnknownHostException e) {
				
				e.printStackTrace();
				return null;
			} catch (IOException e) {
			
				e.printStackTrace();
				return null;
			}
            
               
	}
}
