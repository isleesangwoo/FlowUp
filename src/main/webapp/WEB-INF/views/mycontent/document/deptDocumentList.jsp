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
			<h1>부서문서함</h1>
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
				<c:if test="${not empty requestScope.deptDocumentList}">
					<c:forEach var="deptDocument" items="${requestScope.deptDocumentList}">
						<tr class="document" onclick="location.href='<%= ctxPath%>/document/documentView?documentNo=${deptDocument.documentNo}&documentType=${deptDocument.documentType}';">
							<td>
								<input type="checkbox" class="document_check" onclick='event.cancelBubble=true;'>
							</td>
							<td>
								<span>${deptDocument.draftDate}</span>
							</td>
							<td>
								<span>${deptDocument.approvalDate}</span>
							</td>
							<td>
								<span>${deptDocument.documentType}</span>
							</td>
							<td>
								<span>${deptDocument.subject}</span>
							</td>
							<td>
								<span></span>
							</td>
							<td>
								<span>${deptDocument.name}</span>
							</td>
							<td>
								<span>${deptDocument.documentNo}</span>
							</td>
							<td>
								<span>
									<c:if test="${deptDocument.status == 0}">진행중</c:if>
									<c:if test="${deptDocument.status == 1}">완료</c:if>
									<c:if test="${deptDocument.status == 2}">반려</c:if>
								</span>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty requestScope.deptDocumentList}">
					<tr>
						<td colspan="6"><span>기안 문서가 없습니다.</span></td>
					</tr>
				</c:if>
			</tbody>
		</table>
		
	</div>
</div>
<jsp:include page="../../footer/footer.jsp" /> 