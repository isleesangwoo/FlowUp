package com.spring.app.board.domain;

public class NotificationVO {

	private String notificationNo;     		// 알림 번호 (PK)
	private String fk_employeeNo;			//알림 받는 사람
	private String fk_postNo;				// 관련된 게시글 번호 (댓글 달린 게시글)
	private String fk_commentNo;			// 관련된 댓글 번호 (대댓글의 경우)
	private String senderEmployeeNo;		// 알림을 보낸 사람 (댓글 작성자)
	private String message;					// 알림 메시지
	private String notificationType;		// 알림 유형 ( comment, reply,like)
	private String isRead;					// 읽음 여부 (0: 안읽음, 1: 읽음)
	private String createdAt;				// 생성일(알림 발생일이 됨)
	
	
	private String senderPostionNo;   		// 직급번호
	private String senderName;				// 알림 보내는 사람 프로필
	private String senderPositionName; 		// 직급명
	private String timeAgo;					// 알림이 발생한 시간 계산 
	private String profileimg;				// 알림 보내는 사원의 프로필
	private String fileName;				// 알림 보내는 사원의 프로필사진 파일명
	
	private String boardNo; 				// 알림의 해당 글의 게시판 번호
	private String postCreateBy; 			// 알림의 게시글 작성자
	
	
	
	public String getNotificationNo() {
		return notificationNo;
	}
	public void setNotificationNo(String notificationNo) {
		this.notificationNo = notificationNo;
	}
	public String getFk_employeeNo() {
		return fk_employeeNo;
	}
	public void setFk_employeeNo(String fk_employeeNo) {
		this.fk_employeeNo = fk_employeeNo;
	}
	public String getFk_postNo() {
		return fk_postNo;
	}
	public void setFk_postNo(String fk_postNo) {
		this.fk_postNo = fk_postNo;
	}
	public String getFk_commentNo() {
		return fk_commentNo;
	}
	public void setFk_commentNo(String fk_commentNo) {
		this.fk_commentNo = fk_commentNo;
	}
	public String getSenderEmployeeNo() {
		return senderEmployeeNo;
	}
	public void setSenderEmployeeNo(String senderEmployeeNo) {
		this.senderEmployeeNo = senderEmployeeNo;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getNotificationType() {
		return notificationType;
	}
	public void setNotificationType(String notificationType) {
		this.notificationType = notificationType;
	}
	public String getIsRead() {
		return isRead;
	}
	public void setIsRead(String isRead) {
		this.isRead = isRead;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	public String getSenderPostionNo() {
		return senderPostionNo;
	}
	public void setSenderPostionNo(String senderPostionNo) {
		this.senderPostionNo = senderPostionNo;
	}
	public String getSenderName() {
		return senderName;
	}
	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}
	public String getSenderPositionName() {
		return senderPositionName;
	}
	public void setSenderPositionName(String senderPositionName) {
		this.senderPositionName = senderPositionName;
	}
	public String getTimeAgo() {
		return timeAgo;
	}
	public void setTimeAgo(String timeAgo) {
		this.timeAgo = timeAgo;
	}
	public String getProfileimg() {
		return profileimg;
	}
	public void setProfileimg(String profileimg) {
		this.profileimg = profileimg;
	}
	public String getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(String boardNo) {
		this.boardNo = boardNo;
	}
	public String getPostCreateBy() {
		return postCreateBy;
	}
	public void setPostCreateBy(String postCreateBy) {
		this.postCreateBy = postCreateBy;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	
	
	
	
	
}
  