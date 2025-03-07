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
			$("h3#approve_title").text("결재하기");
			$("th.reason").text("결재의견");
			$("button#execute_btn").text("승인");
			$("button#execute_btn").addClass("approve_btn");
			$("button#execute_btn").removeClass("reject_btn");
			open_modal();
		});
		
		// 반려 버튼 클릭 시
		$("button#reject_btn").click(e=>{
			$("h3#approve_title").text("반려하기");
			$("th.reason").text("반려의견");
			$("button#execute_btn").text("반려");
			$("button#execute_btn").addClass("reject_btn");
			$("button#execute_btn").removeClass("approve_btn");
			open_modal();
		});
		
		// 모달 창에서 승인/반려 버튼 클릭시
		
		
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
			<h3 id="approve_title" class="mb-5"></h3>
			<table>
				<tbody>
					<tr>
						<th>결재문서명</th>
						<td>${document.subject}</td>
					</tr>
					<tr>
						<th class="reason"><span></span></th>
						<td><textarea name="approve_reason" class="approve_modal_reason"></textarea></td>
					</tr>
				</tbody>
			</table>
			<div class="mt-5 text-right">
				<button id="execute_btn">승인</button>
				<button onclick="close_modal()" class="approve_btn ml-3">취소</button>
			</div>
		</div>
	</div>
	

	<div class="m-3 draftForm">
		<h1 class="mb-3">${document.documentType}</h1>
		
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
						<button id="approve_btn" class="doc_btn">결재</button>
						<button id="reject_btn" class="doc_btn">반려</button>
					</c:if>
				</c:if>
			</c:forEach>
		</c:if>
		<!-- 결재해야할 문서 (결재 순서가 자기 차례인 문서)를 보는 경우 결재/반려 버튼이 보이도록 -->
		
		<h3 style="text-align: center">연차신청서</h3>
	
		<div class="drafter_info" style="display: inline-block;">
			
			<table>
				<tbody>
					<tr>
						<th>기안자</th>
						<td>${document.name}</td>
					</tr>
					<tr>
						<th>소속</th>
						<td>${document.teamName}</td>
					</tr>
					<tr>
						<th>기안일</th>
						<td>${document.draftDate}</td>
					</tr>
					<tr>
						<th>문서번호</th>
						<td>${document.documentNo}</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="m-3 p-3" style="display: inline-block;">
		
			<!-- 결재 라인이 들어올 곳 -->
			<div class="approval_info" id="approval_line">
				<c:if test="${not empty requestScope.approvalList}">
					<c:forEach var="approval" items="${requestScope.approvalList}">
						<table class="ml-2" style="display: inline-block;">
							<tbody>
								<tr>
									<th rowspan="4" style="width: 50px;">승인</th>
									<td>${approval.positionName}</td>
								</tr>
								<tr>
									<td>${approval.approvalStatus}</td>
								</tr>
								<tr>
									<td>${approval.name}</td>
								</tr>
								<tr>
									<td>${approval.executionDate}</td>
								</tr>
							</tbody>
						</table>
					</c:forEach>
				</c:if>
			</div>
			<!-- 결재 라인이 들어올 곳 -->
		</div>
		<div>	
			<table class="mt-5" style="width: 1000px;">
				<tbody>
					<tr>
						<th>제목</th>
						<td>${document.subject}</td>
					</tr>
					<tr>
						<th>휴가 종류</th>
						<td><c:if test="${document.annualType == 1}">연차</c:if> <c:if
								test="${document.annualType == 2}">오전반차</c:if> <c:if
								test="${document.annualType == 3}">오후반차</c:if></td>
					</tr>
					<tr>
						<th>사유</th>
						<td>${document.reason}</td>
					</tr>
					<tr>
						<th>기간 및 일시</th>
						<td>${document.startDate} ~ ${document.endDate}</td>
					</tr>
					<tr>
						<th>신청 연차 일수</th>
						<td>${document.useAmount}</td>
					</tr>
					<tr>
						<th class="pl-4" colspan="2" style="text-align: left;">
							1. 연차의 사용은 근로기준법에 따라 전년도에 발생한 개인별 잔여 연차에 한하여 사용함을 원칙으로 한다.
							<br>단, 최초 입사시에는 근로 기준법에 따라 발생 예정된 연차를 차용하여 월 1회 사용 할 수 있다.
							<br>2. 경조사 휴가는 행사일을 증명할 수 있는 가족 관계 증명서 또는 등본, 청첩장 등 제출
							<br>3. 공가(예비군/민방위)는 사전에 통지서를, 사후에 참석증을 반드시 제출
						</th>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

</div>
<jsp:include page="../../footer/footer.jsp" />
