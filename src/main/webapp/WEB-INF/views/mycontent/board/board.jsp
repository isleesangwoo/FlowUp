<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    


<%@include file="../../header/header.jsp" %>
<%@include file="./boardLeftBar.jsp" %>
 
<%-- 각자 페이지에 해당되는 css 연결 --%>
<link href="<%=ctxPath%>/css/board/board_main.css" rel="stylesheet"> 

<script>
	var ctxPath = "<%= request.getContextPath() %>";
	const goBackURL = "<%= request.getAttribute("goBackURL") %>";
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
            </div>
            <!-- 오른쪽 바 메뉴버튼들입니다! -->
        </div>
        
        
        <%-- 이곳에 각 해당되는 뷰 페이지를 작성 시작 --%>
		<div id="postContainer"> <!-- 게시글 보여주는 요소 전체 박스-->
			<div style="width:80%; border: solid 1px orange;">
			 <c:if test="${postAllList[0] != null}"> <%-- 게시글이 있다면 --%>
			 	<div id="allPostElmt">
					<c:forEach var="post" items="${postAllList}">
						<div class="onePostElmt">
							<div style="display: flex; justify-content: space-between;">
								<div class="article_wrap">
									<span class="postBoard">${post.boardvo.boardName}</span>
									<span onclick="goView('${post.postNo}')">
										<span class="postSubject">${post.subject}</span><span class="postCommentCount">[댓개수] ${post.commentCount}</span>
										<span class="postContent">${post.content}</span>
									</span>
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
				</div>
				<%-- === 페이지바 보여주기 === --%>
			    <div align="center" style="border: solid 0px gray; width: 80%; margin: 30px auto;">
			    	${requestScope.pageBar}
			    </div>
			  </c:if>
			  <c:if test="${postAllList[0] == null}"> <%-- 게시글이 없다면 --%>
				  <div style="text-align: center; margin: 150px 0;">
				  	<p>작성된 글이 없습니다.</p>
				  	<p>새로운 정보, 기분 좋은 소식을 동료들과 공유하세요.</p>
				  	<button type="button" class="writePostBtn">글쓰기</button>
				  </div>
			  </c:if>
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

<!-- onClick="goView" 로 클린된 함수에 폼을 같이 넘겨주기위함. 함수에서 폼의 input에 값을 넣어줌.-->    
<form name="goViewFrm">
   <input type="hidden" name="postNo" />
   <input type="hidden" name="goBackURL" />
</form>	     
    
	
	
	
<jsp:include page="../../footer/footer.jsp" /> 
