<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
    //     /myspring
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ajax 연습</title>

<style type="text/css">
	table, th, td {
		border: solid 1px gray;
		border-collapse: collapse;
	}
</style>

<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		func_ajax_select();
		func_ajax_select_2();
		
		$("button#btnOK").click(function(){
						
			const no_val = $("input:text[name='no']").val();
			const name_val = $("input:text[name='name']").val();
			
			const reg_exp = /^[0-9]+$/;
			if( !reg_exp.test(no_val) ) {
				alert("숫자로만 입력하세요");
				return;
			}
			
			if(name_val.trim().length == 0) {
				alert("성명을 입력하세요");
				return;
			}
			
			const param = {"no" : no_val
					      ,"name" : name_val};
			
			$.ajax({
				url:"<%= ctxPath%>/test/ajax_insert_3", 
				type:"post",
				data:JSON.stringify(param), 
				// 전송하는 내용물의 타입은 json 형태를 띈 문자열임. 
			    // data 는 JSON.stringify(param)으로 했으므로 JSON 모양을 띄는 문자열(string)이다.
				
			    contentType:"application/json; charset=utf-8",  
			    /* 위에서 전송하는 내용물의 타입이 json 형태를 띈 문자열 이므로  "application/json; charset=utf-8" 을 꼭 해주어야 한다.
	               만약에 contentType 을 명기하지 않으면 "application/x-www-form-urlencoded" 이다. */
			    
				dataType:"json",
				success:function(json){
				//	console.log(JSON.stringify(json));
					// {"n":1}
					
					if(json.n == 1){
						func_ajax_select();
						func_ajax_select_2();
						
						$("input:text[name='no']").val("");
						$("input:text[name='name']").val("");
					}
					
				},
				error: function(request, status, error){
				   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
			
		});
		
	});// end of $(document).ready(function(){})---------
	
	
	function func_ajax_select(){
		
		$.ajax({
			url:"<%= ctxPath%>/test/ajax_select_3",
			type:"get",
			dataType:"json",
			success:function(json){
			//	console.log(JSON.stringify(json));
			/*    
			  [{"NO":"6004","WRITEDAY":"2025-01-17 11:35:25","NAME":"육천사"}
	 		  ,{"NO":"6003","WRITEDAY":"2025-01-17 11:32:03","NAME":"육천삼"}
	 		  ,{"NO":"6002","WRITEDAY":"2025-01-17 11:12:06","NAME":"육천이"}
	 		  ,{"NO":"6001","WRITEDAY":"2025-01-17 10:48:12","NAME":"육천일"}
	 		  ,{"NO":"5009","WRITEDAY":"2025-01-17 10:43:38","NAME":"이진호"}
	 		  ,{"NO":"5008","WRITEDAY":"2025-01-17 10:43:30","NAME":"강이훈"}
	 		  ,{"NO":"5007","WRITEDAY":"2025-01-17 09:40:12","NAME":"오천칠"}
	 		  ,{"NO":"5006","WRITEDAY":"2025-01-16 14:42:12","NAME":"오천육"}
	 		  ,{"NO":"5005","WRITEDAY":"2025-01-16 14:30:42","NAME":"오천오"}
	 		  ,{"NO":"5004","WRITEDAY":"2025-01-15 00:00:00","NAME":"오천사"}
	 		  ,{"NO":"5003","WRITEDAY":"2025-01-16 12:19:29","NAME":"오천삼"}
	 		  ,{"NO":"5002","WRITEDAY":"2025-01-16 12:09:07","NAME":"오천이"}
	 		  ,{"NO":"5001","WRITEDAY":"2025-01-16 11:46:45","NAME":"오천일"}
	 		  ,{"NO":"103","WRITEDAY":"2025-01-15 17:20:54","NAME":"변우석"}
	 		  ,{"NO":"102","WRITEDAY":"2025-01-15 17:20:54","NAME":"김태희"}
	 		  ,{"NO":"101","WRITEDAY":"2025-01-15 16:49:51","NAME":"이순신"}]
			*/ 
			   let v_html = `<table>  
			                    <tr>
			                       <th>번호</th>
			                       <th>입력번호</th>
			                       <th>성명</th>
			                       <th>작성일자</th>
			                    </tr>`;
			                    
			    $.each(json, function(index, item){
			    	v_html += `<tr>
			    	              <td>\${index+1}</td>
			    	              <td>\${item.NO}</td>
			    	              <td>\${item.NAME}</td>
			    	              <td>\${item.WRITEDAY}</td>
			    	           </tr>`;
			    });
		
		        v_html += `</table>`;
		        
		        $("div#view").html(v_html);
			},
			error: function(request, status, error){
			   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		
	}// end of function func_ajax_select(){}--------------
	
	
	function func_ajax_select_2(){
		
		$.ajax({
			url:"<%= ctxPath%>/test/ajax_select_map_one",
			type:"get",
			dataType:"json",
			success:function(json){
				console.log(JSON.stringify(json));
			/*    
			     {"NO":"6004","WRITEDAY":"2025-01-17 11:35:25","NAME":"육천사"}
			  또는 {}
			
			*/ 
			   let v_html = `<table> 
			                    <tr>
			                       <th>입력번호</th>
			                       <th>성명</th>
			                       <th>작성일자</th>
			                    </tr>`;
			                    
			   if(json.NO != undefined) {
			    	v_html += `<tr>
			    	              <td>\${json.NO}</td>
			    	              <td>\${json.NAME}</td>
			    	              <td>\${json.WRITEDAY}</td>
			    	           </tr>`;
			   }
			   else {
				    v_html += `<tr>
			    	              <td colspan='3'>데이터가 없습니다</td>
			    	           </tr>`;
			   }
			    
		       v_html += `</table>`;
		        
		       $("div#view_2").html(v_html);
			},
			error: function(request, status, error){
			   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		
	}// end of function func_ajax_select_2(){}--------------
	
</script>

</head>
<body>
    <h2>Ajax 연습</h2>
    <p>
        안녕하세요?<br>
        여기는 /test/ajax_form_3 페이지 입니다.
    </p>
	 
		번호 : <input type="text" name="no" /><br>
		성명 : <input type="text" name="name" /><br>
	    <button type="button" id="btnOK">확인</button>
	    <button type="reset" id="btnCancel">취소</button>
	    <br><br> 
	
	<div id="view"></div>
	
	<hr style="margin: 20px 0; border: solid 2px blue;">
	
	<div id="view_2"></div>

</body>
</html>