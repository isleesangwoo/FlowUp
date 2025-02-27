package com.spring.app.mail.domain;

public class TagVO {

	private String tagNo;		// 태그번호
	private String color; 		// 태그색
	private String name; 		// 태그이름
	
	private String fk_mailNo; 	// 메일번호
	
	
	public String getTagNo() {
		return tagNo;
	}
	public void setTagNo(String tagNo) {
		this.tagNo = tagNo;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getFk_mailNo() {
		return fk_mailNo;
	}
	public void setFk_mailNo(String fk_mailNo) {
		this.fk_mailNo = fk_mailNo;
	}
	
	
	
}
