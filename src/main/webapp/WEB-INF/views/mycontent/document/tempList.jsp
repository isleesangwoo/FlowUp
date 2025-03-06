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
			<h3 class="mb-3">임시저장함</h3>
			<button class="doc_btn mr-3">목록 다운로드</button>
			<button class="doc_btn">문서 삭제</button>
		</div>
		<table class="table">
			<thead>
				<tr>
					<th>
						<input type="checkbox" />
					</th>
					<th>
						<span>생성일</span>
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
						<span>결재상태</span>
					</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty requestScope.tempList}">
					<c:forEach var="temp" items="${requestScope.tempList}">
						<tr class="document">
							<td>
								<input type="checkbox" />
							</td>
							<td>
								<span>${temp.draftDate}</span>
							</td>
							<td>
								<span>${temp.documentType}</span>
							</td>
							<td>
								<span>${temp.subject}</span>
							</td>
							<td>
								<span></span>
							</td>
							<td>
								<span>임시저장</span>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty requestScope.tempList}">
					<tr>
						<td colspan="6"><span>임시 저장 문서가 없습니다.</span></td>
					</tr>
				</c:if>
			</tbody>
		</table>
		
	</div>
</div>
<jsp:include page="../../footer/footer.jsp" /> 