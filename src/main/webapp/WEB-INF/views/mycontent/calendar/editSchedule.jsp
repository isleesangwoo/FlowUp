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
	
	select.schedule{
		height: 30px;
	}
	
	input#joinUserName:focus{
		outline: none;
	}
	
	span.plusUser{
			float:left; 
			font-size:12px;
			background-color:#e2f5f6;
			color:#252525;
			border-radius: 80px;
			padding: 4px 4px;
			margin: 3px;
			transition: .8s;
			margin-top: 6px;
	}
	
	span.plusUser > i {
		cursor: pointer;
	}
	
	.ui-autocomplete {
		max-height: 100px;
		overflow-y: auto;
	}
	  
	button.btn_normal{
		border: none;
		color: white;
		width: 70px;
		height: 30px;
		font-size: 12pt;
		padding: 3px 0px;
		border-radius: 10%;
	}
	table {
	    border-collapse: collapse;
	    font-size: var(--size14) !important;
	}
	
	input::value {
		font-size:14px;
	}
	
	input::placeholder {
		font-size:14px;
	}
	
	#subject::placeholder {
		font-size:14px !important;
	}

</style>


<script type="text/javascript">

	$(document).ready(function(){
				
		// ==== 종일체크박스에 체크를 할 것인지 안할 것인지를 결정하는 것 시작 ==== //
		// 시작 시 분
		var str_startdate = "${requestScope.map.STARTDATE}";
	 // console.log(str_startdate); 
		// 2021-12-01 09:00
		var target = str_startdate.indexOf(":");
		var start_min = str_startdate.substring(target+1);
	 // console.log(start_min);
		// 00
		var start_hour = str_startdate.substring(target-2,target);
	 // console.log(start_hour);
		// 09
				
		
		// 종료 시 분
		var str_enddate = "${requestScope.map.ENDDATE}";
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
		
		
		// 시작날짜 넣어주기
		target = str_startdate.indexOf(" ");
		var start_yyyymmdd = str_startdate.substring(0,target);
		$("input#startDate").val(start_yyyymmdd);
		
		// 종료날짜 넣어주기
		target = str_enddate.indexOf(" ");
		var end_yyyymmdd = str_enddate.substring(0,target);
		$("input#endDate").val(end_yyyymmdd);
		
		
		// 시작시간, 종료시간		
		var html="";
		for(var i=0; i<24; i++){
			if(i<10){
				html+="<option value='0"+i+"'>0"+i+"</option>";
			}
			else{
				html+="<option value="+i+">"+i+"</option>";
			}
		}// end of for----------------------
		
		$("select#startHour").html(html);
		$("select#endHour").html(html);
		
		// === *** 시작시간 시 분 넣어주기 *** === //
		$("select#startHour").val(start_hour);
		$("select#endHour").val(end_hour);
		
		// 시작분, 종료분 
		html="";
		for(var i=0; i<60; i=i+5){
			if(i<10){
				html+="<option value='0"+i+"'>0"+i+"</option>";
			}
			else {
				html+="<option value="+i+">"+i+"</option>";
			}
		}// end of for--------------------
		html+="<option value="+59+">"+59+"</option>"
		
		$("select#startMinute").html(html);
		$("select#endMinute").html(html);
		
		// === *** 종료시간 시 분 넣어주기 *** === //
		$("select#startMinute").val(start_min);
		$("select#endMinute").val(end_min);
		
		
		// '종일' 체크박스 클릭시
		$("input#allDay").click(function() {
			var bool = $('input#allDay').prop("checked");
			
			if(bool == true) {
				$("select#startHour").val("00");
				$("select#startMinute").val("00");
				$("select#endHour").val("23");
				$("select#endMinute").val("59");
				$("select#startHour").prop("disabled",true);
				$("select#startMinute").prop("disabled",true);
				$("select#endHour").prop("disabled",true);
				$("select#endMinute").prop("disabled",true);
			} 
			else {
				$("select#startHour").prop("disabled",false);
				$("select#startMinute").prop("disabled",false);
				$("select#endHour").prop("disabled",false);
				$("select#endMinute").prop("disabled",false);
			}
		});
		
		// ========== *** 캘린더선택에서 이미 저장된 캘린더 넣어주기 시작 *** ========== //
		$("select.calType").val("${requestScope.map.FK_LGCATGONO}");
		
		$.ajax({
				url: "<%= ctxPath%>/calendar/selectSmallCategory",
				data: {"fk_lgcatgono":"${requestScope.map.FK_LGCATGONO}", 
					   "fk_employeeNo":"${requestScope.map.fk_employeeNo}"},
				dataType: "json",
				async: false,  //동기방식
				success:function(json){
					var html ="";
					if(json.length>0){
						$.each(json, function(index, item){
							html+="<option value='"+item.smcatgono+"'>"+item.smcatgoname+"</option>";
						});
						$("select.small_category").html(html);
					}
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
		});
	
		$("select.small_category").val("${requestScope.map.FK_SMCATGONO}");
		// ========== *** 캘린더선택에서 이미 저장된 캘린더 넣어주기 끝 *** ========== //
				
		// 내캘린더,사내캘린더 선택에 따른 서브캘린더 종류를 알아와서 select 태그에 넣어주기 
		$("select.calType").change(function(){
			var fk_lgcatgono = $("select.calType").val();      // 내캘린더이라면 1, 사내캘린더이라면 2 이다.
			var fk_employeeNo = $("input[name=fk_employeeNo]").val();  // 로그인 된 사용자아이디
			
			if(fk_lgcatgono != "") { // 선택하세요 가 아니라면
				$.ajax({
						url: "<%= ctxPath%>/calendar/selectSmallCategory",
						data: {"fk_lgcatgono":fk_lgcatgono, 
							   "fk_employeeNo":fk_employeeNo},
						dataType: "json",
						success:function(json){
							var html ="";
							if(json.length>0){
								
								$.each(json, function(index, item){
									html+="<option value='"+item.smcatgono+"'>"+item.smcatgoname+"</option>"
								});
								$("select.small_category").html(html);
								$("select.small_category").show();
							}
						},
						error: function(request, status, error){
				            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						}
				});
			}
			
			else {
				// 선택하세요 이라면
				$("select.small_category").hide();
			}
		});
		
		// **** 수정하기전 이미 저장되어있는 공유자 **** 
		var stored_joinuser = "${requestScope.map.JOINUSER}";
		if(stored_joinuser != "공유자가 없습니다."){
			var arr_stored_joinuser = stored_joinuser.split(",");
			var str_joinuser = "";
			for(var i=0; i<arr_stored_joinuser.length; i++){
				var user = arr_stored_joinuser[i];
			//	console.log(user);
				add_joinUser(user);
			}// end of for--------------------------
		}// end of if--------------------------------      

		
		// 공유자 추가하기
		$("input#joinUserName").bind("keyup",function(){
				var joinUserName = $(this).val();
			//	console.log("확인용 joinUserName : " + joinUserName);
				$.ajax({
					url:"<%= ctxPath%>/calendar/insertcalendar/searchJoinUserList",
					data:{"joinUserName":joinUserName},
					dataType:"json",
					success : function(json){
						var joinUserArr = [];
				
				//		console.log("이:"+json.length);
						if(json.length > 0){
							
							$.each(json, function(index,item){
								var name = item.name;
								if(name.includes(joinUserName)){ // name 이라는 문자열에 joinUserName 라는 문자열이 포함된 경우라면 true , 
									                             // name 이라는 문자열에 joinUserName 라는 문자열이 포함되지 않은 경우라면 false 
								   joinUserArr.push(name+"("+item.employeeNo+")");
								}
							});
							
							$("input#joinUserName").autocomplete({  // 참조 https://jqueryui.com/autocomplete/#default
								source:joinUserArr,
								select: function(event, ui) {       // 자동완성 되어 나온 공유자이름을 마우스로 클릭할 경우 
									add_joinUser(ui.item.value);    // 아래에서 만들어 두었던 add_joinUser(value) 함수 호출하기 
									                                // ui.item.value 이  선택한이름 이다.
									return false;
						        },
						        focus: function(event, ui) {
						            return false;
						        }
							}); 
							
						}// end of if------------------------------------
					}// end of success-----------------------------------
				});
		});
		

		// x아이콘 클릭시 공유자 제거하기
		$(document).on('click','div.displayUserList > span.plusUser > i',function(){
				var text = $(this).parent().text(); // 이순신(leess/leesunsin@naver.com)
				
				var bool = confirm("공유자 목록에서 "+ text +" 회원을 삭제하시겠습니까?");
				// 공유자 목록에서 이순신(leess/leesunsin@naver.com) 회원을 삭제하시겠습니까?
				
				if(bool) {
					$(this).parent().remove();
				}
		});

		
		// 수정 버튼 클릭
		$("button#edit").click(function(){
		
			// 일자 유효성 검사 (시작일자가 종료일자 보다 크면 안된다!!)
			var startDate = $("input#startDate").val();	
	    	var sArr = startDate.split("-");
	    	startDate= "";	
	    	for(var i=0; i<sArr.length; i++){
	    		startDate += sArr[i];
	    	}
	    	
	    	var endDate = $("input#endDate").val();	
	    	var eArr = endDate.split("-");   
	     	var endDate= "";
	     	for(var i=0; i<eArr.length; i++){
	     		endDate += eArr[i];
	     	}
			
	     	var startHour= $("select#startHour").val();
	     	var endHour = $("select#endHour").val();
	     	var startMinute= $("select#startMinute").val();
	     	var endMinute= $("select#endMinute").val();
	        
	     	// 조회기간 시작일자가 종료일자 보다 크면 경고
	        if (Number(endDate) - Number(startDate) < 0) {
	         	alert("종료일이 시작일 보다 작습니다."); 
	         	return;
	        }
	        
	     	// 시작일과 종료일 같을 때 시간과 분에 대한 유효성 검사
	        else if(Number(endDate) == Number(startDate)) {
	        	
	        	if(Number(startHour) > Number(endHour)){
	        		alert("종료일이 시작일 보다 작습니다."); 
	        		return;
	        	}
	        	else if(Number(startHour) == Number(endHour)){
	        		if(Number(startMinute) > Number(endMinute)){
	        			alert("종료일이 시작일 보다 작습니다."); 
	        			return;
	        		}
	        		else if(Number(startMinute) == Number(endMinute)){
	        			alert("시작일과 종료일이 동일합니다."); 
	        			return;
	        		}
	        	}
	        }// end of else if---------------------------------
	    	
			// 제목 유효성 검사
			var subject = $("input#subject").val().trim();
	        if(subject==""){
				alert("제목을 입력하세요."); 
				return;
			}
	        
	        // 캘린더 선택 유무 검사
			var calType = $("select.calType").val().trim();
			if(calType==""){
				alert("캘린더 종류를 선택하세요."); 
				return;
			}
			
			// 달력 형태로 만들어야 한다.(시작일과 종료일)
			// 오라클에 들어갈 date 형식(년월일시분초)으로 만들기
			var sdate = startDate+$("select#startHour").val()+$("select#startMinute").val()+"00";
			var edate = endDate+$("select#endHour").val()+$("select#endMinute").val()+"00";
			
			$("input[name=startdate]").val(sdate);
			$("input[name=enddate]").val(edate);
		
		//	console.log("캘린더 소분류 번호 => " + $("select[name=fk_smcatgono]").val());
			/*
			      캘린더 소분류 번호 => 1 OR 캘린더 소분류 번호 => 2 OR 캘린더 소분류 번호 => 3 OR 캘린더 소분류 번호 => 4 
			*/
			
		//  console.log("색상 => " + $("input#color").val());
			
			      
			// 공유자 넣어주기
			var plusUser_elm = document.querySelectorAll("div.displayUserList > span.plusUser");
			var joinUserArr = new Array();
			
			plusUser_elm.forEach(function(item,index,array){
			//	console.log(item.innerText.trim());
				/*
					이순신(leess) 
					아이유1(iyou1) 
					설현(seolh) 
				*/
				joinUserArr.push(item.innerText.trim());
			});
			
			var joinuser = joinUserArr.join(",");
		//	console.log("공유자 => " + joinuser);
			// 이순신(leess),아이유1(iyou1),설현(seolh) 
			
			$("input[name=joinuser]").val(joinuser);
			
		    var frm = document.scheduleFrm;
		  	frm.action="<%= ctxPath%>/calendar/editSchedule_end";
			frm.method="post";
			frm.submit(); 

		});// end of $("button#edit").click(function(){})--------------------
		
	}); // end of $(document).ready(function(){}-----------------------------------


	// ~~~~ Function Declaration ~~~~
	
	// div.displayUserList 에 공유자를 넣어주는 함수
	function add_joinUser(value){  // value 가 공유자로 선택한이름 이다.
		
		var plusUser_es = $("div.displayUserList > span.plusUser").text();
	
	 // console.log("확인용 plusUser_es => " + plusUser_es);
	    /*
	    	확인용 plusUser_es => 
 			확인용 plusUser_es => 이순신(leess/hanmailrg@naver.com)
 			확인용 plusUser_es => 이순신(leess/hanmailrg@naver.com)아이유1(iyou1/younghak0959@naver.com)
 			확인용 plusUser_es => 이순신(leess/hanmailrg@naver.com)아이유1(iyou1/younghak0959@naver.com)아이유2(iyou2/younghak0959@naver.com)
	    */
	
		if(plusUser_es.includes(value)) {  // plusUser_es 문자열 속에 value 문자열이 들어있다라면 
			alert("이미 추가한 회원입니다.");
		}
		
		else {
			$("div.displayUserList").append("<span class='plusUser'>"+value+"&nbsp;<i class='fas fa-times-circle'></i></span>");
		}
		
		$("input#joinUserName").val("");
		
	}// end of function add_joinUser(value){}----------------------------			

</script>
<jsp:include page="./calendar_bar.jsp" /> 
<link href="<%=ctxPath%>/css/email/email_main.css" rel="stylesheet">
<link href="<%=ctxPath%>/css/reservation/assetDetailPage.css" rel="stylesheet">
<link href="<%=ctxPath%>/css/reservation/reservation_main.css" rel="stylesheet"> 

<div id="right_bar">

	<div id="right_title_box">
        <span id="right_title" style="margin-right:8px;">일정 수정하기</span>
		<a style="font-size: 14px; color:#999;" href="<%= ctxPath%>/calendar/scheduleManagement">
			<span><i class="fa-solid fa-angle-right" style="transform: rotate(180deg); margin-right:4px;"></i>캘린더로 돌아가기</span>
		</a>
    </div>


	<form name="scheduleFrm">
		<table id="schedule" border="1" class="my_table">
			<tr>
				<th style="width: 160px; vertical-align: middle;">일자</th>
				<td>
					<input type="date" id="startDate" value="${requestScope.chooseDate}" style="height: 30px;"/>&nbsp; 
					<select id="startHour" class="schedule"></select> 시
					<select id="startMinute" class="schedule"></select> 분
					- <input type="date" id="endDate" value="${requestScope.chooseDate}" style="height: 30px;"/>&nbsp;
					<select id="endHour" class="schedule"></select> 시
					<select id="endMinute" class="schedule"></select> 분&nbsp;
					<input type="checkbox" id="allDay"/>&nbsp;<label for="allDay">종일</label>
					
					<input type="hidden" name="startdate"/>
					<input type="hidden" name="enddate"/>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" id="subject" name="subject" class="form-control" value="${requestScope.map.SUBJECT}"/></td> 
			</tr>
			
			<tr>
				<th>캘린더선택</th>
				<td>
					<select class="calType schedule" name="fk_lgcatgono">
					<c:choose>
					<%-- 사내 캘린더 추가를 할 수 있는 직원은 직위코드가 3 이면서 부서코드가 4 에 근무하는 사원이 로그인 한 경우에만 가능하도록 조건을 걸어둔다.--%>
						<c:when test="${loginuser.securityLevel =='10' && loginuser.securityLevel == '10' }">
							<option value="">선택하세요</option>
							<option value="1">내 캘린더</option>
							<option value="2">사내 캘린더</option>
						</c:when>
					 
					<%-- 일정등록시 사내캘린더 등록은 loginuser.gradelevel =='10' 인 사용자만 등록이 가능하도록 한다. --%> 
						<c:when test="${loginuser.securityLevel =='10'}"> 
							<option value="">선택하세요</option>
							<option value="1">내 캘린더</option>
							<option value="2">사내 캘린더</option>
						</c:when>
					<%-- 일정등록시 내캘린더 등록은 로그인 된 사용자이라면 누구나 등록이 가능하다. --%> 	
						<c:otherwise>
							<option value="">선택하세요</option>
							<option value="1">내 캘린더</option>
						</c:otherwise >
					</c:choose>
					</select> &nbsp;
					<select class="small_category schedule" name="fk_smcatgono"></select>
				</td>
			</tr>
			<tr>
				<th>색상</th>
				<td><input type="color" id="color" name="color" value="${requestScope.map.COLOR}"/></td>
			</tr>
			<tr>
				<th>장소</th>
				<td><input type="text" name="place" class="form-control" value="${requestScope.map.PLACE}"/></td>
			</tr>
			
			<tr>
				<th>공유자</th>
				<td>
				<input type="text" id="joinUserName" class="form-control" placeholder="일정을 공유할 회원명을 입력하세요"/>
				<div class="displayUserList"></div>
				<input type="hidden" name="joinuser"/>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="10" cols="100" style="height: 200px;" name="content" id="content" class="form-control">${requestScope.map.CONTENT}</textarea></td>
			</tr>
		</table>
		<input type="hidden" value="${sessionScope.loginuser.employeeNo}" name="fk_employeeNo"/>
		<input type="hidden" value="${requestScope.map.SCHEDULENO}" name="scheduleno"/>
	</form>
	
	<div style="display:flex; gap:4px; justify-content:center; margin-top:12px;">
	<button type="button" id="edit" class="okBtn" style="margin-right: 10px; background-color: #0071bd;">완료</button>
	<button type="button" class="resetBtn"  onclick="javascript:location.href='<%= ctxPath%>${gobackURL_detailSchedule}'">취소</button> 
	</div>
</div>

<jsp:include page="../../footer/footer.jsp" /> 

<script>

//=== 사내 캘린더에 사내캘린더 소분류 보여주기 ===
showCompanyCal();

//=== 내 캘린더에 내캘린더 소분류 보여주기 ===
showmyCal();

// === 사내캘린더 체크박스 전체 선택/전체 해제 === //
$("input:checkbox[id=allComCal]").click(function(){
	var bool = $(this).prop("checked");
	$("input:checkbox[name=com_smcatgono]").prop("checked", bool);
});// end of $("input:checkbox[id=allComCal]").click(function(){})-------


// === 내캘린더 체크박스 전체 선택/전체 해제 === //
$("input:checkbox[id=allMyCal]").click(function(){		
	var bool = $(this).prop("checked");
	$("input:checkbox[name=my_smcatgono]").prop("checked", bool);
});// end of $("input:checkbox[id=allMyCal]").click(function(){})-------
		

// === 사내캘린더 에 속한 특정 체크박스를 클릭할 경우 === 
$(document).on("click","input:checkbox[name=com_smcatgono]",function(){	
	var bool = $(this).prop("checked");
	
	if(bool){ // 체크박스에 클릭한 것이 체크된 것이라면 
		
		var flag=false;
		
		$("input:checkbox[name=com_smcatgono]").each(function(index, item){
			var bChecked = $(item).prop("checked");
			
			if(!bChecked){     // 체크되지 않았다면 
				flag=true;     // flag 를 true 로 변경
				return false;  // 반복을 빠져 나옴.
			}
		}); // end of $("input:checkbox[name=com_smcatgono]").each(function(index, item){})---------

		if(!flag){ // 사내캘린더 에 속한 서브캘린더의 체크박스가 모두 체크가 되어진 경우라면 			
            $("input#allComCal").prop("checked",true); // 사내캘린더 체크박스에 체크를 한다.
		}
		
		var com_smcatgonoArr = document.querySelectorAll("input.com_smcatgono");
	    
		com_smcatgonoArr.forEach(function(item) {
	         item.addEventListener("change", function() {  // "change" 대신에 "click" 을 해도 무방함.
	         //	 console.log(item);
	        	 calendar.refetchEvents();  // 모든 소스의 이벤트를 다시 가져와 화면에 다시 표시합니다.
	         });
	    });// end of com_smcatgonoArr.forEach(function(item) {})---------------------

	}
	
	else {
		   $("input#allComCal").prop("checked",false);
	}
	
});// end of $(document).on("click","input:checkbox[name=com_smcatgono]",function(){})--------


// === 내캘린더 에 속한 특정 체크박스를 클릭할 경우 === 
$(document).on("click","input:checkbox[name=my_smcatgono]",function(){	
	var bool = $(this).prop("checked");
	
	if(bool){ // 체크박스에 클릭한 것이 체크된 것이라면 
		
		var flag=false;
		
		$("input:checkbox[name=my_smcatgono]").each(function(index, item){
			var bChecked = $(item).prop("checked");
			
			if(!bChecked){    // 체크되지 않았다면 
				flag=true;    // flag 를 true 로 변경
				return false; // 반복을 빠져 나옴.
			}
		}); // end of $("input:checkbox[name=my_smcatgono]").each(function(index, item){})---------

		if(!flag){	// 내캘린더 에 속한 서브캘린더의 체크박스가 모두 체크가 되어진 경우라면 	
            $("input#allMyCal").prop("checked",true); // 내캘린더 체크박스에 체크를 한다.
		}
		
		var my_smcatgonoArr = document.querySelectorAll("input.my_smcatgono");
	      
		my_smcatgonoArr.forEach(function(item) {
			item.addEventListener("change", function() {   // "change" 대신에 "click" 을 해도 무방함.
			 // console.log(item); 
				calendar.refetchEvents();  // 모든 소스의 이벤트를 다시 가져와 화면에 다시 표시합니다.
	        });
	    });// end of my_smcatgonoArr.forEach(function(item) {})---------------------

	}
	
	else {
		   $("input#allMyCal").prop("checked",false);
	}
	
});// end of $(document).on("click","input:checkbox[name=my_smcatgono]",function(){})--------



//~~~~~~~ Function Declartion ~~~~~~~

//=== 사내 캘린더 소분류 추가를 위해 +아이콘 클릭시 ===
function addComCalendar(){
	$('#modal_addComCal').modal('show'); // 모달창 보여주기	
}// end of function addComCalendar(){}--------------------
	
	
//=== 사내 캘린더 추가 모달창에서 추가 버튼 클릭시 ===
function goAddComCal(){
	
	if($("input.add_com_smcatgoname").val().trim() == ""){
		  alert("추가할 사내캘린더 소분류명을 입력하세요!!");
		  return;
	}
	
	else {
		 $.ajax({
			 url: "<%= ctxPath%>/calendar/addComCalendar",
			 type: "post",
			 data: {"com_smcatgoname": $("input.add_com_smcatgoname").val(), 
				    "fk_employeeNo": "${sessionScope.loginuser.employeeNo}"},
			 dataType: "json",
			 success:function(json){
				 if(json.n != 1){
					alert("이미 존재하는 '사내캘린더 소분류명' 입니다.");
					return;
				 }
				 else if(json.n == 1){
					 $('#modal_addComCal').modal('hide'); // 모달창 감추기				
					 alert("사내 캘린더에 "+$("input.add_com_smcatgoname").val()+" 소분류명이 추가되었습니다.");
					 
					 $("input.add_com_smcatgoname").val("");
					 showCompanyCal();  // 사내 캘린더 소분류 보여주기
				 }
			 },
			 error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
 	     }	 
		 });
	  }
	
}// end of function goAddComCal(){}------------------------------------


//=== 사내 캘린더에서 사내캘린더 소분류  보여주기  === //
function showCompanyCal(){
	$.ajax({
		 url:"<%= ctxPath%>/calendar/showCompanyCalendar",
		 type:"get",
		 dataType:"json",
		 async: false ,
		 success:function(json){
				 var html = "";
				 
				 if(json.length > 0){
					 html += "<table style='width:100%;'>";
					 
					 $.each(json, function(index, item){
						 html += "<tr style='font-size: 11pt;'>";
						 html += "<td style='width:70%; padding: 3px 0px;'><input type='checkbox' name='com_smcatgono' class='calendar_checkbox com_smcatgono' style='margin-right: 3px;' value='"+item.smcatgono+"' checked id='com_smcatgono_"+index+"'/><label for='com_smcatgono_"+index+"'>"+item.smcatgoname+"</label></td>";  
						 
						 <%-- 사내 캘린더 추가를 할 수 있는 직원은 직위코드가 3 이면서 부서코드가 4 에 근무하는 사원이 로그인 한 경우에만 가능하도록 조건을 걸어둔다. 
						 if("${sessionScope.loginuser.securityLevel}" =='3' && "${sessionScope.loginuser.securityLevel}" == '4') { --%>
						 if("${sessionScope.loginuser.securityLevel}" =='10') {
							 html += "<td style='width:15%; padding: 3px 0px;'><button class='btn_edit' data-target='editCal' onclick='editComCalendar("+item.smcatgono+",\""+item.smcatgoname+"\")'><i class='fas fa-edit'></i></button></td>";  
							 html += "<td style='width:15%; padding: 3px 0px;'><button class='btn_edit delCal' onclick='delCalendar("+item.smcatgono+",\""+item.smcatgoname+"\")'><i class='fas fa-trash'></i></button></td>";
						 }
						 
						 html += "</tr>";
					 });
				 	 
					 html += "</table>";
				 }
			 
				 $("div#companyCal").html(html);
		},
		error: function(request, status, error){
	           alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
     }	 	
	});

}// end of function showCompanyCal()------------------	


//=== 사내 캘린더내의 서브캘린더 수정 모달창 나타나기 === 
function editComCalendar(smcatgono, smcatgoname){
	$('#modal_editComCal').modal('show'); // 모달 보이기
	$("input.edit_com_smcatgono").val(smcatgono);
	$("input.edit_com_smcatgoname").val(smcatgoname);
}// end of function editComCalendar(smcatgono, smcatgoname){}----------------------
	
	
//=== 사내 캘린더내의 서브캘린더 수정 모달창에서 수정하기 클릭 === 
function goEditComCal(){
	
	if($("input.edit_com_smcatgoname").val().trim() == ""){
		  alert("수정할 사내캘린더 소분류명을 입력하세요!!");
		  return;
	}
	else{
		$.ajax({
			url:"<%= ctxPath%>/calendar/editCalendar",
			type: "post",
			data:{"smcatgono":$("input.edit_com_smcatgono").val(), 
				  "smcatgoname": $("input.edit_com_smcatgoname").val(), 
				  "fk_employeeNo":"${sessionScope.loginuser.employeeNo}",
				  "caltype":"2"  // 사내캘린더
			     },
			dataType:"json",
			success:function(json){
				if(json.n == 0){
					alert($("input.edit_com_smcatgoname").val()+"은(는) 이미 존재하는 캘린더 명입니다.");
					return;
				 }
				if(json.n == 1){
					$('#modal_editComCal').modal('hide'); // 모달 숨기기
					alert("사내 캘린더명을 수정하였습니다.");
					showCompanyCal();
				}
			},
			 error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		    }
		});
	  }
	
}// end of function goEditComCal(){}--------------------------------


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //	

//=== 내 캘린더 소분류 추가를 위해 +아이콘 클릭시 ===
function addMyCalendar(){
	$('#modal_addMyCal').modal('show');	
}// end of function addMyCalendar(){}-----------------
	

//=== 내 캘린더 추가 모달창에서 추가 버튼 클릭시 === 
function goAddMyCal(){
	
	if($("input.add_my_smcatgoname").val().trim() == ""){
		  alert("추가할 내캘린더 소분류명을 입력하세요!!");
		  return;
	}
	
	else {
		  $.ajax({
			 url: "<%= ctxPath%>/calendar/addMyCalendar",
			 type: "post",
			 data: {"my_smcatgoname": $("input.add_my_smcatgoname").val(), 
				    "fk_employeeNo": "${sessionScope.loginuser.employeeNo}"},
			 dataType: "json",
			 success:function(json){
				 
				 if(json.n!=1){
					alert("이미 존재하는 '내캘린더 소분류명' 입니다.");
					return;
				 }
				 else if(json.n==1){
					 $('#modal_addMyCal').modal('hide'); // 모달창 감추기
					 alert("내 캘린더에 "+$("input.add_my_smcatgoname").val()+" 소분류명이 추가되었습니다.");
					 
					 $("input.add_my_smcatgoname").val("");
				 	 showmyCal(); // 내 캘린더 소분류 보여주기
				 }
			 },
			 error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
 	     }	 
		 });
	  }
	
}// end of function goAddMyCal(){}-----------------------


//=== 내 캘린더에서 내캘린더 소분류 보여주기  === //
function showmyCal(){
	$.ajax({
		 url:"<%= ctxPath%>/calendar/showMyCalendar",
		 type:"get",
		 data:{"fk_employeeNo":"${sessionScope.loginuser.employeeNo}"},
		 dataType:"json",
		 async: false ,
		 success:function(json){
			 var html = "";
			 if(json.length > 0){
				 html += "<table style='width:100%;'>";	 
				 
				 $.each(json, function(index, item){
					 html += "<tr style='font-size: 14px;'>";
					 html += "<td style='width:70%; padding: 3px 0px;'><input type='checkbox' name='my_smcatgono' class='calendar_checkbox my_smcatgono' style='margin-right: 3px;' value='"+item.smcatgono+"' checked id='my_smcatgono_"+index+"' checked/>&nbsp;&nbsp;<label for='my_smcatgono_"+index+"'>"+item.smcatgoname+"</label></td>";   
					 html += "<td style='width:15%; padding: 3px 0px;'><button class='btn_edit editCal' data-target='editCal' onclick='editMyCalendar("+item.smcatgono+",\""+item.smcatgoname+"\")'><i class='fas fa-edit'></i></button></td>"; 
					 html += "<td style='width:15%; padding: 3px 0px;'><button class='btn_edit delCal' onclick='delCalendar("+item.smcatgono+",\""+item.smcatgoname+"\")'><i class='fas fa-trash'></i></button></td>";
				     html += "</tr>";
				 });
				 
				 html += "</table>";
			 }
			 
			 $("div#myCal").html(html);
		 },
		 error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	     }	 	
	});

}// end of function showmyCal()---------------------	


//=== 내 캘린더내의 서브캘린더 수정 모달창 나타나기 === 
function editMyCalendar(smcatgono, smcatgoname){
	$('#modal_editMyCal').modal('show');  // 모달 보이기
	$("input.edit_my_smcatgono").val(smcatgono);
	$("input.edit_my_smcatgoname").val(smcatgoname);
}// end of function editMyCalendar(smcatgono, smcatgoname){}-----------------------
	
	
//=== 내 캘린더내의 서브캘린더 수정 모달창에서 수정 클릭 === 
function goEditMyCal(){
	
	if($("input.edit_my_smcatgoname").val().trim() == ""){
		  alert("수정할 내캘린더 소분류명을 입력하세요!!");
		  return;
	}
	else{
		 $.ajax({
			url:"<%= ctxPath%>/calendar/editCalendar",
			type: "post",
			data:{"smcatgono":$("input.edit_my_smcatgono").val(), 
				  "smcatgoname": $("input.edit_my_smcatgoname").val(), 
				  "fk_employeeNo":"${sessionScope.loginuser.employeeNo}",
				  "caltype":"1"  // 내캘린더
				  },
			dataType:"json",
			success:function(json){
				if(json.n == 0){
					alert($("input.edit_com_smcatgoname").val()+"은(는) 이미 존재하는 캘린더 명입니다.");
					return;
				 }
				if(json.n == 1){
					$('#editMyCal').modal('hide'); // 모달 숨기기
					alert("내캘린더명을 수정하였습니다.");
					showmyCal(); 
				}
			},
			 error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		    }
		});
	  }
	
}// end of function goEditMyCal(){}-------------------------------------
	

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//		

//=== (사내캘린더 또는 내캘린더)속의 소분류 카테고리 삭제하기 === 
function delCalendar(smcatgono, smcatgoname){ // smcatgono => 캘린더 소분류 번호, smcatgoname => 캘린더 소분류 명
	
	var bool = confirm(smcatgoname + " 캘린더를 삭제 하시겠습니까?");
	
	if(bool){
		$.ajax({
			url:"<%= ctxPath%>/calendar/deleteSubCalendar",
			type: "post",
			data:{"smcatgono":smcatgono},
			dataType:"json",
			success:function(json){
				if(json.n==1){
					alert(smcatgoname + " 캘린더를 삭제하였습니다.");
					location.href="javascript:history.go(0);"; // 페이지 새로고침
				}
			},
			error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		    }
		});
	}
	
}// end of function delCalendar(smcatgono, smcatgoname){}------------------------

</script>