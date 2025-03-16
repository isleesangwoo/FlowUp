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
    <div id="doc_menu_container" class="box_modal_container">

		<div class="doc_menu_container m-5">
			<ul class="list-group">
				<li class="list-group-item" onclick="location.href='<%= ctxPath%>/document/annual'"><a>휴가신청서</a></li>
				<li class="list-group-item" onclick="location.href='<%= ctxPath%>/document/overtime'"><a>연장근무신청서</a></li>
				<li class="list-group-item" onclick="location.href='<%= ctxPath%>/document/expense'"><a>지출품의서</a></li>
				<li class="list-group-item" onclick="location.href='<%= ctxPath%>/document/business'"><a>업무기안</a></li>
			</ul>
		</div>
    </div>
    <!-- 전자결재작성 폼 -->

	
	<!-- 왼쪽 사이드바 -->
    <div id="left_bar">

        <!-- === 새 결재 작성 버튼 === -->
        <button id="goDoc">
            <i class="fa-solid fa-plus"></i>
            <span>새 결재</span>
        </button>
        <!-- === 새 결재 작성 버튼 === -->

        <div class="doc_menu_container">
            <ul>
            	<li onclick="location.href='<%= ctxPath%>/document/'"><a>전자결재 홈</a></li>
                <li onclick="location.href='<%= ctxPath%>/document/todoList'">
                    <a>결재 대기 문서</a>
                    <span id="todoCount" class="doc_cnt"></span> <!-- 콤마처리 해주세요 -->
                </li>
                <li onclick="location.href='<%= ctxPath%>/document/upcomingList'">
                	<a>결재 예정 문서</a>
                	<span id="upcomingCount" class="doc_cnt"></span>
                </li>
                <li onclick="location.href='<%= ctxPath%>/document/myDocumentList'"><a>기안 문서함</a></li>
                <li onclick="location.href='<%= ctxPath%>/document/tempList'"><a>임시 저장함</a></li>
                <li onclick="location.href='<%= ctxPath%>/document/approvedList'"><a>결재 문서함</a></li>
                <li onclick="location.href='<%= ctxPath%>/document/deptDocumentList'"><a>부서 문서함</a></li>
            </ul>
        </div>
    </div>
    <!-- 왼쪽 사이드바 -->

    <!-- 오른쪽 바 -->
    <div id="right_bar">
        
    
    <!-- 오른쪽 바 -->
	<%-- 이곳에 각 해당되는 뷰 페이지를 작성해주세요 --%>