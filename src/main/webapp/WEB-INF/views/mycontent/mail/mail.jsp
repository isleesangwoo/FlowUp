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

	<%-- 이곳에 각 해당되는 뷰 페이지를 작성해주세요 --%>
	<!-- 메일작성 폼 -->
    <div id="modal" class="modal_bg">
    </div>
    <div class="modal_container">

        메일 작성 하는 곳
        <!-- 여기에 메일작성 폼을 만들어주세요!! -->

    </div>
    <!-- 메일작성 폼 -->

	
	<!-- 왼쪽 사이드바 -->
    <div id="left_bar">

        <!-- === 메일 작성 버튼 === -->
        <button id="goMail">
            <i class="fa-solid fa-plus"></i>
            <span>메일쓰기</span>
        </button>
        <!-- === 메일 작성 버튼 === -->

        <div class="mail_menu_container">
            <ul>
                <li>
                    <a href="#">받은메일함</a>
                    <span class="mail_cnt">135</span> <!-- 콤마처리 해주세요 -->
                </li>
                <li><a href="#">보낸메일함</a></li>
                <li><a href="#">임시보관함</a></li>
                <li><a href="#">태그메일함</a></li>
                <li><a href="#">중요메일함</a></li>
                <li><a href="#">휴지통</a></li>
            </ul>
        </div>
    </div>
    <!-- 왼쪽 사이드바 -->

    <!-- 오른쪽 바 -->
    <div id="right_bar">
        <div id="right_title_box">
            <span id="right_title">Inbox</span>
            <span id="right_info">
                <span>
                    All
                    <span class="right_info_cnt">66</span> <!-- 전체 메일의 개수를 띄워주세요! -->
                </span>
                <span>/</span>
                <span>
                    Unread
                    <span class="right_info_cnt">10</span> <!-- 읽은 메일의 개수를 띄워주세요! -->
                </span>
            </span>

            <!-- 오른쪽 바 메뉴버튼들입니다! -->
            <div id="right_menu_container">
                <input id="mailListAllCheck" type="checkbox" />
                <span>
                    <a href="#">
                        <span>답장</span>
                        <i class="fa-solid fa-share"></i>
                    </a>
                </span>
                
                <span>
                    <a href="#">
                        <span>삭제</span>
                        <i class="fa-regular fa-trash-can"></i>
                    </a>
                </span>
                <span>
                    <a href="#">
                        <span>태그</span>
                        <i class="fa-solid fa-tags"></i>
                    </a>
                </span>
                <span>
                    <a href="#">
                        <span>읽음</span>
                        <i class="fa-regular fa-envelope-open"></i>
                    </a>
                </span>
                <span>
                    <a href="#">
                        <span>메일이동</span>
                        <i class="fa-solid fa-arrow-up-right-from-square"></i>
                    </a>
                </span>

                <span id="reBtn_box">
                    <span>
                        <span id="sort_btn" title="정렬"> <!-- 정렬 버튼입니다! -->
                            <i class="fa-solid fa-arrow-down-short-wide"></i>
                            <ul>
                                <li class="list_title">정렬순서</li>
                                <!-- 각 li 태그 마다 ajax 보내주세요 -->
                                <li>제목</li> 
                                <li>받은날짜</li>
                                <li>크기</li>

                                <li class="list_title">빠른검색</li>
                                <li>중요메일</li>
                                <li>안읽은 메일</li>
                                <li>읽은 메일</li>
                                <li>오늘온 메일</li>
                                <li>어제온 메일</li>
                                <!-- 각 li 태그 마다 ajax 보내주세요 -->
                            </ul>
                        </span>
                        <span id="re_btn" title="새로고침">
                            <i class="fa-solid fa-rotate-right"></i>
                        </span>
                        <span id="sortCnt_btn">
                            <span>20</span>
                            <i class="fa-solid fa-angle-right"></i>
                            <ul>
                                <li>10</li>
                                <li>20</li>
                                <li>40</li>
                            </ul>
                        </span>
                    </span>
                </span>
            </div>
            <!-- 오른쪽 바 메뉴버튼들입니다! -->
        </div>
        
        <div id="right_content_box">
        	
        		<input id="mailOneCheck" type="checkbox" />
        	
        	<span id="action">
        		<i class="fa-regular fa-star"></i>
        		<i class="fa-regular fa-envelope"></i>
        		<i class="fa-solid fa-paperclip"></i>
        		<span id="mailName">이름</span>
        		<span id="mailTitle">메일 있는 곳</span>
        		
        	</span>
        </div>
        
        
    </div>
    <!-- 오른쪽 바 -->
	<%-- 이곳에 각 해당되는 뷰 페이지를 작성해주세요 --%>
	
<jsp:include page="../../footer/footer.jsp" /> 