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
	<h1>메일(이동훈)</h1>
	<c:if test="${not empty requestScope.testList}">
		<c:forEach var="test" items="${requestScope.testList}">
		<table>
		<tr>
			<td>${test.no}</td>
			<td>${test.name}</td>
			<td>${test.writeday}</td>
			<td>안농하세오 메일입니다.</td>
		</tr>
		</table>
		</c:forEach>
	</c:if>
	<c:if test="${empty requestScope.testList}">
       <h1>데이터가 없습니다.</h1>
    </c:if>
</body>
</html>