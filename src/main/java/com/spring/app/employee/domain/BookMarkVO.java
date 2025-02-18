package com.spring.app.employee.domain;

public class BookMarkVO {
	
	private String FK_employeeNo;		// 사번(대상자)
	private String FK_adrsBNo;			// 주소록고유번호
	private String FK_groupNo;			// 그룹번호
	private String email;				// 이메일
	private String name;				// 이름

	////////////////////////////////////////////////
	
	public String getFK_employeeNo() {
		return FK_employeeNo;
	}
	public void setFK_employeeNo(String fK_employeeNo) {
		FK_employeeNo = fK_employeeNo;
	}
	public String getFK_adrsBNo() {
		return FK_adrsBNo;
	}
	public void setFK_adrsBNo(String fK_adrsBNo) {
		FK_adrsBNo = fK_adrsBNo;
	}
	public String getFK_groupNo() {
		return FK_groupNo;
	}
	public void setFK_groupNo(String fK_groupNo) {
		FK_groupNo = fK_groupNo;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
}
