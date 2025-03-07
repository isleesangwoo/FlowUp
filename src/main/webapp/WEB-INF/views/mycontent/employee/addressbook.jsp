<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String ctxPath = request.getContextPath();
   //     /flowUp
%> 
<jsp:include page="../../header/header.jsp" />
<%@include file="./addressbookbar.jsp" %>

<link href="<%=ctxPath%>/css/employeeCss/addressbook.css" rel="stylesheet"> 

<script type="text/javascript">

$(document).ready(function() {
	
	$("span.error").hide();
	
	$("div.addFrmModal").hide();
	
	$("button.openModal").click(function(){
		
		$("div.addFrmModal").show();
		
		$("input:text[name='firstName']").focus();
		
		// 이름 유효성
		$("input:text[name='firstName']").blur(function(e){
			
			const regExp= /^[가-힣a-zA-Z]{1,6}$/ // 한글&영어 1~6자리
	 		const bool = regExp.test($(e.target).val());
	 		
	 		if(!bool){
				 
				 $(e.target).next().show();
				 $(e.target).focus();
				 
			}
	 		
	 		else{
				$(e.target).next().hide();
		    }			
			
		});// end of $("input:text[name='firstName']").blur(function(e)--------
				
		// 가운데 이름 유효성
		$("input:text[name='middleName']").blur(function(e){
			
			const regExp= /^[가-힣a-zA-Z]{1,6}$/ // 한글&영어 1~6자리
	 		const bool = regExp.test($(e.target).val());
	 		
	 		if(!bool){
				 
				 $(e.target).next().show();
				 $(e.target).focus();
				 
			}
	 		
	 		else{
				$(e.target).next().hide();
		    }			
			
		});// end of $("input:text[name='middleName']").blur(function(e)--------
				
		//  이름 유효성
		$("input:text[name='lastName']").blur(function(e){
			
			const regExp= /^[가-힣a-zA-Z]{1,6}$/ // 한글&영어 1~6자리
	 		const bool = regExp.test($(e.target).val());
	 		
	 		if(!bool){
				 
				 $(e.target).next().show();
				 $(e.target).focus();
				 
			}
	 		
	 		else{
				$(e.target).next().hide();
		    }			
			
		});// end of $("input:text[name='middleName']").blur(function(e)--------
				
				
				
	    $("input:text[name='company']").blur(function(e){
	    	
	    	if($(e.target).val() == ""){
		    	 $(e.target).next().show();
				 $(e.target).focus();
			}
		
	    	else{
				$(e.target).next().hide();
	    	}			
		
	    	
	    });//end of $("input:text[name='company']").blur(function(e){});
	    
	    $("input:text[name='department']").blur(function(e){
	    	
	    	
	    	const regExp= /^[가-힣a-zA-Z]{2,6}$/ // 한글&영어 2~6자리
		 	const bool = regExp.test($(e.target).val());
		 		
	 		if(!bool){
				 
				 $(e.target).next().show();
				 $(e.target).focus();
				 
			}
	 		
	 		else{
				$(e.target).next().hide();
		    }	
	    	
	    	
	    });// end of $("input:text[name='department']").blur(function(e){});input')

	    
	    $("input:text[name='rank']").blur(function(e){
	    	
	    	const regExp= /^[가-힣a-zA-Z]{2,6}$/ // 한글&영어 2~6자리
			const bool = regExp.test($(e.target).val());
			 		
	 		if(!bool){
				 
				 $(e.target).next().show();
				 $(e.target).focus();
				 
			}
	 		
	 		else{
				$(e.target).next().hide();
		    }	
		    	
	    });//end of  $("input:text[name='rank']").blur(function(e){});
	    
	    
	    $("input:text[name='email']").blur(function(e){
	    	
	    	const regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	    	const bool = regExp.test($(e.target).val());
	    	
	    	if(!bool){
				 
				 $(e.target).next().show();
				 $(e.target).focus();
				 
			}
	 		
	 		else{
				$(e.target).next().hide();
		    }	
	    	
	    });// end of $("input:text[name='email']").blur(function(e){});
	    
	    $("input:text[name='directCall']").blur(function(e){
	    	
	    	const regExp = /^0([0|1|6|7|8|9|4|3|1|2]{0,2}?)?([0-9]{3,4})?([0-9]{4})$/;
	    	const bool = regExp.test($(e.target).val());
	    	
	    	if(!bool){
				 
				 $(e.target).next().show();
				 $(e.target).focus();
				 
			}
	 		
	 		else{
				$(e.target).next().hide();
		    }    
	    	
	    });// end of $("input:text[name='directCall']").blur(function(e){})
	    
	    
	    const companyAddress = $("input:text[name='companyAddress']").val();
	    if(companyAddress == ""){
	    	$("input:text[name='companyAddress']").focus();
	    	$("input:text[name='companyAddress']").next().show();
	    }
	    
	    else{
	    	$("input:text[name='companyAddress']").next().hide();
	    }   
	    
	    $("input:text[name='phoneNo']").blur(function(e){
	    	
	    	 const regExp = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;
	 		 const bool = regExp.test( $(e.target).val() );
			 
			if(!bool){
				$(e.target).next().show();
				$(e.target).focus()
			}
			 
			 else{
				 $(e.target).next().hide();	
			 }
	    	
	    });//$("input:text[name='phoneNo']").blur(function(e){});
	    
		
		
		
	});// end of $("button.openModal").click(function(){});--------
	
	$("button.add").click(function(){
		
		const frm = document.addAdrsFrm;
		frm.action = "<%= ctxPath%>/employee/addAddressEnd";
	    frm.method = "post";
	    frm.submit();
		
	});// end of $("button.add").click(function(){});
	
	
	<%--alert($("input:text[name='fk_employeeNo']").val());--%>

	const fk_employeeNo = $("input:hidden[name='fk_employeeNo']").val()
	
	// 주소록 전체 목록
	$.ajax({
		url:"<%= ctxPath%>/employee/all_address_data",
		data:{"fk_employeeNo":fk_employeeNo},
		dataType:"json",
		type: "get",
  	  	success:function(json){
  	  		//console.log(JSON.stringify(json));
  	  		//alert(JSON.stringify(json));
  	  		<%--
	  	  		[{"DIRECTCALL":"0209091212","PHONENO":"01023238989","name":"김춘배","DEPARTMENT":"영업부","RANK":"부장","EMAIL":"kimchunbae@naver.com","COMPANY":"flow up"}
	  	  		,{"DIRECTCALL":"010121212121","PHONENO":"01023238989","name":"이지지혜","DEPARTMENT":"영업부","RANK":"부장","EMAIL":"bamu6651@gmail.com","COMPANY":"주식회사"}
	  	  		,{"DIRECTCALL":"04178129878","PHONENO":"01020706651","name":"곽두팔","DEPARTMENT":"영업부","RANK":"사원","EMAIL":"banana5092@naver.com","COMPANY":"주식회사"}
	  	  		,{"DIRECTCALL":"04178129878","PHONENO":"01020706651","name":"김 봉춘","DEPARTMENT":"영업부","RANK":"부장","EMAIL":"bamu6651@gmail.com","COMPANY":"주식회사"}]
  	  		--%>
  	  		let v_html="";
  	  		
  	  		
  	  		v_html += "<table class='addressbooktable'>"
				    +	 "<thead>" 
					+		 "<tr>"
					+			"<th class='thcss thcheck'><input type='checkbox'></th>"
					+			"<th class='thcss'><span class='tabletitle'>이름(표시명)</span></th>"
					+			"<th class='thcss'><span class='tabletitle'>직위</span></th>"
					+			"<th class='thcss'><span class='tabletitle'>이메일</span></th>"
					+			"<th class='thcss'><span class='tabletitle'>휴대폰</span></th>"
					+			"<th class='thcss'><span class='tabletitle'>부서</span></th>"
					+			"<th class='thcss'><span class='tabletitle'>회사</span></th>"
					+			"<th class='thcss'><span class='tabletitle'>내선번호</span></th>"
					+		  "</tr>"
					+		"</thead>"		
					+	"<tbody>";
  	  		
  	  		for(let i=0;i<json.length;i++){
  	  			
  	  			v_html+="<tr>"
		  	  		  +		"<td class='tdcss thcheck'><input type='checkbox'></td>"
		  			  +		"<td class='tdcss'><span class='tabletitle'>"+json[i].name+"</span></td>"
		  			  +		"<td class='tdcss'><span class='tabletitle'>"+json[i].RANK+"</span></td>"
		  			  +		"<td class='tdcss'><span class='tabletitle'>"+json[i].EMAIL+"</span></td>"
		  			  +		"<td class='tdcss'><span class='tabletitle'>"+json[i].PHONENO+"</span></td>"
		  			  +		"<td class='tdcss'><span class='tabletitle'>"+json[i].DEPARTMENT+"</td>"
		  			  +		"<td class='tdcss'><span class='tabletitle'>"+json[i].COMPANY+"</span></td>"
		  			  +		"<td class='tdcss'><span class='tabletitle'>"+json[i].DIRECTCALL+"</span></td>"
		  			  + "</tr>";
			  			
  	  			
  	  		}// end of for(let i = 0; i<json.length; i++){}
  	  		v_html+="</tbody>"+
  	  				"</table>";
  	  				
  	  				$("div.addressbookcontent").html(v_html);
  	  				
  	  				
  	  	},
  	 	 error: function(request, status, error){
		 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	     }
		
	});// end of $.ajax({});----------------------------------------------------------------
	
}); //$(document).ready(function(){});-------------------

</script>

<div id="right-bar">
	<div id="right_title_box">
		<span id="right_title">주소록</span><span class="sidetitle">in 공용주소록(<span class="addresscount">10</span>건)</span>
	</div>


<div id="toolbar">
	 <div>
		<button class="openModal toolbtn">빠른 등록</button>
		<button class="toolbtn">삭제</button>
		<button class="toolbtn">메일발송</button>
	 </div>
</div>

<div class="navtab_spelling">
<button class="spelling listall list">전체</button>
	<button class="spelling list" id="a">ㄱ</button>
	<button class="spelling list" id="b">ㄴ</button>
	<button class="spelling list" id="c">ㄷ</button>
	<button class="spelling list" id="d">ㄹ</button>
	<button class="spelling list" id="e">ㅁ</button>
	<button class="spelling list" id="f">ㅂ</button>
	<button class="spelling list" id="g">ㅅ</button>
	<button class="spelling list" id="h">ㅇ</button>
	<button class="spelling list" id="i">ㅈ</button>
	<button class="spelling list" id="j">ㅊ</button>
	<button class="spelling list" id="k">ㅋ</button>
	<button class="spelling list" id="l">ㅌ</button>
	<button class="spelling list" id="m">ㅍ</button>
	<button class="spelling list" id="o">ㅎ</button>
	<button class="spelling list" id="alphabet">A~Z</button>
	<button class="spelling list" id="number">1~9</button>
	
</div>

<div class="addressbookcontent">

<div class="addFrmModal">
		<div class="maodal_background"></div><%-- 모달창 백그라운드 --%>
		<div class="modal_content"><%-- 모달창 메인 내용 --%>
			<form name="addAdrsFrm" class="addAdrsFrm">
			<div class="frmTitle">
			<h4>주소록 추가</h4>
			</div>
			<div class="close_btn_div">
				<button class="closeModal">X</button><%-- 모달창 닫기 --%>
			</div>
				
				<ul>
					<li class="input_li">
						<label class="modal_input_title">성</label>
						<input type="text" name="firstName" class="modal_input"/>
						<span class = "error">한글 또는 영어로 입력해주세요</span>					
					</li>
					<li class="input_li">
						<label class="modal_input_title">중간이름</label>
						<input type="text" name="middleName" class="modal_input"/>
						<span class = "error">한글 또는 영어로 입력해주세요</span>	
					</li>
					<li class="input_li">
						<label class="modal_input_title">이름</label>
						<input type="text" name="lastName" class="modal_input"/>
						<span class = "error">한글 또는 영어로 입력해주세요</span>	
					</li>
					<li class="input_li">
						<label class="modal_input_title">회사</label>
						<input type="text" name="company" class="modal_input"/>
						<span class = "error">한글 또는 영어로 입력해주세요</span>	
					</li>
					<li class="input_li">
						<label class="modal_input_title">부서</label>
						<input type="text" name="department" class="modal_input"/>
						<span class = "error">한글 또는 영어로 입력해주세요</span>	
					</li>
					<li class="input_li">
						<label class="modal_input_title">직위</label>
						<input type="text" name="rank" class="modal_input"/>
						<span class = "error">한글 또는 영어로 입력해주세요</span>	
					</li>
					<li class="input_li">
						<label class="modal_input_title">이메일</label>
						<input type="text" name="email" class="modal_input"/>
						<span class = "error">이메일 형식에 맞게 입력해주세요</span>	
					</li>
					<li class="input_li">
						<label class="modal_input_title">전화번호</label>
						<input type="text" name="phoneNo" class="modal_input"/>
						<span class = "error">'-'를 빼고 입력해주세요</span>	
					</li>
					<li class="input_li">
						<label class="modal_input_title">내선번호</label>
						<input type="text" name="directCall" class="modal_input"/>
						<span class = "error">'-'를 빼고 입력해주세요</span>	
					</li>
					<li class="input_li">
						<label class="modal_input_title">회사주소</label>
						<input type="text" name="companyAddress" class="modal_input"/>
					</li>
					<li class="input_li">
						<input type="hidden" name="fk_employeeNo" class="modal_input" value="${sessionScope.loginuser.employeeNo}"/>
					</li>
					
					<li class="input_li">
						<button type="button" class="add">주소록 등록</button>
						<button type="reset" class="no_add">등록 취소</button>
					</li>
				</ul>
					
			</form>
		</div>
		
	</div>

	</div>
</div>

