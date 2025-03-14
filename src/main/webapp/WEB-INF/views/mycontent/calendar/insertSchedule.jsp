<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% 
   String ctxPath = request.getContextPath(); 
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

	table#schedule{
		margin-top: 70px;
	}
	
	table#schedule th, td{
	 	padding: 8px 24px 8px 4px;
	 	vertical-align: middle;
	}
	
	table#schedule th {
		padding-left:24px;
		width:172px !important;
	}
	
	select.schedule{
		height: 30px;
	}
	
	input#joinUserName:focus{
		outline: none;
	}
	
	#joinUserName::placeholder {
		font-size:14px;
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
	
	.displayUserList {
		padding-top:4px;
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
	
	#schedule > tbody > tr:nth-child(1) > td {
		padding: 10px 24px 6px 24px;
		margin-bottom: 6px;
	}
	
	.my_table th {
		width:172px;
		padding: 0px 24px 0px 24px;
	}
	
	.my_table {
		table-layout: inherit !important;
	}
	
	.ui-widget.ui-widget-content {
		overflow-x:hidden;
	}
	
	.my_table tr th {
		font-weight: 400;
	}
	#content {
	    padding: 16px !important;
	}
	
	.flexable_title{
		border: 1px solid #ddd;
	    border-bottom: 0;
	    background-color: #fbfbfb;
	    height: 38px;
		vertical-align: middle;
		display:flex;
		align-items: center;
		padding-left: 12px;
		cursor:pointer;
	}
	
	.txt{
		display: inline-block;
		padding: 3px 0;
	}
	
	.flexable_box {
		margin: 2px 0 4px;
		border-bottom: 1px solid #d9d9d9;
	}
	
	.flexable_box .flexable_info {
	    border: 1px solid #ddd;
	    border-bottom: 0;
	    padding: 2px 10px;
	}
	
	.baseTable thead tr {
		background-color: #eee;
	}
	
	#assetModal {
		width: 600px !important;
		height: auto;
		z-index: 100;
		border-radius: 10px;
		background-color: #fff;
		position: fixed;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		display: none;
		filter: drop-shadow(4px 5px 22px rgba(0,0,0, 0.2));
	}
	
	
	.assetModalTitle {
		font-size: var(--size20);
		margin-bottom: 8px;
	}
	
	.assetModal_body > div label {
		width: 100px;
	}
	
	
	#goReservation {
		margin-top: 20px;
		text-align: center;
		padding: 10px 20px;
		border-radius: 8px;
		cursor:pointer;
		background-color: #2985db;
		color: #fff;
	}
	
	textarea[name="reservationContents"] {
	    box-sizing: border-box;
	    padding: 8px;
	    border: 1px solid #dbdbdb;
	    width: 100%;
	    height: 100px;
	}
	
	input {
	    box-sizing: border-box;
	    border: 1px solid #dbdbdb;
	    border-radius: 4px;
	}
	
	.my_table2 tr th {
		text-align: center !important;
		padding-left:0px !important;
	}
	
	.my_table2 th,.my_table2 td{
	    padding: 0px 0px 0px 0px;
	}
	
	.my_table2 > tbody tr{
		height: 32px;
	}
	
	.my_table2 > tbody tr > td:first-child{
		padding-left: 8px !important;
	}
	
</style>


<script type="text/javascript">

	let reservationArr = [];
	let plusUserArr = [];
	
	let nameAppend = ``;
	let employeenoAppend = ``;
	
	$(document).ready(function(){
		
		selectReservationTitle();
		
		
		
		<%-- 시작날짜 시간이랑 끝날짜 시간 띄우기 --%>
		$('select#startHour').change(e=>{
			dateSet(); // 날짜랑 시간 input태그에 넣어주기
			
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
	        	selectReservationTitle();
	         	return;
	        }
	        
	     	// 시작일과 종료일 같을 때 시간과 분에 대한 유효성 검사
	        else if(Number(endDate) == Number(startDate)) {
	        	
	        	if(Number(startHour) > Number(endHour)){
	        		selectReservationTitle();
	        		return;
	        	}
	        	else if(Number(startHour) == Number(endHour)){
	        		if(Number(startMinute) > Number(endMinute)){
	        			selectReservationTitle();
	        			return;
	        		}
	        		else if(Number(startMinute) == Number(endMinute)){
	        			selectReservationTitle();
	        			return;
	        		}
	        	}
	        }// end of else if---------------------------------
	        
	        var startTime = Number(startHour) * 60 + Number(startMinute); // 시작 시간 (분 단위)
	        var endTime = Number(endHour) * 60 + Number(endMinute); // 종료 시간 (분 단위)

	        var validStartTime = 9 * 60; // 9:00 (분 단위)
	        var validEndTime = 21 * 60 + 30; // 21:30 (분 단위)
	        
	     	// 시작 시간은 9:00 이상, 종료 시간은 9:30 이상이고 종료 시간은 21:30 이하인 경우
	        if (startTime < validStartTime || startTime > validEndTime || endTime < validStartTime || endTime > validEndTime) {
	            selectReservationTitle();
	            return;
	        }
	        
	        selectReservation();
			
		})
		
		$('select#startMinute').change(e=>{
			dateSet(); // 날짜랑 시간 input태그에 넣어주기
			
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
	        	selectReservationTitle();
	         	return;
	        }
	        
	     	// 시작일과 종료일 같을 때 시간과 분에 대한 유효성 검사
	        else if(Number(endDate) == Number(startDate)) {
	        	
	        	if(Number(startHour) > Number(endHour)){
	        		selectReservationTitle();
	        		return;
	        	}
	        	else if(Number(startHour) == Number(endHour)){
	        		if(Number(startMinute) > Number(endMinute)){
	        			selectReservationTitle();
	        			return;
	        		}
	        		else if(Number(startMinute) == Number(endMinute)){
	        			selectReservationTitle();
	        			return;
	        		}
	        	}
	        }// end of else if---------------------------------
	        
	        var startTime = Number(startHour) * 60 + Number(startMinute); // 시작 시간 (분 단위)
	        var endTime = Number(endHour) * 60 + Number(endMinute); // 종료 시간 (분 단위)

	        var validStartTime = 9 * 60; // 9:00 (분 단위)
	        var validEndTime = 21 * 60 + 30; // 21:30 (분 단위)
	        
	     	// 시작 시간은 9:00 이상, 종료 시간은 9:30 이상이고 종료 시간은 21:30 이하인 경우
	        if (startTime < validStartTime || startTime > validEndTime || endTime < validStartTime || endTime > validEndTime) {
	            selectReservationTitle();
	            return;
	        }
	        
	        selectReservation();
		})
		
		$('select#endHour').change(e=>{
			dateSet(); // 날짜랑 시간 input태그에 넣어주기
			
			
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
	        	selectReservationTitle();
	         	return;
	        }
	        
	     	// 시작일과 종료일 같을 때 시간과 분에 대한 유효성 검사
	        else if(Number(endDate) == Number(startDate)) {
	        	
	        	if(Number(startHour) > Number(endHour)){
	        		selectReservationTitle();
	        		return;
	        	}
	        	else if(Number(startHour) == Number(endHour)){
	        		if(Number(startMinute) > Number(endMinute)){
	        			selectReservationTitle();
	        			return;
	        		}
	        		else if(Number(startMinute) == Number(endMinute)){
	        			selectReservationTitle();
	        			return;
	        		}
	        	}
	        }// end of else if---------------------------------
	        
	        
	        var startTime = Number(startHour) * 60 + Number(startMinute); // 시작 시간 (분 단위)
	        var endTime = Number(endHour) * 60 + Number(endMinute); // 종료 시간 (분 단위)

	        var validStartTime = 9 * 60; // 9:00 (분 단위)
	        var validEndTime = 21 * 60 + 30; // 21:30 (분 단위)
	        
	     	// 시작 시간은 9:00 이상, 종료 시간은 9:30 이상이고 종료 시간은 21:30 이하인 경우
	        if (startTime < validStartTime || startTime > validEndTime || endTime < validStartTime || endTime > validEndTime) {
	            selectReservationTitle();
	            return;
	        }
	        
	        
	        selectReservation();
	     	
	     	
		})
		
		$('select#endMinute').change(e=>{
			dateSet(); // 날짜랑 시간 input태그에 넣어주기
			
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
	        	selectReservationTitle();
	         	return;
	        }
	        
	     	// 시작일과 종료일 같을 때 시간과 분에 대한 유효성 검사
	        else if(Number(endDate) == Number(startDate)) {
	        	
	        	if(Number(startHour) > Number(endHour)){
	        		selectReservationTitle();
	        		return;
	        	}
	        	else if(Number(startHour) == Number(endHour)){
	        		if(Number(startMinute) > Number(endMinute)){
	        			selectReservationTitle();
	        			return;
	        		}
	        		else if(Number(startMinute) == Number(endMinute)){
	        			selectReservationTitle();
	        			return;
	        		}
	        	}
	        }// end of else if---------------------------------
	        
	        var startTime = Number(startHour) * 60 + Number(startMinute); // 시작 시간 (분 단위)
	        var endTime = Number(endHour) * 60 + Number(endMinute); // 종료 시간 (분 단위)

	        var validStartTime = 9 * 60; // 9:00 (분 단위)
	        var validEndTime = 21 * 60 + 30; // 21:30 (분 단위)
	        
	     	// 시작 시간은 9:00 이상, 종료 시간은 9:30 이상이고 종료 시간은 21:30 이하인 경우
	        if (startTime < validStartTime || startTime > validEndTime || endTime < validStartTime || endTime > validEndTime) {
	            selectReservationTitle();
	            return;
	        }
	        
	        selectReservation();
	        
		})
		<%-- 시작날짜 시간이랑 끝날짜 시간 띄우기 --%>
		
		
		
		
		// 캘린더 소분류 카테고리 숨기기
		$("select.small_category").hide();
		
		// === *** 달력(type="date") 관련 시작 *** === //
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
		
		// 시작분, 종료분 
		html="";
		html+="<option value='00'>00</option><option value='30'>30</option>";
		
		$("select#startMinute").html(html);
		$("select#endMinute").html(html);
		// === *** 달력(type="date") 관련 끝 *** === //
		
		// '종일' 체크박스 클릭시
		$("input#allDay").click(function() {
			var bool = $('input#allDay').prop("checked");
			
			if(bool == true) {
				$("select#startHour").val("00");
				$("select#startMinute").val("00");
				$("select#endHour").val("23");
				$("select#endMinute").val("30");
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
			
			
			var sdate = startDate+$("select#startHour").val()+$("select#startMinute").val();
			var edate = endDate+$("select#endHour").val()+$("select#endMinute").val();
			
			$("input[name=startdate]").val(sdate);
			$("input[name=enddate]").val(edate);
			
			selectReservation();
						
		});
		
		$('span.firstment').hide();
		// 내캘린더,사내캘린더 선택에 따른 서브캘린더 종류를 알아와서 select 태그에 넣어주기 
		$("select.calType").change(function(){
			$("select.calType").find('option:first-child').attr('selected', false);
			
			
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
								$('span.firstment').hide();
							}
							else{
								
								$("select.calType").find('option:first-child').attr('selected', true)
								
								$("select.small_category").hide();
								$('span.firstment').show();
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
				$('span.firstment').hide();
			}
			
		});
		
		
		// 공유자 추가하기
		$("input#joinUserName").bind("keyup",function(){
			 
				var joinUserName = $(this).val();
				console.log("확인용 joinUserName : " + joinUserName);
				$.ajax({
					url:"<%= ctxPath%>/calendar/insertcalendar/searchJoinUserList",
					data:{"joinUserName":joinUserName},
					dataType:"json",
					success : function(json){
						var joinUserArr = [];
				    
					//  input태그 공유자입력란에 "이" 를 입력해본 결과를 json.length 값이 얼마 나오는지 알아본다. 
						console.log(json.length);
					
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
					// alert($(this).parent().text().split("\(")[1].split("\)")[0])
					$(`span#\${$(this).parent().text().split("\(")[1].split("\)")[0]}`).parent().parent().remove();
					
					// nameAppend = ``;
					// updateDate();
					// 공유자 리스트에서 제거
			        plusUserArr = plusUserArr.filter(user => user.employeeno !== `\${$(this).parent().text().split("\(")[1].split("\)")[0]}`);
			        updateDate();
				}
				if($('tbody#tbody > tr').text() == ''){
			    	$('tbody#tbody').append(`<tr class="gong"><td  colspan="26" style="color:#999; text-align:center;">공유자 명단이 없습니다.</td></tr>`);
			    }
		});

		
		// 등록 버튼 클릭
		$("button#register").click(function(){
			
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
			var sdate = startDate+$("select#startHour").val()+$("select#startMinute").val();
			var edate = endDate+$("select#endHour").val()+$("select#endMinute").val();
			
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
			frm.action="<%= ctxPath%>/calendar/registerSchedule_end";
			frm.submit();

		});// end of $("button#register").click(function(){})--------------------
		
		
		
		
		
		
		$(document).on('click', '.flexable_title', function(e) {
		    // i 태그를 클릭했을 때에는 toggle이 발생하지 않도록
		    if ($(e.target).is('i')) return;

		    $(this).next().toggle();
		});
		
		
		
		// 자산 예약 상세보기를 눌렀을 경우
		$(document).on('click', '.assetdetailnoInfo', e=>{
			// alert($(e.target).next().val())
			
			$('.fixNo').text($(e.target).next().val());
			$('span.assetName').html($(e.target).parent().prev().text());
			$('.informationTitleAppend').empty();
			
			$.ajax({
			  url:"<%=ctxPath%>/reservation/fixSelectAssetNo",
			  type:"post",
			  data:{"fk_assetDetailNo":$(e.target).next().val()},
			  dataType:"json",
			  success:function(json){
				console.log(JSON.stringify(json))
				/*
				[{"assetInformationNo":"100006","InformationContents":"X","release":"0","assetDetailNo":"100029","InformationTitle":"확인","assetName":"Edge"}
				,{"assetInformationNo":"100009","InformationContents":"X","release":"0","assetDetailNo":"100029","InformationTitle":"테스트","assetName":"Edge"}]
				*/
				
				let c_html = ``;
				let appendcheck = ``;
				let appendCnt = 0;
				
				if(json.length == 0) { // 비품이 존재하지 않는 경우
					c_html += `<tr><td colspan="2" style="text-align: center; color:#999;">등록된 비품이 없습니다.</td></tr>`;
				}
				else{ // 비품이 존재하는 경우
	
					$.each(json, function(index, item){
						if(item.release == 0){ // 공개여부에 따라 쌓기!
						
						appendCnt++; // 쌓을 때마다 카운트 남겨주기
							
						c_html += `<tr>
				                   	 <td>\${item.InformationTitle}</td>
			            			 <td>\${item.InformationContents}</td>
								   </tr>`;
								   
						}
				    }); // end of $.each(json, function(index, item){})-------
					
					if(appendCnt == 0) { // 비품이 있긴 있지만 전부 비공개일 경우
						c_html += `<tr><td colspan="2" style="text-align: center; color:#999;">등록된 비품이 없습니다.</td></tr>`;
					}
				}
				
				$('.informationTitleAppend').append(c_html);
				
				
				$('#assetModalBg2').fadeIn();
				$('#assetModal2').fadeIn();
				  
			  },
			  error: function(request, status, error){
			 	  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  } 
		  })
			
		}) 
		// 자산 예약 상세보기를 눌렀을 경우
		// === 비품수정창 모달창 닫기 === //
	   $(document).on('click', '#CloseInfo', e=>{
		   $('#assetModalBg2').fadeOut();
		   $('#assetModal2').fadeOut();
	   });
	   
	   $('#assetModalBg2:not(#assetModal2)').click(e=>{
		   $('#assetModalBg2').fadeOut();
		   $('#assetModal2').fadeOut();
	   });
	   // === 비품수정창 모달창 닫기 === //
	   
	   
	   
	   
	   
	   let assetdetailnoReserNo = ``;
	   
	   
	   $(document).on('click', '.assetdetailnoReser', e=>{
		   // alert($(e.target).next().val())
		   
		   assetdetailnoReserNo = $(e.target).attr('id');
		   
		   if($(e.target).text() == '예약하기'){
		   
			   if($('input[name="reservationContents"]').val() != ''){
				   alert('자산은 1번만 예약 가능합니다.')
				   return;
			   }
			   
			   // ======= 모달창 on ======= //
	           $('#assetModalBg').fadeIn();
	           $('.modal_containerAsset').fadeIn();
	           // ======= 모달창 on ======= //
	           
		   }
		   else {
			   if(confirm("예약을 취소하시겠습니까?")){
				   $(e.target).text("예약하기");
				   $('input[name="reservationContents"]').val("");
				   $('input[name="Fk_assetDetailNo"]').val("");
			   }
		   }
	   }) 
	   
	   // ======== 모달창 닫기 ======== //
	    $('#assetModalBg:not(.modal_containerAsset)').click(e=>{
	    	$('#assetModalBg').fadeOut();
	    	$('.modal_containerAsset').fadeOut();
	    })
	    // ======== 모달창 닫기 ======== //
	    
	    
	    $('#goReservation').click(e=>{
	    	
	    	if($('textarea[name="reservationContents"]').val() == '') {
	    		alert('예약 목적을 기입해주세요')
	    		return;
	    	}
	    	
	    	$('input[name="reservationContents"]').val($('textarea[name="reservationContents"]').val())
	    	
	    	$('input[name="Fk_assetDetailNo"]').val(assetdetailnoReserNo);
	    	
	    	$('textarea[name="reservationContents"]').val("");
	    	
	    	$('#assetModalBg').fadeOut();
	    	$('.modal_containerAsset').fadeOut();
	    	
	    	$("span#"+assetdetailnoReserNo).text("예약취소")
	    })
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	}); // end of $(document).ready(function(){}-----------------------------------


	// ~~~~ Function Declaration ~~~~
	
	
	function dateSet() {
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
		
		
		var sdate = startDate+$("select#startHour").val()+$("select#startMinute").val();
		var edate = endDate+$("select#endHour").val()+$("select#endMinute").val();
		
		$("input[name=startdate]").val(sdate);
		$("input[name=enddate]").val(edate);
	}
	
	
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
			plusUserArr.push({name: value.split("\(")[0], employeeno: value.split("\(")[1].split("\)")[0]}) // 공유자 employeeno 배열
				
				
			nameAppend = value.split("\(")[0];
			employeenoAppend = value.split("\(")[1].split("\)")[0];
				
			/*
				alert(plusUserArr);
				console.log(plusUserArr);
				console.log(plusUserArr[0]);
				console.log(typeof plusUserArr[0]);
			*/
			updateDate(plusUserArr);
			
			displayUserListSelect(value.split("\(")[1].split("\)")[0]);
			
		}
 			updateDate();
		$("input#joinUserName").val("");
		
	}// end of function add_joinUser(value){}----------------------------			

	
	
	
	
	function selectReservation() {
		$.ajax({
			url:"<%=ctxPath%>/reservation/selectReservation",
			type:"get",
			data:{"startdate":$("input[name=startdate]").val(),
				  "enddate":$("input[name=enddate]").val()},
			async: false ,
			dataType:"json",
			success:function(json){
				// console.log(JSON.stringify(json));
				/*
					[{"assetdetailno":"100078","assetname":"Edge","assetNo":"100046"}
					,{"assetdetailno":"100084","assetname":"A회의실","assetNo":"100048"}
					,{"assetdetailno":"100079","assetname":"Whale","assetNo":"100046"}, ...]
				*/
				let v_html = ``;
				let t_html = ``;
				$('.reservationHere').empty();
				
				console.log(reservationArr[0])
				
				reservationArr.forEach(function(item, index){
					v_html += `
					
                     <div class="flexable_box asset-reservation">
                        
                        <div class="flexable_title">
                           <i class="fa-solid fa-angle-right" style="transform: rotate(90deg); margin-right:4px;"></i>
                           <span class="txt">\${item.assetTitle}</span>
                        </div>
                        
                        
                       
                        <div class="flexable_info foldable" style="min-height:100px; display:none;">
                           
                           <table class="baseTable" style="margin-top:30px;">
                              <thead>
                                 <tr>
                                    <th style="padding-left:16px;">필드명</th>
                                    <th style="padding-left:16px;">상세</th>
                                    <th style="padding-left:16px;">예약</th>

                                 </tr>
                              </thead>
                              <tbody id="appendTrMiddle">`;
									
									$.each(json, function(i, asset){
										// alert(asset.fk_assetNo)
										if (item.assetNo == asset.fk_assetNo) { // 대분류마다 짝지어줄거임
											
										v_html += `
											<tr>
					                            <td>\${asset.assetname}</td>
					                            <td><span class="assetdetailnoInfo" style="cursor:pointer">상세보기</span><input type="hidden" name="assetdetailnoInfo" value="\${asset.assetdetailno}" /></td>
					                            <td><span class="assetdetailnoReser" id="\${asset.assetdetailno}" style="cursor:pointer">예약하기</span><input type="hidden" name="assetdetailnoReser" value="\${asset.assetdetailno}" /></td>
					                         </tr>
										`;
										}
										
									}) // end of $.each(json, function(i, asset){})-------
                                 
								
                     v_html += `
                              </tbody>
                           </table>
                           
                        </div>
                        
                     </div>
                     
					 `;
					
				}) // end of reservationArr.each(function(index, item){})------------
				
				$('.reservationHere').append(v_html);
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		}) 
	}
	
	
	
	
	function selectReservationTitle() {
		
		$('.reservationHere').empty();
		
		$.ajax({
			url:"<%=ctxPath%>/reservation/selectReservationTitle",
			type:"get",
			dataType:"json",
			async: false ,
			success:function(json){
				// console.log(JSON.stringify(json));
				reservationArr = json;
				let v_html = ``;
				
				if(json.length != 0){
				
					$.each(json, function(index, item){
	
						v_html += `
						<div class="flexable_box asset-reservation">
							
							<div class="flexable_title">
								<i class="fa-solid fa-angle-right" style="transform: rotate(90deg); margin-right:4px;"></i>
								<span class="txt">\${item.assetTitle}</span>
							</div>
							
							
							
							<div class="flexable_info foldable" style="min-height:100px; display:none;">
								
								<table class="baseTable" style="margin-top:30px;">
									<thead>
										<tr>
											<th style="padding-left:16px;">필드명</th>
											<th style="padding-left:16px;">상세</th>
											<th style="padding-left:16px;">예약</th>
	
										</tr>
									</thead>
									<tbody id="appendTrMiddle">
										
										
										<tr>
											<td colspan="3">이용가능한 자산이 없습니다.</td>
										</tr>
	
									</tbody>
								</table>
								
							</div>

						</div>
						`;
						
					}) // end of $.each(json, function(item, index){})-----------
				}
				else {
					v_html += `<div style="width:100%; height:50px; text-align:center; line-height:50px; border: 1px solid #ced4da; color:#999;">이용가능한 자산이 없습니다.</div>`;
				}
				$('.reservationHere').append(v_html);
				
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		}) 
	}
	
	
	
	
	function displayUserListSelect(fk_employeeno) {
		// alert( $('div#today').text().split(" ")[0].split("\-").join("") ) // 20250312
		// alert(plusUserArr.join(",")) // 100012,100022
		$.ajax({
			url:"<%=ctxPath%>/calendar/displayUserListSelect",
			data:{ "fk_employeeno": fk_employeeno,
				   "selectDay": $('div#today').text().split(" ")[0].split("\-").join("") },
			type:"get",
			dataType:"json",
			success:function(json){
				console.log(JSON.stringify(json));
				/*
					[{"STARTDATE":"2025-03-13 14:00","SUBJECT":"테스트 제목52","fk_employeeNo":"100012","ENDDATE":"2025-03-13 17:00","NAME":"강이훈 "}
					,{"STARTDATE":"2025-03-12 00:00","SUBJECT":"테스트 제목5","fk_employeeNo":"100012","ENDDATE":"2025-03-14 23:59","NAME":"강이훈 "}
					,{"STARTDATE":"2025-03-13 11:00","SUBJECT":"테스트 제목11","fk_employeeNo":"100012","ENDDATE":"2025-03-13 15:00","NAME":"강이훈 "}]
				
				*/
				
				Array.from($('span.name')).forEach(function(elmt, i) {
				    $.each(json, function(idx, item) {
				        if ($(elmt).attr('id') == item.fk_employeeNo) {
				            Array.from($(`input.em\${item.fk_employeeNo}`)).forEach(function(td, index) {
				                let startTime = item.STARTDATE;
				                let endTime = item.ENDDATE;
				                
				                let startHour = Number(startTime.split(" ")[1].split(":")[0]);
				                let startMin = Number(startTime.split(" ")[1].split(":")[1]);
				                let endHour = Number(endTime.split(" ")[1].split(":")[0]);
				                let endMin = Number(endTime.split(" ")[1].split(":")[1]);
				                
				                let totalStartMinutes = startHour * 60 + startMin;
				                let totalEndMinutes = endHour * 60 + endMin;
				                
				                let diff = totalEndMinutes - totalStartMinutes;
				                
				                if ($(td).val() == item.STARTDATE) {
				                    let parentTd = $(td).parent();
				                    parentTd.css('background-color', '#eee');
				                    
				                    // 30분 단위로 다음 칸도 색칠하기
				                    let nextTd = parentTd;
				                    for (let i = 30; i < diff; i += 30) {
				                        nextTd = nextTd.next(); // 다음 칸으로 이동
				                        if (nextTd.length) {
				                            nextTd.css('background-color', '#eee');
				                        }
				                    }
				                }
				            });
				        }
				    });
				});
				
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		}) 
	} // end of function displayUserListSelect()----------------
	
	
	
	
</script>
<jsp:include page="./calendar_bar.jsp" /> 
<link href="<%=ctxPath%>/css/email/email_main.css" rel="stylesheet">
<link href="<%=ctxPath%>/css/reservation/assetDetailPage.css" rel="stylesheet">
<link href="<%=ctxPath%>/css/reservation/reservation_main.css" rel="stylesheet"> 

<div id="right_bar">
	<div id="right_title_box">
	    <span id="right_title" style="margin-right:8px;">일정 등록</span>
		<a style="font-size: 14px; color:#999;" href="<%= ctxPath%>/calendar/scheduleManagement">
			<span><i class="fa-solid fa-angle-right" style="transform: rotate(180deg); margin-right:4px;"></i>캘린더로 돌아가기</span>
		</a>
	</div>

	<div style="display:flex;">
		<form name="scheduleFrm" method="post">
			<table id="schedule" class="my_table" style="margin-top:0px; width:820px; padding:4px 24px; box-sizing:border-box; flex-shrink: 0;">
				<tr>
					<td colspan="2"><input type="text" style="width:570px;" id="subject" name="subject" class="form-control"/></td>
				</tr>
				
				<tr>
					<th>일자</th>
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
					<th>캘린더선택</th>
					<td>
						<select class="calType schedule" name="fk_lgcatgono">
						<c:choose>
						<%-- 사내 캘린더 추가를 할 수 있는 직원은 loginuser.gradelevel =='10' 인 사원이 로그인 한 경우에만 가능하도록 조건을 걸어둔다.--%> 
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
						<span class="firstment" style="color:#999; font-size:12px;">해당 캘린더의 소분류를 먼저 등록해주세요.</span>
					</td>
				</tr>
				<tr>
					<th>색상</th>
					<td><input type="color" id="color" name="color" value="#009900"/></td>
				</tr>
				<tr>
					<th>장소</th>
					<td><input type="text" name="place" class="form-control"/></td>
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
					<td><textarea rows="10" cols="100" style="height: 200px;" name="content" id="content"  class="form-control"></textarea></td>
				</tr>
				
				<!-- 예약하기 기능 -->
				<tr>
					<th>예약하기</th>
					<td>
						<span style="font-size:12px; color:#999;">*설정한 시간대에 예약 가능한 회의실만 보여집니다.</span>
						<div class="reservationHere" style="min-height:50px;">
							
							<%-- 내가 고른 시간에 맞는 예약가능 자산 띄워주기 기능 --%>
							<%-- 내가 고른 시간에 맞는 예약가능 자산 띄워주기 기능 --%>
							<%-- 내가 고른 시간에 맞는 예약가능 자산 띄워주기 기능 --%>
							
						</div>
					</td>
				</tr>
				<!-- 예약하기 기능 -->
				
				
				
				<tr>
					<td colspan="2">
						<div style="display: flex;  justify-content: center; margin-top:20px; gap:10px;" >
							<button type="button" id="register" class="okBtn" style=" background-color: #0071bd;">등록</button>
							<button type="button" class="resetBtn" onclick="javascript:location.href='<%= ctxPath%>/calendar/scheduleManagement'">취소</button>
							<input type="submit" style="display:none;"/>
						</div>
					</td>
				</tr>
			</table>
			<input type="hidden" value="${sessionScope.loginuser.employeeNo}" name="fk_employeeNo"/>
			
			<input type="hidden" name="reservationContents" />
			<input type="hidden" name="Fk_assetDetailNo" />
		</form>
		
		
		<div style="border-top: 1px solid #ddd; width:100%; border-bottom: 1px solid #ddd; width:100%;">
			
			<div style="width:100%; height:50px; margin:16px 0px 16px 0px; padding: 0px 16px;">
				<div style="font-size:13px; color: #999; margin-bottom: 4px;">참석자 일정</div>
				<div style="display:flex;   justify-content: space-between; align-items: center;">
					<div style="display:flex; align-items: center; font-size: 17px; gap:4px;">
					
						<div id="today" style="text-align: center; font-size: 17px;">today</div> <!-- 날짜 표기 -->
						<span id="prev" style="cursor: pointer;">&#60;</span>   <!-- 이전날짜 버튼 -->
				        <span id="next" style="cursor: pointer;">&#62;</span>   <!-- 다음날짜 버튼 -->
					</div>
					
					<div style="font-size:12px;">
						<span style="display:inline-block; width:10px; height:10px; background-color:#999;"></span>  
						<span>일정있음</span>
					</div>
				</div>
			</div>
			
			
			<div style="width:100%">
				<table class="my_table my_table2" border="1">
					<thead>
		                <th style="width: 15%;"></th>
		                <!-- 하루의 시작은 9시부터 21시까지 고정 -->
		                <th colspan="2">09</th>
		                <th colspan="2">10</th>
		                <th colspan="2">11</th>
		                <th colspan="2">12</th>
		                <th colspan="2">13</th>
		                <th colspan="2">14</th>
		                <th colspan="2">15</th>
		                <th colspan="2">16</th>
		                <th colspan="2">17</th>
		                <th colspan="2">18</th>
		                <th colspan="2">19</th>
		                <th colspan="2">20</th>
		                <th colspan="2">21</th>
		                <!-- 하루의 시작은 9시부터 21시까지 고정 -->
		            </thead>
		            
		            <tbody id="tbody">
			            
			            <!-- 일정정보가 들어올 자리 -->
			            <!-- 일정정보가 들어올 자리 -->
			            <!-- 일정정보가 들어올 자리 -->
			            
			           
			            
		            </tbody>
		            
				</table>
				
				
				<div style="padding: 16px; ">
					<ul style="font-size:12px; color:#999;">
						<li>- 최대 10명까지의 참석자만 확인할 수 있습니다.</li>
						<li>- 상세일정은 확인할 수 없으며, 참석자의 일정 여부만 확인할 수 있습니다.</li>
						<li>- 근무시간인 09시부터 21시까지의 일정만 확인할 수 있습니다.</li>
					</ul>
				</div>
				
			</div>
			
		</div>
			
	</div>
	
	
</div>





<div id="assetModalBg" class="modal_bg">				
</div>
<div id="assetModal" class="modal_containerAsset" style="padding:24px;">
	<div class="assetModalTitle" >예약</div>
	<div class="assetModal_body">
		<input type="hidden"  name="fk_assetDetailNo" />
		<input type="hidden" value="${sessionScope.loginuser.employeeNo}" name="fk_employeeNo" />
		<div>
			<label>예약자</label><span>${sessionScope.loginuser.name}</span>
		</div>
		<div>
			<label>목적</label><span><textarea type="text" name="reservationContents"></textarea></span>
		</div>
	</div>
	<div id="goReservation">확인</div>
</div>




<div id="assetModalBg2" class="modal_bg"></div>
<div id="assetModal2" class="modal_containerAssetFix">
	<div>
		<label class="assetNameTitle">ID값</label><span class="fixNo"></span>
	</div>
	
	<div>
		<label class="assetNameTitle">항목명</label><span class="assetName"></span>
	</div>
	
	<table class="baseTable" style="margin-top:12px;">
		<thead>
			<tr>
				<th>비품명</th>
				<th>유무 상태</th>
			</tr>
		</thead>
		<tbody class="informationTitleAppend">
			<!-- 여기는 추가된 항목들 목록 -->
			
			<!-- 여기는 추가된 항목들 목록 -->
		</tbody>
	</table>
	
	
	<div class="bottom_btn_box">
		<button class="okBtn" id="CloseInfo">확인</button>
	</div>
</div>


<script>

//====================== 날짜 리모컨 기능 생성 ====================== //
let today = new Date(); // 현재 날짜 저장
let currentDate = new Date(); // 오늘을 저장하는 변수

// 이전 버튼 클릭 시
$('#prev').click(() => {
    today.setDate(today.getDate() - 1);
    updateDate();
});

// 다음 버튼 클릭 시
$('#next').click(() => {
    today.setDate(today.getDate() + 1);
    updateDate();
});

// 오늘 버튼 클릭 시
$('#now').click(() => {
    today = new Date(currentDate); // 저장된 currentDate 날짜로 복구
    updateDate();
});

// 날짜 업데이트 함수
function updateDate(arr) {
    const daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];
    const year = today.getFullYear();
    const month = String(today.getMonth() + 1).padStart(2, '0'); // 1월부터 시작
    const day = String(today.getDate()).padStart(2, '0');
    const dayOfWeek = daysOfWeek[today.getDay()]; // 요일

    const timeString = `\${year}-\${month}-\${day}`;
    $('#today').text(timeString);








    // ====================== table tr 생성 ====================== //
    // $('tbody#tbody').empty();
    // 왜 이렇게 따로 빼두었나?? - td 26개 생성하기 귀찮아서,,, for문 돌릴 생각 하다가 이렇게 번짐
    let html = ``;
    //-- DB 연동시 foreach로 바꿀것 --//

    // console.log(item);
    // alert(Array.from($('tbody#tbody > tr')).lengh)
    
    
   	
   	
    
    
    if($('tbody#tbody > tr').text() == ''){
    	html += `<tr class="gong"><td  colspan="26" style="color:#999; text-align:center;">공유자 명단이 없습니다.</td></tr>`;
    }
    else{
    	$('tbody#tbody').empty();
    	
    	plusUserArr.forEach(function(item, index){ // 날짜 넘겨도 쌓이게 하려고 배열로 결국 돌리기...
       		nameAppend = item.name;
       		employeenoAppend = item.employeeno;
       		
       		// alert('employeenoAppend ' +employeenoAppend)
    	
    	
	    	$('.gong').remove();
	    	
	        html += `<tr>`;
	
	        html += `
	            <td class="info">
	                <span class="name" id="\${item.employeeno}" title="\${item.name}">\${item.name}</span>
	            </td>
	        `;
	
	
	        for(let i=0; i<26; i++) {
	            let timeStr = String(9 + i/2).padStart(2, '0');
	
				if (!isNaN(timeStr) && timeStr !== "" && timeStr !== " ") {
				    if (isInteger(timeStr)) { 
				        html += `<td><input class="clickTime em\${item.employeeno}" type="hidden" value="\${timeString + ' '+timeStr+':00'}"/></td>`;
				    } else {
				        html += `<td><input class="clickTime em\${item.employeeno}" type="hidden" value="\${timeString + ' '+parseInt(timeStr, 10)+':30'}"/></td>`;
				    }
				} else {
				    console.error("Invalid timeStr value:", timeStr);
				}
	
	            
	        }
	
	        html += `</tr>`;
        
	        // nameAppend =``;
	        
	        displayUserListSelect(employeenoAppend); // 일정 조회
    })
    }
   		
   	
    //-- DB 연동시 foreach로 바꿀것 --//
   	
    $('tbody#tbody').append(html);
    
// ====================== table tr 생성 ====================== //

} // end of function updateDate()------------

// 페이지 로드 시 현재 날짜 표시
updateDate();
// ====================== 날짜 리모컨 기능 생성 ====================== //

// === 정수 체크 함수 === //
function isInteger(number) {
    return !isNaN(number) && Number.isInteger(Number(number));
}
// === 정수 체크 함수 === //




</script>

<jsp:include page="../../footer/footer.jsp" /> 
