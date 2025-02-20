package com.spring.app.reservation.domain;

public class AssetVO {

	private String assetNo;         // 회의실 ID
	private String assetTitle; 		// 회의실 장소 대분류 명 (예: 4층 공용 공간)
	private String assetInfo;       // 회의실 장소 정보 (예: 소화기 배치도 및 비상구 위치 사진)
	private String assetRegisterday;// 회의실 등록일자
	private String assetChangeday;  // 회의실 수정일자
	private String classification;  // 회의실 / 자산 구분
	private String asseGroupno;     // 계층형 그룹
	private String asseDepthno;     // 계층형 표기를 위한 깊이
	
	
	
	
	
	
	///////////////////////////////////////////////
	
	
	public String getAssetNo() {
		return assetNo;
	}
	public void setAssetNo(String assetNo) {
		this.assetNo = assetNo;
	}
	public String getAssetTitle() {
		return assetTitle;
	}
	public void setAssetTitle(String assetTitle) {
		this.assetTitle = assetTitle;
	}
	public String getAssetInfo() {
		return assetInfo;
	}
	public void setAssetInfo(String assetInfo) {
		this.assetInfo = assetInfo;
	}
	public String getAssetRegisterday() {
		return assetRegisterday;
	}
	public void setAssetRegisterday(String assetRegisterday) {
		this.assetRegisterday = assetRegisterday;
	}
	public String getAssetChangeday() {
		return assetChangeday;
	}
	public void setAssetChangeday(String assetChangeday) {
		this.assetChangeday = assetChangeday;
	}
	public String getClassification() {
		return classification;
	}
	public void setClassification(String classification) {
		this.classification = classification;
	}
	public String getAsseGroupno() {
		return asseGroupno;
	}
	public void setAsseGroupno(String asseGroupno) {
		this.asseGroupno = asseGroupno;
	}
	public String getAsseDepthno() {
		return asseDepthno;
	}
	public void setAsseDepthno(String asseDepthno) {
		this.asseDepthno = asseDepthno;
	}
	
	
	
}
