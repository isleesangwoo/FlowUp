<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>캘린더(강이훈)</h1>
	<c:if test="${not empty requestScope.testList}">
		<c:forEach var="test" items="${requestScope.testList}">
		<table>
		<tr>
			<td>${test.no}</td>
			<td>${test.name}</td>
			<td>${test.writeday}</td>
		</tr>
		</table>
		</c:forEach>
	</c:if>
	<c:if test="${empty requestScope.testList}">
       <h1>데이터가 없습니다.</h1>
    </c:if>
    <hr>
    파이팅 해보자구~~~~ 2훈
</body>
</html>