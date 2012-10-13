/**
 * @�����д������
 * @ʱ�䣺2008-8-18
 * @�޸ģ�2008-8-20 
 */
package com.esri.demo.dbconnection;

import java.sql.*;
import java.util.Map;

import com.ctbr.das.database.DBBroker;
import com.ctbr.das.service.ServiceFactory;
import com.ctbr.das.service.DAOService;
/**
 * ��ݿ�SQL������
 * ����ݿ�l��	void DbConn() 
 * ִ����ݿ��ѯ(select)����	void excQuery(String sqlStr)
 * ������ݼ�	ResultSet rst
 * ִ����ݿ����(UPDATE, DELETE��INSERT)����	int excUpdate(String sqlStr)��  
 * �ͷ���ݿ�l�ӳ���Դ	void close()
 */

public class OraOpt {
	/**
	 * ��ݿ�SQL��������
	 */
	DAOService dao=ServiceFactory.getDAOService();
	
 private Connection conn=null;//��ݿ�l��
 private Statement stmt;
 private Statement stmt1;
 private static String conStr;//jdbc��ݿ�l�Ӵ�
 public ResultSet rst;//������ݼ� 
 private static int jiangshijituan=0;//δ�رյ�l����
 /*
  * ����Comm.TextSecurity������������
  * 
  */ 
 public String oraIp=null;
 public String em;
 public String dm;
 public Connection getConn() {
		return conn;
	}
 public void setConn(Connection conn) {
		this.conn = conn;
	}
 //��ʼ��
 public void init() throws Exception {	 
       try{
    	   DBBroker dbbroker=dao.getDBBroker();
  		 conn=dbbroker.getConnection();
       }
	 catch(Exception e){
		 throw new Exception("��ݿ�l���쳣��"+e.getMessage());
		 }
 }
 /*������ݿ��ѯSQL��䣬�����м�������¼
 */
 public String excMultiPageQuery( 
		  int count_pages,//��ҳ��
		  int count_rows,//������
		  int page_index,//�ڼ�ҳ
		  int rows_per_page,//ÿҳ����
		  String tableName
){
int PageUpperBound=page_index*rows_per_page;
int PageLowerBound= (page_index-1)*rows_per_page;
String sql="SELECT * FROM ( SELECT A.*, rownum r FROM ( SELECT * FROM "+tableName+
         " ORDER BY "+tableName+".rowid "+
      ") A WHERE rownum <= "+PageUpperBound+
    ") B WHERE r >"+PageLowerBound;// 10;
  return sql;
 }
 /*
  *  SELECT * FROM (SELECT A.*, rownum r FROM 
  *                (SELECT * FROM tops ORDER BY tops.rowid) A 
  *           WHERE rownum <= PageUpperBound) B  WHERE r > PageLowerBound; 
  * */
 public String excMultiPageQuery( 
		  int count_pages,//��ҳ��
		  int count_rows,//������
		  int page_index,//�ڼ�ҳ
		  int rows_per_page,//ÿҳ����		  
		  String tableName,
		  String order_fieldname
		  )
 {
 int PageUpperBound=page_index*rows_per_page;
 int PageLowerBound= (page_index-1)*rows_per_page;
 String sql="SELECT * FROM ( SELECT A.*, rownum r FROM ( SELECT * FROM "+tableName+
          " ORDER BY "+tableName+"."+order_fieldname+
       ") A WHERE rownum <= "+PageUpperBound+
     ") B WHERE r >"+PageLowerBound;
 return sql;
  }
 //����ݿ�l��
 public void open() throws Exception {
	 try{
		init();
		conn.setAutoCommit(true);
		 stmt=conn.createStatement(
				 ResultSet.TYPE_SCROLL_SENSITIVE,//ResultSet����Ƿ���Թ�
				 ResultSet.CONCUR_UPDATABLE//,//�������ResultSet
				 );
	 }
	 catch(SQLException e){
		 throw new Exception("��ݿ���쳣��"+e.getMessage());
		 }	 
 }
 public void open1() throws Exception {
	 try{
		init();
		 stmt=conn.createStatement();
	 }
	 catch(SQLException e){
		 throw new Exception("��ݿ���쳣��"+e.getMessage());
		 //e.printStackTrace();
		 }	 
 }
 //����ݿ�l�ӣ����лع�
 public void pidopen() throws Exception {
	 try{
		 init();
		 conn.setAutoCommit(false);
		 stmt1=conn.createStatement(
				 ResultSet.TYPE_SCROLL_SENSITIVE,//ResultSet����Ƿ���Թ�
				 ResultSet.CONCUR_UPDATABLE//,//�������ResultSet
				// ResultSet.HOLD_CURSORS_OVER_COMMIT //�ύ���ر�ResultSet,ҳ�治֧�ֵ�����
				 );
	 }
	 catch(SQLException e){
		 throw new Exception("��ݿ���쳣��"+e.getMessage());
		 //e.printStackTrace();
		 }	 
 }
 //ִ����ݿ��ѯ����
 public void excQuery(String s) throws Exception {
	 try{
		 if (stmt!=null){
			 rst=stmt.executeQuery(s);
		 }
	 }
	 catch(SQLException e)
	 {
	    throw new 	 Exception("��ݿ��ѯ�쳣��"+e.getMessage());
	 }	 
 }
 //ִ����ݿ���²���UPDATE, EXEC PROCUDE & DELETE 
 public int excUpdate(String s) throws Exception{
	 int status=0;
	 try
	 {
	 	 if (stmt!=null)
	 	 {
			 status=stmt.executeUpdate(s);
		 }
	 }
	 catch(SQLException e)
	 {
	    throw new 	 Exception("��ݿ�����쳣��"+e.getMessage());
	 }	
	 return status;
 }
//ִ����ݿ��ѯ����
 public void pidexcQuery(String s) throws Exception {
	 try{
		 if (stmt1!=null){
			 rst=stmt1.executeQuery(s);
		 }
	 }
	 catch(SQLException e)
	 {
	    throw new 	 Exception("��ݿ��ѯ�쳣��"+e.getMessage());
	 }	 
 }
//ִ����ݿ���²���UPDATE, EXEC PROCUDE & DELETE 
 public int pidexcUpdate(String s) throws Exception{
	 int status=0;
	 try
	 {
	 	 if (stmt1!=null)
	 	 {
			 status=stmt1.executeUpdate(s);
			 
		 }
	 }
	 catch(SQLException e)
	 {
	    throw new 	 Exception("��ݿ�����쳣��"+e.getMessage());
	 }	
	 return status;
 }
 //�ͷ���ݿ�l�ӳ���Դ
 public void close(){
	 try{
		 if (rst!=null)				 
			 rst.close();
		 if (stmt!=null)			 
			 stmt.close();
		 if (stmt1!=null)			 
			 stmt1.close();
		 if (conn!=null)			 
			 conn.close();
		 
		 
		 if(jiangshijituan>0)
		 {
		 jiangshijituan--;		 
		 }
		 System.out.println("δ�رյ�l����="+jiangshijituan);
	 }
	 catch(Exception e){e.printStackTrace();}
 }
 
	/**
	 * ȡ���XML�ļ��ľ��·��
	 * */
	public String classPath(){
		String className = this.getClass().getName();
		String packageName = this.getClass().getPackage().getName();
		String classFileName = className.substring(packageName.length()+1)+".class";
		String classFilePath = this.getClass().getResource(classFileName).toString();
		String ps= classFilePath.substring(0,classFilePath.length()-classFileName.length());
		String h="file:/";
		ps= ps.substring(6);
		return ps;
	}

}
