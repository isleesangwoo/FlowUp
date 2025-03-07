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
			$('.box_modal_container').css({
				'display':'block'
			})
			
			// 모달 조직도에 뿌려주기 위한 사원 목록 가져오기
			$.ajax({
				url:"<%= ctxPath%>/document/getEmployeeList",
				dataType:"json",
				success: function(json){
					let departmentName = json[0].departmentName;
					let v_html = `<ul>
									<li class='departmentName'>\${departmentName}</li>
									<ul class='closed ml-1'>`;
					
					$.each(json, function(index, item){
						if(departmentName == item.departmentName) {
							v_html += `<li class='employee_name'>\${item.name}</li>
										<li class='employee_no' style='display:none'>\${item.employeeNo}</li>
										<li class='security_level' style='display:none'>\${item.securityLevel}</li>`;
						}
						else {
							departmentName = item.departmentName
							v_html += `</ul>
											<li class='departmentName'>\${departmentName}</li>
											<ul class='closed ml-1'>
												<li class='employee_name'>\${item.name}</li>
												<li class='employee_no' style='display:none'>\${item.employeeNo}</li>
												<li class='security_level' style='display:none'>\${item.securityLevel}</li>`;
						}
					});
					
					v_html += `</ul>
								</ul>`;
					
					$("div#organization_chart").html(v_html);
					
					 
					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
	  
	    }) // end of $('#goMail').click(e=>{})-----------
	    
	    
	    // 모달에서 조직도에서 사원을 클릭했을 때
		$("div#organization_chart").on('click', "li.employee_name", function(e) {
			$("li.employee_name").removeClass("selected");
			$(e.target).addClass("selected");
			$("button#add_approval_btn").css({"pointer-events":"auto"});
			$("input#selected_employee_name").val($(e.target).html());
			$("input#selected_employee_departmentName").val($(e.target).parent().prev().html());
			$("input#selected_employee_no").val($(e.target).next().html());
			$("input#selected_security_level").val($(e.target).next().next().html());
			
		});
		
		
		// 모달에서 조직도에서 부서를 클릭했을 때
		$("div#organization_chart").on('click', "li.departmentName", function(e) {
	    	console.log($(e.target).html());
	    	$(e.target).next().toggle('closed');
		});
		
		
		// 모달에서 사원을 결재 라인으로 추가 하는 버튼
		$("button#add_approval_btn").on('click', function(e) {
			
			if($("tbody#added_approval_line").children().length > 2) {
				alert("더 이상 추가할 수 없습니다.");
			}
			else {
				
				let isExist = false; // 이미 추가된 사원인지 확인하는 변수
				
				// 이미 추가된 사원인지 확인하는 for 문
				$("tbody#added_approval_line").find("td.selected_employee_no").each(function(){
					if($('input#selected_employee_no').val() == $(this).html()) {
						// for 문 안에서 선택된 사원번호와 추가된 사원번호가 같은지 확인
						
						alert("이미 추가된 사원입니다.");
						isExist = true;
						return;
					}
				});
				
				// 추가되지 않은 사원이라면
				if(!isExist) {
					
					let v_html=`<tr>
									<td>결재</td>
									<td class='selected_employee_no' style='display: none'>\${$('input#selected_employee_no').val()}</td>
									<td class='selected_security_level' style='display: none'>\${$('input#selected_security_level').val()}</td>
									<td class='selected_employee_name'>\${$('input#selected_employee_name').val()}</td>
									<td class='selected_employee_departmentName'>\${$('input#selected_employee_departmentName').val()}</td>
									<td>예정</td>
									<td class='delete_approver'>삭제</td>
								</tr>`;
					
					$("tbody#added_approval_line").append(v_html);
				}
			}
			
			$("input#selected_employee_name").val("");
			$("input#selected_employee_departmentName").val("");
			$("input#selected_employee_no").val("");
			$("input#selected_security_level").val("");
			// 선택되서 임시 저장된 데이터 초기화
			
			$("li.employee_name").removeClass("selected");	// 선택해제
			$("button#add_approval_btn").css({"pointer-events":""});	// 결재 라인 추가 버튼 비활성화
		}); 
		
		
		// 모달에서 결재 라인에 추가된 사원을 삭제하는 버튼
		$("tbody#added_approval_line").on('click', "td.delete_approver", function(e) {
			$(e.target).parent().remove();
		});
	   

	    // 모달에서 확인 버튼을 클릭했을 때 결재라인이 추가되도록하기
	    $("button#submit_approval_line").click(e=>{
	    	if($("tbody#added_approval_line").children().length < 1) {
	    		alert("결재 라인을 추가해주세요");
			}
	    	else {
	    		const approval_line_arr = [];
	    		
	    		$("tbody#added_approval_line").children().each(function(item, index){
	    			let approver = {selected_employee_no:$(this).find("td.selected_employee_no").html(),
	    							selected_security_level:$(this).find("td.selected_security_level").html(),
	    							selected_employee_name:$(this).find("td.selected_employee_name").html(),
	    							selected_employee_departmentName:$(this).find("td.selected_employee_departmentName").html()}
	    			
	    			approval_line_arr.push(approver);
	    		});
	    		
	    		approval_line_arr.sort((a, b) => Number(a.selected_security_level) - Number(b.selected_security_level));
	    		
	    		console.log(approval_line_arr);
	    		
	    		v_html = ``;
	    		
	    		$.each(approval_line_arr, function(index, element){
		    		v_html += `<table class="ml-2" style="display: inline-block;">
									<tbody>
										<tr>
											<th rowspan="4" style="width: 50px;">승인</th>
											<td>\${element.selected_employee_departmentName}</td>
										</tr>
										<tr>
											<td>\${element.selected_employee_name}</td>
										</tr>
										<tr>
											<td> </td>
										</tr>
									</tbody>
								</table>
								<input class='selected_security_level' type='hidden' value='\${element.selected_security_level}'>
		    					<input name='added_employee_no\${index}' type='hidden' value='\${element.selected_employee_no}'>`;
	    			
	    		});
	    		
	    		v_html += `<input name='added_approval_count' type='hidden' value='\${$("tbody#added_approval_line").children().length}'/>`;
	    		
	    		
	    		$("div#approval_line").html(v_html);
	    		
	    		close_modal();
	    	}
	    });
		
	    
	    // 모달에서 취소 버튼을 클릭했을 때 모달이 사라지게 하기
		$("button#cancel_approval_line").click(e=>{
			close_modal();
		});
		
		
		// 모달 바깥 부분을 클릭했을 때 모달이 사라지게 하기
	    $('.modal_bg:not(.modal_container_document)').click(e=>{
	    	close_modal();
	    });
	    
	    
	}); // end of $(document).ready(funtion(){})-----------------------------------

	
	// 모달창을 사라지게 하기
	function close_modal() {
		$('#approval_line_bg').fadeOut();
        $('.box_modal_container').css({
        	'display':''
		});
	}
	
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
		if($("div#approval_line").children().length == 0) {
			alert("결재 라인을 추가해주세요!");
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
					location.href="<%= ctxPath%>/document/myDocumentList";
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
		<!-- 모달창을 띄웠을때의 뒷 배경 -->
	</div>
	<div id="approval_line_container" class="box_modal_container">
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
		<div>
			<button id="submit_approval_line">확인</button>
			<button id="cancel_approval_line">취소</button>
		</div>
		<input id="selected_employee_name"/>
		<input id="selected_employee_departmentName"/>
		<input id="selected_employee_no"/>
		<input id="selected_security_level"/>
	</div>
		

    <!-- 휴가신청서 폼 -->
	
	<div class="m-3">
		<h1 class="mb-3">휴가신청서</h1>
		<button class="doc_btn mr-3" onclick="annualDraft()">결재요청</button>
		<button class="doc_btn mr-3" onclick="saveTemp()">임시저장</button>
		<button class="doc_btn mr-3">미리보기</button>
		<button class="doc_btn" id="approval_line_btn">결재 정보</button>
	</div>
	<div class="m-3 draftForm">
		<form name="annualDraftForm">
		
			<input type="hidden" name="documentType" value="휴가신청서" />
			<input type="hidden" name="temp" value="0" />
			
			<h3 style="text-align: center">연차신청서</h3>
			
			<div class="drafter_info" style="display: inline-block;">
				<table>
					<tbody>
						<tr>
							<th>기안자</th>
							<td>${sessionScope.loginuser.name}</td>
						</tr>
						<tr>
							<th>소속</th>
							<td>${sessionScope.loginuser.departmentName}</td>
						</tr>
						<tr>
							<th>기안일</th>
							<td><%= today%></td>
						</tr>
						<tr>
							<th>문서번호</th>
							<td></td>
						</tr>
						
					</tbody>
				</table>
			</div>
			<div class="m-3 p-3" style="display: inline-block;">
				<div class="approval_info" id="approval_line" style="text-align: right; display: inline-block; width: 100%">
				
					<!-- 결재 라인이 들어올 곳 -->
					
				</div>
			</div>
			<div class="document_info">
				<table class="mt-5" style="width: 100%">
					<tbody>
						<tr>
							<th>제목</th>
							<td><input type="text" name="subject" value=" " style="width: 100%;"/></td>
						</tr>
						<tr>
							<th>휴가 종류</th>
							<td>
								<select name="annualType" onchange="calAnnualAmount()">
									<option value="1">연차</option>
									<option value="2">오전반차</option>
									<option value="3">오후반차</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>사유</th>
							<td><input type="text" name="reason" value=" " style="width: 100%;"/></td>
						</tr>
						<tr>
							<th>기간 및 일시</th>
							<td>
								<input type="date" name="startDate" onchange="calAnnualAmount()" onkeydown="return false" />
								<input type="date" name="endDate"   onchange="calAnnualAmount()" onkeydown="return false" />
							</td>
						</tr>
						<tr>
							<th>연차 일수</th>
							<td>
								잔여 연차 : <input type="text" name="totalAmount" value="10" readonly />
								신청 연차 : <input type="text" name="useAmount" value="0" readonly />
							</td>
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
		</form>
	</div>
</div>
<jsp:include page="../../footer/footer.jsp" /> 