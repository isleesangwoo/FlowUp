<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/myspring/test/select_all_crud</title>

<style type="text/css">
	
	table {
	    width: 50%;
	}
	
	table, th, td {
		border: solid 1px gray;
		border-collapse: collapse;
	}
	
	th, td {
		height: 30px;
		text-align: center;
	}
	
	a { text-decoration: none;
	    color: blue;
	}
	
	a:hover{ color: red;}
</style>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
  $(document).ready(function(){
	
	const func_all_view = function(){
		
		$.ajax({ 
			url:`${pageContext.request.contextPath}/test/select_all_view`,
			type:"get",
			dataType:"json",
			success:function(json){
			   // console.log(JSON.stringify(json));
				/*
				  [{"NO":"5004","WRITEDAY":"2025-01-03 00:05:18","NAME":"오천사"},{"NO":"5003","WRITEDAY":"2025-01-03 00:04:32","NAME":"오천삼"},{"NO":"5002","WRITEDAY":"2025-01-02 23:22:12","NAME":"오천이"},{"NO":"5001","WRITEDAY":"2025-01-02 21:35:55","NAME":"오천일"},{"NO":"102","WRITEDAY":"2025-01-02 20:41:25","NAME":"김태희"},{"NO":"103","WRITEDAY":"2025-01-02 20:41:25","NAME":"변우석"},{"NO":"101","WRITEDAY":"2025-01-02 20:34:49","NAME":"이순신"}] 
				*/
				
				 let v_html = `<table>
									<tr>
										<th>번호</th>
										<th>입력번호</th>
										<th>성명</th>
										<th>작성일자</th>
										<th>조회</th>
										<th>수정</th>
										<th>삭제</th>
									</tr>`;
									
				$.each(json, function(index, item){
					 v_html += `<tr>
							       <td>\${index+1}</td>
							       <td>\${item.NO}</td>
							       <td>\${item.NAME}</td>
							       <td>\${item.WRITEDAY}</td>
							       <td><button type="button" class="read" value="\${item.NO}">조회</button></td>
							       <td><button type="button" class="update" value="\${item.NO}">수정</button></td>
							       <td><button type="button" class="delete" value="\${item.NO}">삭제</button></td>
							   </tr>`;
				 });					
				
				 v_html += `</table>`;
				             
				 $("div#all_view").html(v_html);              
			},
			error: function(request, status, error){
			   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		
	}; // end of const func_all_view = function(){}----------------
	
	
	func_all_view();
	
	
	// create 폼
	$(document).on("click", "button#btn_create", function(e){
		
		const div_elmt = $(e.target).parent();
		
		div_elmt.html(`<form>
						  번호 : <input type="text" name="no" /><br>
					 	  성명 : <input type="text" name="name" /><br>
			    		 <input type="button" id="btn_create_ok" value="생성완료" />
			    		 <input type="reset"  value="취소" />                   
		               </form>`);
	});
	
	
	// create
	$(document).on("click", "input#btn_create_ok", function(e){
		
		const no = $("input:text[name='no']").val();
		const name = $("input:text[name='name']").val();
		
		const reg_exp = /^[0-9]+$/;
		if( !reg_exp.test(no) ) {
			alert("숫자로만 입력하세요");
			return;
		}
		
		if(name.trim().length == 0) {
			alert("성명을 입력하세요");
			return;
		}
		
		const param = {"no":no, "name":name};
		
		$.ajax({
			url:`${pageContext.request.contextPath}/test/crud/create_update`,
			type:"post",
			contentType:"application/json; charset=utf-8",  
			// 전송하는 내용물의 타입은 json 형태를 띈 문자열임.
			// contentType 을 명시하지 않으면 기본은 "application/x-www-form-urlencoded" 이다.
			
			data:JSON.stringify(param), 
			// 위에서 전송하는 내용물의 타입이 json 형태를 띈 문자열로 했기에 JSON.stringify() 를 사용해야 함 
			
			dataType:"json",
			success:function(json){
				// console.log(JSON.stringify(json));
				// {"n":1}
				
				   if(json.n == 1) {
					   alert(`회원생성이 성공했습니다.`);
					   func_all_view();
					   $("div#div_create").html(`<button type="button" id="btn_create" style="width: 4%; height: 30px;">생성</button>`);
				   }
			},
			error: function(request, status, error){
			   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});
	});
	
	
	// read
	$(document).on("click", "button.read", function(e){
		const no = $(e.target).val();
	 // alert(`${pageContext.request.contextPath}/test/crud/\${no}`);
		//    /begin/test/crud/5006
			
		$.ajax({ 
			url:`${pageContext.request.contextPath}/test/crud/\${no}`,
			type:"get",
			dataType:"json",
			success:function(json){
				// console.log(JSON.stringify(json));
				// {"NO":"5006","WRITEDAY":"2025-01-03 22:41:00","NAME":"오천육"}
				
				let v_html = `<ol>  
				                <li>입력번호 : \${json.NO}</li>
				                <li>성명 : \${json.NAME}</li>
				                <li>작성일자 : \${json.WRITEDAY}</li>
				              </ol>`;
				              
				$("div#one_view").html(v_html);              
			},
			error: function(request, status, error){
			   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});	
	});  
	

	// update 폼
	$(document).on("click", "button.update", function(e){
		
		const no = $(e.target).val();
	//	alert(`${pageContext.request.contextPath}/test/crud/\${no}`);
	    //    /begin/test/crud/5006
	    
	    const name = $(e.target).parent().parent().find("td:nth-child(3)").text();
	    	
		$("div#div_update").html(`<h3>회원수정</h3>
							      <form>
									 번호 : <input type="text" name="no" value="\${no}" readonly /><br>
								 	 성명 : <input type="text" name="name" value="\${name}" /><br>
						    		 <input type="button" id="btn_update_ok" value="수정완료" />
						    		 <input type="reset"  value="취소" />                   
					              </form>`);
		
		$("div#one_view").empty();
	});
	
	
	// update
	$(document).on("click", "input#btn_update_ok", function(e){
		
		const no = $("input:text[name='no']").val();
		const name = $("input:text[name='name']").val();
		
		const reg_exp = /^[0-9]+$/;
		if( !reg_exp.test(no) ) {
			alert("숫자로만 입력하세요");
			return;
		}
		
		if(name.trim().length == 0) {
			alert("성명을 입력하세요");
			return;
		}
		
		const param = {"no":no, "name":name};
		
		$.ajax({
			url:`${pageContext.request.contextPath}/test/crud/create_update`,
			type:"put",
			contentType:"application/json; charset=utf-8",  
			// 전송하는 내용물의 타입은 json 형태를 띈 문자열임.
			// contentType 을 명시하지 않으면 기본은 "application/x-www-form-urlencoded" 이다.
			
			data:JSON.stringify(param), 
			// 위에서 전송하는 내용물의 타입이 json 형태를 띈 문자열로 했기에 JSON.stringify() 를 사용해야 함 
			
			dataType:"json",
			success:function(json){
				// console.log(JSON.stringify(json));
				// {"n":1}
				
				   if(json.n == 1) {
					   alert(`회원 수정이 성공했습니다.`);
					   func_all_view();
					   $("div#div_update").empty();
				   }
			},
			error: function(request, status, error){
			   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});
	});
	
	
	// delete
	$(document).on("click", "button.delete", function(e){
		const no = $(e.target).val();
	 //	alert(`${pageContext.request.contextPath}/test/crud/\${no}`);
		//    /begin/test/crud/5006
		
		$.ajax({ 
			url:`${pageContext.request.contextPath}/test/crud/\${no}`,
			type:"delete",
			dataType:"json",
			success:function(json){
				// console.log(JSON.stringify(json));
				// {"n":1}
				
				   if(json.n == 1) {
					   alert(`입력번호 \${no}을 삭제했습니다.`);
					   func_all_view();
					   $("div#one_view").empty();
				   }
			},
			error: function(request, status, error){
			   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});	
	});
	
	
  });// end of $(document).ready(function(){})----------------------------
</script>
	
</head>
<body>

    <h2>REST-API 연습</h2>
	<h3>오라클 서버에 있는 데이터 조회</h3> 
	<div id="all_view"></div>
	<div style="margin: 2% 0;" id="div_create">
		<button type="button" id="btn_create" style="width: 4%; height: 30px;">생성</button>
	</div>
	<div style="margin: 2% 0;" id="div_update"></div>
	<div id="one_view"></div>
    
</body>
</html>