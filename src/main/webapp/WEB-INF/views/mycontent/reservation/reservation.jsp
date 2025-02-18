<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    


<%@include file="../../header/header.jsp" %>
<%@include file="./reservationLeftBar.jsp" %>
 
<%-- 각자 페이지에 해당되는 css 연결 --%>
<link href="<%=ctxPath%>/css/reservation/reservation_main.css" rel="stylesheet"> 

<%-- 각자 페이지에 해당되는 js 연결 --%>
<script src="<%=ctxPath%>/js/reservation/reservation.js"></script>

	<%-- 이곳에 각 해당되는 뷰 페이지를 작성해주세요 --%>
	<!-- 글작성 폼 -->
    <div id="modal" class="modal_bg">
    </div>
    <div class="modal_container">

		<div style="padding: var(--size24)">
			<form name="addPostFrm" enctype="multipart/form-data">
			               <span>To.</span>
			               <select name="selectBoardGroup">
							 <option value="0">회의실</option>
							 <option value="1">비품</option>
			               </select>
			               <hr>
			               
			               <table>
			                  <tr style="height:40px;">
			                     <td>대분류명</td>
			                     <td><input type="text" name="title"></td> <%-- 대분류명 자리 --%>
			                  </tr>
			                  <tr>
			                       <td>이용안내</td>
			                       <td style="width: 100%;">
			                          <textarea name="content" id="content" rows="10" cols="100" style="width:100%; height:412px;"></textarea>
			                       </td>
			                   </tr>
			                   
			               </table>
			               
			               <button type="button" id="addPostBtn">등록</button><button type="reset">취소</button>
			            </form>
		</div>
		

    </div>
    <!-- 글작성 폼 -->
	
	


    <!-- 오른쪽 바 -->
    <div id="right_bar">
        <div id="right_title_box">
            <span id="right_title">자산 예약 현황</span>
        </div>
        
        <%-- 이곳에 각 해당되는 뷰 페이지를 작성 시작 --%>
		<!-- 시간표 달력을 보여주는 요소 전체 박스-->
		<div id="postContainer"> 
			<jsp:include page="../../common/time_calendar.jsp" /> 
		</div>
		<!-- 시간표 달력을 보여주는 요소 전체 박스-->
		
		<!-- 내 예약/ 대여 현황 테이블 -->
        <div>
			<div class="mytitle">
					내 예약 / 대여 현황
			</div>
			
			<div>
				<table border="1" class="my_table">
					<thead>
						<tr>
							<th>자산</th>
							<th>이름</th>
							<th>예약종류</th>
							<th>예약 시간 (대여 시작 시간)</th>
							<th>취소/반납</th>
						</tr>
					</thead>
					<tbody class="my_tbody">
						<tr>
							<td>차</td>
							<td>모닝1122</td>
							<td>대여</td>
							<td>09:00</td>
							<td>반납</td>
						</tr>
						
						<tr>
							<td>차</td>
							<td>모닝1122</td>
							<td>대여</td>
							<td>09:00</td>
							<td>반납</td>
						</tr>
						
						<tr>
							<td>차</td>
							<td>모닝1122</td>
							<td>대여</td>
							<td>09:00</td>
							<td>반납</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<!-- 내 예약/ 대여 현황 테이블 -->
		<!-- 시간표 달력을 보여주는 요소 전체 박스-->
		<%-- 이곳에 각 해당되는 뷰 페이지를 작성 끝 --%>
    </div>
    <!-- 오른쪽 바 -->
    
	
	
<script>
	$(document).ready(function(){  
		  
		  <%--  ==== 스마트 에디터 구현 시작 ==== --%>
			//전역변수
		    var obj = [];
		    
		    //스마트에디터 프레임생성
		    nhn.husky.EZCreator.createInIFrame({
		        oAppRef: obj,
		        elPlaceHolder: "content",
		        sSkinURI: "<%= ctxPath%>/smarteditor/SmartEditor2Skin.html",
		        htParams : {
		            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		            bUseToolbar : true,            
		            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		            bUseVerticalResizer : true,    
		            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		            bUseModeChanger : true,
		        }
		    });
		  <%--  ==== 스마트 에디터 구현 끝 ==== --%>
		  
		  
		  // 수정완료 버튼
		  $("button#btnUpdate").click(function(){
			  
			  <%-- === 스마트 에디터 구현 시작 === --%>
			   // id가 content인 textarea에 에디터에서 대입
		       obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
			  <%-- === 스마트 에디터 구현 끝 === --%>
			  
			  // === 글제목 유효성 검사 === 
		      const subject = $("input:text[name='subject']").val().trim();	  
		      if(subject == "") {
		    	  alert("글제목을 입력하세요!!");
		    	  $("input:text[name='subject']").val("");
		    	  return; // 종료
		      }	
			  
			  // === 글내용 유효성 검사(스마트 에디터를 사용할 경우) ===
			  let content_val = $("textarea[name='content']").val().trim();
			  
		  //  alert(content_val);  // content 에 공백만 여러개를 입력하여 쓰기할 경우 알아보는 것.
		  //  <p>&nbsp; &nbsp; &nbsp; &nbsp;</p> 이라고 나온다.
		  
		      content_val = content_val.replace(/&nbsp;/gi, "");  // 공백(&nbsp;)을 "" 으로 변환
		      /*    
			         대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
				   ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
				               그리고 뒤의 gi는 다음을 의미합니다.
				
				   g : 전체 모든 문자열을 변경 global
				   i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
		      */
		   // alert(content_val);
		   // <p>                                      </p>
		   
		      content_val = content_val.substring(content_val.indexOf("<p>")+3);
		   // alert(content_val);
			  //                                       </p>
			  
		      content_val = content_val.substring(0, content_val.indexOf("</p>"));
		   // alert(content_val);
		     
		      if(content_val.trim().length == 0) {
		    	  alert("글내용을 입력하세요!!");
		    	  return; // 종료
		      }
		      
		      
		      // === 글암호 유효성 검사 === 
		      const pw = $("input:password[name='pw']").val();	  
		      if(pw == "") {
		    	  alert("글암호를 입력하세요!!");
		    	  return; // 종료
		      }	
		      else {
		    	  if("${requestScope.boardvo.pw}" != pw) {
		    		  alert("입력하신 글암호가 원래암호와 일치하지 않습니다.");
			    	  return; // 종료
		    	  }
		      }
		    	  
		      // 폼(form)을 전송(submit)
		      const frm = document.editFrm;
		      frm.method = "post";
		      frm.action = "<%= ctxPath%>/board/edit";
		      frm.submit();
		  });
		  
	  });// end of $(document).ready(function(){})-----------
</script>
	
	
	
<jsp:include page="../../footer/footer.jsp" /> 
