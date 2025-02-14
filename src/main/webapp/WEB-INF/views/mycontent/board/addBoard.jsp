<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="../../header/header.jsp" %>
<%@include file="./boardLeftBar.jsp" %>

<%-- 각자 페이지에 해당되는 css 연결 --%>
<link href="<%=ctxPath%>/css/board/addBoard.css" rel="stylesheet"> 

<%-- 각자 페이지에 해당되는 js 연결 --%>
<script src="<%=ctxPath%>/js/board/addBoard.js"></script>

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