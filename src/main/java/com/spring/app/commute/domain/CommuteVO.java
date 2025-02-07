package com.spring.app.commute.domain;

public class CommuteVO {

	private String seq_commute;		// 근태 고유번호
	private String workDate;		// 근무 일자 (연,월,일)
	private String startTime;		// 출근 시간 (00:00:00 ~ 23:59:59)
	private String endTime;			// 퇴근 시간 (00:00:00 ~ 23:59:59)
	private String status;     		// 현재 상태 0:업무시작전 1:연차 2:오전반차 3:오후반차 4:내근 5:외근 6:파견 7:출장 8:업무종료
	private String rest;   			// 휴가 여부 0:해당없음 1:연차 2:오전반차 3:오후반차 4:휴직
	
	
	
	
	
	
	
	
	public String getSeq_commute() {
		return seq_commute;
	}
	public void setSeq_commute(String seq_commute) {
		this.seq_commute = seq_commute;
	}
	public String getWorkDate() {
		return workDate;
	}
	public void setWorkDate(String workDate) {
		this.workDate = workDate;
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
	
	
	
	
	
	
}
