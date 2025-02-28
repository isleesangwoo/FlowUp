<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>


<jsp:include page="document_main.jsp" />

	<div>
		<h1>${document.documentType}</h1>
		
		<table>
			<tbody>
				<tr>
					<td>기안자</td>
					<td></td>
				</tr>
				<tr>
					<td>기안부서</td>
					<td></td>
				</tr>
				<tr>
					<td>기안일</td>
					<td></td>
				</tr>
				<tr>
					<td>문서번호</td>
					<td></td>
				</tr>
			</tbody>
		</table>
	</div>

</div>
<jsp:include page="../../footer/footer.jsp" /> 