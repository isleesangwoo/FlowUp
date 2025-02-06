<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>select 연습</title>

<style type="text/css">
	table, th, td {
		border: solid 1px gray;
		border-collapse: collapse;
	}
</style>

</head>
<body>

	<h3>오라클 서버에 있는 데이터 조회(BeginDateVO)</h3>
	<table>
		<tr>
			<th>번호</th>
			<th>입력번호</th>
			<th>성명</th>
			<th>작성일자</th>
		</tr>
		
		<c:forEach var="begindatevo" items="${requestScope.begindatevoList}" varStatus="status"> 
		   <tr>
		      <td>${status.count}</td>
		      <td>${begindatevo.no}</td>
		      <td>${begindatevo.name}</td>
	   <%--   <td>${begindatevo.writeday}</td>
	              Thu Jun 13 09:47:20 GMT+09:00 2024  형식으로 출력됨.
	   --%>
		      <td><fmt:formatDate value="${begindatevo.writeday}" type="date" pattern="yyyy-MM-dd HH:mm:ss" /></td> 
		      <%-- 2024-06-13 09:47:20  형식으로 출력됨 --%>
		   </tr>
		</c:forEach>

    </table>
</body>
</html>