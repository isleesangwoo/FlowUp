package com.spring.app.employee.domain;

public class PositionVO {

	private String positionNo;     // 직급번호
	private String positionName;    // 직급명
	private String salary; 			// 기본급
	
	//////////////////////////////////////////////
	
	public String getPositionNo() {
		return positionNo;
	}
	
	public void setPositionNo(String positionNo) {
		this.positionNo = positionNo;
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
