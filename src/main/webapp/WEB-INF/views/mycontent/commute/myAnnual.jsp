<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
String ctxPath = request.getContextPath();
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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

:root {
	--size2: clamp(2px, 0.1042vw, 200px);
	--size8: clamp(6px, 0.4167vw, 200px);
	--size12: clamp(10px, 0.6250vw, 200px);
	--size14: clamp(12px, 0.7292vw, 200px);
	--size15: clamp(14px, 0.7813vw, 200px);
	--size16: clamp(16px, 0.8333vw, 200px);
	--size18: clamp(17px, 0.9375vw, 200px);
	--size20: clamp(18px, 1.0417vw, 200px);
	--size24: clamp(24px, 1.2500vw, 200px);
	--size30: clamp(28px, 1.5625vw, 200px);
	--size32: clamp(30px, 1.6667vw, 200px);
	--size40: clamp(36px, 2.0833vw, 200px);
	--size52: clamp(48px, 2.7083vw, 200px);
	--size60: clamp(50px, 3.1250vw, 200px);
	--size65: clamp(60px, 3.3854vw, 200px);
	--size98: clamp(80px, 5.1042vw, 2000px);
	--size100: clamp(80px, 5.2083vw, 2000px);
	--size120: clamp(100px, 6.2500vw, 2000px);
	--size200: clamp(200px, 10.4167vw, 2000px);
	--size300: clamp(300px, 15.6250vw, 2000px);
	--size400: clamp(380px, 20.8333vw, 2000px);
	--size500: clamp(500px, 26.0417vw, 2000px);
	--size670: clamp(650px, 34.8958vw, 2000px);
	--size700: clamp(680px, 36.4583vw, 3000px);
	--size930: clamp(900px, 48.4375vw, 10000px);
	--whiteColor: #fff;
	--baseColor1: #F9FAFB;
	--baseColor2: #f1f2f3;
	--pointColor: #2985DB;
	--keyColor: #21255b;
	--darkBgColor: #0C1929;
	--darkBaseColor: #141C30;
}

.dateController {
	width: 100%;
	margin: auto;
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


.calendar_container {
	position: relative;
}

table {
	border-collapse: collapse;
	font-size: var(--size14);
	border: 1px solid #ddd;
	width: 100%;
	table-layout: fixed;
	border-collapse: collapse;
	border-spacing: 0;
}

table tr th, .info {
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

.info span {
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

table td {
	
}

div.hoverDiv:hover {
	cursor: pointer;
}

/*   table td:hover {
    	background-color: yellow;
    	cursor: pointer;
    } */

</style>


<script>

	$(document).ready(()=>{
		
		const today = new Date(); 
		
		const year = today.getFullYear();
		const month = String(today.getMonth()+1).padStart(2, '0');  
		const day = String(today.getDate()).padStart(2, '0');
		const daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];
		const dayOfWeek = daysOfWeek[today.getDay()]; 	
		
		const timeString = year+"."+month+"."+day+" ("+dayOfWeek+")";
		
		$('#today').text(timeString);
	});
  
    
</script>
<div style="display: flex;">

	<div
		style="width: var(--size250);; height: 100vh; border-right: solid 1px #000;">

		<jsp:include page="../../common/commute_btn.jsp" />
	</div>
	
	<div style="width: 100%; padding: 5px;">
	
		<div class="dateController" style="margin-bottom: 50px;">
			<div class="" style="width: 200px; margin: 20px auto;">
				<div id="today" style="text-align: center; font-size:20px;">today</div>
			</div>
		</div>
		
		<div class="ml-1 mr-1 mb-5" style="border: solid 1px #e5e5e5;">
		
			<div style="display: flex; height: 120px; align-items: center;">
			
					<div style="align-items: center; width: 20%;">
						<div style="text-align: center;  width: 100%;">${requestScope.map.positionName}&nbsp;${requestScope.map.name}</div>
					</div>
					
					<div style="height: 120px; width: 3px;">
						<span style="background-color: #e5e5e5; width: 1px; height: 120px; display: inline-block; margin: 0 1px;"></span>
					</div>
				
					<div style="align-items: center; width: 10%;">
						<div style="text-align: center;  width: 100%; margin-bottom: 10px;">발생 연차</div>
						<div style="text-align: center;  width: 100%;">${requestScope.avo.occurAnnual}</div>
					</div>
					
					<div style="height: 120px; width: 3px;">
						<span style="background-color: #e5e5e5; width: 1px; height: 70px; display: inline-block; margin: 25px 1px;"></span>
					</div>
					
					<div style="align-items: center; width: 10%;">
						<div style="text-align: center;  width: 100%; margin-bottom: 10px;">이월 연차</div>
						<div style="text-align: center;  width: 100%;">${requestScope.avo.overAnnual}</div>
					</div>
					
					<div style="height: 120px; width: 3px;">
						<span style="background-color: #e5e5e5; width: 1px; height: 70px; display: inline-block; margin: 25px 1px;"></span>
					</div>
					
					<div style="align-items: center; width: 10%;">
						<div style="text-align: center;  width: 100%; margin-bottom: 10px;">조정 연차</div>
						<div style="text-align: center;  width: 100%;">${requestScope.avo.addAnnual}</div>
					</div>
				
					<div style="height: 120px; width: 3px;">
						<span style="background-color: #e5e5e5; width: 1px; height: 120px; display: inline-block; margin: 0 1px;"></span>
					</div>
				
				
					<div style="align-items: center; width: 10%;">
						<div style="text-align: center;  width: 100%; margin-bottom: 10px; color:#2985DB; font-weight: bold">총 연차</div>
						<div style="text-align: center;  width: 100%;">${requestScope.avo.totalAnnual}</div>
					</div>
					
					<div style="height: 120px; width: 3px;">
						<span style="background-color: #e5e5e5; width: 1px; height: 70px; display: inline-block; margin: 25px 1px;"></span>
					</div>
					
					<div style="align-items: center; width: 10%;">
						<div style="text-align: center;  width: 100%; margin-bottom: 10px; color:#2985DB; font-weight: bold">사용 연차</div>
						<div style="text-align: center;  width: 100%;">${requestScope.avo.usedAnnual}</div>
					</div>
					
					<div style="height: 120px; width: 3px;">
						<span style="background-color: #e5e5e5; width: 1px; height: 70px; display: inline-block; margin: 25px 1px;"></span>
					</div>
					
					<div style="align-items: center; width: 10%;">
						<div style="text-align: center;  width: 100%; margin-bottom: 10px; color:#2985DB; font-weight: bold">잔여 연차</div>
						<div style="text-align: center;  width: 100%;">${requestScope.avo.remainderAnnual}</div>
					</div>
				
			</div>
	
		</div>
	
		<div class="ml-3 mr-3 mb-3">
	
			<label for="useYear">연차 사용기간 : </label>
			<select id="useYear" name="useYear">
				<option value="2025">2025년</option>
	      		<option value="2024">2024년</option>
				<option value="2023">2023년</option>
				<option value="2022">2022년</option>
				<option value="2021">2021년</option>
			</select>
		</div>
	
		<div class="ml-3 mr-3 mb-3">
			<div style="font-size:16pt;">사용 내역</div>
			
			<table>
				<thead>
					<tr>
						<th>연차사용기간</th>
						<th>사용 연차</th>
						<th>사유</th>
					</tr>
				</thead>
				
				<tbody></tbody>
			</table>
		</div>
	
		
	
	
	
	
	
	
	
	
	
	
	</div>


</div>











<jsp:include page="../../footer/footer.jsp" />
