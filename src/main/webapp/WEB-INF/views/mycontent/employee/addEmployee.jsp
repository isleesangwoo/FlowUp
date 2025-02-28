<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   String ctxPath = request.getContextPath();
   //     /flowUp
%>  

<jsp:include page="../../header/header.jsp" />

<link href="<%=ctxPath%>/css/employeeCss/addEmployee.css" rel="stylesheet"> 
 
<style type="text/css">
   span.error {
   	  color: red;
   }
</style>

<script type="text/javascript">

$(document).ready(function(){
	$("input:text[name='employeeNo']").focus();
	
	// === 샘 시작=== //=========================================================
			
	// --- 부서번호 입력해주기 시작 ---
	$.ajax({
		url:"<%= ctxPath%>/employee/departmentno_select",
		dataType:"json",
		async:false,
		succcess:function(json){
	       alert(JSON.stringify(json));
			
	       /*
	          [{"departmentno":"100000", "departmentname":" "}
	          ,{"departmentno":"100002", "departmentname":"영업부"}
	          ,{"departmentno":"100003", "departmentname":"총무부"}
	          ,{"departmentno":"100004", "departmentname":"물류부"}
	          ,{"departmentno":"100005", "departmentname":"관리부"}
	          ]
	       */
		},
		error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	    }	
	});
	// --- 부서번호 입력해주기 끝 ---
		
	$("span.error").hide();
	
	$("input:text[name='employeeNo']").keyup(function(e){
		
		 const regExp = /^[0-9]+$/;
		
		 const bool = regExp.test($(e.target).val());
		 
		 if(!bool) { // 입력한 글자가 숫자가 아닌 경우
			 $(e.target).next().show(); 
		 
			 const current_val = $(e.target).val();
		     const str_only_number = current_val.substring(0, current_val.length-1);
		     $(e.target).val(str_only_number);
		 }
		 else if( $(e.target).val().substring(0, 1) === '0' ){ // 처음 시작하는 숫자가 '0' 일 경우
			 $(e.target).next().show(); 
			 
			 const current_val = $(e.target).val();
		     const str_only_number = current_val.substring(0, current_val.length-1);
		     $(e.target).val(str_only_number);
		 }
		 else if($(e.target).val().length < 6 ) { // 입력한 글자가 모두 숫자이지만 글자수가 6글자 미만인 경우 
			 $(e.target).next().show();
		 }
		 else if($(e.target).val().length > 6 ) { // 입력한 글자가 모두 숫자이지만 글자수가 6글자를 초과한 경우 
			 $(e.target).next().show();
		 
			 const current_val = $(e.target).val();
		     const str_only_number = current_val.substring(0, current_val.length-1);
			       
			 $(e.target).val(str_only_number);
		 }
		 else { // 모두가 숫자 6자리로만 채워진 경우
			 $(e.target).next().hide();
		 }
		 
	 });
	
	
	$("input:text[name='employeeNo']").blur(function(e){
		
		 const regExp = /^[0-9]+$/;
		 
		 const bool = regExp.test($(e.target).val());
		 
		 if(bool && $(e.target).val().length == 6) { // 모두가 숫자 6자리로만 채워진 경우
			 $(e.target).next().hide(); 
		 }
		 else { // 모두가 숫자 6자리로만 채워것이 아닌 경우
			 $(e.target).next().show();
			 $(e.target).focus();
		 }
 
	 });
	 // === 샘 끝=== //=========================================================
	 
	 // === 지혜 시작 === //
	 <%-- ======== 비밀번호 검사 시작 ======== --%>
	 $("input:text[name='passwd']").blur(function(e) {
		 
		 const regExp =  /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
		 const bool = regExp.test($(e.target).val());
		 
		 if(!bool){
			 $(e.target).next().show(); 
			 $(e.target).focus();
		 }
		 
		 else{
			 $(e.target).next().hide();  
		 }

	});// end of  $("input:text[name='passwd']").keyup(function(e) {});----------
	
	$("input:text[name='passwd']").keyup(function(e){
		if($(e.target).val().length < 8){
			$(e.target).next().show(); 
			$(e.target).focus();
		}
		else if($(e.target).val().length > 15){
			$(e.target).next().show(); 
			
			const current_val = $(e.target).val();
			const str_passwd = current_val.substring(0, current_val.length-1);
			
			$(e.target).val(str_passwd);
		}
		
		else{
			$(e.target).next().hide
		}
	});
	 <%-- ======== 비밀번호 검사 끝 ======== --%>
	 
	 
	 <%-- ========= 이름 검사 시작 ========= --%>
	 $("input:text[name='name']").blur(function(e){
		 
		 const regExp= /^[가-힣]{2,6}$/ // 한글이 2~6자리
		 const bool = regExp.test($(e.target).val());
		 
		 if(!bool){
			 
			 $(e.target).next().show();
			 $(e.target).focus();
			 
		 }
		 else{
				$(e.target).next().hide();
		 }
		 
	 })	;
	
	 <%-- ========= 이름 검사 끝 =========  --%>
	 
	 
	 <%-- ========= 이메일 검사 시작 ========= --%>
	 
	 $("input:text[name='email']").blur(function(e){
		 
		 const regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; 
		 const bool = regExp.test($(e.target).val());
		 
		 if(!bool){
			 $(e.target).next().show();
			 $(e.target).focus();
		 }
		 else{
				$(e.target).next().hide();
		 }
		 
	 });
	 
	 <%-- ========= 이메일 검사  끝 ========= --%>

	 
	
	// === 지혜 시작 끝 === //
	
	
	
	
	
	
<%-- 사원 등록 --%>
 $("button#addEmployee").click(function(){

	 
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
		 alert("직급번호를 입력해주세요!");
		 $("input.positionNoInfo").val("").focus();
		 return;
	 }
	 
	/* 	 s
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
		 alert("입사일을 입력해주세요!");
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
		<h3>사원추가</h3>
	</div>
	<div class="frmdiv">
		
		<form name="addEmployeeFrm">
		<ul>
	
			<li class="inputList">
				<span class="inputTitle">사번</span>
				<input type="text" class="frmInput employeeNoInfo" name="employeeNo" placeholder="6자리 숫자 조합"/>
				<span class="error">사번은 숫자 6자리 입력하세요</span>
			</li>
			
			<li class="inputList">
				<span class="inputTitle">비밀번호</span>
				<input type="text" class="frmInput passwdInfo" name="passwd" placeholder="8~15자의 영어, 숫자 조합"/>
				<span class="error">비밀번호는 8~15자의 영어와 숫자, 특수문자가 포함되어야합니다.</span>
			</li>
			
			<li class="inputList">
				<span class="inputTitle">이름</span>
				<input type="text" class="frmInput nameInfo" name="name" />
				<span class="error">이름을 입력하세요</span>
			</li>
			
			<li class="inputList">
				<span class="inputTitle">부서번호</span>
	<!-- 		<input type="text" class="frmInput deptNoInfo" name="FK_departmentNo" placeholder="6자리 숫자 조합" maxlength="6"/> -->
				<select name="departmentNo">
					<option value="defaultselect">부서번호를 선택하세요</option>
					<option value="100002" class="deptNoAndName">100002(영업부)</option>
					<option value="100003" class="deptNoAndName">100003(총무부)</option>
					<option value="100004" class="deptNoAndName">100004(물류부)</option>
					<option value="100005" class="deptNoAndName">100004(관리부)</option>
				</select>
			
			</li>
			
			<li class="inputList">
			<span class="inputTitle">직위번호</span>
			<input type="text" class="frmInput positionNoInfo" name="FK_positionNo" placeholder="6자리 숫자 조합" maxlength="6"/>
			
			<li class="inputList">
			<span class="inputTitle">팀번호</span>
			<input type="text" class="frmInput teamNoInfo" name="FK_teamNo" placeholder="6자리 숫자 조합" maxlength="6"/>
			</li>
			
			
			<li class="inputList">
			<input type="hidden" class="frmInput directCallInfo" name="directCall" placeholder="'-'없이 숫자로만 입력하세요" value="1"/>
			</li>
			
			
			<li class="inputList">
			<span class="inputTitle">보안등급</span>
			<input type="text" class="frmInput securityInfo" name="securityLevel" placeholder="1~10 중 골라주세요."/> 
			</li>
			
			<li class="inputList">
			<span class="inputTitle">이메일</span>
			<input type="text" class="frmInput emailInfo" name="email" placeholder="예) honggildong@naver.com"/>
			<span class="error">이메일의 형식에 맞춰서 입력하세요</span>
			</li>
			
			<li class="inputList">
			<span class="inputTitle">전화번호</span>
			<input type="text" class="frmInput mobileInfo" name="mobile" placeholder="'-'없이 숫자로만 입력하세요"/>
			</li>
			
			<li class="inputList">
			<span class="inputTitle">은행</span>
			<input type="text" class="frmInput bankInfo" name="bank" />
			</li>
			
			<li class="inputList">
			<span class="inputTitle">계좌</span>
			<input type="text" class="frmInput accountInfo" name="account" placeholder="'-'없이 숫자로만 입력하세요"/>
			</li>
			
			<li class="inputList">
			<span class="inputTitle">입사일</span>
			<input type="text" class="frmInput registerInfo" name="registerDate" placeholder="'-'없이 숫자로만 입력하세요"/>
			</li>
			
			<li class="inputList">
			<span class="inputTitle">주소</span>
			<input type="text" class="frmInput addressInfo" name="address"/>
			</li>
			
			<li class="inputList">
			<span class="inputTitle">생년월일</span>
			<input type="text" class="frmInput birthInfo" name="birth" placeholder="'-'없이 숫자로만 입력하세요"/>
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