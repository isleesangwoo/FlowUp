<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();
%>

<jsp:include page="document_main.jsp" />

<script type="text/javascript">
	
	$(document).ready(function(){
		
	});

</script>


	<div id="right_title_box">
    	<h5 class="doc_title">전자결재 홈</h5>

	</div>
	<div>
        <div class="doc_todo_box" style="display: flex;">
        	<c:if test="${not empty requestScope.todoList}">
        		<c:forEach var="todo" items="${requestScope.todoList}">
        			<div class="card todo_card m-4">
        				<div class="card-body">
        					<span class="p-1 mb-2 in_progress">진행중</span><c:if test="${todo.urgent == 1}"><span class="p-1 urgent ml-2">긴급</span></c:if>
        					<span class="card_subject">${todo.subject}</span>
        					<span>기안자:  ${todo.name} ${todo.positionName}</span>
        					<span>기안일:  ${todo.draftDate}</span>
        					<span>결재양식: ${todo.documentType}</span>
        				</div>
        				<div class="card-footer" onclick="location.href='<%= ctxPath%>/document/documentView?documentNo=${todo.documentNo}&documentType=${todo.documentType}';">
        					<button>결재하기</button>
        				</div>
        			</div>
        		</c:forEach>
        	</c:if>
        	<c:if test="${empty requestScope.todoList}">
				<span>결재할 문서가 없습니다.</span>
			</c:if>
	    </div>
	    
        <div class="doc_box">
        	<h6 class="m-3">기안 진행 문서</h6>
        	<table class="table">
        		<thead class="doc_box_thead">
        			<tr>
	        			<th>기안일</th>
	        			<th>결재양식</th>
	        			<th>긴급</th>
	        			<th>제목</th>
	        			<th>첨부</th>
	        			<th>문서번호</th>
	        			<th>결재상태</th>
        			</tr>
        		</thead>
        		<tbody>
        			<c:if test="${not empty requestScope.progressList}">
						<c:forEach var="progress" items="${requestScope.progressList}">
							<tr class="document" onclick="location.href='<%= ctxPath%>/document/documentView?documentNo=${progress.documentNo}&documentType=${progress.documentType}';">
								<td>
									<span>${progress.draftDate}</span>
								</td>
								<td>
									<span>${progress.documentType}</span>
								</td>
								<td>
									<c:if test="${progress.urgent == 1}"><span class="p-1 urgent">긴급</span></c:if>
								</td>
								<td>
									<span>${progress.subject}</span>
								</td>
								<td>
									<span></span>
								</td>
								<td>
									<span>${progress.documentNo}</span>
								</td>
								<td>
									<c:if test="${progress.status == 0}"><span class="p-1 in_progress">진행중</span></c:if>
									<c:if test="${progress.status == 1}"><span class="p-1 approved">완료</span></c:if>
									<c:if test="${progress.status == 2}"><span class="p-1 rejected">반려</span></c:if>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty requestScope.progressList}">
						<tr>
							<td colspan="7"><span>기안 진행중인 문서가 없습니다.</span></td>
						</tr>
					</c:if>
        		</tbody>
        	</table>
	    </div>
	    
	    
        <div class="doc_box">
        	<h6 class="m-3">완료 문서</h6>
        	<table class="table">
        		<thead class="doc_box_thead">
        			<tr>
	        			<th>기안일</th>
	        			<th>기안일</th>
	        			<th>결재양식</th>
	        			<th>긴급</th>
	        			<th>제목</th>
	        			<th>첨부</th>
	        			<th>문서번호</th>
	        			<th>결재상태</th>
        			</tr>
        		</thead>
        		<tbody>
        			<c:if test="${not empty requestScope.completedList}">
						<c:forEach var="completed" items="${requestScope.completedList}">
							<tr class="document" onclick="location.href='<%= ctxPath%>/document/documentView?documentNo=${completed.documentNo}&documentType=${completed.documentType}';">
								<td>
									<span>${completed.draftDate}</span>
								</td>
								<td>
									<span>${completed.approvalDate}</span>
								</td>
								<td>
									<span>${completed.documentType}</span>
								</td>
								<td>
									<c:if test="${progress.urgent == 1}"><span class="p-1 urgent">긴급</span></c:if>
								</td>
								<td>
									<span>${completed.subject}</span>
								</td>
								<td>
									<span></span>
								</td>
								<td>
									<span>${completed.documentNo}</span>
								</td>
								<td>
									<c:if test="${completed.status == 0}"><span class="p-1 in_progress">진행중</span></c:if>
									<c:if test="${completed.status == 1}"><span class="p-1 approved">완료</span></c:if>
									<c:if test="${completed.status == 2}"><span class="p-1 rejected">반려</span></c:if>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty requestScope.completedList}">
						<tr>
							<td colspan="8"><span>완료된 없습니다.</span></td>
						</tr>
					</c:if>
        		</tbody>
        	</table>
	    </div>
	    
	    
	</div>
	
<jsp:include page="../../footer/footer.jsp" /> 