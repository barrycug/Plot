package com.esri.user.login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.esri.demo.dbconnection.ConnectDATABASE;

public class GetUsers {

	public List<User> getUsers() {

		Connection conn = null;
		List<User> users = new ArrayList<User>();
		try {
			// 首先判断是否有以前的方案
			conn = ConnectDATABASE.getConnection();
			// 请求数据库，查看是否有用户名和密码
			String isuser = "select username,limits from userLog where islogin=1";

			PreparedStatement selectpps = conn.prepareStatement(isuser);
			ResultSet sets = selectpps.executeQuery();
			while (sets.next()) {
				User user=new User();
				user.setUser(sets.getString(1));
				user.setLimits(sets.getString(2));
				users.add(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return users;
	}

	public Boolean changeLimits(String username) {
		Boolean flag = false;
		Connection conn = null;
		try {
			// 首先判断是否有以前的方案
			conn = ConnectDATABASE.getConnection();
			// 请求数据库，查看是否有用户名和密码
			String updateuser = "update  userLog set limits=? where limits=?";
			String updateuser2 = "update userlog set limits=? where username=?";
			PreparedStatement updatepps = conn.prepareStatement(updateuser);
			PreparedStatement updatepps2 = conn.prepareStatement(updateuser2);
			updatepps.setString(1,"guest");
			updatepps.setString(2,"admin");
			updatepps2.setString(1,"admin");
			updatepps2.setString(2, username);
			int i = updatepps.executeUpdate();
			int j = updatepps2.executeUpdate();
			if (i > 0 && j > 0) {
				flag = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return flag;
	}
}
