<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
 	String ctxPath = request.getContextPath();
	//     /myspring
%>

<%-- === 사내 캘린더 추가 Modal === --%>
<div class="modal fade" id="modal_addComCal" role="dialog" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
    
      <!-- Modal header -->
      <div class="modal-header">
        <h4 class="modal-title">사내 캘린더 추가</h4>
        <button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
       	<form name="modal_frm">
       	<table style="width: 100%;" class="table table-bordered">
     			<tr>
     				<td style="text-align: left; ">소분류명</td>
     				<td><input type="text" class="add_com_smcatgoname"/></td>
     			</tr>
     			<tr>
     				<td style="text-align: left;">만든이</td>
     				<td style="text-align: left; padding-left: 5px;">${sessionScope.loginuser.name}</td>
     			</tr>
     		</table>
       	</form>	
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
      	<button type="button" id="addCom" class="btn btn-success btn-sm" onclick="goAddComCal()">추가</button>
          <button type="button" class="btn btn-danger btn-sm modal_close" data-dismiss="modal">취소</button>
      </div>
      
    </div>
  </div>
</div>

<%-- === 사내 캘린더 수정 Modal === --%>
<div class="modal fade" id="modal_editComCal" role="dialog" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
    
      <!-- Modal header -->
      <div class="modal-header">
        <h4 class="modal-title">사내 캘린더 수정</h4>
        <button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
       	<form name="modal_frm">
       	<table style="width: 100%;" class="table table-bordered">
     			<tr>
     				<td style="text-align: left; ">소분류명</td>
     				<td><input type="text" class="edit_com_smcatgoname"/><input type="hidden" value="" class="edit_com_smcatgono"></td>
     			</tr>
     			<tr>
     				<td style="text-align: left;">만든이</td>
     				<td style="text-align: left; padding-left: 5px;">${sessionScope.loginuser.name}</td>
     			</tr>
     		</table>
       	</form>	
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
      	<button type="button" id="addCom" class="btn btn-success btn-sm" onclick="goEditComCal()">수정</button>
          <button type="button" class="btn btn-danger btn-sm modal_close" data-dismiss="modal">취소</button>
      </div>
      
    </div>
  </div>
</div>

<%-- === 내 캘린더 추가 Modal === --%>
<div class="modal fade" id="modal_addMyCal" role="dialog" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
      
      <!-- Modal header -->
      <div class="modal-header">
        <h4 class="modal-title">내 캘린더 추가</h4>
        <button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
          <form name="modal_frm">
       	<table style="width: 100%;" class="table table-bordered">
     			<tr>
     				<td style="text-align: left; ">소분류명</td>
     				<td><input type="text" class="add_my_smcatgoname" /></td>
     			</tr>
     			<tr>
     				<td style="text-align: left;">만든이</td>
     				<td style="text-align: left; padding-left: 5px;">${sessionScope.loginuser.name}</td> 
     			</tr>
     		</table>
     		</form>
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
      	<button type="button" id="addMy" class="btn btn-success btn-sm" onclick="goAddMyCal()">추가</button>
          <button type="button" class="btn btn-danger btn-sm modal_close" data-dismiss="modal">취소</button>
      </div>
      
    </div>
  </div>
</div>

<%-- === 내 캘린더 수정 Modal === --%>
<div class="modal fade" id="modal_editMyCal" role="dialog" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
    
      <!-- Modal header -->
      <div class="modal-header">
        <h4 class="modal-title">내 캘린더 수정</h4>
        <button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
      	<form name="modal_frm">
       	<table style="width: 100%;" class="table table-bordered">
     			<tr>
     				<td style="text-align: left; ">소분류명</td>
     				<td><input type="text" class="edit_my_smcatgoname"/><input type="hidden" value="" class="edit_my_smcatgono"></td>
     			</tr>
     			<tr>
     				<td style="text-align: left;">만든이</td>
     				<td style="text-align: left; padding-left: 5px;">${sessionScope.loginuser.name}</td>
     			</tr>
     		</table>
       	</form>
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
      	<button type="button" id="addCom" class="btn btn-success btn-sm" onclick="goEditMyCal()">수정</button>
          <button type="button" class="btn btn-danger btn-sm modal_close" data-dismiss="modal">취소</button>
      </div>
      
    </div>
  </div>
</div>
<jsp:include page="../../header/header.jsp" />

<style type="text/css">


	table#schedule th, td{
	 	padding: 10px 5px;
	 	vertical-align: middle;
	}
	
	a{
	    color: #395673;
	    text-decoration: none;
	    cursor: pointer;
	}
	
	a:hover {
	    color: #395673;
	    cursor: pointer;
	    text-decoration: none;
		font-weight: bold;
	}
	
	button.btn_normal{
		background-color: #0071bd;
		border: none;
		color: white;
		width: 70px;
		height: 30px;
		font-size: 12pt;
		padding: 3px 0px;
		margin-right: 10px;
		border-radius: 10%;
	}

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		// ==== 종일체크박스에 체크를 할 것인지 안할 것인지를 결정하는 것 시작 ==== //
		// 시작 시 분
		var str_startdate = $("span#startdate").text();
	 // console.log(str_startdate); 
		// 2021-12-01 09:00
		var target = str_startdate.indexOf(":");
		var start_min = str_startdate.substring(target+1);
	 // console.log(start_min);
		// 00
		var start_hour = str_startdate.substring(target-2,target);
	 //	console.log(start_hour);
		// 09
		
		// 종료 시 분
		var str_enddate = $("span#enddate").text();
	//	console.log(str_enddate);
		// 2021-12-01 18:00
		target = str_enddate.indexOf(":");
		var end_min = str_enddate.substring(target+1);
	 // console.log(end_min);
	    // 00 
		var end_hour = str_enddate.substring(target-2,target);
	 //	console.log(end_hour);
		// 18
		
		if(start_hour=='00' && start_min=='00' && end_hour=='23' && end_min=='59' ){
			$("input#allDay").prop("checked",true);
		}
		else{
			$("input#allDay").prop("checked",false);
		}
		// ==== 종일체크박스에 체크를 할 것인지 안할 것인지를 결정하는 것 끝 ==== //
		
	}); // end of $(document).ready(function(){})==============================


	// ~~~~~~~ Function Declartion ~~~~~~~
	
	// 일정 삭제하기
	function delSchedule(scheduleno){
	
		var bool = confirm("일정을 삭제하시겠습니까?");
		
		if(bool){
			$.ajax({
				url: "<%= ctxPath%>/calendar/deleteSchedule",
				type: "post",
				data: {"scheduleno":scheduleno},
				dataType: "json",
				success:function(json){
					if(json.n==1){
						alert("일정을 삭제하였습니다.");
					}
					else {
						alert("일정을 삭제하지 못했습니다.");
					}
					
					location.href="<%= ctxPath%>/calendar/scheduleManagement";
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
			});
		}
		
	}// end of function delSchedule(scheduleno){}-------------------------


	// 일정 수정하기
	function editSchedule(scheduleno){
		var frm = document.goEditFrm;
		frm.scheduleno.value = scheduleno;
		
		frm.action = "<%= ctxPath%>/calendar/editSchedule";
		frm.method = "post";
		frm.submit();
	}

</script>
<jsp:include page="./calendar_bar.jsp" /> 
<link href="<%=ctxPath%>/css/email/email_main.css" rel="stylesheet">
<link href="<%=ctxPath%>/css/reservation/assetDetailPage.css" rel="stylesheet">
<link href="<%=ctxPath%>/css/reservation/reservation_main.css" rel="stylesheet"> 

<div id="right_bar">
	<div id="right_title_box">
        <span id="right_title" style="margin-right:8px;">일정 상세보기</span>
		<a style="font-size: 14px; color:#999;" href="<%= ctxPath%>/calendar/scheduleManagement">
			<span><i class="fa-solid fa-angle-right" style="transform: rotate(180deg); margin-right:4px;"></i>캘린더로 돌아가기</span>
		</a>
    </div>

		<table id="schedule" border="1" class="my_table">
			<tr>
				<th style="width: 160px; vertical-align: middle;">일자</th>
				<td>
					<span id="startdate">${requestScope.map.STARTDATE}</span>&nbsp;~&nbsp;<span id="enddate">${requestScope.map.ENDDATE}</span>&nbsp;&nbsp;  
					<input type="checkbox" id="allDay" disabled/>&nbsp;종일
				</td>
			</tr>
			<tr>
				<th style="vertical-align: middle;">제목</th>
				<td>${requestScope.map.SUBJECT}</td>
			</tr>
			
			<tr>
				<th style="vertical-align: middle;">캘린더종류</th>
				<td>
				<c:if test="${requestScope.map.FK_LGCATGONO eq '2'}">
					사내 캘린더 - ${requestScope.map.SMCATGONAME}
				</c:if>
				<c:if test="${requestScope.map.FK_LGCATGONO eq '1'}">
					내 캘린더 - ${requestScope.map.SMCATGONAME}
				</c:if></td>
			</tr>
			<tr>
				<th style="vertical-align: middle;">장소</th>
				<td>${requestScope.map.PLACE}</td>
			</tr>
			
			<tr>
				<th style="vertical-align: middle;">공유자</th>
				<td>${requestScope.map.JOINUSER}</td>
			</tr>
			<tr>
				<th style="vertical-align: middle;">내용</th>
				<td><textarea id="content" rows="10" cols="100" style="height: 200px; border: none;" readonly>${requestScope.map.CONTENT}</textarea></td>
			</tr>
			<tr>
				<th style="vertical-align: middle;">작성자</th>
				<td>${requestScope.map.NAME}</td>
			</tr>
		</table>
	
	<input type="hidden" value="${sessionScope.loginuser.employeeNo}" />
	<input type="hidden" value="${requestScope.map.FK_LGCATGONO}" />
	
	<c:set var="v_fk_employeeNo" value="${requestScope.map.fk_employeeNo}" />
	<c:set var="v_fk_lgcatgono" value="${requestScope.map.FK_LGCATGONO}"/>
	<c:set var="v_loginuser_employeeNo" value="${sessionScope.loginuser.employeeNo}"/>

	<div style="display:flex; gap:4px; justify-content:center; margin-top:12px;">
		<c:if test="${not empty requestScope.listgobackURL_schedule}">
	    <%-- 
	               일정이 사내캘린더 인데, 로그인한 사용자가 4번 부서에 근무하는 3직급을 가진 사용자 이라면 
	        <c:if test="${v_fk_lgcatgono eq '2' && sessionScope.loginuser.securityLevel =='10' && sessionScope.loginuser.securityLevel == '10' }">  
	    --%>
			<c:if test="${v_fk_lgcatgono eq '2' && sessionScope.loginuser.securityLevel == 10 }">
				<button type="button" id="edit" class="okBtn" onclick="editSchedule('${requestScope.map.SCHEDULENO}')">수정</button>
				<button type="button" class="okBtn" onclick="delSchedule('${requestScope.map.SCHEDULENO}')">삭제</button>
			</c:if>	
			<c:if test="${v_fk_lgcatgono eq '1' && v_fk_employeeNo eq v_loginuser_employeeNo}">
				<button type="button" id="edit" class="okBtn" onclick="editSchedule('${requestScope.map.SCHEDULENO}')">수정</button>
				<button type="button" class="okBtn" onclick="delSchedule('${requestScope.map.SCHEDULENO}')">삭제</button>
			</c:if>
				<button type="button" id="cancel" class="resetBtn" onclick="javascript:location.href='<%= ctxPath%>${requestScope.listgobackURL_schedule}'">취소</button> 
		</c:if>
		
		<c:if test="${empty requestScope.listgobackURL_schedule}">
		<%-- 
	               일정이 사내캘린더 인데, 로그인한 사용자가 4번 부서에 근무하는 3직급을 가진 사용자 이라면 
	        <c:if test="${v_fk_lgcatgono eq '2' && sessionScope.loginuser.fk_pcode =='3' && sessionScope.loginuser.fk_dcode == '4' }">  
	    --%>
	        <c:if test="${v_fk_lgcatgono eq '2' && sessionScope.loginuser.securityLevel == 10 }">
				<button type="button" id="edit" class="okBtn" onclick="editSchedule('${requestScope.map.SCHEDULENO}')">수정</button>
				<button type="button" class="okBtn" onclick="delSchedule('${requestScope.map.SCHEDULENO}')">삭제</button>
			</c:if>
			<c:if test="${v_fk_lgcatgono eq '1' && v_fk_employeeNo eq v_loginuser_employeeNo}">
				<button type="button" id="edit" class="okBtn" onclick="editSchedule('${requestScope.map.SCHEDULENO}')">수정</button>
				<button type="button" class="okBtn" onclick="delSchedule('${requestScope.map.SCHEDULENO}')">삭제</button>
			</c:if>
				<button type="button" id="cancel" class="resetBtn" onclick="javascript:location.href='<%= ctxPath%>/calendar/detailSchedule'">취소</button> 
		</c:if>
	
	</div>
</div>

<form name="goEditFrm">
	<input type="hidden" name="scheduleno"/>
	<input type="hidden" name="gobackURL_detailSchedule" value="${requestScope.gobackURL_detailSchedule}"/>
</form>

<jsp:include page="../../footer/footer.jsp" /> 
