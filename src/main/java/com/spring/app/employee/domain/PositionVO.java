package com.spring.app.employee.domain;

public class PositionVO {

	private String posiotionNo;     // 직급번호
	private String positionName;    // 직급명
	private String salary; 			// 기본급
	
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

	public String getSalary() {
		return salary;
	}

	public void setSalary(String salary) {
		this.salary = salary;
	}
	
	
	
	
}
