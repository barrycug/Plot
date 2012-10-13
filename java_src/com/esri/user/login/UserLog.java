package com.esri.user.login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.esri.demo.dbconnection.ConnectDATABASE;

public class UserLog {
	// 用户登录
	public String LogIn(String username, String password) {
		String flag = "";
		if ("".equalsIgnoreCase(username) || username == null) {
			flag = "您的用户名和密码不正确，请重新输入！！";
			return flag;
		}
		Connection conn = null;
		String limits = null;
		try {
			// 首先判断是否有以前的方案
			conn = ConnectDATABASE.getConnection();
			// 检查一下是否登录
			String islogin = "select islogin from userlog where username=? and password=?";
			PreparedStatement loginpps = conn.prepareStatement(islogin);
			loginpps.setString(1, username);
			loginpps.setString(2, password);
			ResultSet usersets = loginpps.executeQuery();
			if (usersets.next()) {
				if (usersets.getDouble(1) == 1) {
					flag = "这个用户已登录，请更换用户！";
					return flag;
				}
			}
			// 请求数据库，查看是否有用户名和密码
			String isuser = "select limits from userLog where username=? and password=?";

			PreparedStatement selectpps = conn.prepareStatement(isuser);
			System.out.println(username);
			selectpps.setString(1, username);
			selectpps.setString(2, password);
			ResultSet sets = selectpps.executeQuery();

			while (sets.next()) {
				limits = sets.getString(1);
				// 更新它的登录状态，
				String update = "update userlog set islogin=1 where username=? and password=?";
				PreparedStatement pps = conn.prepareStatement(update);
				pps.setString(1, username);
				pps.setString(2, password);
				pps.executeUpdate();
			}
			flag = username + "-" + limits;
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

	// 用户退出，
	public Boolean logOut(String username) {
		Boolean flag = false;
		if ("".equalsIgnoreCase(username) || username == null) {
			return flag;
		}
		Connection conn = null;
		try {
			// 首先判断是否有以前的方案
			conn = ConnectDATABASE.getConnection();
			String updatesql = "update userlog set islogin=0 where username=?";
			PreparedStatement pps = conn.prepareStatement(updatesql);
			pps.setString(1, username);
			pps.executeUpdate();
			flag = true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return flag;
	}

	// 用户注册
	public String registerUser(String user, String pwd, String email) {
		String flag = "";
		if ("".equalsIgnoreCase(user) || "".equalsIgnoreCase(pwd)
				|| "".equalsIgnoreCase(email))
			return "您的用户名和密码或邮箱为空";
		Connection conn = null;
		try {
			conn = ConnectDATABASE.getConnection();
			String insertsql = "insert into userlog (username,password,email) values (?,?,?)";
			PreparedStatement rpps = conn.prepareStatement(insertsql);
			rpps.setString(1, user);
			rpps.setString(2, pwd);
			rpps.setString(3, email);
			int i = rpps.executeUpdate();
			if (i > 0)
				flag = "sucessed";
		} catch (SQLException e) {
			flag = e.getMessage();
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
