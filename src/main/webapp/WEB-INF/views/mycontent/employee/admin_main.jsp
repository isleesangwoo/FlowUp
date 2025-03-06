<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String ctxPath = request.getContextPath();
//     /myspring 
%>  


<jsp:include page="../../header/header.jsp" /> 



<link href="<%=ctxPath%>/css/employeeCss/adminMain.css" rel="stylesheet"> 


<script type="text/javascript">


</script>


       <div class="adminHeader">
         <h3 class="adminTitle">관리자</h3>
       </div> 
       <hr>
   

    <div class="adminBody">
        <div class="amdimChart">
            통계 차트
        </div>
        <div class="amdimChart">
            통계 차트
        </div>

    </div>
    <hr>
    <div class="adminFooter">
    	<a href="<%= ctxPath%>/employee/addEmployee"id="addEmployee">사원등록</a>
    	<a href="<%= ctxPath%>/employee/updateEmployee"id="updateEmployee">사원정보수정</a>
        <!-- <button type="button" id="addEmployee" onclick=""> 사원등록 </button> --> <!-- 누르면 사원 등록 페이지가 나옴. -->
</div>
