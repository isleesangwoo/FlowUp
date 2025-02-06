<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<%
    String ctxPath = request.getContextPath();
    //     /myspring
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>select 연습</title>

<style type="text/css">
	span {
		display: inline-block;
		width: 100px;
	}
</style>

</head>
<body>

	<h3>오라클 서버에 있는 데이터 조회(/myspring/test/select_one 페이지)</h3>
	
	<div>
	   <ul>
	   	  <li><span>입력번호 : </span>${requestScope.bvo.no}</li>
	   	  <li><span>성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명 : </span>${requestScope.bvo.name}</li>
	   	  <li><span>작성일자 : </span>${requestScope.bvo.writeday}</li>
	   </ul>
	     
	   <button onclick="location.href='<%= ctxPath%>/test/select_all_1'">전체보기</button>
	</div>
	
</body>
</html>