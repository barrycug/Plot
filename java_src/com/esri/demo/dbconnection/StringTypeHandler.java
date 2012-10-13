package com.esri.demo.dbconnection;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;

import com.ibatis.sqlmap.client.extensions.ParameterSetter;
import com.ibatis.sqlmap.client.extensions.ResultGetter;
import com.ibatis.sqlmap.client.extensions.TypeHandlerCallback;

public class StringTypeHandler implements TypeHandlerCallback {

	public Object getResult(ResultGetter getter) throws SQLException {
		 // TODO Auto-generated method stub
		  String temp="";
		  try {
		   temp= new String(getter.getString().getBytes("GBK"),"iso8859-1");
		  } catch (UnsupportedEncodingException e) {
		   // TODO Auto-generated catch block
		  }
		  //System.out.println("Get:"+getter.getString());
		  return temp;
	}

	public void setParameter(ParameterSetter setter, Object value)
			throws SQLException {
		 // TODO Auto-generated method stub
		  String s= (String)value;
		  String temp="";
		  try {
		   temp = new String(s.getBytes(),"GBK");
		  } catch (UnsupportedEncodingException e) {
		   // TODO Auto-generated catch block
		   e.printStackTrace();
		  }
		  System.out.println("Set:"+temp);
		  setter.setString(s);
	}

	public Object valueOf(String arg0) {
		// TODO Auto-generated method stub
		return arg0;
	}

}
