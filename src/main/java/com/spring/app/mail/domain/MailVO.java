package com.spring.app.mail.domain;

import com.spring.app.employee.domain.EmployeeVO;

public class MailVO {

	private String mailNo;           // 메일번호
	private String subject;          // 메일제목
	private String content;          // 메일내용
	private String readStatus;       // 열람여부 / 0:미열람, 1:열람
	private String deleteStatus;     // 삭제여부 / 0:존재, 1:삭제
	private String saveStatus;       // 저장여부 / 0:일반상태, 1:임시저장
	private String importantStatus;  // 중요표시 / 0:기본, 1:중요
	private String sendDate;         // 전송날짜
	
	private String fk_employeeNo;    // 사번 (직원 테이블 참조)
	private String fk_fileNo;
	
	private EmployeeVO employeevo;   // employee 테이블 조인
	private MailFileVO fileNo;       // 
	
	public String getMailNo() {
		return mailNo;
	}
	public void setMailNo(String mailNo) {
		this.mailNo = mailNo;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReadStatus() {
		return readStatus;
	}
	public void setReadStatus(String readStatus) {
		this.readStatus = readStatus;
	}
	public String getDeleteStatus() {
		return deleteStatus;
	}
	public void setDeleteStatus(String deleteStatus) {
		this.deleteStatus = deleteStatus;
	}
	public String getSaveStatus() {
		return saveStatus;
	}
	public void setSaveStatus(String saveStatus) {
		this.saveStatus = saveStatus;
	}
	public String getImportantStatus() {
		return importantStatus;
	}
	public void setImportantStatus(String importantStatus) {
		this.importantStatus = importantStatus;
	}
	public String getSendDate() {
		return sendDate;
	}
	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
	}
	public String getFk_employeeNo() {
		return fk_employeeNo;
	}
	public void setFk_employeeNo(String fk_employeeNo) {
		this.fk_employeeNo = fk_employeeNo;
	}
	public EmployeeVO getEmployeevo() {
		return employeevo;
	}
	public void setEmployeevo(EmployeeVO employeevo) {
		this.employeevo = employeevo;
	}
	public MailFileVO getFileNo() {
		return fileNo;
	}
	public void setFileNo(MailFileVO fileNo) {
		this.fileNo = fileNo;
	}
	
	
	
	
}
