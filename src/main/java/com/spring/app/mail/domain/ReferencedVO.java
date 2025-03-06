package com.spring.app.mail.domain;

public class ReferencedVO {

	private String refMailNo;      // 참조 이메일번호
	private String reference;      // 참조수신여부 / 0:수신자, 1:참조자
	private String referenceName;  // 참조/수신자이름
	private String referenceMail;  // 참조/수신자이메일
	
	private String fk_mailNo;      // 메일번호
	private String fk_adrsBNo;     // 주소록 고유번호
	
	
	public String getRefMailNo() {
		return refMailNo;
	}
	public void setRefMailNo(String refMailNo) {
		this.refMailNo = refMailNo;
	}
	public String getReference() {
		return reference;
	}
	public void setReference(String reference) {
		this.reference = reference;
	}
	public String getReferenceName() {
		return referenceName;
	}
	public void setReferenceName(String referenceName) {
		this.referenceName = referenceName;
	}
	public String getReferenceMail() {
		return referenceMail;
	}
	public void setReferenceMail(String referenceMail) {
		this.referenceMail = referenceMail;
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
