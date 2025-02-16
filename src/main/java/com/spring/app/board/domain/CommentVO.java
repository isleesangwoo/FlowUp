package com.spring.app.board.domain;

public class CommentVO {

	private String commentNo; 
	private String fk_postNo; 		   // 해당 댓글이 속한 게시글 번호
	private String fk_employeeNo;      // 댓글 작성자사번
	private String name;               // 작성자 이름
	private String content;            // 댓글내용
	private String regDate;            // 작성일자 
	private String status;             // 삭제여부 1 활성화 0 삭제
	private String groupNo;            // 댓글 그룹 번호 (원댓글/대댓글을 묶는 값)
	private String fk_commentNo;       // 부모 댓글 번호 (대댓글일 경우 부모 댓글 번호, 댓글이면 0)
	private String depthNo;            // CHECK (depthNo IN (0,1)) / 댓글: 0, 대댓글: 1 (들여쓰기를 위한 컬럼)
	
	
	public String getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(String commentNo) {
		this.commentNo = commentNo;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getGroupNo() {
		return groupNo;
	}
	public void setGroupNo(String groupNo) {
		this.groupNo = groupNo;
	}
	public String getFk_commentNo() {
		return fk_commentNo;
	}
	public void setFk_commentNo(String fk_commentNo) {
		this.fk_commentNo = fk_commentNo;
	}
	public String getDepthNo() {
		return depthNo;
	}
	public void setDepthNo(String depthNo) {
		this.depthNo = depthNo;
	}
	
}
