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
	private String likeCount ;     	   // 좋아요 개수 누적
	
	private String previouspostNo;      // 이전글 번호
	private String previoussubject;  	// 이전글 제목
	private String previousname;		// 이전글 작성자
	private String previousregDate;		// 이전글 작성일
	private String previousreadCount;	// 이전글 조회수
	private String previouslikeCount;	// 이전글 좋아요수
	
	private String nextpostNo;          // 다음글 번호
	private String nextsubject;      	// 다음글 제목
	private String nextname;			// 다음글 작성자
	private String nextregDate;			// 다음글 작성일
	private String nextreadCount;		// 다음글 조회수
	private String nextlikeCount;		// 다음글 좋아요수
	
	
	private String currentDate;	 		// 현재 시각
	
	private String profileImg; 			//글 렌더링 시 글 작성자의 프로필 사진을 알아오기 위함.
	private String positionName; 		// 글 렌더링 시 글 작성자의 직급을 알기위함.
	
	private boolean liked; // 로그인한 사원이 좋아요한 상태인지 저장하는 필드
	
	private String login_userid; 	
	private String login_userName; 	
	private String fileName; 

	private BoardVO boardvo; // 조인을 위해
	private PostFileVO postfilevo; // 조인을 위해
	
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
	public String getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(String likeCount) {
		this.likeCount = likeCount;
	}
	
	
	public BoardVO getBoardvo() {
		return boardvo;
	}
	public void setBoardvo(BoardVO boardvo) {
		this.boardvo = boardvo;
	}
	public PostFileVO getPostfilevo() {
		return postfilevo;
	}
	public void setPostfilevo(PostFileVO postfilevo) {
		this.postfilevo = postfilevo;
	}
	
	
	
	public String getPreviouspostNo() {
		return previouspostNo;
	}
	public void setPreviouspostNo(String previouspostNo) {
		this.previouspostNo = previouspostNo;
	}
	public String getPrevioussubject() {
		return previoussubject;
	}
	public void setPrevioussubject(String previoussubject) {
		this.previoussubject = previoussubject;
	}
	public String getNextpostNo() {
		return nextpostNo;
	}
	public void setNextpostNo(String nextpostNo) {
		this.nextpostNo = nextpostNo;
	}
	public String getNextsubject() {
		return nextsubject;
	}
	public void setNextsubject(String nextsubject) {
		this.nextsubject = nextsubject;
	}
	public String getPreviousname() {
		return previousname;
	}
	public void setPreviousname(String previousname) {
		this.previousname = previousname;
	}
	public String getPreviousregDate() {
		return previousregDate;
	}
	public void setPreviousregDate(String previousregDate) {
		this.previousregDate = previousregDate;
	}
	public String getPreviousreadCount() {
		return previousreadCount;
	}
	public void setPreviousreadCount(String previousreadCount) {
		this.previousreadCount = previousreadCount;
	}
	public String getNextname() {
		return nextname;
	}
	public void setNextname(String nextname) {
		this.nextname = nextname;
	}
	public String getNextregDate() {
		return nextregDate;
	}
	public void setNextregDate(String nextregDate) {
		this.nextregDate = nextregDate;
	}
	public String getNextreadCount() {
		return nextreadCount;
	}
	public void setNextreadCount(String nextreadCount) {
		this.nextreadCount = nextreadCount;
	}
	public String getPreviouslikeCount() {
		return previouslikeCount;
	}
	public void setPreviouslikeCount(String previouslikeCount) {
		this.previouslikeCount = previouslikeCount;
	}
	public String getNextlikeCount() {
		return nextlikeCount;
	}
	public void setNextlikeCount(String nextlikeCount) {
		this.nextlikeCount = nextlikeCount;
	}
	
	
	
	
    public String getCurrentDate() {
		return currentDate;
	}
	public void setCurrentDate(String currentDate) {
		this.currentDate = currentDate;
	}
	
	
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	public String getPositionName() {
		return positionName;
	}
	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}
	public boolean isLiked() { // JSP에서 ${post.liked}로 사용
        return liked;
    }

    public void setLiked(boolean liked) { // 로그인한 사원이 좋아요한 상태를 설정
        this.liked = liked;
    }
	public String getLogin_userid() {
		return login_userid;
	}
	public void setLogin_userid(String login_userid) {
		this.login_userid = login_userid;
	}
	public String getLogin_userName() {
		return login_userName;
	}
	public void setLogin_userName(String login_userName) {
		this.login_userName = login_userName;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
    
    
	
	
	
	
	
	
	
}
