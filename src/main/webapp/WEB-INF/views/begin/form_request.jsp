<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
    //    /begin 
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>form 연습</title>

<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		$("form[name='testFrm']").submit(function(){
			
			const no_val = $("input:text[name='no']").val();
			const name_val = $("input:text[name='name']").val();
			
			const reg_exp = /^[0-9]+$/;
			if( !reg_exp.test(no_val) ) {
				alert("숫자로만 입력하세요");
				return false; // submit(전송)을 하지말라는 뜻이다.
			}
			
			if(name_val.trim().length == 0) {
				alert("성명을 입력하세요");
				return false; // submit(전송)을 하지말라는 뜻이다.
			}
			
		});
		
	});
</script>

</head>
<body>

    <div>/test/form_request 페이지</div>
    <br>
	<form name="testFrm" action="<%= ctxPath%>/test/form_request" method="post"> 
		번호 : <input type="text" name="no" /><br>
		성명 : <input type="text" name="name" /><br>
	    <input type="submit" value="확인" />
	    <input type="reset"  value="취소" /> 
	</form>

</body>
</html>




