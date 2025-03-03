<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>


<jsp:include page="document_main.jsp" />

	<div style="width: 1000px;">
		<h1>${document.documentType}</h1>
		
		<div style="width: 300px; display: inline-block;">
			<table class="table">
				<tbody>
					<tr>
						<td style="border: solid 1px black;">기안자</td>
						<td style="border: solid 1px black;">${document.name}</td>
					</tr>
					<tr>
						<td style="border: solid 1px black;">소속</td>
						<td style="border: solid 1px black;">${document.teamName}</td>
					</tr>
					<tr>
						<td style="border: solid 1px black;">기안일</td>
						<td style="border: solid 1px black;">${document.draftDate}</td>
					</tr>
					<tr>
						<td style="border: solid 1px black;">문서번호</td>
						<td style="border: solid 1px black;">${document.documentNo}</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div style="display: inline-block; border: solid 1px black; width:600px;">
		
			<c:if test="${not empty requestScope.approvalList}">
				<c:forEach var="approval" items="${requestScope.approvalList}">
					<table>
						<tbody>
							<tr>
								<td rowspan="3" style="border: solid 1px black">승인</td>
								<td style="border: solid 1px black">${approval.positionName}</td>
							</tr>
							<tr>
								<td style="border: solid 1px black">${approval.name}</td>
							</tr>
							<tr>
								<td style="border: solid 1px black"> ${approval.executionDate}</td>
							</tr>
						</tbody>
					</table>
				</c:forEach>
			</c:if>
		</div>
		
		<div style="border: solid 1px gray; width: 1000px;">
			<form name="annualDraftForm">
				<input type="hidden" name="documentType" value="휴가신청서" />
				<input type="hidden" name="temp" value="0" />
				<h1 style="text-align: center">연차신청서</h1>
				<div style="display: inline-block; width: 300px">
					<table>
						<tbody>
							<tr>
								<td>기안자</td>
								<td>${document.name}</td>
							</tr>
							<tr>
								<td>기안부서</td>
								<td>${document.teamName}</td>
							</tr>
							<tr>
								<td>기안일</td>
								<td>${document.draftDate}</td>
							</tr>
							<tr>
								<td>문서번호</td>
								<td>${document.documentNo}</td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<div id="approval_line" style="text-align: right; display: inline-block; width: 690px">
				
					<!-- 결재 라인이 들어올 곳 -->
					
				</div>
				
				<table class="mt-5" style="width: 1000px;">
					<tbody>
						<tr>
							<td>제목</td>
							<td>${document.subject}</td>
						</tr>
						<tr>
							<td>휴가 종류</td>
							<td>
								<c:if test="${document.annualType == 1}">연차</c:if>
								<c:if test="${document.annualType == 2}">오전반차</c:if>
								<c:if test="${document.annualType == 3}">오후반차</c:if>
							</td>
						</tr>
						<tr>
							<td>사유</td>
							<td>${document.reason}</td>
						</tr>
						<tr>
							<td>기간 및 일시</td>
							<td>
								${document.startDate} ~ ${document.endDate}
							</td>
						</tr>
						<tr>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td>연차 일수</td>
							<td>
								${document.useAmount}
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
		
	</div>

</div>
<jsp:include page="../../footer/footer.jsp" /> 