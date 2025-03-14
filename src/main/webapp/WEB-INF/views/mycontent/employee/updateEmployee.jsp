<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String ctxPath = request.getContextPath();
   //     /flowUp
%>  


<jsp:include page="../../header/header.jsp" />
<link href="<%=ctxPath%>/css/employeeCss/updateEmployee_by_addmin.css" rel="stylesheet"> 


<div id="container">
	<div class="content_title">
		<h4>관리자의 사원 정보 수정</h4>
	</div>
	<div id="content">
		<form name = "updateEmployee_by_addmin">
		
			<select class="search_type">
				<option>사번</option>
				<option>팀</option>
				<option>부서</option>
				<option>이름</option>
			</select>
			<input type=text/>
			<button class="search_employee">검색</button>
			
			<div class="table_content">
			<table>
			<thead>
				<tr>
					<th>이름</th>
					<th>사번</th>
					<th>직급</th>
					<th>부서</th>
					<th>팀</th>
					<th>수정</th>
				</tr>
			</thead>
			<tbody>
				
				<tr>
					<td class="employee_name">이지혜</td>
					<td class="employee_no">100011</td>
					<td class="employee_position">차장</td>
					<td class="employee_department">경영관리부</td>
					<td class="employee_team">경영기획관리팀</td>
					<td>
						<button class="update">수정하기</button>
						<!-- <button class="update">수정취소</button><%-- 수정하기를 클릭 했을 때 나오는 버튼 --%> -->
					</td>
				</tr>
			</tbody>
			<tbody>
			</tbody>
			</table>
		 </div>
		 <a href="<%= ctxPath%>/employee/admin"id="noAddEmployee">사원등록취소</a>
		</form>
	
	</div>
</div>