package remoting;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;

import com.esri.demo.dbconnection.ConnectDATABASE;

/*
 * 这个类的主要作用就是把flex传过来的codes去查询数据库，然后得到结果，通过jsp传过去
 * 
 */
public class GetYL {
	public String getValues(String codes, String date) {
		if(codes.trim().equalsIgnoreCase("")){
		return "";
		}
		
	     String[]	codesarr=codes.trim().split(" ");
	     System.out.println(codes);
		String values = "";
		// 得到数据库连接并查询数据库得到结果

		try {
			Connection conn = ConnectDATABASE.getConnection();
			String sql = "select DRP from st_pptn_R where TM>to_date(?,'YYYY-MM-DD hh24') and stcd=? ";
			PreparedStatement pps = conn.prepareStatement(sql);
            ResultSet sets=null;
            double value=0.0;
            if(codesarr.length>0){
			for (int i = 0; i < codesarr.length; i++) {
				String code = codesarr[i];
				pps.setString(1, date);
				pps.setString(2, code);
				sets=pps.executeQuery();
				while(sets.next()){
					value+=sets.getDouble(1);
				}
				//下面是高定数据类型的
				DecimalFormat df = new DecimalFormat("#.##");
		
			    values+=code+"-"+df.format(value)+",";

			}
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}

		return values;
	}
}
