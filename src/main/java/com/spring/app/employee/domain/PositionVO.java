package com.spring.app.employee.domain;

public class PositionVO {

	private String posiotionNo;     // 직급번호
	private String positionName;    // 직급명
	
	//////////////////////////////////////////////
	
	public String getPosiotionNo() {
		return posiotionNo;
	}
	
	public void setPosiotionNo(String posiotionNo) {
		this.posiotionNo = posiotionNo;
	}
	
	public String getPositionName() {
		return positionName;
	}
	
	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}
	
}
