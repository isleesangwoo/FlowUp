package com.spring.app.document.domain;

// 휴가신청서 VO
public class DraftAnnualVO {
	
	private String documentNo;	// 문서번호
	private String useAmount;	// 사용하는 연차 개수      
	private String reason;		// 사유
	private String startDate;	// 시작 날짜
	private String endDate;		// 끝 날짜
	private String annualType;	// 연차 종류 (1:휴가,2:오전반차,3:오후반차)
	
	public String getDocumentNo() {
		return documentNo;
	}
	public void setDocumentNo(String documentNo) {
		this.documentNo = documentNo;
	}
	public String getUseAmount() {
		return useAmount;
	}
	public void setUseAmount(String useAmount) {
		this.useAmount = useAmount;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getAnnualType() {
		return annualType;
	}
	public void setAnnualType(String annualType) {
		this.annualType = annualType;
	}
	
}
