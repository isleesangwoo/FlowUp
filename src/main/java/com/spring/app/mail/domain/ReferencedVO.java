package com.spring.app.mail.domain;

public class ReferencedVO {

	private String refMailNo;      // 참조 이메일번호
	private String refStatus;      // 참조수신여부 / 0:수신자, 1:참조자
	private String refName;  	   // 참조/수신자이름
	private String refMail;  	   // 참조/수신자이메일
	
	private String fk_mailNo;      // 메일번호
	private String fk_adrsBNo;     // 주소록 고유번호
	
	
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
		return refMail;
	}
	public void setRefMail(String refMail) {
		this.refMail = refMail;
	}
	public String getFk_mailNo() {
		return fk_mailNo;
	}
	public void setFk_mailNo(String fk_mailNo) {
		this.fk_mailNo = fk_mailNo;
	}
	public String getFk_adrsBNo() {
		return fk_adrsBNo;
	}
	public void setFk_adrsBNo(String fk_adrsBNo) {
		this.fk_adrsBNo = fk_adrsBNo;
	}
	
}
