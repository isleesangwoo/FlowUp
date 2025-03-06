<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String ctxPath = request.getContextPath();
%>

<jsp:include page="document_main.jsp" />

<script type="text/javascript">

	$(document).ready(function(){
		
		// 모달 바깥 부분을 클릭했을 때 모달이 사라지게 하기
	    $('.modal_bg:not(.modal_container_document)').click(e=>{
	    	close_modal();
	    });
		
	 	// 결재 버튼 클릭 시
		$("button#approve_btn").click(e=>{
			open_modal();
		});
		
		// 반려 버튼 클릭 시
		$("button#reject_btn").click(e=>{
			
		});
		
	}); // end of $(document).ready(function(){})---------------------

	// 모달창 보이게 하기
	function open_modal() {
		$('#approve_modal_bg').fadeIn();
		$('.box_modal_container').css({
			'display':'block'
		});
	}
	
	// 모달창 사라지게 하기
	function close_modal() {
		$('#approve_modal_bg').fadeOut();
        $('.box_modal_container').css({
        	'display':''
		});
	}
	
	// 결재 모달에서 확인 버튼 클릭 시
	function approve() {
		
		$.ajax({
			url:"<%=ctxPath%>/document/documentView/approve",
			dataType:"json",
			data:{"documentNo":"${document.documentNo}"},
			success:function(json){
				if(json.n == 1) {
					alert("결재 성공");
					location.href='<%=ctxPath%>/document/documentView?documentNo=${document.documentNo}&documentType=${document.documentType}';
				}
				else {
					alert("결재 실패");
				}
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	}
	
</script>


<!-- 결재처리 모달 -->
<div id="approve_modal_bg" class="modal_bg">
	<!-- 모달창을 띄웠을때의 뒷 배경 -->
</div>
<div id="approve_modal_container" class="box_modal_container">

	<div class="m-5">
		<h3 class="mb-5">결재하기</h3>
		<table>
			<tbody>
				<tr>
					<th>결재문서명</th>
					<td>${document.subject}</td>
				</tr>
				<tr>
					<th class="reason"><span>결재의견</span></th>
					<td><textarea name="approve_reason" class="approve_modal_reason"></textarea></td>
				</tr>
			</tbody>
		</table>
		<div class="mt-5 text-right">
			<button onclick="approve()" class="approve_btn">승인</button>
			<button onclick="close_modal()" class="approve_btn ml-3">취소</button>
		</div>
	</div>
</div>


<div style="width: 1000px;">
	<h1>${document.documentType}</h1>

	<!-- 결재해야할 문서 (결재 순서가 자기 차례인 문서)를 보는 경우 결재/반려 버튼이 보이도록 -->
	<c:if test="${not empty requestScope.approvalList}">
		<c:set var="isOrder" value="true" />
		<c:forEach var="approval" items="${requestScope.approvalList}">
			<c:if test="${isOrder}">
				<c:if
					test="${approval.approvalStatus eq 0 && sessionScope.loginuser.employeeNo ne approval.fk_approver}">
					<c:set var="isOrder" value="false" />
				</c:if>
				<c:if
					test="${approval.approvalStatus eq 0 && sessionScope.loginuser.employeeNo eq approval.fk_approver}">
					<button id="approve_btn">결재</button>
					<button id="reject_btn">반려</button>
				</c:if>
			</c:if>
		</c:forEach>
	</c:if>
	<!-- 결재해야할 문서 (결재 순서가 자기 차례인 문서)를 보는 경우 결재/반려 버튼이 보이도록 -->

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

	<div style="display: inline-block; width: 600px;">

		<c:if test="${not empty requestScope.approvalList}">
			<c:forEach var="approval" items="${requestScope.approvalList}">
				<table style="display: inline-block;">
					<tbody>
						<tr>
							<td rowspan="4" style="border: solid 1px black">승인</td>
							<td style="border: solid 1px black">${approval.positionName}</td>
						</tr>
						<tr>
							<td style="border: solid 1px black">${approval.approvalStatus}</td>
						</tr>
						<tr>
							<td style="border: solid 1px black">${approval.name}</td>
						</tr>
						<tr>
							<td style="border: solid 1px black">
								${approval.executionDate}</td>
						</tr>
					</tbody>
				</table>
			</c:forEach>
		</c:if>
	</div>

	<div style="border: solid 1px gray; width: 1000px;">
		<form name="annualDraftForm">
			<input type="hidden" name="documentType" value="휴가신청서" /> <input
				type="hidden" name="temp" value="0" />
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

			<div id="approval_line"
				style="text-align: right; display: inline-block; width: 690px">

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
						<td><c:if test="${document.annualType == 1}">연차</c:if> <c:if
								test="${document.annualType == 2}">오전반차</c:if> <c:if
								test="${document.annualType == 3}">오후반차</c:if></td>
					</tr>
					<tr>
						<td>사유</td>
						<td>${document.reason}</td>
					</tr>
					<tr>
						<td>기간 및 일시</td>
						<td>${document.startDate} ~ ${document.endDate}</td>
					</tr>
					<tr>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>연차 일수</td>
						<td>${document.useAmount}</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>

</div>

</div>
<jsp:include page="../../footer/footer.jsp" />
