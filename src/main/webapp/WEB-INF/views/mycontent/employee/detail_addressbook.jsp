<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String ctxPath = request.getContextPath();
   //     /flowUp
%> 
<link href="<%=ctxPath%>/css/employeeCss/addressbookDetail.css" rel="stylesheet"> 
<%-- 주소록 윈도우 팝업창에 띄워줄 내용 --%>

<script type="text/javascript">
	$(document).ready(function(){
		
		$.ajax({
			
		});//end of $.ajax({});
		
	});// end of $(document).ready(function(){});--------------
</script>

<div class="container">
	<input type="hidden" name="fk_employeeno" value="${sessionScope.loginuser}"/>
	<form name="address_update_frm">
		<ul class="addressInfoUl">
			<li class="addressLi">
				<span class="addressSpanTitle">이름</span>
				<input class="addressInputcontent"/>
			</li>
		</ul>
	</form>
	
</div>