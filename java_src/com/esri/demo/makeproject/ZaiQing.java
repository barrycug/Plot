package com.esri.demo.makeproject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.esri.demo.dbconnection.ConnectDATABASE;
import com.esri.dynamicplot.object.GXQUP;

/*
 * @这个类主要是处理灾情的业务逻辑的.
 */
public class ZaiQing {
/*
 * @得到灾情的信息
 * 
 */
	public List<GXQUP> getzqInfo(String sttime,String endtime){
		List<GXQUP> gxoups=new ArrayList<GXQUP>();
		if("".equalsIgnoreCase(sttime)||"".equalsIgnoreCase(endtime)){
			return null;
		}
		Connection conn=null;
		try {
			// 首先判断是否有以前的方案
			 conn = ConnectDATABASE.getConnection();
			 String selectsql = "select cxdd,gcmc,xqms,jd,wd from ZKR_GXQUPLOADINFO where tbsj between to_date(?,'YYYY-MM-DD') and to_date(?,'YYYY-MM-DD')";
			 PreparedStatement pps=conn.prepareStatement(selectsql);
			 pps.setString(1,sttime);
			 pps.setString(2, endtime);
			ResultSet sets=pps.executeQuery();
			while(sets.next()){
				GXQUP gxoup=new GXQUP();
				gxoup.setCxdd(sets.getString(1));
				gxoup.setGcmc(sets.getString(2));
				gxoup.setXqms(sets.getString(3));
				gxoup.setJd(sets.getDouble(4));
				gxoup.setWd(sets.getDouble(5));
				gxoups.add(gxoup);
			} 
		}catch(Exception e){	
			e.printStackTrace();
		}
		finally{
			try {
				conn.close();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		}
		return gxoups;
	}
}
