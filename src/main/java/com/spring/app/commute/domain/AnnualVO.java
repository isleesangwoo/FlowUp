package com.spring.app.commute.domain;

public class AnnualVO {

	private String seq_annual;		// 연차 고유번호
	private String year;			// 적용 연도
	private String occur;			// 발생 연차
	private String over;			// 이월 연차
	private String add;				// 조정 연차
	private String used;     		// 소진 연차
	
	
	
	
	
	
	
	
	
	public String getSeq_annual() {
		return seq_annual;
	}
	public void setSeq_annual(String seq_annual) {
		this.seq_annual = seq_annual;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getOccur() {
		return occur;
	}
	public void setOccur(String occur) {
		this.occur = occur;
	}
	public String getOver() {
		return over;
	}
	public void setOver(String over) {
		this.over = over;
	}
	public String getAdd() {
		return add;
	}
	public void setAdd(String add) {
		this.add = add;
	}
	public String getUsed() {
		return used;
	}
	public void setUsed(String used) {
		this.used = used;
	}

	
	
	
	
	
	
}
