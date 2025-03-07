package com.spring.app.board.domain;

public class LikeVO {
	private String likeNo; 				// 좋아요번호
	private String fk_postNo; 			// 좋아요된 게시글번호
	private String fk_employeeNo; 		// 좋아요한 사원번호
	private String regDate; 			//좋아요 날짜
	
	
	public String getLikeNo() {
		return likeNo;
	}
	public void setLikeNo(String likeNo) {
		this.likeNo = likeNo;
	}
	public String getFk_postNo() {
		return fk_postNo;
	}
	public void setFk_postNo(String fk_postNo) {
		this.fk_postNo = fk_postNo;
	}
	public String getFk_employeeNo() {
		return fk_employeeNo;
	}
	public void setFk_employeeNo(String fk_employeeNo) {
		this.fk_employeeNo = fk_employeeNo;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	
}


