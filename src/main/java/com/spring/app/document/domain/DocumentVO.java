package com.spring.app.document.domain;

public class DocumentVO {

	private String documentNo;		// 문서번호
	private String fk_emloyeeNo;	// 사원번호
	private String subject;			// 제목
	private String draftDate;		// 기안날짜
	private String status;			// 승인여부
	private String securityLevel;	// 보안등급
	private String temp;			// 임시저장여부
	private String type;			// 양식이름
	
	public String getDocumentNo() {
		return documentNo;
	}
	public void setDocumentNo(String documentNo) {
		this.documentNo = documentNo;
	}
	public String getFk_emloyeeNo() {
		return fk_emloyeeNo;
	}
	public void setFk_emloyeeNo(String fk_emloyeeNo) {
		this.fk_emloyeeNo = fk_emloyeeNo;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getDraftDate() {
		return draftDate;
	}
	public void setDraftDate(String draftDate) {
		this.draftDate = draftDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getSecurityLevel() {
		return securityLevel;
	}
	public void setSecurityLevel(String securityLevel) {
		this.securityLevel = securityLevel;
	}
	public String getTemp() {
		return temp;
	}
	public void setTemp(String temp) {
		this.temp = temp;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
}
