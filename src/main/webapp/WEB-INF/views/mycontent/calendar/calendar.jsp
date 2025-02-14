<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();
    //     /myspring
%>

<jsp:include page="../../header/header.jsp" />
 
<%-- 각자 페이지에 해당되는 css 연결 --%>
<link href="<%=ctxPath%>/css/email/email_main.css" rel="stylesheet">

<%-- 각자 페이지에 해당되는 js 연결 --%>
<script src="<%=ctxPath%>/js/email/email.js"></script>

<script type="text/javascript">


$(document).ready(function(){
	


//==== 풀캘린더와 관련된 소스코드 시작(화면이 로드되면 캘린더 전체 화면 보이게 해줌) ==== //
var calendarEl = document.getElementById('calendar');
    
var calendar = new FullCalendar.Calendar(calendarEl, {
 // === 구글캘린더를 이용하여 대한민국 공휴일 표시하기 시작 === //
    
	googleCalendarApiKey : "AIzaSyASM5hq3PTF2dNRmliR_rXpjqNqC-6aPbQ",
    eventSources :[ 
        {
        //  googleCalendarId : '대한민국의 휴일 캘린더 통합 캘린더 ID'
            googleCalendarId : 'ko.south_korea#holiday@group.v.calendar.google.com'
          , color: 'white'   // 옵션임! 옵션참고 사이트 https://fullcalendar.io/docs/event-source-object
          , textColor: 'red' // 옵션임! 옵션참고 사이트 https://fullcalendar.io/docs/event-source-object 
        } 
    ],
 // === 구글캘린더를 이용하여 대한민국 공휴일 표시하기 끝 === //

    initialView: 'dayGridMonth',
    locale: 'ko',
    selectable: true,
    editable: false,
    headerToolbar: {
    	  left: 'dayGridMonth dayGridWeek dayGridDay',
          center: 'title',
          right: 'prev,next today'
    },
    dayMaxEventRows: true, // for all non-TimeGrid views
    views: {
      timeGrid: {
        dayMaxEventRows: 3 // adjust to 6 only for timeGridWeek/timeGridDay
      }
    },
	
    // ===================== DB 와 연동하는 법 시작 ===================== //
	events:function(info, successCallback, failureCallback) {

    	 
    
    }, // end of events:function(info, successCallback, failureCallback) {}---------
    // ===================== DB 와 연동하는 법 끝 ===================== //
    
	// 풀캘린더에서 날짜 클릭할 때 발생하는 이벤트(일정 등록창으로 넘어간다)
    dateClick: function(info) {
  	 // alert('클릭한 Date: ' + info.dateStr); // 클릭한 Date: 2021-11-20
  	    $(".fc-day").css('background','none'); // 현재 날짜 배경색 없애기
  	    info.dayEl.style.backgroundColor = '#b1b8cd'; // 클릭한 날짜의 배경색 지정하기
  	    $("form > input[name=chooseDate]").val(info.dateStr);
  	    
  	    var frm = document.dateFrm;
  	    frm.method="POST";
  	    frm.action="<%= ctxPath%>/schedule/insertSchedule";
  	    frm.submit();
  	  },
  	  
  	 // === 사내캘린더, 내캘린더, 공유받은캘린더의 체크박스에 체크유무에 따라 일정을 보여주거나 일정을 숨기게 하는 것이다. === 
	 eventDidMount: function (arg) {
            var arr_calendar_checkbox = document.querySelectorAll("input.calendar_checkbox"); 
            // 사내캘린더, 내캘린더, 공유받은캘린더 에서의 모든 체크박스임
            
            arr_calendar_checkbox.forEach(function(item) { // item 이 사내캘린더, 내캘린더, 공유받은캘린더 에서의 모든 체크박스 중 하나인 체크박스임
	              if (item.checked) { 
	            	// 사내캘린더, 내캘린더, 공유받은캘린더 에서의 체크박스중 체크박스에 체크를 한 경우 라면
	                
	            	if (arg.event.extendedProps.cid === item.value) { // item.value 가 체크박스의 value 값이다.
	                	// console.log("일정을 보여주는 cid : "  + arg.event.extendedProps.cid);
	                	// console.log("일정을 보여주는 체크박스의 value값(item.value) : " + item.value);
	                    
	                	arg.el.style.display = "block"; // 풀캘린더에서 일정을 보여준다.
	                }
	              } 
	              
	              else { 
	            	// 사내캘린더, 내캘린더, 공유받은캘린더 에서의 체크박스중 체크박스에 체크를 해제한 경우 라면
	                
	            	if (arg.event.extendedProps.cid === item.value) {
	            		// console.log("일정을 숨기는 cid : "  + arg.event.extendedProps.cid);
	                	// console.log("일정을 숨기는 체크박스의 value값(item.value) : " + item.value);
	                	
	            		arg.el.style.display = "none"; // 풀캘린더에서 일정을  숨긴다.
	                }
	              }
            });// end of arr_calendar_checkbox.forEach(function(item) {})------------
      }
});

calendar.render();  // 풀캘린더 보여주기


	

	
})


</script>



	<%-- 이곳에 각 해당되는 뷰 페이지를 작성해주세요 --%>
	
	<jsp:include page="./calendar_bar.jsp" /> 

    <!-- 오른쪽 바 -->
    <div id="right_bar">
        <div id="right_title_box">
            <span id="right_title">Calendar</span>
            

            <!-- 오른쪽 바 메뉴버튼들입니다! -->
            
            <!-- 오른쪽 바 메뉴버튼들입니다! -->
        </div>
        

		

		<%-- 풀캘린더가 보여지는 엘리먼트  --%>
		<div id="calendar"></div>


    </div>
    <!-- 오른쪽 바 -->
	<%-- 이곳에 각 해당되는 뷰 페이지를 작성해주세요 --%>
	
<jsp:include page="../../footer/footer.jsp" /> 