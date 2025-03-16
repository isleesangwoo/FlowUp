package com.spring.app.mail.domain;

public class ReferencedVO {

	private String refMailNo;      // 참조 이메일번호
	private String refStatus;      // 참조수신여부 / 0:수신자, 1:참조자
	private String refName;  	   // 참조/수신자이름
	private String refEmail;  	   // 참조/수신자이메일
	
	private String fk_mailNo;      // 메일번호
	
	
	public String getRefMailNo() {
		return refMailNo;
	}
	public void setRefMailNo(String refMailNo) {
		this.refMailNo = refMailNo;
	}
	public String getRefStatus() {
		return refStatus;
	}
	public void setRefStatus(String refStatus) {
		this.refStatus = refStatus;
	}
	public String getRefName() {
		return refName;
	}
	public void setRefName(String refName) {
		this.refName = refName;
	}
	public String getRefMail() {
		return refEmail;
	}
	public void setRefMail(String refMail) {
		this.refEmail = refMail;
	}
	public String getFk_mailNo() {
		return fk_mailNo;
	}
	public void setFk_mailNo(String fk_mailNo) {
		this.fk_mailNo = fk_mailNo;
	}
	
}
