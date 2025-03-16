package com.spring.app.employee.domain;

import org.springframework.web.multipart.MultipartFile;

public class EmployeeVO {

	
	 private String employeeNo;         // 사번
	 private String FK_positionNo;      // 직급번호
     private String FK_teamNo;         // 팀번호
     private String passwd;             // 비밀번호
     private String name;               // 이름
     private String securityLevel;      // 보안등급 // 0 < level <10
     private String email;              // 이메일
     private String mobile;             // 전화번호
     private String directCall;          // 내선번호
     private String bank;               // 은행  
     private String account;            // 계좌번호
     private String registerDate;       // 입사일
     private String status;             // 재직상태(1: 재직)
     private String lastDate;           // 퇴직일
     private String reasonForLeaving;   // 퇴직사유
     private String birth;				// 생년월일
     private String profileImg;			// 프로필 사진
     private String lastPweChange;		// 마지막 비밀번호 변경일
     private String motive;				// 동기
     private String FK_departmentNo;	//부서번호
     private String address;			// 집 주소		
     
     //테이블 추가 x
     private String departmentName;     // 부서 이름
     private String teamName;			// 팀이름
     private String positionName;		// 직급이름
	
     private boolean requireLastChangePwd = false; 
     
     private MultipartFile attach;   // 프로필 사진 업로드용
     private String fileSize;        // 업로드할 파일의 사이즈
     private String fileName; 		 // 톰캣에 올라갈 파일 이름
    /////////////////////////////////////////
    
     
 

	public String getEmployeeNo() {
		return employeeNo;
	}

	public void setEmployeeNo(String employeeNo) {
		this.employeeNo = employeeNo;
	}
	
	public String getFK_positionNo() {
		return FK_positionNo;
	}
	
	public void setFK_positionNo(String fK_positionNo) {
		FK_positionNo = fK_positionNo;
	}
	
	public String getFK_teamNo() {
		return FK_teamNo;
	}
	public void setFK_teamNo(String fK_teamNo) {
		FK_teamNo = fK_teamNo;
	}
	
	public String getPasswd() {
		return passwd;
	}
	
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getSecurityLevel() {
		return securityLevel;
	}
	
	public void setSecurityLevel(String securityLevel) {
		this.securityLevel = securityLevel;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getMobile() {
		return mobile;
	}
	
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getDirectCall() {
		return directCall;
	}
	
	public void setDirectCall(String directCall) {
		this.directCall = directCall;
	}
	
	public String getBank() {
		return bank;
	}
	
	public void setBank(String bank) {
		this.bank = bank;
	}
	
	public String getAccount() {
		return account;
	}
	
	public void setAccount(String account) {
		this.account = account;
	}
	
	
	public String getRegisterDate() {
		return registerDate;
	}
	public void setRegisterDate(String registerDate) {
		this.registerDate = registerDate;
	}
	
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getLastDate() {
		return lastDate;
	}
	
	public void setLastDate(String lastDate) {
		this.lastDate = lastDate;
	}
	
	public String getReasonForLeaving() {
		return reasonForLeaving;
	}
	
	public void setReasonForLeaving(String reasonForLeaving) {
		this.reasonForLeaving = reasonForLeaving;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	public boolean isRequireLastChangePwd() {
		return requireLastChangePwd;
	}

	public void setRequireLastChangePwd(boolean requireLastChangePwd) {
		this.requireLastChangePwd = requireLastChangePwd;
	}

	public String getMotive() {
		return motive;
	}

	public void setMotive(String motive) {
		this.motive = motive;
	}
	
	public String getLastPweChange() {
		return lastPweChange;
	}

	public void setLastPweChange(String lastPweChange) {
		this.lastPweChange = lastPweChange;
	}

	public String getFK_departmentNo() {
		return FK_departmentNo;
	}

	public void setFK_departmentNo(String fK_departmentNo) {
		FK_departmentNo = fK_departmentNo;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	///////////////// JOIN 해서 가져오기
	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	

   public MultipartFile getAttach() {
		return attach;
   }

   public void setAttach(MultipartFile attach) {
		this.attach = attach;
   }

	public String getFileSize() {
		return fileSize;
	}
	
	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	
	public String getFileName() {
		return fileName;
	}
	
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getTeamName() {
		return teamName;
	}

	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}

	public String getPositionName() {
		return positionName;
	}

	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}
   
   
	
     
     
	
}
