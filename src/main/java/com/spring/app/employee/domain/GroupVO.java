package com.spring.app.employee.domain;

public class GroupVO {
	
	private String groupNo;             // 그룹번호
	private String groupName;			// 그룹이름
	private String FK_employeeNo;		// 사번(주소록의 주인)	
	
	////////////////////////////////////////////////////////
	
	public String getGroupNo() {
		return groupNo;
	}
	
	public void setGroupNo(String groupNo) {
		this.groupNo = groupNo;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getFK_employeeNo() {
		return FK_employeeNo;
	}

	public void setFK_employeeNo(String fK_employeeNo) {
		FK_employeeNo = fK_employeeNo;
	}
	
	
	

}
