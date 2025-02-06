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
	table, th, td {
		border: solid 1px gray;
		border-collapse: collapse;
	}
</style>

</head>
<body>

	<h3>오라클 서버에 있는 데이터 조회(/myspring/test/select_all_2 페이지)</h3>
	<table>
		<tr>
			<th>번호</th>
			<th>입력번호</th>
			<th>성명</th>
			<th>작성일자</th>
		</tr>
		
		<c:forEach var="beginvo" items="${requestScope.beginvoList}" varStatus="status"> 
		   <tr>
		      <td>${status.count}</td>
		      <td><a href="<%= ctxPath%>/test/select_one/${beginvo.no}">${beginvo.no}</a></td>
		      <td>${beginvo.name}</td>
		      <td>${beginvo.writeday}</td>
		   </tr>
		</c:forEach>

    </table>
</body>
</html>