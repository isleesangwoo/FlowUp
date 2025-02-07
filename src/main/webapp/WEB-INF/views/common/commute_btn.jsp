<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   String ctxPath = request.getContextPath();
   //     /myspring 
%>      
<%-- Optional JavaScript --%>
<script type="text/javascript" src="<%=ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%=ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script>
  
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
	
	#goToWork {
	    width: 100%;
	    height: auto;
	    background-color: var(--whiteColor);
	    border-radius: var(--size20);
	    box-sizing: border-box;
	    padding: var(--size16);
	    color: #000;
	}
	
	#goToWork > div {
	    position: relative;
	    width: 100%;
	    height: 100%;
	}
	
	#workTitle {
	    font-size: var(--size16);
	    margin-bottom: var(--size12);
	}
	
	#clock {
	    font-size: var(--size14);
	    color: var(--pointColor);
	    opacity: 0.9;
	}
	
	#gauge-title {
	    font-size: var(--size24);
	    line-height: var(--size40);
	}
	
	#gauge-title b {
	    font-size: var(--size16);
	    margin-left: var(--size2);
	    letter-spacing: 0;  
	}
	
	#gauge {
	    position: relative;
	    width: 100%;
	    height: var(--size12);
	    background-color: #eee;
	    border-radius: var(--size12);
	    overflow: hidden;
	}
	
	#gauge-percent {
	    width: 30%;
	    height: 100%;
	    background-color: var(--keyColor);
	}
	
	#clock-contants > div:nth-child(2) {
	
	    width: 100%;
	    display: flex;
	    justify-content: space-between;
	}
	
	#clock-contants > div:nth-child(2) span {
	    display: inline-block;
	    width: 46%;
	    height: var(--size40);
	    line-height: var(--size40);
	    text-align: center;
	    color: var(--keyColor);
	    box-sizing: initial;
	    border: 1px solid var(--keyColor);
	    border-radius: var(--size8);
	    font-size: var(--size16);
	    cursor: pointer;
	    transition: all 0.3s;
	}
	
	#clock-contants > div:nth-child(2) span:hover {
	    color: var(--whiteColor);
	    background-color: var(--keyColor);
	}
	
	#total-hour {
	    position: relative;
	    box-sizing: border-box;
	    padding: var(--size12) 0px;
	    margin-bottom: var(--size40);
	}
	
	#total-hour::before {
	    content: "";
	    position: absolute;
	    bottom: 0px;
	    left: 0px;
	    background-color: var(--pointColor);
	    width: 100%;
	    height: 0.5px;
	}
	
	#hour-gauge {
	    font-size: var(--size14);
	    color: var(--keyColor);
	}
	
	#hour-gauge > div:nth-child(1) {
	    margin-bottom: var(--size40);
	}
	
	#gauge-container {
	    position: relative;
	}
	
	.gauge-bar {
	    position: absolute;
	    top: 0px;
	    left: calc(40 / 52 * 100% - 20px);
	    width: var(--size2);
	    height: 100%;
	    background-color: red;
	}
	
	.max-time {
	    position: absolute;
	    right: 0px;
	    top: calc(-1 * var(--size20) );
	    color: #5a5a5a;
	}
	
	.min-time {
	    position: absolute;
	    top: var(--size20);
	    left: calc(40 / 52 * 100% - var(--size30) );
	}
	
	.hour-check {
	    display: flex;
	    justify-content: space-between;
	}
</style>


<script type="text/javascript">
	$(document).ready(()=>{
	
	    // ========== 시간을 알려주는 메소드 ========== //
	    function updateClock() {
	        const now = new Date();
	        const daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];
	        const dayOfWeek = daysOfWeek[now.getDay()];
	        const year = now.getFullYear();
	        const month = (now.getMonth() + 1).toString().padStart(2, '0');
	        const day = now.getDate().toString().padStart(2, '0');
	        const hours = now.getHours();
	        const minutes = now.getMinutes().toString().padStart(2, '0');
	        const seconds = now.getSeconds().toString().padStart(2, '0');
	        
	        let displayHours = hours;
	        
	        const timeString = `\${year}-\${month}-\${day} (\${dayOfWeek}) \${displayHours}:\${minutes}:\${seconds}`;
	        document.getElementById('clock').textContent = timeString;
	    }
	    
	    // 매 초마다 시계 업데이트
	    setInterval(updateClock, 1000);
	    
	    // 페이지 로드 시에도 시계 업데이트
	    updateClock();
	    // ========== 시간을 알려주는 메소드 ========== //
	});
</script>
<div id="goToWork">
     <div>
         <div id="workTitle">근태관리</div>
         <div id="clock">Loading...</div> 
         <!-- $('#clock').text(); 찍으면 현재 시간 나옵니다! ex) 2025-01-31 (금) 0:00:49 -->
        <!-- 출근, 퇴근 클릭시 해당 엘리먼트 이용하면 될듯 합니다! -->
        <div id="clock-contants">
            <div id="total-hour">
                <div id="hour-gauge">
                    <div>
                        <span id="gauge-title" title="주간 근무시간입니다.">20<b>h</b> 29<b>m</b></span>
                        <div id="gauge-container">
                            <div id="gauge">
                                <div id="gauge-percent"></div> 
                                <!-- 주마다 시간을 모두 합산해 n/52 한 백분율 값을 gauge-percent의 width로 %를 주세요 -->
                                <!-- 현재는 임의로 30%를 지정했습니다. -->
                            </div>
                            <div class="gauge-bar"></div>
                            <div class="max-time">최대 52h</div>
                            <div class="min-time">최소 40h</div>
                        </div>
                    </div>
                    <div>
                        <div class="hour-check">
                            <span>출근시간</span>
                            <span>09:00:00</span> <!-- 출근시간과 퇴근시간을 기록해주세요 -->
                        </div>
                        <div class="hour-check">
                            <span>퇴근시간</span>
                            <span>18:00:00</span>  <!-- 출근시간과 퇴근시간을 기록해주세요 -->
                        </div>
                    </div>
                </div>
            </div>
            <div>
                <span>출근</span> <!-- 해당버튼 클릭시 출근시간이 input태그의 value값에 들어가게 해주세요 -->
                <span>퇴근</span> <!-- 해당버튼 클릭시 퇴근시간이 input태그의 value값에 들어가게 해주세요 -->
                <!-- 출근시간과 퇴근시간의 차에 시급을 곱한 값이 일당입니다. -->
            </div>
        </div>
    </div>
</div>
