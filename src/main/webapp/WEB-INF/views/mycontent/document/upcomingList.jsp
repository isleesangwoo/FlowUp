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
		<div class="m-3">
			<h3 class="mb-3">결재 대기 문서함</h3>
			<button class="doc_btn">목록 다운로드</button>
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
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty requestScope.upcomingList}">
					<c:forEach var="upcoming" items="${requestScope.upcomingList}">
						<tr class="document" onclick="location.href='<%= ctxPath%>/document/documentView?documentNo=${upcoming.documentNo}&documentType=${upcoming.documentType}';">
							<td>
								<input type="checkbox" class="document_check" onclick='event.cancelBubble=true;'>
							</td>
							<td>
								<span>${upcoming.draftDate}</span>
							</td>
							<td>
								<span>${upcoming.documentType}</span>
							</td>
							<td>
								<span>${upcoming.subject}</span>
							</td>
							<td>
								<span></span>
							</td>
							<td>
								<span>${upcoming.name}</span>
							</td>
							<td>
								<span>${upcoming.documentNo}</span>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty requestScope.upcomingList}">
					<tr>
						<td colspan="6"><span>결재 예정 문서가 없습니다.</span></td>
					</tr>
				</c:if>
			</tbody>
		</table>
		
	</div>
</div>
<jsp:include page="../../footer/footer.jsp" /> 