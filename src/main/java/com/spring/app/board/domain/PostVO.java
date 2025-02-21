package com.spring.app.board.domain;

public class PostVO {
	private String postNo;             // 글번호
	private String fk_boardNo;         // 게시판 번호 (FK)
	private String fk_employeeNo;      // 사번 (작성자)
	private String name;               // 글쓴이
	private String subject;            // 글 제목
	private String content;            // 글 내용
	private String readCount;          // 조회수
	private String regDate;            // 작성일
	private String commentCount;       // 댓글 개수
	private String allowComments;      // 댓글 허용 여부 (1: 허용, 0: 비허용)
	private String status;             // 글 삭제 여부 (1: 활성, 0: 삭제)
	private String isNotice;           // 공지글 여부 (1: 공지글, 0: 일반글)
	private String noticeEndDate ;     // 공지사항 종료일 (공지글일 경우 사용)
	
	private BoardVO boardvo; // 조인을 위해
	
	
	public String getPostNo() {
		return postNo;
	}
	public void setPostNo(String postNo) {
		this.postNo = postNo;
	}
	public String getFk_boardNo() {
		return fk_boardNo;
	}
	public void setFk_boardNo(String fk_boardNo) {
		this.fk_boardNo = fk_boardNo;
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
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReadCount() {
		return readCount;
	}
	public void setReadCount(String readCount) {
		this.readCount = readCount;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(String commentCount) {
		this.commentCount = commentCount;
	}
	public String getAllowComments() {
		return allowComments;
	}
	public void setAllowComments(String allowComments) {
		this.allowComments = allowComments;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getIsNotice() {
		return isNotice;
	}
	public void setIsNotice(String isNotice) {
		this.isNotice = isNotice;
	}
	public String getNoticeEndDate() {
		return noticeEndDate;
	}
	public void setNoticeEndDate(String noticeEndDate) {
		this.noticeEndDate = noticeEndDate;
	}
	
	
	public BoardVO getBoardvo() {
		return boardvo;
	}
	public void setBoardvo(BoardVO boardvo) {
		this.boardvo = boardvo;
	}
	
	
	
	
}
