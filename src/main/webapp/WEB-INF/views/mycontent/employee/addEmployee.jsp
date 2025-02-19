<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String ctxPath = request.getContextPath();
//     /myspring 
%>  

<link href="<%=ctxPath%>/css/employeeCss/addEmployee.css" rel="stylesheet"> 
<jsp:include page="../../header/header.jsp" /> 

<script type="text/javascript">

$(document).ready(function(){
	
	$("span.errorMsg").hide();
	$("span.errorMsg2").hide();
	
<%-- 사원 등록 --%>
 $("button#addEmployee").click(function(){
	 //alert("클릭됨");
	 
	 
	 
	 const employeeNoInfo = $("input.employeeNoInfo").val().trim();
	 if(employeeNoInfo ==  ""){
		 alert("사번을 입력해주세요!");
		 $("input.employeeNoInfo").val("").focus();
		 return;
	 }
	 
	 
	/*  // ---- 사번 유효성 검사 확인 ----
	 $("input.employeeNoInfo").blur((e)=>{
		 
		 const employeeNoInfo = $("input.employeeNoInfo").val().trim();
		 const regExp_employeeNoInfo = /^[ㄱ-ㅎ가-힣a-zA-Z]+$/ //한국어나 영어가 들어감
		 const bool = regExp_employeeNoInfo.test($(e.target).val());
		 
		 
		 if(bool){
			 $("input").prop("disabled", true);
				$("a#noAddEmployee").prop("disabled", false);  
				$(e.target).prop("disabled", false);
				$(e.target).val("").focus();
				$(e.target).parent().find("span.errorMsg2").show(); // 숫자가 아닌 다른 글자가 들어 갔을 때 경고문을 띄움
		 }
		 
		 else if(employeeNoInfo==""){
			 $("input").prop("disabled", true);
				$("a#noAddEmployee").prop("disabled", false);  
				$(e.target).prop("disabled", false);
				$(e.target).val("").focus();
				$(e.target).parent().find("span.errorMsg").show(); // 공백일 때 경고문을 띄움
		 }
		 
		 else{
			 $("input").prop("disabled", false);
			 $(e.target).parent().find("span.errorMsg2").hide();
			 $(e.target).parent().find("span.errorMsg").hide();
		 }
		 
	 }); // end of $("input.employeeNoInfo").blur((e)=>{})---------------------
	// ---- 사번 유효성 검사 확인 끝 ----
	  */
	 
	 // ----- 비밀번호 공백 확인 ------
	 const passwdInfo = $("input.passwdInfo").val().trim();
	 if(passwdInfo ==  ""){
		 alert("비밀번호를 입력해주세요!");
		 $("input.passwdInfo").val("").focus();
		 return;
	 }
	 
	 // --- 이름 공백 확인 ------
	 const nameInfo = $("input.nameInfo").val().trim();
	 if(nameInfo ==  ""){
		 alert("이름을 입력해주세요!");
		 $("input.nameInfo").val("").focus();
		 return;
	 }
	 
	 // --- 부서번호 공백 확인 ------
	 const deptNoInfo = $("input.deptNoInfo").val().trim();
	 if(deptNoInfo ==  ""){
		 alert("부서번호를 입력해주세요!");
		 $("input.deptNoInfo").val("").focus();
		 return;
	 }

	 
	// --- 팀번호 공백 확인 ------
	 const teamNoInfo = $("input.teamNoInfo").val().trim();
	 if(teamNoInfo ==  ""){
		 alert("팀번호를 입력해주세요!");
		 $("input.teamNoInfo").val("").focus();
		 return;
	 }
	 
	// --- 직급번호 공백 확인 ------
	 const positionNoInfo = $("input.positionNoInfo").val().trim();
	 if(positionNoInfo ==  ""){
		 alert("팀번호를 입력해주세요!");
		 $("input.positionNoInfo").val("").focus();
		 return;
	 }
	 
/* 	 
	// --- 내선번호 공백 확인 ------
	 const directCallInfo = $("input.directCallInfo").val().trim();
	 if(directCallInfo ==  ""){
		 alert("내선번호를 입력해주세요!");
		 $("input.directCallInfo").val("").focus();
		 return;
	 }
	  */
	 
	// --- 보안등급 공백 확인 ------
	 const securityInfo = $("input.securityInfo").val().trim();
	 if(securityInfo ==  ""){
		 alert("보안등급을 입력해주세요!");
		 $("input.securityInfo").val("").focus();
		 return;
	 }
	 
	 
	// --- 이메일 공백 확인 ------
	 const emailInfo = $("input.emailInfo").val().trim();
	 if(emailInfo ==  ""){
		 alert("이메일을 입력해주세요!");
		 $("input.emailInfo").val("").focus();
		 return;
	 }
	 
	 
	// --- 전화번호 공백 확인 ------
	 const mobileInfo = $("input.mobileInfo").val().trim();
	 if(mobileInfo ==  ""){
		 alert("전화번호를 입력해주세요!");
		 $("input.mobileInfo").val("").focus();
		 return;
	 }
	 
	 
	// --- 은행 공백 확인 ------
	 const banckInfo = $("input.bankInfo").val().trim();
	 if(banckInfo ==  ""){
		 alert("은행을 입력해주세요!");
		 $("input.banckInfo").val("").focus();
		 return;
	 }
	 
	 
	// --- 계좌 공백 확인 ------
	 const accountInfo = $("input.accountInfo").val().trim();
	 if(accountInfo ==  ""){
		 alert("계좌를 입력해주세요!");
		 $("input.accountInfo").val("").focus();
		 return;
	 }
	 
	 
	// --- 입사일 공백 확인 ------
	 const registerInfo = $("input.registerInfo").val().trim();
	 if(registerInfo ==  ""){
		 alert("계좌를 입력해주세요!");
		 $("input.registerInfo").val("").focus();
		 return;
	 }
	 
	 
	// --- 집주소 공백 확인 ------
	 const addressInfo = $("input.addressInfo").val().trim();
	 if(addressInfo ==  ""){
		 alert("집주소를 입력해주세요!");
		 $("input.addressInfo").val("").focus();
		 return;
	 }
	 
	// --- 생년월일 공백 확인 ------
	 const birthInfo = $("input.birthInfo").val().trim();
	 if(birthInfo ==  ""){
		 alert("생년월일을 입력해주세요!");
		 $("input.birthInfo").val("").focus();
		 return;
	 }
	 
	 
	 const frm = document.addEmployeeFrm;
	 frm.action = "<%= ctxPath%>/employee/addEmployeeFrm";
     frm.method = "post";
     frm.submit();
	 
 });

 
});



</script>

<div class="container">

	<div class="addtitle">
		<h3>회원추가</h3>
	</div>
	<hr>
	<div class="frmdiv">
		
		<form name="addEmployeeFrm">
		<ul>
	
			<li class="inputList">
			<span class="inputTitle">사번</span>
			<input type="text" class="frmInput employeeNoInfo" name="employeeNo" placeholder="6자리 숫자 조합"/>
			<!-- <span class="errorMsg">*사번을 입력해주세요!</span> first-child
			<span class="errorMsg2">*숫자로만 입력할 수 있습니다!</span> first-child -->
			</li>
			
			<li class="inputList">
			<span class="inputTitle">비밀번호</span>
			<input type="text" class="frmInput passwdInfo" name="passwd" placeholder="8~15자의 영어, 숫자 조합"/>
			<!-- <span class="errorMsg">*비밀번호를 입력해주세요!</span> nth-child(2)
			<span class="errorMsg2">*8~15자의 영어, 숫자 조합로만 입력할 수 있습니다!</span> nth-child(2) -->
			</li>
			
			<li class="inputList">
			<span class="inputTitle">이름</span>
			<input type="text" class="frmInput nameInfo" name="name"/>
			<!-- <span class="errorMsg">*이름을 입력해주세요!</span>nth-child(3) -->
			</li>
			
			<li class="inputList">
			<span class="inputTitle">부서번호</span>
			<input type="text" class="frmInput deptNoInfo" name="FK_departmentNo" placeholder="6자리 숫자 조합" maxlength="6"/>
			<!-- <span class="errorMsg">*부서번호를 입력해주세요!</span>nth-child(4)
			<span class="errorMsg2">*부서번호는 6자리로 입력해주세요!</span>nth-child(3) : 숫자가 6자리 미만이면 나올 메세지 -->
			</li>
			
			<li class="inputList">
			<span class="inputTitle">직위번호</span>
			<input type="text" class="frmInput positionNoInfo" name="FK_positionNo" placeholder="6자리 숫자 조합" maxlength="6"/>
			<!-- <span class="errorMsg">*직위번호를 입력해주세요!</span>nth-child(5)
			<span class="errorMsg2">*직위번호는 6자리로 입력해주세요!</span>nth-child(4) : 숫자가 6자리 미만이면 나올 메세지 -->
			</li>
			
			<li class="inputList">
			<span class="inputTitle">팀번호</span>
			<input type="text" class="frmInput teamNoInfo" name="FK_teamNo" placeholder="6자리 숫자 조합" maxlength="6"/>
			<!-- <span class="errorMsg">*팀번호를 입력해주세요!</span>nth-child(6)
			<span class="errorMsg2">*팀번호는 6자리로 입력해주세요!</span>nth-child(5) : 숫자가 6자리 미만이면 나올 메세지 -->
			</li>
			
			<li class="inputList">
			<input type="hidden" class="frmInput directCallInfo" name="directCall" placeholder="'-'없이 숫자로만 입력하세요" value="000000"/>
			<!-- <span class="errorMsg">*내선번호를 입력해주세요!</span>nth-child(7) -->
			</li>
			
			<li class="inputList">
			<span class="inputTitle">보안등급</span>
			<input type="text" class="frmInput securityInfo" name="securityLevel" placeholder="1~10 중 골라주세요."/> 
			<!-- <span class="errorMsg">*보안등급을 입력해주세요!</span>nth-child(8) -->
			</li>
			
			<li class="inputList">
			<span class="inputTitle">이메일</span>
			<input type="text" class="frmInput emailInfo" name="email" />
			<!-- <span class="errorMsg">*이메일을 입력해주세요!</span>nth-child(9) -->
			</li>
			
			<li class="inputList">
			<span class="inputTitle">전화번호</span>
			<input type="text" class="frmInput mobileInfo" name="mobile" placeholder="'-'없이 숫자로만 입력하세요"/>
		<!-- 	<span class="errorMsg">*전화번호를 입력해주세요!</span>nth-child(10) -->
			</li>
			
			<li class="inputList">
			<span class="inputTitle">은행</span>
			<input type="text" class="frmInput bankInfo" name="bank" />
			<!--<span class="errorMsg">*은행을 입력해주세요!</span> nth-child(11) -->
			</li>
			
			<li class="inputList">
			<span class="inputTitle">계좌</span>
			<input type="text" class="frmInput accountInfo" name="account" placeholder="'-'없이 숫자로만 입력하세요"/>
			<!--<span class="errorMsg">*계좌번호를 입력해주세요!</span> nth-child(12) -->
			</li>
			
			<li class="inputList">
			<span class="inputTitle">입사일</span>
			<input type="text" class="frmInput registerInfo" name="registerDate" placeholder="'-'없이 숫자로만 입력하세요"/>
			<!--<span class="errorMsg">*입사일을 입력해주세요!</span> nth-child(13) -->
			</li>
			
			<li class="inputList">
			<span class="inputTitle">주소</span>
			<input type="text" class="frmInput addressInfo" name="address"/>
			<!--<span class="errorMsg">*주소를 입력해주세요!</span> nth-child(14) -->
			</li>
			
			<li class="inputList">
			<span class="inputTitle">생년월일</span>
			<input type="text" class="frmInput birthInfo" name="birth" placeholder="'-'없이 숫자로만 입력하세요"/>
			<!--  <span class="errorMsg">*생년월일을 입력해주세요!</span>- last-child -->
			</li>
			
			<!-- status 기본적으로 상태 1로 맞춘다. -->
			<li>
			<input type="hidden" class="frmInput status" name="status" value="1"/>
			</li>
		</ul>
		<hr>
			
		 <button type="button" id="addEmployee" > 사원등록 </button>	<!-- 누르면 사원이 추가됨 -->
		 <!-- <button type="reset" id="noAddEmployee"> 사원등록취소 </button> -->	<!-- 누르면 사원 추가가 취소 되고 관리자 페이지로 돌아감.  -->
		 <a href="<%= ctxPath%>/employee/admin"id="noAddEmployee">사원등록취소</a>
	
		</form>
		
	</div>

</div>