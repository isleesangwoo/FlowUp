package com.spring.app.employee.domain;

public class GroupVO {
	
	private String groupNo;             // 그룹번호
	private String FK_addressBookNo;    // 주소록고유번호
	private String groupName;           // 그룹이름
	private String person;              // 그룹원
	
	
	public String getGroupNo() {
		return groupNo;
	}
	
	public void setGroupNo(String groupNo) {
		this.groupNo = groupNo;
	}
	
	public String getFK_addressBookNo() {
		return FK_addressBookNo;
	}
	
	public void setFK_addressBookNo(String fK_addressBookNo) {
		FK_addressBookNo = fK_addressBookNo;
	}
	
	public String getGroupName() {
		return groupName;
	}
	
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	
	public String getPerson() {
		return person;
	}
	
	public void setPerson(String person) {
		this.person = person;
	}

}
