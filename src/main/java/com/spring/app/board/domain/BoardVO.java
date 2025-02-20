package com.spring.app.board.domain;

public class BoardVO {
	
	
	private String boardNo;     // 게시판  번호
	private String boardName;   // 게시판명
	private String boardDesc;   // 게시판 설명
	private String isPublic;    // 공개 여부 (1: 공개, 0: 부서별)
	private String createdBy;   // 게시판 생성자(관리자)
	private String createdAt;   // 게시판 생성일
	private String status;      // 게시판 활성/비활성화(삭제) :: 1 활성화 0 비활성화
	
	
	public String getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(String boardNo) {
		this.boardNo = boardNo;
	}
	public String getBoardName() {
		return boardName;
	}
	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}
	public String getBoardDesc() {
		return boardDesc;
	}
	public void setBoardDesc(String boardDesc) {
		this.boardDesc = boardDesc;
	}
	public String getIsPublic() {
		return isPublic;
	}
	public void setIsPublic(String isPublic) {
		this.isPublic = isPublic;
	}
	public String getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
	
}
