<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    


<%@include file="../../header/header.jsp" %>
<%@include file="./boardLeftBar.jsp" %>
 
<%-- 각자 페이지에 해당되는 css 연결 --%>
<link href="<%=ctxPath%>/css/board/board_main.css" rel="stylesheet"> 

<script>
	var ctxPath = "<%= request.getContextPath() %>";
</script>
<%-- 각자 페이지에 해당되는 js 연결 --%>
<script src="<%=ctxPath%>/js/board/board.js"></script>

	<%-- 이곳에 각 해당되는 뷰 페이지를 작성해주세요 --%>
	

    <!-- 오른쪽 바 -->
    <div id="right_bar">
        <div id="right_title_box">
            <span id="right_title">게시판 홈</span>

            <!-- 오른쪽 바 메뉴버튼들입니다! -->
            <div id="right_menu_container">
                <span>
                    <a href="#">
                        <span>전체 게시판</span>
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
        
        <%-- 이곳에 각 해당되는 뷰 페이지를 작성 시작 --%>
		<div id="postContainer"> <!-- 게시글 보여주는 요소 전체 박스-->
			<div style="width:80%; border: solid 1px orange;">
			
				<c:forEach var="post" items="${postAllList}">
					<div class="onePostElmt">
						<div style="display: flex; justify-content: space-between;">
							<div class="article_wrap">
								<span class="postBoard">${post.boardvo.boardName}</span> <!-- 게시판 이름은... 조인해야긋네.. -->
								<span class="postSubject">${post.subject}</span><span class="postCommentCount">[댓개수] ${post.commentCount}</span>
								<span class="postContent">${post.content}</span>
							</div>
							<div>
								<div class="postLikeBtn"><i class="fa-regular fa-heart"></i></div>
								<div class="likeCount">10</div> <!-- 좋아요도 조인해야긋네..~ -->
							</div>
						</div>
						
						<span id="profileImg">프사</span><!-- 프사도 조인해야긋네~.. -->
						<span id="postCreateBy">${post.name}</span>
						<span id="postCreateAt">${post.regDate}</span>
					</div>
				</c:forEach>
				<%-- === #103. 페이지바 보여주기 === --%>
    <div align="center" style="border: solid 0px gray; width: 80%; margin: 30px auto;">
    	${requestScope.pageBar}
    </div>
			</div>
			
			<%-- 게시판 별 게시글 조회 --%>
			<div id="postOfBoardGroup">
			<p id="postOfBoardGroup_name">전사게시판</p>
			<ul>
                <li>
                	<div>
		                <div id="postOfBoardGroup_post">
		                <div>2025년 하반기 야유회</div><div>06-24</div>
		                </div>
	                </div>
                </li> 
            </ul>
			</div>
		
		</div>
		<%-- 이곳에 각 해당되는 뷰 페이지를 작성 끝 --%>
        
    </div>
    <!-- 오른쪽 바 -->
    
	
	
	
<jsp:include page="../../footer/footer.jsp" /> 
