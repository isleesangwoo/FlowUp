<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();
    //     /myspring
%>

<jsp:include page="../../header/header.jsp" /> 

<!-- clipboard.js cdn 추가 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/2.0.10/clipboard.min.js"></script>



<link href="<%=ctxPath%>/css/main/main.css" rel="stylesheet"> 


	<%-- <div class="dashboard"> --%>
	<div id="assetModalBg" class="modal_bg"></div>
	
	
	<div class="dashboard">
		<div class="leftDiv">
		
			<!-- 타이틀, 검색창 -->
			<div class="titleSearchBox">
				<div class="dashboardTitle">Flow Up Dashboard</div>
				
				<div class="searchbox">
					<i class="fa-solid fa-magnifying-glass"></i>
				</div>
			</div>
			<!-- 타이틀, 검색창 -->
			
			
			<!-- 첫 container -->
			<div class="topContainer">
				<div class="topInnerContainer">
					<div class="topInnerTitle">
						<i class="fa-solid fa-user"></i>
						사원번호
					</div>
					
					<!-- 사원번호 복사기능 -->
					<div class="employeeNoCopyBox">
						<span id="employeeNoCopy">${sessionScope.loginuser.employeeNo}</span> 
						
						<span class="copyBtn btnBack" data-clipboard-target="#employeeNoCopy">
							<i class="fa-solid fa-paperclip"></i>
						</span>
					</div>
					<!-- 사원번호 복사기능 -->
				</div>
				
				<div class="topInnerContainer">
					<div class="topInnerTitle">
						<i class="fa-solid fa-address-card"></i>
						주소록
					</div>
					
					<!-- 주소록 기능 -->
					<div class="employeeNoCopyBox">
						<span class="topInnerContentTitle">
							강이훈 외 9건+
						</span>
						
						
						<span class="btnBack addrBtn" style="display: flex; position: relative;">
							<i style="margin:auto;" class="fa-solid fa-angle-right arrow"></i>
							
							<div class="addrModal">
								<div style="padding: 16px;">
								
									<div style="margin-bottom: 12px;">
										강이훈 님의 주소록입니다.
									</div>
									
									<table border="1" class="time_table_back_form">
										<tr>
											<th>이름</th>
											<th>직위</th>
											<th>이메일</th>
											<th>전화번호</th>
											<th>내선번호</th>
										</tr>
									</table>
									
								</div>
							</div>
						</span>
							
							
					</div>
					<!-- 주소록 기능 -->
				</div>
				
				<div class="topInnerContainer">
					<div class="topInnerTitle">
						<i class="fa-solid fa-location-dot"></i>
						최근접속
					</div>
					
					<!-- ip 기능 -->
					<div class="employeeNoCopyBox">
						<span class="topInnerContentTitle">
							192.168.0.205
						</span>
						
						<span class="btnBack">
							<i class="fa-solid fa-angle-right arrow"></i>
						</span>
					</div>
					<!-- ip 기능 -->
				</div>
			</div>
			<!-- 첫 container -->
			
			
			<!-- 두번째 container -->
			<div class="secContainer">
				<div class="topInnerTitle">
					<i class="fa-solid fa-chart-simple"></i>
					예약정보
				</div>
				
				<div>
				
					<jsp:include page="../../common/time_calendar.jsp" /> 
				</div>
			</div>
			<!-- 두번째 container -->
			
			
			<!-- 세번째 container -->
			<div class="treContainer">
				<div class="treInnerContainer">
					<div class="topInnerTitle">
						<i class="fa-solid fa-money-check-dollar"></i>
						전자결제
					</div>
				</div>
				
				<div class="treInnerContainer">
					<div class="topInnerTitle">
						<i class="fa-solid fa-envelope"></i>
						이메일
					</div>
				</div>
			</div>
			<!-- 세번째 container -->
			
			
			<!-- 네번째 container -->
			<div class="forContainer">
				<div class="topInnerTitle">
					<i class="fa-solid fa-comments"></i>
					게시판
				</div>
				<jsp:include page="../board/board2.jsp" /> 
				
			</div>
			<!-- 네번째 container -->
		</div>
			
		<div class="rightDiv">
		
			<div class="stickyBox">
		
				<div class="rightTopContainer">
					
				</div>
				
				<div class="rightSeContainer" style="margin-top:16px; height: auto;">
					<jsp:include page="../../common/commute_btn2.jsp" /> 
				</div>
			
			</div>
			
		</div>
	</div>
	<%-- <div class="dashboard"> --%>
	
	
	
	
	
	
	
	<%--
	<div style="display:none; width: 430px; height: auto; background-color: #252525; text-align: center; color: #fff">
		<jsp:include page="../../common/commute_btn2.jsp" /> 
	</div>
	--%>
	



<!-- 라이브러리 실행 -->
<link rel="stylesheet" href="<%=ctxPath%>/js-snackbar-master/dist/js-snackbar.css">
<script src="<%=ctxPath%>/js-snackbar-master/dist/js-snackbar.js">


</script>
<script>
    var clipboard = new ClipboardJS('.copyBtn');
  
    clipboard.on('success', function(e) {
    	demoContainer();
    });
  
    clipboard.on('error', function(e) {
        console.log(e);
    });
    
    
    
    var demoContainer = function () {
	    SnackBar({
	    	message: "복사가 완료되었습니다.",
		    status: "success"
	    })
	}
    
    
    
    $('.addrBtn').click(e=>{
    	$('.addrModal').css({
    		'height': '500px'
    	})
    	
    	setTimeout( ()=>{
    		$('.addrModal').css({
        		'width': '400px'
        	})
    	}, 500);
    	
    	$('#assetModalBg').fadeIn();
    	
    })
    
</script>

<jsp:include page="../../footer/footer.jsp" /> 