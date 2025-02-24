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
		text-align: left;
		border-radius: 3%;
		display: none;
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
	
	.closed {
		display: none;
	}
	
	.selected {
		background: yellow;
	}
	
	button#add_approval_btn {
		pointer-events : none;
	}
	
	
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
	
		// 결재 정보 버튼을 눌렀을 때
		$('#approval_line_btn').click(e=>{

	        $('#approval_line_bg').fadeIn();
			$('.approval_line_modal_container').css({
				'display':'block'
			})
			
			// 조직도에 뿌려주기 위한 사원 목록 가져오기
			$.ajax({
				url:"<%= ctxPath%>/document/getEmployeeList",
				dataType:"json",
				success: function(json){
					let departmentName = json[0].departmentName;
					let v_html = `<ul><li class='departmentName'>\${departmentName}</li><ul class='closed ml-1'>`;
					
					$.each(json, function(index, item){
						if(departmentName == item.departmentName) {
							v_html += `<li class='employee_name'>\${item.name}</li>`;
						}
						else {
							departmentName = item.departmentName
							v_html += `</ul><li class='departmentName'>\${departmentName}</li><ul class='closed ml-1'><li class='employee_name'>\${item.name}</li>`;
						}
					});
					
					v_html += `</ul></ul>`;
					
					$("div#organization_chart").html(v_html);
					
					 
					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
	  
	    }) // end of $('#goMail').click(e=>{})-----------
	    
	    
		$("div#organization_chart").on('click', "li.employee_name", function(e) {
			$("li.employee_name").removeClass("selected");
			$(e.target).addClass("selected");
			$("button#add_approval_btn").css({"pointer-events":"auto"});
			$("input#selected_employee_name").val($(e.target).html());
			$("input#selected_employee_departmentName").val($(e.target).parent().prev().html());
			
		});
		
		
		$("div#organization_chart").on('click', "li.departmentName", function(e) {
	    	console.log($(e.target).html());
	    	$(e.target).next().toggle('closed');
		});
		
		
		$("button#add_approval_btn").on('click', function(e) {
			if($("input#selected_employee_name").val() == ""){
				alert("dddd");
			}
			else {
				let v_html=`<tr>
								<td>결재</td>
								<td>\${$('input#selected_employee_name').val()}</td>
								<td>\${$('input#selected_employee_departmentName').val()}</td>
								<td>예정</td>
								<td class='delete_approver'>삭제</td>
							</tr>`;
				
				$("tbody#added_approval_line").after(v_html);
				
				$("input#selected_employee_name").val("");
				$("input#selected_employee_departmentName").val("");
				$("li.employee_name").removeClass("selected");
				$("button#add_approval_btn").css({"pointer-events":""});
			}
		});
		
		
		$("tbody#added_approval_line").on('click', "td.delete_approver", function(e) {
			alert("Dd");
			$(e.target).parent().remove();
		});
	   

	    $('.modal_bg:not(.modal_container_document)').click(e=>{

	        $('#approval_line_bg').fadeOut();
	        $('.approval_line_modal_container').css({
	        	'display':''
			})

	    })
	    
		$('.close').click(e=>{
			
			$('#approval_line_modal').fadeOut();
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
	<div id="approval_line_bg" class="modal_bg">
	</div>
	<div id="approval_line_container" class="approval_line_modal_container">
		<div>
			<h1>결재 정보</h1>
		</div>
		<div style="border: solid 1px gray; width: 40%; display: inline-block;" >
			<span>결재선</span>
			<div id="approval_line_content" class="approval_line_modal_content" style="border: solid 1px gray;" >
				<div style="border: solid 1px gray">
					<span>조직도</span>
				</div>
				<div>
					<input type="text" />
				</div>
				<div id="organization_chart" class="organization_chart">
				</div>
			</div>
		</div>
		<div style="border: solid 1px gray; display: inline-block; width: 40%">
			<div>
				<table class="table">
					<thead>
						<tr>
							<th></th>
							<th>타입</th>
							<th>이름</th>
							<th>부서</th>
							<th>상태</th>
							<th>삭제</th>
						</tr>
					</thead>
				</table>
			</div>
			<div>
				승인
			</div>
			<div>
				<div style="display: inline-block;">
					<button id="add_approval_btn">>></button>
				</div>
				<div style="display: inline-block;">
					<table class="table">
						<tbody style="border: solid 1px gray" id="added_approval_line">
							
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<input id="selected_employee_name"/>
		<input id="selected_employee_departmentName"/>
	</div>
		

    <!-- 휴가신청서 폼 -->
	
	<div>
		<h1>휴가신청서</h1>
		<button onclick="annualDraft()">결재요청</button>
		<button onclick="saveTemp()">임시저장</button>
		<button>미리보기</button>
		<button id="approval_line_btn">결재 정보</button>
	</div>
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