<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%
   String ctxPath = request.getContextPath();

	Date date = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd(E)");
	String today = sdf.format(date);
	
%>


<jsp:include page="document_main.jsp" />

<style type="text/css">
	td {
		border: solid 1px gray;
	}
	
	.approval_line_modal_container {
		border-radius: 3%;
		display: none;
		text-align: center;
		position: fixed;
		min-width: 600px;
		min-height: 300px;
		width: 50%;
		height: 60vh;
		z-index: 11;
		top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
	    background-color: #fff;
	    overflow: hidden;
	}
	
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
	
		$('#approve_line').click(e=>{

	        $('#approve_line_modal').fadeIn();
			$('.approval_line_modal_container').css({
				'display':'block'
			})
	  
	    }) // end of $('#goMail').click(e=>{})-----------

	    $('.modal_bg:not(.modal_container_document)').click(e=>{

	        $('#approve_line_modal').fadeOut();
	        $('.approval_line_modal_container').css({
	        	'display':''
			})

	    })
	    
		$('.close').click(e=>{
			
			$('#approve_line_modal').fadeOut();
			$('.approval_line_modal_container').css({
				'width': '0%'
			})
			
			
		}); // end of $('.close').click(e=>{})---------- 
		
	}); // end of $(document).ready(funtion(){})-----------------------------------

	
	// 사용연차 개수 계산하기
	function calAnnualAmount(){
		
		if($("select[name='annualType']").val() != "1") {
			// 반차일 경우
			
			$("input[name='endDate']").val($("input[name='startDate']").val());
			$("input[name='endDate']").hide(); // 종료일 선택을 숨기기
			
			if($("input[name='startDate']").val() != ""){
				$("input[name='useAmount']").val(0.5);	// 신청 연차에 값 넣어주기
			}
		}
		else {
			// 연차일 경우
			$("input[name='endDate']").show();	// 종료일 선택 다시 보여주기
			
			let startDate = $("input[name='startDate']").val();
			let endDate = $("input[name='endDate']").val();
			
			if(startDate != "" && endDate != "") {
				// 시작일과 종료일 둘 다 선택했을 경우
				
				// console.log(startDate);
				// console.log(endDate);
				
				if(startDate <= endDate) {
					// 종료일이 시작일 이후인 경우
					startDate = Number(startDate.split("-").join(""));
					endDate = Number(endDate.split("-").join(""));
					
					$("input[name='useAmount']").val(endDate - startDate + 1);	// 신청 연차에 값 넣어주기
				}
				else {
					// 종료일이 시작일 이전인 경우
					alert("종료일은 시작일보다 이후여야 합니다.");
					
					$("input[name='startDate']").val("");	// 값 초기화
					$("input[name='endDate']").val("");		// 값 초기화
				}
			}
		}
		
	} // end of function calAnnualAmount(){}------------------------
	
	
	// 휴가신청서 결재요청하기
	function annualDraft(){
		
		if($("input[name='subject']").val().trim() == "") {	// 제목을 입력하지 않았을 경우
			alert("제목을 입력하세요!")
			return;
		}
		if($("input[name='reason']").val().trim() == "") {	// 휴가사유를 입력하지 않았을 경우
			alert("휴가사유를 입력하세요!");
			return;
		}
		if($("input[name='startDate']").val() == "" || $("input[name='startDate']").val() == "0000-00-00") {// 연차 시작일을 입력하지 않았을 경우
			alert("연차 시작일을 입력하세요!");
			return;
		}
		if($("input[name='endDate']").val() == "" || $("input[name='endDate']").val() == "0000-00-00") {	// 연차 종료일을 입력하지 않았을 경우
			alert("연차 종료일을 입력하세요!");
			return;
		}
		
		const queryString = $("form[name='annualDraftForm']").serialize();
		console.log(queryString);
		
		$.ajax({
			url:"<%= ctxPath%>/document/annualDraft",
			data:queryString,
			type:"post",
			dataType:"json",
			success:function(json){
				console.log(JSON.stringify(json));
				if(json.n == "1"){
					alert("결재 요청이 완료되었습니다.");
					location.href="<%= ctxPath%>/document/";
				}
				else {
					alert("결재 요청이 실패되었습니다.");
				}
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of $.ajax({})----------------
		
		
	} // end of function annualDraft(){}---------------------------------------------
	
	
	// 결재정보 수정하기
	function editApprover(){
		
		$('div#approverModal').css('display','block');
		
		
	} // end of function editApprover(){}---------------------------------------------
	
	
	// 임시저장하기
	function saveTemp(){
		
		const queryString = $("form[name='annualDraftForm']").serialize();
		console.log(queryString);
			
		$.ajax({
			url:"<%= ctxPath%>/document/saveTemp",
			data:queryString,
			type:"post",
			dataType:"json",
			success:function(json){
				console.log(JSON.stringify(json));
				if(json.n == "1"){
					alert("임시 저장이 완료되었습니다.");
					location.href="<%= ctxPath%>/document/";
				}
				else {
					alert("임시 저장이 실패되었습니다.");
				}
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of $.ajax({})----------------
		
	} // end of function annualTemp(){}-----------------------------------------------
	
	</script>
	
	
	<!-- 결재라인 모달 -->
	<div id="approve_line_modal" class="modal_bg">
	</div>
	<div class="approval_line_modal_container">
		<p>hello world</p>
	</div>
		

    <!-- 전자결재작성 폼 -->
	
	
		<h1>휴가신청서</h1>
		<button onclick="annualDraft()">결재요청</button>
		<button onclick="saveTemp()">임시저장</button>
		<button>미리보기</button>
		<button id="approve_line">결재 정보</button>
		
		<div style="border: solid 1px gray">
			<form name="annualDraftForm">
				<input type="hidden" name="documentType" value="휴가신청서" />
				<input type="hidden" name="temp" value="0" />
				<h1 style="text-align: center">연차신청서</h1>
				<table>
					<tbody>
						<tr>
							<td>기안자</td>
							<td>${sessionScope.loginuser.name}</td>
						</tr>
						<tr>
							<td>기안부서</td>
							<td>${sessionScope.loginuser.departmentName}</td>
						</tr>
						<tr>
							<td>기안일</td>
							<td><%= today%></td>
						</tr>
						<tr>
							<td>문서번호</td>
							<td></td>
						</tr>
					</tbody>
				</table>
				
				<table class="mt-5">
					<tbody>
						<tr>
							<td>제목</td>
							<td><input type="text" name="subject" value=" "/></td>
						</tr>
						<tr>
							<td>휴가 종류</td>
							<td>
								<select name="annualType" onchange="calAnnualAmount()">
									<option value="1">연차</option>
									<option value="2">오전반차</option>
									<option value="3">오후반차</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>사유</td>
							<td><input type="text" name="reason" value=" " /></td>
						</tr>
						<tr>
							<td>기간 및 일시</td>
							<td>
								<input type="date" name="startDate" onchange="calAnnualAmount()" onkeydown="return false" />
								<input type="date" name="endDate"   onchange="calAnnualAmount()" onkeydown="return false" />
							</td>
						</tr>
						<tr>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td>연차 일수</td>
							<td>
								잔여 연차 : <input type="text" name="totalAmount" value="10" readonly />
								신청 연차 : <input type="text" name="useAmount" value="0" readonly />
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
		
	</div>
</div>
<jsp:include page="../../footer/footer.jsp" /> 