<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>


<jsp:include page="document_main.jsp" />

<style type="text/css">
	
	.document:hover {
		cursor: pointer;
		background-color: gray;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		
	}); // end of $(document).ready(function(){})-------------------------------------------------
	
	
</script>

	<div>
		<div class="m-3">
			<h3 class="mb-3">기안문서함</h3>
			<button class="doc_btn">목록 다운로드</button>
		</div>
		<table id="myDocumentList" class="table">
			<thead>
				<tr>
					<th>
						<input type="checkbox" />
					</th>
					<th>
						<span>기안일</span>
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
						<span>문서번호</span>
					</th>
					<th>
						<span>결재상태</span>
					</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty requestScope.myDocumentList}">
					<c:forEach var="myDocument" items="${requestScope.myDocumentList}">
						<tr class="document" onclick="location.href='<%= ctxPath%>/document/documentView?documentNo=${myDocument.documentNo}&documentType=${myDocument.documentType}';">
							<td>
								<input type="checkbox" class="document_check" onclick='event.cancelBubble=true;'>
							</td>
							<td>
								<span>${myDocument.draftDate}</span>
							</td>
							<td>
								<span>${myDocument.documentType}</span>
							</td>
							<td>
								<span>${myDocument.subject}</span>
							</td>
							<td>
								<span></span>
							</td>
							<td>
								<span>${myDocument.documentNo}</span>
							</td>
							<td>
								<span>
									<c:if test="${myDocument.status == 0}">진행중</c:if>
									<c:if test="${myDocument.status == 1}">완료</c:if>
									<c:if test="${myDocument.status == 2}">반려</c:if>
								</span>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty requestScope.myDocumentList}">
					<tr>
						<td colspan="6"><span>기안 문서가 없습니다.</span></td>
					</tr>
				</c:if>
			</tbody>
		</table>
		
	</div>
</div>
<jsp:include page="../../footer/footer.jsp" /> 