package com.spring.app.board.domain;

public class PostFileVO {
	private String fileNo;          
	private String fk_postNo;       // 글번호 
	private String orgFilename;     // 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명 
	private String fileName;        // WAS(톰캣)에 저장될 파일명(2025020709291535243254235235234.png) 
	private String fileSize;        // 파일크기 
	
	
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
	
	
}
