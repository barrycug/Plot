package com.esri.demo.dbconnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.log4j.Logger;

import com.ctbr.das.database.DBBroker;
import com.ctbr.das.exception.DaoException;
import com.ctbr.das.service.DAOService;
import com.ctbr.das.service.ServiceFactory;

public class ConnectDATABASE {
	private static Logger logger = Logger.getLogger("ConectionDATABASE");

	/*
	 * get oracle connection
	 */
	public static Connection getConnection() {
		DAOService dao = ServiceFactory.getDAOService();
		Connection conn = null;
		DBBroker dbroker = dao.getDBBroker();
		try {
			conn = dbroker.getConnection();
		} catch (DaoException e) {

			e.printStackTrace();
		}
		return conn;
	}

	/*
	 * commit select
	 */
	public static ResultSet getResult(String sql) {
		ResultSet sets = null;
		try {
			PreparedStatement pps = ConnectDATABASE.getConnection()
					.prepareStatement(sql);
			sets = pps.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return sets;
	}

	/*
	 * close connection
	 */
	public void close(Connection conn) {
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
		}
	}

	/*
	 * close connection
	 */
	public static void close(Statement stmt) {
		if (stmt != null) {
			try {
				stmt.close();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
		}
	}

	public static void close(ResultSet rs) {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
		}
	}

	public static void close(Statement stmt, Connection conn) {
		close(stmt);
	}

	public static void close(ResultSet rs, Statement stmt, Connection conn) {
		close(rs);
		close(stmt, conn);
	}

	public static void main(String[] args) {
		System.out.println("dfffaaaaaaaaaaaaa");
	}
}
