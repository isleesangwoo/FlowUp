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
   <%-- 직접 만든 css --%>
   <link href="<%=ctxPath%>/css/employeeCss/login.css" rel="stylesheet">
   <%-- Optional JavaScript --%>
   <script type="text/javascript" src="<%=ctxPath%>/js/jquery-3.7.1.min.js"></script>

   
<script type="text/javascript">


<%-- 유효성 검사 시작 --%>

    $(document).ready(function(){
    	
    	$("div.errorMsg").hide();
    	
    	$("input:text[name='id']").blur(function(e){
        	const regExp = /^[0-9]+$/;
        	const bool = regExp.test($(e.target).val());
        	
        	if(!bool){
        		$(e.target).val('');
        		$(e.target).next().show();
            }
        	
        	else{
        		$(e.target).next().hide();
        	}
        });// end of $("input:text[name='id']").blur(function(e){});----------
        
        
        $("input:password").blur(function(e){
        	 const regExp =  /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
   			 const bool = regExp.test($(e.target).val());
   			 
   			 if(!bool){
   					$(e.target).val('');
   					$(e.target).next().show();
   		     }
   			 
   			 else{
        	 	$(e.target).next().hide();
        	 }
   			 
        });// end of $("input:password").blur(function(e){})------------

       
        // 엔터키로도 로그인 처리
        $("input:password[id='pwd']").keydown(function(e){
            if(e.keyCode == 13) { // 엔터를 했을 경우
                func_Login();
            }
        });
    }); // end of $(document).ready(function(){})-------------

    const func_Login = function(){
    	
        const userid = $("input#userid").val();
        const pwd = $("input#pwd").val();
        
        if(userid.trim() == "") {
            alert("아이디를 입력하세요!!");
            $("input#userid").val("");
            $("input#userid").focus();
            return; // 종료
        }
        
        if(pwd.trim() == "") {
            alert("비밀번호를 입력하세요!!");
            $("input#pwd").val("");
            $("input#pwd").focus();
            return; // 종료
        }
        
        // 로그인 폼 제출
        const frm = document.loginFrm;
        frm.action = "<%= ctxPath%>/employee/login";
        frm.method = "post";
        frm.submit();
    };
    
</script>
   
    <title>loginpage</title>

</head>
<body>

    <div class="container">
        <!-- 로고 -->
        <div class="logo">
            <h2>  <img id="logo_img" src="<%=ctxPath%>/images/logo/logo1.png" /> </h2>
        </div>
       

        <!-- 로그인 폼 -->
        <form name="loginFrm">
         <h2 class="title">FLOW UP</h2>
            <!-- 아이디 -->
            <div class="inputDiv">
                <input type="text" class="loginId loginInput" name="id" id="userid" placeholder="사원번호">
                
                 <div class="errorMsg">
                    <span class="loginErrorId">아이디가 틀렸습니다 올바른 아이디를 입력하세요</span>
                </div> 
               
            </div>

            <!-- 비밀번호 -->
            <div class="inputDiv">
                <input type="password" class="loginPasswd loginInput" name="passwd" id="pwd" placeholder="비밀번호">
               <div class="errorMsg">
                <span class="loginErrorPwd">비밀번호가 틀렸습니다 올바른 비밀번호를 입력하세요</span>
               </div> 
               
            </div>

            <!-- 로그인 버튼 -->
            <div>
                <button type="button" class="loginBtn loginInput" id="loginBtn" onclick="func_Login()">로그인</button>
            </div>

            <!-- 아이디/비밀번호 찾기-->
            
        </form>
        <div class="findTagDiv">
            <a href="#" class="findPwd">비밀번호찾기</a>
        </div>
    </div>
    
</body>
</html>