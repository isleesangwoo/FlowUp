package com.spring.app.commute.domain;

public class CommuteVO {

	private String commuteNo;		// 근태 고유번호
	private String FK_employeeNo;	// 사원번호
	private String startTime;		// 출근 시간 (00:00:00 ~ 23:59:59)
	private String endTime;			// 퇴근 시간 (00:00:00 ~ 23:59:59)
	private String status;     		// 현재 상태 0:업무시작전 1:휴가 2:내근 3:외근 4:파견 5:출장 6:업무종료
	private String rest;   			// 휴가 여부 0:해당없음 1:연차 2:오전반차 3:오후반차 4:결근
	private String overTimeYN;		// 연장근무 유무 기본 0 // 0:해당없음 1:연장근무
	private String workDate;		// yyyy-mm-dd
	
	
	
	
	
	public String getWorkDate() {
		return workDate;
	}
	public void setWorkDate(String workDate) {
		this.workDate = workDate;
	}
	public String getCommuteNo() {
		return commuteNo;
	}
	public void setCommuteNo(String commuteNo) {
		this.commuteNo = commuteNo;
	}
	public String getFK_employeeNo() {
		return FK_employeeNo;
	}
	public void setFK_employeeNo(String fK_employeeNo) {
		FK_employeeNo = fK_employeeNo;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getRest() {
		return rest;
	}
	public void setRest(String rest) {
		this.rest = rest;
	}
	public String getOverTimeYN() {
		return overTimeYN;
	}
	public void setOverTimeYN(String overTimeYN) {
		this.overTimeYN = overTimeYN;
	}
	
	
	
	
	
}
