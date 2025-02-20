<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../header/header.jsp" %>
<%@include file="./boardLeftBar.jsp" %>

<%-- 각자 페이지에 해당되는 css 연결 --%>
<link href="<%=ctxPath%>/css/board/onePostView.css" rel="stylesheet"> 

<script>
	var ctxPath = "<%= request.getContextPath() %>";
	const goBackURL = "<%= request.getAttribute("goBackURL") %>";
</script>
<%-- 각자 페이지에 해당되는 js 연결 --%>
<script src="<%=ctxPath%>/js/board/onePostView.js"></script>

<!-- 오른쪽 바 -->
    <div id="right_bar">
        <div id="right_title_box">
            <span id="right_title">${postvo.boardvo.boardName} </span>
			<span id="boardMaster">운영 : ${postvo.boardvo.createdBy}</span>
            <!-- 오른쪽 바 메뉴버튼들입니다! -->
            
            <div id="right_menu_container">
            
            	<span id="tool_box_left">
                    <span>
                        <span id="re_btn">
                            <a href="#"><i class="fa-regular fa-pen-to-square"></i> 수정</a>
                        </span>
                        <span>
                            <a href="#"><i class="fa-regular fa-trash-can"></i>삭제</a>
                        </span>
                    </span>
                </span>
	                

                <span id="tool_box_right">
                    <span>
                        <span id="re_btn" title="새로고침">
                            <a href="#"><i class="fa-solid fa-arrow-left"></i>이전</a>
                        </span>
                        <span id="sortCnt_btn">
                            <a href="#">다음<i class="fa-solid fa-arrow-right"></i></a>
                        </span>
                        <span>
                            <button type="button" onclick="javascript:location.href='<%= ctxPath%>${requestScope.goBackURL}'" id="goBackUrlBtn">
                            	<i class="fa-solid fa-list"></i> 목록
                            </button>
                        </span>
                    </span>
                </span>
            </div>
            <!-- 오른쪽 바 메뉴버튼들입니다! -->
        </div>
        
        <!-- 게시글 하나 내용보여주기 시작  -->
        	<div id="onePostHeader" class="padding">
        		<span id="postSubject">제목 : ${postvo.subject}</span>
        		<span id="postCommentCount">[${postvo.commentCount}]</span>
        		<div>
        			<span id="postCreatBy">${postvo.name}</span>
        			<span id="postRegDate">${postvo.regDate}</span>
        		</div>
        	</div>
	        <div id="onePostContent" class="padding">
	        	${postvo.content}
	        </div>
	        <div id="ViewOption" class="padding">
	        	<span class="tranBlock">댓글 ${postvo.commentCount}개</span>
	        	<span class="tranBlock">조회 ${postvo.readCount}</span>
	        	<span class="tranBlock">좋아요 누른 사람 0명</span>
	        </div>
	        <div id="commentCreate" class="padding">
	        	<div>프로필</div>
	        	<div id="commentContent">
	        		<input type="text" name="content" placeholder="댓글을 남겨보세요">
	        	</div>
	        </div>
	        
	        
        
        <div>
	        게시글 번호 : ${postvo.postNo} <br>
			게시판 번호 : ${postvo.fk_boardNo}<br>
			작성자 번호 : ${postvo.fk_employeeNo}<br>
		</div>
		
		
   </div>




<jsp:include page="../../footer/footer.jsp" /> 