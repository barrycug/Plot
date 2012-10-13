package com.esri.plotdemo.interaction;

/*
 * 这个类主要是保存前台发送过来的消息的，把他们存储的数据库中去
 */
import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.esri.demo.dbconnection.ConnectDATABASE;

public class DynamicPlot {

	public String sendToDB(String xmlstr, String project, String username)
			throws UnsupportedEncodingException {
		// 存放到数据库中,
		if ("".equalsIgnoreCase(xmlstr.trim()) || "".equalsIgnoreCase(project)
				|| "".equalsIgnoreCase(username)) {
			return null;
		}
		System.out.println(xmlstr);
		Connection conn = null;
		try {
			// 首先判断是否有以前的方案
			conn = ConnectDATABASE.getConnection();
			// String selctsql="select projectname from esri_graphic where
			// projectname";
			// 执行删除操作
			conn.setAutoCommit(true);
			String detesql = "delete from  esri_graphic where projectname=?";
			PreparedStatement depps = conn.prepareStatement(detesql);
//			project = new String(project.getBytes(),"GBK");
//			System.out.println(Charset.defaultCharset().name());
//			System.out.println(project);
			depps.setString(1, project);
			depps.executeUpdate();
			// 插入新的数据
			String insertsql = "insert into esri_graphic (xmlblob,projectname,username) values(?,?,?)";
			PreparedStatement insertpps = conn.prepareStatement(insertsql);
			ByteArrayInputStream bainput = getBlob(xmlstr);
			insertpps.setBinaryStream(1, bainput, bainput.available());
			insertpps.setString(2, project);
			insertpps.setString(3, username);
			insertpps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {

				e.printStackTrace();
			}
		}
		return project + "," + username;

	}

	// 字符串转化成二进制
	public ByteArrayInputStream getBlob(String xmlStr) {
		ByteArrayInputStream bainput = new ByteArrayInputStream(xmlStr
				.getBytes());
		return bainput;
	}

	/*
	 * 这个函数的主要作用就是取得数据库中所有的方案名称
	 * 
	 */
	public List<HashMap<String, String>> getProjects() {
		List<HashMap<String, String>> projects = new ArrayList<HashMap<String, String>>();
		Connection conn = null;
		try {
			// 首先判断是否有以前的方案
			conn = ConnectDATABASE.getConnection();
			String sql = "select projectname,username from esri_graphic";
			PreparedStatement pps = conn.prepareStatement(sql);
			ResultSet set = null;
			set = pps.executeQuery();
			while (set.next()) {
				HashMap<String, String> hm = new HashMap<String, String>();
				hm.put("project", set.getString(1));
				hm.put("username", set.getString(2));
				projects.add(hm);
			}
		} catch (SQLException e) {
			// 处理异常
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				// 处理异常块。
				e.printStackTrace();
			}
		}
		return projects;
	}

	/*
	 * 这个函数的主要的作用就是从数据库中得到这个方案的二进制并转化成String传到flex端
	 */
	public String getGraphicFeature(String project) {
		System.out.println("把方案名称已经传到了java端，他的名字是:" + project);
		Connection conn = null;
		String gstr = "";
		try {
			conn = ConnectDATABASE.getConnection();
			String sql = "select xmlblob from esri_graphic where projectname='"
					+ project + "'";
			PreparedStatement pps = conn.prepareStatement(sql);
			ResultSet set = null;
			set = pps.executeQuery();

			while (set.next()) {
				// 用二进制流去接，然后转化成字符串，
				byte[] gbyte = blobToString(set.getBlob(1));
				gstr = new String(gbyte);

			}
		} catch (SQLException e) {
			// 处理异常
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				// 处理异常块。
				e.printStackTrace();
			}
		}
		return gstr;
	}

	/*
	 * @把blob转化成byte[]类型
	 */
	public static byte[] blobToString(Blob blob) {
		BufferedInputStream is = null;
		try {
			is = new BufferedInputStream(blob.getBinaryStream());
			byte[] bytes = new byte[(int) blob.length()];
			int len = bytes.length;
			int offset = 0;
			int read = 0;
			while (offset < len
					&& (read = is.read(bytes, offset, len - offset)) >= 0) {
				offset += read;
			}
			return bytes;
		} catch (Exception e) {
			return null;
		} finally {
			try {
				is.close();
				is = null;
			} catch (IOException e) {
				return null;
			}

		}

	}
}
