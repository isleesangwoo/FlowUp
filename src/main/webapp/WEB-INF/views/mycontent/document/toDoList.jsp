<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>


<jsp:include page="document_main.jsp" />

<script type="text/javascript">

	$(document).ready(function(){
		
		
	}); // end of $(document).ready(function(){})-------------------------------------------------
	
</script>

	<div>
		<div>
			<h1>결제 대기 문서함</h1>
			<button>목록 다운로드</button>
			<button>문서 삭제</button>
		</div>
		
		<table class="table">
			<thead>
				<tr>
					<th>
						<input type="checkbox" />
					</th>
					<th>
						<span>기안일</span>
					</th>
					<th>
						<span>완료일</span>
					</th>
					<th>
						<span>결재양식</span>
					</th>
					<th>
						<span>제목</span>
					</th>
					<th>
						<span>첨부</span>
					</th>
					<th>
						<span>기안자</span>
					</th>
					<th>
						<span>문서번호</span>
					</th>
					<th>
						<span>결재상태</span>
					</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty requestScope.toDoList}">
					<c:forEach var="toDo" items="${requestScope.toDoList}">
						<tr>
							<td>
								<input type="checkbox" />
							</td>
							<td>
								<span>${toDo.draftDate}</span>
							</td>
							<td>
								<span>${toDo.approvalDate}</span>
							</td>
							<td>
								<span>${toDo.documentType}</span>
							</td>
							<td>
								<span>${toDo.subject}</span>
							</td>
							<td>
								<span></span>
							</td>
							<td>
								<span>${toDo.name}</span>
							</td>
							<td>
								<span>${toDo.documentNo}</span>
							</td>
							<td>
								<span>${toDo.status}</span>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty requestScope.toDoList}">
					<tr>
						<td colspan="6"><span>결제 대기 문서가 없습니다.</span></td>
					</tr>
				</c:if>
			</tbody>
		</table>
		
	</div>
</div>
<jsp:include page="../../footer/footer.jsp" /> 