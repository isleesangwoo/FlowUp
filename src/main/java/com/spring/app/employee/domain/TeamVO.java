package com.spring.app.employee.domain;

public class TeamVO {

	private String teamNo;         // 팀번호
	private String FK_managerNo;   // 팀장사번
	private String FK_departmentNo; // 부서번호
	private String teamName;        // 팀명
	
	////////////////////////////////////////////////// 
	
	
	public String getTeamNo() {
		return teamNo;
	}

	public void setTeamNo(String teamNo) {
		this.teamNo = teamNo;
	}

	
	public String getFK_managerNo() {
		return FK_managerNo;
	}


	public void setFK_managerNo(String fK_managerNo) {
		FK_managerNo = fK_managerNo;
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
