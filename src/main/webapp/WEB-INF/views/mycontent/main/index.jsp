<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();
    //     /myspring
%>

<jsp:include page="../../header/header.jsp" /> 

	<%-- 이곳에 각 해당되는 뷰 페이지를 작성해주세요 --%>
	<%-- ex) --%>
	<div style="width: 500px; height: 500px; background-color: #252525; text-align: center; line-height: 500px; color: #fff">
		이것은 예시 html 태그입니다!
	</div>

	<%-- 이곳에 각 해당되는 뷰 페이지를 작성해주세요 --%>
	
<jsp:include page="../../footer/footer.jsp" /> 