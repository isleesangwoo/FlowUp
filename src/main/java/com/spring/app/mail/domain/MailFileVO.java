package com.spring.app.mail.domain;

public class MailFileVO {
	
	private String fileNo;		 // 첨부파일번호
	private String fileName;     // 첨부파일명
	private String orgFileName;  // 원래파일명
	private Long fileSize;     // 파일용량
	
	private int fk_mailNo;    // 메일번호
	
	private MailVO mailvo;       // mail 테이블 조인
	
	
	public String getFileNo() {
		return fileNo;
	}
	public void setFileNo(String fileNo) {
		this.fileNo = fileNo;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getOrgFileName() {
		return orgFileName;
	}
	public void setOrgFileName(String orgFileName) {
		this.orgFileName = orgFileName;
	}
	public Long getFileSize() {
		return fileSize;
	}
	public void setFileSize(Long fileSize) {
		this.fileSize = fileSize;
	}
	
	
	public int getFk_mailNo() {
		return fk_mailNo;
	}
	public void setFk_mailNo(int fk_mailNo) {
		this.fk_mailNo = fk_mailNo;
	}
	
	
	public MailVO getMailvo() {
		return mailvo;
	}
	public void setMailvo(MailVO mailvo) {
		this.mailvo = mailvo;
	}
	
	
	
}
