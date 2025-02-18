<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../../header/header.jsp" /> 

<style>
   * {
       font-family: "Noto Sans KR", sans-serif;
       font-optical-sizing: auto;
       margin: 0px;
       padding: 0px;
   }
   
   *::after {
       margin: 0px;
       padding: 0px;
   }
   
   *::before { 
       margin: 0px;
       padding: 0px;
   }

   :root{
       --size2  : clamp(2px, 0.1042vw, 200px);
       --size8  : clamp(6px, 0.4167vw, 200px);
       --size12 : clamp(10px, 0.6250vw, 200px);
       --size14 : clamp(12px, 0.7292vw, 200px);
       --size15 : clamp(14px, 0.7813vw, 200px);
       --size16 : clamp(16px, 0.8333vw, 200px);
       --size18 : clamp(17px, 0.9375vw, 200px);
       --size20 : clamp(18px, 1.0417vw, 200px);
       --size24 : clamp(24px, 1.2500vw, 200px);
       
       --size30 : clamp(28px, 1.5625vw, 200px);
       --size32 : clamp(30px, 1.6667vw, 200px);
       --size40 : clamp(36px, 2.0833vw, 200px);
       --size52 : clamp(48px, 2.7083vw, 200px);
       --size60 : clamp(50px, 3.1250vw, 200px);
       --size65 : clamp(60px, 3.3854vw, 200px);
   
       --size98  : clamp(80px, 5.1042vw, 2000px);
       --size100 : clamp(80px, 5.2083vw, 2000px);
       --size120 : clamp(100px, 6.2500vw, 2000px);
       --size200 : clamp(200px, 10.4167vw, 2000px);
       --size300 : clamp(300px, 15.6250vw, 2000px);
       --size400 : clamp(380px, 20.8333vw, 2000px);
       --size500 : clamp(500px, 26.0417vw, 2000px);
       --size670 : clamp(650px, 34.8958vw, 2000px);
       --size700 : clamp(680px, 36.4583vw, 3000px);
       --size930 : clamp(900px, 48.4375vw, 10000px);
   
       --whiteColor : #fff;
       --baseColor1 : #F9FAFB;
       --baseColor2 : #f1f2f3;
       --pointColor : #2985DB;
       --keyColor : #21255b;
   
       --darkBgColor : #0C1929;
       --darkBaseColor : #141C30;
   }
   
   .dateController {
        width: 100%; 
        margin: auto;
    }

    .dateTopBar {
        display: flex;
        gap: var(--size16);
        align-items: center;
        justify-content: space-between;
      padding: 0px var(--size24);
        margin-bottom: var(--size30);
    }
   
   .dateTopBtn {
      display: flex;
        gap: var(--size16);
        align-items: center;
        justify-content: center;
   }
    #today {
        font-size: var(--size24);
        font-weight: 500;
    }

    #now {
        box-sizing: border-box;
        padding: calc(var(--size2) + var(--size2)) calc(var(--size2) + var(--size2));
        margin-top: calc(var(--size2) + var(--size2));
        font-size: var(--size12);
    }

    #now:hover {
        background-color: #eee;
    }

    .calendar_container {
        position: relative;
    }

    table {
        border-collapse : collapse;
        font-size: var(--size14);
    }

    .time_table_back_form {
        border: 1px solid #ddd;
        width: 100%;
        table-layout: fixed;
        border-collapse: collapse;
        border-spacing: 0;
    }

    .time_table_back_form tr th,
    .info {
        height: var(--size30);
        font-weight: normal;
      text-align: center;
    }

    .info {
        vertical-align: middle;
        overflow: hidden;
        text-align: center;
        border-left: 0;
    }

    .info span{
        display: block;
        color: #333;
        text-align: left;
        margin: 2px 5px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        max-width: 100%;
        cursor: pointer;
        font-size: 13px;
    }
    
    table#timeTable td {
    	
    }
    
    table#timeTable td:hover {
    	background-color: yellow;
    	cursor: pointer;
    }
 
    .openDiv {
    	display:block;
    }
    
    .closeDiv {
    	display:none;
    }

    
</style>

<script>
    $(document).ready(() => {
    	
        // ====================== 날짜 리모컨 기능 생성 ====================== //
        const currentDate = new Date(); 
        const currentDate_year = currentDate.getFullYear();
        const currentDate_month = String(currentDate.getMonth()+1).padStart(2, '0');  
        
        
        const select_month_first_day = new Date(currentDate_year,currentDate_month-1,1);
        
        
        // 이전 버튼 클릭 시
        $('#prev').click(() => {
        	select_month_first_day.setMonth(select_month_first_day.getMonth() - 1);
            week_div(select_month_first_day);
            
        });

        // 다음 버튼 클릭 시
        $('#next').click(() => {
        	select_month_first_day.setMonth(select_month_first_day.getMonth() + 1);
            week_div(select_month_first_day);
        });

        // 오늘 버튼 클릭 시
        $('#now').click(() => {
        	select_month_first_day = new Date(currentDate); // 저장된 currentDate 날짜로 복구
            week_div(select_month_first_day);
        });

       
        // 페이지 로드 시 현재 날짜 및 테이표시
        week_div(select_month_first_day);
        // ====================== 날짜 리모컨 기능 생성 ====================== //
 
        $('div.oneday').hide();
        
     	
     	// 주차 버튼 클릭시 열림
     	$(document).on('click', 'div.weekBig',e=>{
     	
     		if($(e.target).next().css('display') == 'none') {
     			$(e.target).parent().parent().find("div.weekbro").css({"display":"none"});
     			$(e.target).next().css({"display":""});
     			$(e.target).parent().parent().find("div.daybro").css({"display":"none"});
	 		}
	 		else {
	 			$(e.target).parent().parent().find("div.weekbro").css({"display":"none"});
	 		}
	 		
     		
     		
     	});
     	
     	
     	
     	// 일자 버튼 클릭시 열림
     	$(document).on('click', 'div.dayBig',e=>{
     		
     		if($(e.target).next().css('display') == 'none') {
     			$(e.target).next().css({"display":""});
     			
	 		}
	 		else {
	 			$(e.target).next().css({"display":"none"});
	 		}
    	
     	});
        
        
        
        
    }); // end of $(document).ready(() => {})-------------

   
    function week_div(today) {

    	const year = today.getFullYear();
    	let month = String(today.getMonth()+1).padStart(2, '0');  		// 오늘(선택일)의 월

    	console.log(month);
    	
    	const day = String(today.getDate()).padStart(2, '0');			// 오늘(선택일)의 일
    	const daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];		//
    	const dayOfWeek = daysOfWeek[today.getDay()]; 					// 오늘(선택일)의 요일
 
    	const end = new Date(year, month, 0);
    	
    	const end_day = Number(String(end.getDate()));

    	const timeString = `\${year}-\${month}`;
    	
    	
        $('#today').text(timeString);
    	
 
    	let weekNo = 1;
    	
    	let html = `<div style="padding:10px;"> `; // 전체 div 시작
    	
    
    	for(let i=1; i<=end_day; i++) {
    		
    		let i_day = i;
    		
    		if(i == end_day) {
    			month++;
    			i_day = 0;
    			
    		}
    		
    		const i_today = new Date(year,month-1, i_day);

    		const i_month = String(i_today.getMonth()+1).padStart(2, '0'); 
    		const i_date = String(i_today.getDate()).padStart(2, '0');
    		const i_dayOfWeek = daysOfWeek[i_today.getDay()]; 
    	
    		
    		if(i == 1 || i_dayOfWeek == '월') {
    			html += `<div>
    						<div class="weekBig" style="width:100px; font-size:14pt;">\${weekNo} 주차</div>
    						<div class="weekbro" style="display:none;">`;			// 주차 적는 div
    		}
    		
    		html += `<div class="dayBig" style="width:200px;">&nbsp;&nbsp;&nbsp;\${i_month}월 \${i_date}일 (\${i_dayOfWeek})</div>		
 
    				<div class="daybro" style="display:none; padding:0 10px;">													
    		    		<table border="1" class="time_table_back_form" id="timeTable">			
    		    			<thead>`;															
    					
    		for(let j=1; j<=24; j++) {
    	        		
    	    	let hour = j;
    	    			
    	    	if(hour < 10 ) {
    	    		hour = `0\${j}`;
    	    	}
    	    			
    	        html += `<th colspan="6">\${hour}</th>`;										// th 
    		} ///
    			
    		html += `</thead>`;																	// 헤더 끝
    		
    		/* tbody */

    		html += `<tbody>`;																// 바디 시작
    					
        	for(let k=0; k<144; k++) {
        		
        		const hour = Math.floor(k/6);
        		const min = (k - ( Math.floor(k/6) * 6 ) ) * 10;
        		
        		html += `<td style="height:30px;"><input type="hidden" name="today" value="\${hour}-\${min}"></td>`;	// td
        		
        	}
        	
        	html += `</tbody></table></div>`; 																			// 테이블 감싸는 div 끝
				
    		if(i_dayOfWeek == '일') {
    			html += `</div></div>`;														// 주차 감싸는 div 끝
    			weekNo++;   
    		}
    		
    		
    	}
    
    	html += `</div>`; // 전체 div 끝
    	
    	$("div#vieww").html(html);
    	
    	
    	
    	
    } //// week_div(today) 
    
    
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
</script>

<div style="display:flex;">
	
	<div style="width: var(--size250);; height:100vh; border-right: solid 1px #000;">
	
		<jsp:include page="../../common/commute_btn.jsp" /> 
		
	</div>
	
	<div style="width:100%; padding:5px;">
		<div class="dateController">
    		<div class="dateTopBar">
	      
	      		<div class="dateTopBtn" style="width:200px; margin:0 auto;">
	           		<span id="prev" style="cursor: pointer;">&#60;</span>   <!-- 이전날짜 버튼 -->
	           		<div id="today" style="text-align: center;">today</div> <!-- 날짜 표기 -->
	           		<span id="next" style="cursor: pointer;">&#62;</span>   <!-- 다음날짜 버튼 -->
	   
	           		<span id="now" style="cursor: pointer;">오늘</span>
	      		</div>
	      
    		</div>
    		
    		<div id=vieww>
    		
			</div>
			
		</div>
		
	</div>
	
</div>

<jsp:include page="../../footer/footer.jsp" /> 
