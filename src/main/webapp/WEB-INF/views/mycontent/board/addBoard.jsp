<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="../../header/header.jsp" %>

<%-- 각자 페이지에 해당되는 css 연결 --%>
<link href="<%=ctxPath%>/css/board/addBoard.css" rel="stylesheet"> 

<%-- 각자 페이지에 해당되는 js 연결 --%>
<script src="<%=ctxPath%>/js/board/addBoard.js"></script>

<!-- 왼쪽 사이드바 -->
    <div id="left_bar">

        <!-- === 글작성 버튼 === -->
        <button id="writePostBtn">
            <i class="fa-solid fa-plus"></i>
            <span id="goWrite">글쓰기</span>
        </button>
        <!-- === 글작성 버튼 === -->

        <div class="board_menu_container">
            <ul>
                <li>
                    <a href="#">게시판 목록</a>
                </li>
                <li>
                	<a href="#">예)부서게시판</a>&nbsp&nbsp&nbsp<a href="<%=ctxPath%>/board/updateBoardView" id="upateBoard">설정*</a>
                </li>
            	<li>
            		<a href="<%=ctxPath%>/board/addBoardView" id="addBoard">게시판 생성하기+</a>
            	</li>
            </ul>
        </div>
    </div>
    <!-- 왼쪽 사이드바 -->
    
   <!-- 오른쪽 바 -->
    <div id="right_bar">
        <div id="right_title_box">
            <span id="right_title">게시판 생성</span>
		</div>
		<%-- 이곳에 각 해당되는 뷰 페이지를 작성 끝 --%>
        
        <form name="addBoardGroup">

	<table>
	<tr>
		<td>
			제목
		</td>
		<td>
			<input type="text" name="boardName"/>
		</td>
	</tr>
	
	<tr>
		<td>
			설명
		</td>
		<td>
			<input type="text" name="boardDesc"/>
		</td>
	</tr>
	
	<tr>
		<td>
			공개 범위 설정
		</td>
		<td>
			부서별 공개 <input type="radio" name="isPublic" value="0" class="isPublic" /> <!-- 부서별 -->
			전체공개 <input type="radio" name="isPublic" value="1" class="isPublic"/> <!-- 전체공개 -->
			
			<div id="selectDepartment">
				<div style="border:solid 1px red;">
					<p>공유부서 선택</p>
					<div >
					<!-- 부서들 나열 -->
					영업부서<br>
					인사부서<br>
					.<br>
					.<br>
					</div>
				</div>
			</div>
		</td>
	</tr>
	
	<tr>
		<td>
			운영자(생성자)
		</td>
		<td>
			<input type="text" name="createdBy" value=""/>
		</td>
	</tr>
	</table>
	<button type="button" id="addBoardGroup">생성</button> <button type="button">취소</button>
</form>
    </div>
    <!-- 오른쪽 바 -->





<jsp:include page="../../footer/footer.jsp" /> 