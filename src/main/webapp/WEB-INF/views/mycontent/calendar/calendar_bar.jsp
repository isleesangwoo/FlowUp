<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String ctxPath = request.getContextPath();
    //     /myspring
%>

<!-- full calendar에 관련된 script -->
<script src='<%=ctxPath%>/fullcalendar_5.10.1/main.min.js'></script>
<script src='<%=ctxPath%>/fullcalendar_5.10.1/ko.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<link href='<%=ctxPath %>/fullcalendar_5.10.1/main.min.css' rel='stylesheet' />

<style type="text/css">

div#wrapper1{
	display: inline-block; width: 100%; font-size: 14px; margin-top:10px;
}


/* ========== full calendar css 시작 ========== */
.fc-header-toolbar {
	height: 30px;
}

a, a:hover, .fc-daygrid {
    color: #000;
    text-decoration: none;
    background-color: transparent;
    cursor: pointer;
} 

    .fc-day-number.fc-sat.fc-past { color:#0000FF; }     /* 토요일 */    .fc-day-number.fc-sun.fc-past { color:#FF0000; }    /* 일요일 */

/* ========== full calendar css 끝 ========== */

ul{
	list-style: none;
}

button.btn_normal{
	background-color: #990000;
	border: none;
	color: white;
	width: 50px;
	height: 30px;
	font-size: 12pt;
	padding: 3px 0px;
	border-radius: 10%;
}

button.btn_edit{
	border: none;
}

.fc-view-harness-active{
	height:900px !important;
	font-size:14px;
}

.fc .fc-daygrid-day.fc-day-today {
	background-color:#eee !important;
}

.fc-button-primary {
	width:60px !important;
	margin: 0px !important;
	padding: 4px 0px;
	font-size: 14px !important;
	background-color: none !important;
}

.fc-button-primary:hover {
	background-color: none !important;
}

.fc-day-sun .fc-col-header-cell-cushion,
.fc-day-sun a{
    color : red;
}

.fc-day-sat .fc-col-header-cell-cushion,
.fc-day-sat a {
    color : blue;
}

.fc-toolbar-chunk > div:nth-child(1){
	display:flex;
	margin-bottom:50px;
}

.fc .fc-toolbar.fc-header-toolbar{
	position:relative;
}

.fc .fc-toolbar.fc-header-toolbar::after{
	position:absolute;
	content:"";
	bottom:0px;
	left:0px;
	width:100%;
	height:1px;
	background-color: #999;
}

</style>




<!-- 메일작성 폼 -->
    <div id="modal111" class="modal_bg11">
    </div>
    <div class="modal_container">

        <!-- 여기에 메일작성 폼을 만들어주세요!! -->
        <!-- 여기에 메일작성 폼을 만들어주세요!! -->
        <!-- 여기에 메일작성 폼을 만들어주세요!! -->

    </div>
    <!-- 메일작성 폼 -->

	
	<!-- 왼쪽 사이드바 -->
    <div id="left_bar">

        <!-- === 메일 작성 버튼 === -->
        <button id="goMail">
            <i class="fa-solid fa-plus"></i>
            <span>일정추가</span>
        </button>
        <!-- === 메일 작성 버튼 === -->

		
		<div id="wrapper1">
				<input type="hidden" value="${sessionScope.loginuser.employeeNo}" id="fk_employeeNo"/>
				
				<input type="checkbox" id="allComCal" class="calendar_checkbox" checked/>&nbsp;&nbsp;<label for="allComCal">사내 캘린더</label>
			
			<%-- 사내 캘린더 추가를 할 수 있는 직원은 직위코드가 3 이면서 부서코드가 4 에 근무하는 사원이 로그인 한 경우에만 가능하도록 조건을 걸어둔다.  	 --%>
				<c:when test="${loginuser.securityLevel =='10'}"> 
				 	<button class="btn_edit" style="float: right;" onclick="addComCalendar()"><i class='fas'>&#xf055;</i></button>
			    </c:when>
			    <%-- 사내 캘린더를 보여주는 곳 --%>
				<div id="companyCal" style="margin-left: 12px; margin-bottom: 10px;"></div>
				
				
				<input type="checkbox" id="allMyCal" class="calendar_checkbox" checked/>&nbsp;&nbsp;<label for="allMyCal">내 캘린더</label>
				<button class="btn_edit" style="float: right;" onclick="addMyCalendar()"><i class='fas'>&#xf055;</i></button>
				
				<%-- 내 캘린더를 보여주는 곳 --%>
				<div id="myCal" style="margin-left: 12px; margin-bottom: 10px;"></div>

				<input type="checkbox" id="sharedCal" class="calendar_checkbox" value="0" checked/>&nbsp;&nbsp;<label for="sharedCal">공유받은 캘린더</label> 
			</div>
			
    </div>
    <!-- 왼쪽 사이드바 -->
    
    
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
				  "fk_employeeNo": "${sessionScope.loginuser.employeeNo}",
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
				  "fk_employeeNo": "${sessionScope.loginuser.employeeNo}",
				  "caltype":"1"  // 내캘린더
				  },
			dataType:"json",
			success:function(json){
				if(json.n == 0){
					alert($("input.edit_com_smcatgoname").val()+"은(는) 이미 존재하는 캘린더 명입니다.");
					return;
				 }
				if(json.n == 1){
					$('#modal_editMyCal').modal('hide'); // 모달 숨기기
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