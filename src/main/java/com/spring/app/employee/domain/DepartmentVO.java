package com.spring.app.employee.domain;

public class DepartmentVO {
	
	private String departmentNo;      	// 부서번호
	private String FK_managerNo;      	// 부서장사번
	private String departmentName;   	// 부서명
	
	
	///////////////////////////////////////////////
	
	
	public String getDepartmentNo() {
		return departmentNo;
	}
	
	public void setDepartmentNo(String departmentNo) {
		this.departmentNo = departmentNo;
	}
	
	public String getFK_managerNo() {
		return FK_managerNo;
	}
	
	public void setFK_managerNo(String fK_managerNo) {
		FK_managerNo = fK_managerNo;
	}

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	
	
	
	

}
