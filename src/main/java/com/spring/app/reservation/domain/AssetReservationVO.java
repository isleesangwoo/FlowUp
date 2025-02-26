package com.spring.app.reservation.domain;

public class AssetReservationVO {
	
	private String assetReservationNo;  // 회의실 이용정보 ID
	private String fk_assetDetailNo;    // tbl_roomDetail 회의실 상세 ID fk
	private String fk_employeeNo;       // tbl_employee 사원 ID fk
	private String reservationStart;    // 이용시작시간
	private String reservationEnd;      // 이용끝시간
	private String reservationDay;      // 예약한 날짜
	private String reservationContents; // 예약한 이유
	
	
	
	
	
	//////////////////////////////////////////////////
	
	public String getAssetReservationNo() {
		return assetReservationNo;
	}
	public void setAssetReservationNo(String assetReservationNo) {
		this.assetReservationNo = assetReservationNo;
	}
	public String getFk_assetDetailNo() {
		return fk_assetDetailNo;
	}
	public void setFk_assetDetailNo(String fk_assetDetailNo) {
		this.fk_assetDetailNo = fk_assetDetailNo;
	}
	public String getFk_employeeNo() {
		return fk_employeeNo;
	}
	public void setFk_employeeNo(String fk_employeeNo) {
		this.fk_employeeNo = fk_employeeNo;
	}
	public String getReservationStart() {
		return reservationStart;
	}
	public void setReservationStart(String reservationStart) {
		this.reservationStart = reservationStart;
	}
	public String getReservationEnd() {
		return reservationEnd;
	}
	public void setReservationEnd(String reservationEnd) {
		this.reservationEnd = reservationEnd;
	}
	public String getReservationDay() {
		return reservationDay;
	}
	public void setReservationDay(String reservationDay) {
		this.reservationDay = reservationDay;
	}
	public String getReservationContents() {
		return reservationContents;
	}
	public void setReservationContents(String reservationContents) {
		this.reservationContents = reservationContents;
	}
	
	
	
	
	
	
}
