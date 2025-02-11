<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 홈</title>

<%@include file="../../header/header.jsp" %>
<script type="text/javascript">
$(document).ready(function () {
	
  
}); // end of $(document).ready(function () {} --------


</script>

<style>
#boardContainer{
display:flex;
height:100%;
}
#boardTabs{
width:250px;
height:100%;
padding-left: 40px;
border:solid 1px red;
}

#CategoryType{
padding: 10px;
}

#writePostBtn{
	width: 200px;
	height: 46px;
}

#boardGroup{
	border-bottom:solid 1px gray;
	padding: 40px 0;
}

#addBoard{
	font-size:10pt;
	border: 0;
  	background-color: transparent;
}
</style>
</head>
<body>




	<div id="boardContainer"> <!-- 게시판 전체 블럭  -->
		<div id="boardTabs"> <!-- 사이드탭 -->
		<div id="CategoryType">게시판</div>
			<button type="button" id="writePostBtn">글쓰기</button>
			
<%-- 		<c:forEach var="test" items="${requestScope.testList}"> --%>
				<div id="boardGroup">
					:: 추가된 게시판이 들어올 곳 ::
				</div>
<%-- 		</c:forEach> --%>
	
			<form name="addBoardFrm"> <%-- 로그인 된 사용자의 정보를 담아서 전송할 폼태그 --%>
				<a href="<%=ctxPath%>/board/addBoardView" id="addBoard">게시판 생성하기+</a>
			</form>
		</div>
		
<%-- 		<c:forEach var="test" items="${requestScope.testList}"> --%>		
		<div class="boardPost">
		<hr>
			작성된 게시글의 정보가 들어올 예정
		<hr>
		</div>
<%-- 		</c:forEach> --%>		
	</div>
</body>
</html>
