<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.net.InetAddress" %>

<%
   String ctxPath = request.getContextPath();
%>      

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<%
    // === (#웹채팅관련2) === 
    // === 서버 IP 주소 알아오기(사용중인 IP주소가 유동IP 이라면 IP주소를 알아와야 한다.) === 
    InetAddress inet = InetAddress.getLocalHost();
	String serverIP = inet.getHostAddress();
     
//	System.out.println("serverIP : " + serverIP);
 // serverIP : 192.168.0.204

 // String serverIP = "192.168.0.204";
  //String serverIP = "15.164.234.113"; 
    // 자신의 EC2 퍼블릭 IPv4 주소임. // 아마존(AWS)에 배포를 하기 위한 것임. 
    // 만약에 사용중인 IP주소가 고정IP 이라면 IP주소를 직접입력해주면 된다. 
 
    // === 서버 포트번호 알아오기 === //
    int portnumber = request.getServerPort();
//	System.out.println("portnumber : " + portnumber);
 // portnumber : 9090
 
    String serverName = "http://"+serverIP+":"+portnumber;
//	System.out.println("serverName : " + serverName);
 // serverName : http://192.168.0.204:9090

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FlowUp</title>
  <!-- Required meta tags -->
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  
  <%-- Bootstrap CSS --%>
  <link rel="stylesheet" type="text/css" href="<%=ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" >
 
  <%-- Font Awesome 6 Icons --%>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

  <%-- Optional JavaScript --%>
  <script type="text/javascript" src="<%=ctxPath%>/js/jquery-3.7.1.min.js"></script>
  <script type="text/javascript" src="<%=ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script>

  <script type="text/javascript" src="<%=ctxPath%>/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script> 

  
  <%-- 스피너 및 datepicker 를 사용하기 위해 jQueryUI CSS 및 JS --%>
  <link rel="stylesheet" type="text/css" href="<%=ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
  <script type="text/javascript" src="<%=ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>

  <%-- === jQuery 에서 ajax로 파일을 업로드 할때 가장 널리 사용하는 방법 : ajaxForm === --%> 
  <script type="text/javascript" src="<%=ctxPath%>/js/jquery.form.min.js"></script> 

   <!-- css -->
   <link href="<%=ctxPath%>/css/header.css" rel="stylesheet">
   <link href="<%=ctxPath%>/css/main-section.css" rel="stylesheet">

   <!-- js -->
   <!--<script src="<%=ctxPath%>/js/util.js"></script>-->
   <script>
		var ctxPath = "<%= request.getContextPath() %>";
	</script>
   <script src="<%=ctxPath%>/js/header.js"></script>
   <script src="<%=ctxPath%>/js/dark_mode/dark.js"></script>

   <!-- font -->
   <link rel="preconnect" href="https://fonts.googleapis.com">
   <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
   <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
</head>
<body>
    <div id="container">
        <div id="header_container">
            <header>
                <div class="side_btn">
					<i class="fa-solid fa-angle-right"></i>
				</div>
                <div id="logo_box">
                    <span>
                        <img id="logo_img" src="<%=ctxPath%>/images/logo/logo1.png" /> 
                    </span>
                </div>

                <div id="header_ikon_container">
                    <ul id="header_ikon_box">
                          <li>
                              <a href="<%= ctxPath%>/index"><i class="fa-solid fa-house"></i><span>홈</span></a>
                          </li>
                          <li>
                              <a href="<%= ctxPath%>/mail"><i class="fa-regular fa-envelope"></i><span>메일</span></a>
                          </li>
                          <li>
                              <a href="<%= ctxPath%>/reservation/"><i class="fa-solid fa-file-contract"></i><span>예약</span></a>
                          </li>
                          <li>
                              <a href="<%= ctxPath%>/document/"><i class="fa-solid fa-file-invoice-dollar"></i><span>전자결제</span></a>
                          </li>
                          <li>
                              <a href="<%= ctxPath%>/commute/"><i class="fa-regular fa-credit-card"></i><span>근태관리</span></a>
                          </li>
                          <li>
                              <a href="<%= ctxPath%>/board/"><i class="fa-regular fa-comments"></i><span>게시판</span></a>
                          </li>
                          <li>
                              <a href="<%= ctxPath%>/calendar/"><i class="fa-regular fa-calendar-days"></i><span>캘린더</span></a>
                          </li>
                          <li>
                              <a href="<%= ctxPath%>/commute/organization"><i class="fa-regular fa-folder"></i><span>조직도</span></a>
                          </li>
                          <li>
                              <a href="<%= ctxPath%>/employee/addressBook"><i class="fas fa-address-book"></i><span>주소록</span></a>
                          </li>
                          
                      </ul>
                </div>

            </header>
        </div>

        <div id="section_Container">
            <!-- top header -->
            <div id="top_header_container">
                <div class="top_header_l top_header">
                    <div class="top_ikon">
	                    <span class="bell">
	                        <i class="fa-solid fa-bell" style="color: black;"></i>
	                        <div class="alarm-cnt"></div> <!-- js를 통해 자동적으로 개수가 카운트 됩니다. -->
	                        <div class="alarm">
	                        	<div class="alarmInfo">
	                            	<div class="alarm-title">최근 알림</div>
	                            	<div class="alarm-allRead" onclick="goNotificationReadAll()">전체읽기</div>
	                            </div>
	                            <ul>
	                               <%-- 알림 List가 ajax를 통해 추가됨 --%>
	                            </ul>
	                        </div>
	                    </span>
                    </div>
                </div>
                <div class="top_header_c top_header">
                    <div class="dark_btn">
                        <div class="dark_circle"></div>
                    </div>
                </div>
                <div class="top_header_r top_header">
                    <div class="top_ikon">
                       <a class="dropdown-item" href="<%=serverName%><%=ctxPath%>/chatting/multichat"><i class="fa-solid fa-comment-dots"></i></a>
                    </div>
                    <div class="top_ikon">
                        
                    </div>
                    <div class="top_ikon">
	                     <c:if test="${empty sessionScope.loginuser.fileName}">
	                        <a class="right-ikon" href="<%= ctxPath%>/employee/mypage"><i class="fa-solid fa-user"></i></a>
	                      </c:if>
	                      <c:if test="${not empty sessionScope.loginuser.fileName}">
	                      <a class="right-ikon" href="<%= ctxPath%>/employee/mypage">
							<img class="ikon-img" src="<%= ctxPath%>/resources/files/${sessionScope.loginuser.fileName}" />
						   </a>
	                      </c:if>
                    </div>
                </div>
            </div>
            <!-- top header -->

            <section id="main_section">