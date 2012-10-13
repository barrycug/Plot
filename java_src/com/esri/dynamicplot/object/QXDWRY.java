/**
 * 
 */
package com.esri.dynamicplot.object;

/**
 * @author 张德品
 *这个主要是实现抢险队伍及人员的类
 */

public class QXDWRY {
    public String plan_id;
    public String team_cd;
    public String team_nm;
    public Number p_num;
    public String xqid;
    public String cxdd;
    public String p_dept;
    public String bz;
    public boolean choosed=false;
	public boolean isChoosed() {
		return choosed;
	}
	public void setChoosed(boolean choosed) {
		this.choosed = choosed;
	}
	public String getPlan_id() {
		return plan_id;
	}
	public void setPlan_id(String plan_id) {
		this.plan_id = plan_id;
	}
	public String getTeam_cd() {
		return team_cd;
	}
	public void setTeam_cd(String team_cd) {
		this.team_cd = team_cd;
	}
	public String getTeam_nm() {
		return team_nm;
	}
	public void setTeam_nm(String team_nm) {
		this.team_nm = team_nm;
	}
	public Number getP_num() {
		return p_num;
	}
	public void setP_num(Number p_num) {
		this.p_num = p_num;
	}
	public String getXqid() {
		return xqid;
	}
	public void setXqid(String xqid) {
		this.xqid = xqid;
	}
	public String getCxdd() {
		return cxdd;
	}
	public void setCxdd(String cxdd) {
		this.cxdd = cxdd;
	}
	public String getP_dept() {
		return p_dept;
	}
	public void setP_dept(String p_dept) {
		this.p_dept = p_dept;
	}
	public String getBz() {
		return bz;
	}
	public void setBz(String bz) {
		this.bz = bz;
	}
    
}
