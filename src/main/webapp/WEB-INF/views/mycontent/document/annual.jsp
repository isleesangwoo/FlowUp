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
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
	
			
	}); // end of $(document).ready(funtion(){})-----------------------------------
	
	
	// 사용연차 개수 계산하기
	function calAnnualAmount(){
		
		if($("select[name='annualType']").val() != "1") {
			// 반차일 경우
			
			$("input[name='endDate']").val($("input[name='startDate']").val());
			$("input[name='endDate']").hide(); // 종료일 선택을 숨기고 초기화
			
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
	
	// 휴가신청서 결재요청
	function annualDraft(){
		
		if($("input[name='subject']").val() == "") {
			alert("제목을 입력하세요!")
			return;
		}
		if($("input[name='reason']").val() == "") {
			alert("휴가사유를 입력하세요!");
			return;
		}
		if($("input[name='startDate']").val() == "") {
			alert("연차 시작일을 입력하세요!");
			return;
		}
		if($("input[name='endDate']").val() == "") {
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
	
	// 결재정보 수정
	function editApprover(){
		
		alert("결재정보");
		
	} // end of function editApprover(){}---------------------------------------------
	
</script>

 
	<div>
		<h1>휴가신청서</h1>
		<button onclick="annualDraft()">결재요청</button>
		<button>임시저장</button>
		<button>미리보기</button>
		<button onclick="editApprover()">결재 정보</button>
		
		<div style="border: solid 1px gray">
			<form name="annualDraftForm">
				<h1 style="text-align: center">연차신청서</h1>
				<table>
					<tbody>
						<tr>
							<td>기안자</td>
							<td>김상훈</td>
						</tr>
						<tr>
							<td>기안부서</td>
							<td>다우그룹</td>
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
							<td><input type="text" name="subject" /></td>
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
							<td><input type="text" name="reason" /></td>
						</tr>
						<tr>
							<td>기간 및 일시</td>
							<td>
								<input type="date" name="startDate" onchange="calAnnualAmount()" onkeydown="return false" />
								<input type="date" name="endDate" onchange="calAnnualAmount()" onkeydown="return false" />
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