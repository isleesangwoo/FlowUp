<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    



 
<%@include file="./reservationLeftBar.jsp" %>

<%-- 각자 페이지에 해당되는 css 연결 --%>
<link href="<%=ctxPath%>/css/reservation/reservation_main.css" rel="stylesheet"> 

<%-- 각자 페이지에 해당되는 js 연결 --%>
<script src="<%=ctxPath%>/js/reservation/reservation.js"></script>

	<%-- 이곳에 각 해당되는 뷰 페이지를 작성해주세요 --%>
    <!-- 오른쪽 바 -->
    <div id="right_bar">
        <div id="right_title_box">
            <span id="right_title">자산 예약 현황</span>
        </div>

		<!-- 시간표 달력을 보여주는 요소 전체 박스-->
		<div id="postContainer"> 
			<jsp:include page="../../common/time_calendar.jsp" /> 
		</div>
		<!-- 시간표 달력을 보여주는 요소 전체 박스-->
		
		<!-- 내 예약/ 대여 현황 테이블 -->
        <div>
			<div class="mytitle">
					내 예약 / 대여 현황
			</div>
			
			<div>
				<table border="1" class="my_table">
					<thead>
						<tr>
							<th>자산</th>
							<th>이름</th>
							<th>예약종류</th>
							<th>예약 시간 (대여 시작 시간)</th>
							<th>취소/반납</th>
						</tr>
					</thead>
					<tbody class="my_tbody">
					
					
						<tr>
							<td>차</td>
							<td>모닝1122</td>
							<td>대여</td>
							<td>09:00</td>
							<td>반납</td>
						</tr>
						
						
					</tbody>
				</table>
			</div>
		</div>
		<!-- 내 예약/ 대여 현황 테이블 -->
		<!-- 시간표 달력을 보여주는 요소 전체 박스-->
		<%-- 이곳에 각 해당되는 뷰 페이지를 작성 끝 --%>
    </div>
    <!-- 오른쪽 바 -->
    
	
	
<script>
	$(document).ready(function(){  
		  
		  
		  // ================ 들어오자마자 보이는 내 대여 현황 ================ //
		  <%--
		  $.ajax({
			  url:"<%= ctxPath%>/reservation/showMyReservation",
			  type:"get",
			  data:{"employeeNo":"${sessionScope.loginuser.employeeNo}"},
			  dataType:"json",
			  success:function(json){
				  
			  console.log("ajax 뽑아옴 : ", JSON.stringify(json));

			  
			  let v_html = ``;
			  
			  $.each(json, function(index, item){
				  v_html += `<tr>
								<td>\${item.}</td>
								<td>모닝1122</td>
								<td>대여</td>
								<td>09:00</td>
								<td>반납</td>
							</tr>`;
			  });
			  
			  
			  
			  },
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }   
		  });
		  --%>
		  // ================ 들어오자마자 보이는 내 대여 현황 ================ //
		  
		  
	  });// end of $(document).ready(function(){})-----------
</script>
	
	
	
<jsp:include page="../../footer/footer.jsp" /> 
