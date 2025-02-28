<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    


<%@include file="../../header/header.jsp" %>
<%@include file="./updateMypageInfoLeftBar.jsp" %>

<link href="<%=ctxPath%>/css/employeeCss/myPage.css" rel="stylesheet">

<script type="text/javascript">

 $(document).ready(function(){
	 $("button#updateInfo").click(function(){
			//alert("버튼 누름");
			
			const frm = document.mypageInfoUpdateFrm;
			frm.action="<%=ctxPath%>/employee/updateInfoEnd";
			frm.method="post";
			frm.submit();
			
	 });// end of $("button#update").on('click',function{});
	

 });// end of $(document).ready(function{});
	

	
</script>
 
<div id="right-bar">
	<div id="right_title_box">
		<span id="right_title">내 정보 수정</span>
	</div>
	

	<div id="mypagecontent">
		<form name="mypageInfoUpdateFrm">
			<table class="profiletable">
				<colgroup>
					<col width="130px">
					<col width="*">
				</colgroup>
				<tbody>
					<tr>
						<th> <span class="title">사진</span></th>
						<td>
							<div id="profileImg">
								<svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
								<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
							    <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
								</svg>
								
							</div>
							<button class="updateProfileImg">사진등록</button>
							<br>
							<span class="profileimg_text">*사진은 자동적으로 150x150 사이즈로 적용됩니다</span>
						</td>
					</tr>
					<tr>
						<th><span class="title">이름</span></th>
						<td>${sessionScope.loginuser.name}</td>
					</tr>
					<tr>
						<th><span class="title">회사</span></th>
						<td>FlowUp</td>
					</tr>
					<tr>
						<th><span class="title">부서</span></th>
						<td>${sessionScope.loginuser.departmentName}</td>
					</tr>
					<tr>
						<th><span class="title">직위</span></th>
						<td>
						
							<c:choose>
				              <c:when test="${sessionScope.loginuser.FK_positionNo == 100001}">
				                  사원
				              </c:when>
				              <c:when test="${sessionScope.loginuser.FK_positionNo == 100002}">
				                  대리
				              </c:when>
				              <c:when test="${sessionScope.loginuser.FK_positionNo == 100003}">
				                  과장
				              </c:when>
				              <c:when test="${sessionScope.loginuser.FK_positionNo == 100004}">
				                  차장
				              </c:when>
				              <c:when test="${sessionScope.loginuser.FK_positionNo == 100005}">
				                  부장
				              </c:when>
				              <c:when test="${sessionScope.loginuser.FK_positionNo == 100006}">
				                  상무
				              </c:when>
				              <c:when test="${sessionScope.loginuser.FK_positionNo == 100007}">
				                  전무
				              </c:when>
				              <c:when test="${sessionScope.loginuser.FK_positionNo == 100008}">
				                  사장
				              </c:when>
				           </c:choose>	
						</td>
					</tr>
					<!-- 기존의 입력 되어있던 값을 보여준다. -->
					<tr>
						<th><span class="title">이메일</span></th>
						<td>
							<input class="myinfoinput" type="text" name="email" placeholder="${sessionScope.loginuser.email}">
						</td>
					</tr>
					<tr>
						<th><span class="title">전화번호</span></th>
						<td><input class="myinfoinput" type="text" name="mobile" placeholder="${sessionScope.loginuser.mobile}"></td>
					</tr>
					<tr>
						<th><span class="title">내선번호</span></th>
						<td><input class="myinfoinput" type="text" name="directCall" placeholder="${sessionScope.loginuser.directCall}"></td>
					</tr>
					<tr>
						<th><span class="title">생일</span></th>
						<td><input class="myinfoinput" type="date" name="birth" placeholder="${sessionScope.loginuser.birth}"></td>
					</tr>
					<tr>
						<th><span class="title">입사일</span></th>
						<td>${sessionScope.loginuser.registerDate}</td>
					</tr>
					<tr>
						<th><span class="title">집주소</span></th>
						<td><input class="myinfoinput" type="text" name="address" placeholder="${sessionScope.loginuser.address}"></td>
					</tr>
					<tr>
						<th><span class="title">동기</span></th>
						<td><input class="myinfoinput" type="text" name="motive" placeholder="${sessionScope.loginuser.motive}"></td>
						
						<td><input type="hidden" name="employeeNo" value="${sessionScope.loginuser.employeeNo}"></td>
					</tr>
				</tbody>
			</table>
			<button type="button" class="successInfoUpdate" id="updateInfo">수정</button>
			<button type="reset"class="cancelInfoUpdate">취소</button>
		</form>
	</div>
	
</div>
