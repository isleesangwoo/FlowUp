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
	float: left; display: inline-block; width: 20%; margin-top:250px; font-size: 13pt;
}

div#wrapper2{
	display: inline-block; width: 80%; padding-left: 20px;
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
	background-color: #fff;
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

        <div class="mail_menu_container">
            <ul>
                <li>
                    <a href="#">받은메일함</a>
                </li>
                <li><a href="#">보낸메일함</a></li>
                <li><a href="#">임시보관함</a></li>
                <li><a href="#">태그메일함</a></li>
                <li><a href="#">중요메일함</a></li>
                <li><a href="#">휴지통</a></li>
            </ul>
        </div>
		
		<div id="wrapper1">
				<input type="hidden" value="100012" id="fk_userid"/>
				
				<input type="checkbox" id="allComCal" class="calendar_checkbox" checked/>&nbsp;&nbsp;<label for="allComCal">사내 캘린더</label>
			
			<%-- 사내 캘린더 추가를 할 수 있는 직원은 직위코드가 3 이면서 부서코드가 4 에 근무하는 사원이 로그인 한 경우에만 가능하도록 조건을 걸어둔다.  	
				 	<button class="btn_edit" style="float: right;" onclick="addComCalendar()"><i class='fas'>&#xf055;</i></button>
			    
			    <%-- 사내 캘린더를 보여주는 곳 --%>
				<div id="companyCal" style="margin-left: 50px; margin-bottom: 10px;"></div>
				
				
				<input type="checkbox" id="allMyCal" class="calendar_checkbox" checked/>&nbsp;&nbsp;<label for="allMyCal">내 캘린더</label>
				<button class="btn_edit" style="float: right;" onclick="addMyCalendar()"><i class='fas'>&#xf055;</i></button>
				
				<%-- 내 캘린더를 보여주는 곳 --%>
				<div id="myCal" style="margin-left: 50px; margin-bottom: 10px;"></div>

				<input type="checkbox" id="sharedCal" class="calendar_checkbox" value="0" checked/>&nbsp;&nbsp;<label for="sharedCal">공유받은 캘린더</label> 
			</div>
			
    </div>
    <!-- 왼쪽 사이드바 -->