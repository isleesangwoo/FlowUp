package com.spring.app.employee.domain;

public class TeamVO {

	private String teamSeq;         // 팀번호
	private String FK_employeeNo;   // 팀장사번
	private String FK_departmentNo; // 부서번호
	private String teamName;        // 팀명
	
	////////////////////////////////////////////////// 
	
	
	public String getTeamSeq() {
		return teamSeq;
	}
	
	public void setTeamSeq(String teamSeq) {
		this.teamSeq = teamSeq;
	}
	
	public String getFK_employeeNo() {
		return FK_employeeNo;
	}
	
	public void setFK_employeeNo(String fK_employeeNo) {
		FK_employeeNo = fK_employeeNo;
	}
	
	public String getFK_departmentNo() {
		return FK_departmentNo;
	}
	
	public void setFK_departmentNo(String fK_departmentNo) {
		FK_departmentNo = fK_departmentNo;
	}
	
	public String getTeamName() {
		return teamName;
	}
	
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
    
	
    
}
