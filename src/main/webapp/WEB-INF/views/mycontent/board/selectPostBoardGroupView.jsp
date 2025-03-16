<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../header/header.jsp" %>
<%@include file="./boardLeftBar.jsp" %>
<link href="<%=ctxPath%>/css/board/selectPostBoardGroupView.css" rel="stylesheet"> 
<script>
	var ctxPath = "<%= request.getContextPath() %>";
	const goBackURL = "<%= request.getAttribute("goBackURL") %>";
</script>
<%-- 각자 페이지에 해당되는 js 연결 --%>
<script src="<%=ctxPath%>/js/board/selectPostBoardGroupView.js"></script>    
<!-- 오른쪽 바 -->
    <div id="right_bar">
        <div id="right_title_box">
            <span id="right_title">${boardInfoMap.boardName} </span><span id="totalCount">글 [${totalCount}]</span>

            <!-- 오른쪽 바 메뉴버튼들입니다! -->
            <div id="boardInfoElmt">
            	<div><span>운영자 : </span><span>${boardInfoMap.createdBy}</span></div>
            	<div><span>${boardInfoMap.boardDesc}</span></div>
            </div>
            <div id="right_menu_container">
				<button class="writePostBtn writePostBtn_small btnDefaultDesignNone"><i class="fa-solid fa-pencil"></i> 글쓰기</button>
                <span id="reBtn_box">
                    <span>
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
		<div id="postContainer"> <!-- 게시글 보여주는 요소 전체 박스-->
			<table>
	            <tr>
	                <td>번호</td>
	                <td>제목</td>
	                <td>작성자</td>
	                <td>작성일</td>
	                <td>조회</td>
	                <td>좋아요</td>
	            </tr>
	            
		            	<tr class="onePostElmt">
				         	
			            </tr>
		            
	    	</table>
		</div>
		
		<c:if test="${groupPostMapList[0] == null}"> <%-- 게시글이 없다면 --%>
		    <div style="text-align: center; margin: 150px 0;">
			  	  <p>작성된 글이 없습니다.</p>
			  	  <p>새로운 정보, 기분 좋은 소식을 동료들과 공유하세요.</p>
			  	  <button type="button"  class="writePostBtn ifNoPostWritePostBtn">글쓰기</button>
		    </div>
	    </c:if>
	    
		<c:if test="${groupPostMapList[0] != null}"> <%-- 게시글이 있다면 페이지바 보여주기 --%>
		    <div id="paginationContainer" align="center" style="border: solid 0px gray; width: 80%; margin: 30px auto;">
		    </div>
	    </c:if>
    </div>
    <!-- 오른쪽 바 -->

<!-- onClick="goView" 로 클릭된 함수에 폼을 같이 넘겨주기위함. 함수에서 폼의 input에 값을 넣어줌.-->   	
<form name="goViewFrm">
   <input type="hidden" name="postNo" />
   <input type="hidden" name="goBackURL" />
   <input type="hidden" name="checkAll_or_boardGroup" />
   <input type="hidden" name="fk_boardNo" value='${boardNo}' /> <!-- 이전/다음 글 할 때 전체 게시판은 조건이 필요없지만 게시판 별 게시글의 이전/다음글은 boardNo가 필요함 -->
</form>
	
	
	
	<div style="display: none;">
		<%--<c:forEach var="postList" items="${groupPostMapList}">
		<br>
		게시판 이름 : ${postList.boardvo.boardName}<br>
		게시판 운영자 : ${postList.boardvo.createdBy}<br>
		게시글번호 : ${postList.postNo}<br>
		게시판번호 : ${postList.fk_boardNo}<br>
		작성자 사번 : ${postList.fk_employeeNo}<br>
		작성자 명 : ${postList.name}<br>
		글제목 : ${postList.subject}<br>
		글내용 : ${postList.content}<br>
		조회수 : ${postList.readCount}<br>
		작성 날짜 : ${postList.regDate}<br>
		댓글 개수 : ${postList.commentCount}<br>
		댓글 허용 여부 : ${postList.allowComments}<br>
		공지사항 여부 : ${postList.isNotice}<br>
		공지사항 종료일 : ${postList.noticeEndDate}<br>
		</c:forEach> --%>
    </div>
<jsp:include page="../../footer/footer.jsp" />     