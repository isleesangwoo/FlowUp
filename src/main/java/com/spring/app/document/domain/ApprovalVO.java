package com.spring.app.document.domain;

public class ApprovalVO {
	
	private String approvalNo;		// 승인번호
	private String fk_documentNo;	// 문서번호
	private String fk_approver;		// 승인자
	private String approvalOrder;	// 승인순서
	private String approvalStatus;	// 승인상태(0:처리전,1:결재,2:반려,3:보류)
	private String executionDate;	// 처리날짜
	
	public String getApprovalNo() {
		return approvalNo;
	}
	public void setApprovalNo(String approvalNo) {
		this.approvalNo = approvalNo;
	}
	public String getFk_documentNo() {
		return fk_documentNo;
	}
	public void setFk_documentNo(String fk_documentNo) {
		this.fk_documentNo = fk_documentNo;
	}
	public String getFk_approver() {
		return fk_approver;
	}
	public void setFk_approver(String fk_approver) {
		this.fk_approver = fk_approver;
	}
	public String getApprovalOrder() {
		return approvalOrder;
	}
	public void setApprovalOrder(String approvalOrder) {
		this.approvalOrder = approvalOrder;
	}
	public String getApprovalStatus() {
		return approvalStatus;
	}
	public void setApprovalStatus(String approvalStatus) {
		this.approvalStatus = approvalStatus;
	}
	public String getExecutionDate() {
		return executionDate;
	}
	public void setExecutionDate(String executionDate) {
		this.executionDate = executionDate;
	}
	
}
