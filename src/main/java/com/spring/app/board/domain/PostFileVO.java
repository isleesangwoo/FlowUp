package com.spring.app.board.domain;

import org.springframework.web.multipart.MultipartFile;

public class PostFileVO {
	private String fileNo;          
	private String fk_postNo;       // 글번호 
	private String orgFilename;     // 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명 
	private String fileName;        // WAS(톰캣)에 저장될 파일명(2025020709291535243254235235234.png) 
	private String fileSize;        // 파일크기 
	
	/*
    === #147. 파일을 첨부하도록 VO 수정하기
        먼저, 오라클에서 tbl_board 테이블에 3개 컬럼(fileName, orgFilename, fileSize)을 추가한 다음에 아래의 작업을 한다.        
	*/
	private MultipartFile attach;
	/*
	    form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다. 
	       진짜파일 ==> WAS(톰캣) 디스크에 저장됨.
	          조심할것은 MultipartFile attach 는 오라클 데이터베이스 tbl_board 테이블의 컬럼이 아니다.
	    /myspring/src/main/webapp/WEB-INF/views/mycontent1/board/add.jsp 파일에서 input type="file" 인 name 의 이름(attach) 과 
	     동일해야만 파일첨부가 가능해진다.!!!!           
	 */
	
	
	public String getFileNo() {
		return fileNo;
	}
	public void setFileNo(String fileNo) {
		this.fileNo = fileNo;
	}
	public String getFk_postNo() {
		return fk_postNo;
	}
	public void setFk_postNo(String fk_postNo) {
		this.fk_postNo = fk_postNo;
	}
	public String getOrgFilename() {
		return orgFilename;
	}
	public void setOrgFilename(String orgFilename) {
		this.orgFilename = orgFilename;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileSize() {
		return fileSize;
	}
	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	public MultipartFile getAttach() {
		return attach;
	}
	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	
	
}
