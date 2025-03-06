<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();
%>

<jsp:include page="../../header/header.jsp" />
 
<%-- 각자 페이지에 해당되는 css 연결 --%>
<link href="<%=ctxPath%>/css/document/document_main.css" rel="stylesheet">
<link href="<%=ctxPath%>/css/document/document.css" rel="stylesheet">

<%-- 각자 페이지에 해당되는 js 연결 --%>
<script src="<%=ctxPath%>/js/document/document.js"></script>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		// 결제 예정 문서와 결제 대기 문서의 갯수 가져오기
		$.ajax({
			url:"<%= ctxPath%>/document/getDocCount",
			dataType:"json",
			success:function(json){
				if(json.todoCount != 0) {
					$("span#todoCount").text(json.todoCount);
				}
				if(json.upcomingCount != 0) {
					$("span#upcomingCount").text(json.upcomingCount);
				}
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of $.ajax({})----------------
		
		
	}); // end of $(document).ready(function()})---------------------------
	
</script>

	<%-- 이곳에 각 해당되는 뷰 페이지를 작성해주세요 --%>
	<!-- 전자결재작성 폼 -->
    <div id="modal" class="modal_bg">
    </div>
    <div class="modal_container">

		<div class="mail_menu_container">
			<ul>
				<li><a href="<%= ctxPath%>/document/annual">휴가신청</a></li>
				<li><a href="#">업무기안</a></li>
				<li><a href="#">지출품의</a></li>
				<li><a href="#">연장근무신청</a></li>
			</ul>
		</div>
        <!-- 여기에 메일작성 폼을 만들어주세요!! -->
        <!-- 여기에 메일작성 폼을 만들어주세요!! -->
        <!-- 여기에 메일작성 폼을 만들어주세요!! -->

    </div>
    <!-- 전자결재작성 폼 -->

	
	<!-- 왼쪽 사이드바 -->
    <div id="left_bar">

        <!-- === 새 결재 작성 버튼 === -->
        <button id="goMail">
            <i class="fa-solid fa-plus"></i>
            <span>새 결재</span>
        </button>
        <!-- === 새 결재 작성 버튼 === -->

        <div class="mail_menu_container">
            <ul>
                <li>
                    <a href="<%= ctxPath%>/document/todoList">결재 대기 문서</a>
                    <span id="todoCount" class="doc_cnt"></span> <!-- 콤마처리 해주세요 -->
                </li>
                <li>
                	<a href="<%= ctxPath%>/document/upcomingList">결재 예정 문서</a>
                	<span id="upcomingCount" class="doc_cnt"></span>
                </li>
                <li><a href="<%= ctxPath%>/document/myDocumentList">기안 문서함</a></li>
                <li><a href="<%= ctxPath%>/document/tempList">임시 저장함</a></li>
                <li><a href="<%= ctxPath%>/document/approvedList">결재 문서함</a></li>
                <li><a href="<%= ctxPath%>/document/deptDocumentList">부서문서함</a></li>
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
                                <li>5</li>
                                <li>10</li>
                                <li>20</li>
                            </ul>
                        </span>
                    </span>
                </span>
            </div>
            <!-- 오른쪽 바 메뉴버튼들입니다! -->
        </div>
        
    
    <!-- 오른쪽 바 -->
	<%-- 이곳에 각 해당되는 뷰 페이지를 작성해주세요 --%>