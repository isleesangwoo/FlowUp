<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%@include file="../../header/header.jsp" %>
 
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
			<form name="addReserFrm" enctype="multipart/form-data">
               <span>To.</span>
               <select name="classification">
				 <option value="0">회의실</option>
				 <option value="1">비품</option>
               </select>
               <hr>
               
               <table>
                  <tr style="height:40px;">
                     <td style="display: inline-block; width: 100px; vertical-align: middle;">대분류명</td>
                     <td><input type="text" name="assetTitle"></td> <%-- 대분류명 자리 --%>
                  </tr>
                  <tr>
                       <td>이용안내</td>
                       <td style="width: 100%;">
                          <textarea name="assetInfo" id="assetInfo" rows="10" cols="100" style="width:100%; height:412px;"></textarea>
                       </td>
                   </tr>
                   
               </table>
               
               <button class="okBtn" type="button" id="addReserBtn">등록</button><button class="resetBtn" type="reset">취소</button>
            </form>
		</div>
		

    </div>
    <!-- 글작성 폼 -->
	
	<!-- 왼쪽 사이드바 -->
	  <div id="left_bar">

	      <!-- === 글작성 버튼 === -->
	      <button id="writePostBtn">
	          <i class="fa-solid fa-plus"></i>
	          <span id="goWrite">자산추가</span>
	      </button>
	      <!-- === 글작성 버튼 === -->

	      <div class="board_menu_container">
	          <ul>
				
				
				<!--  여기 들어옴  -->
				
	          </ul>
	      </div>
	  </div>
	 <!-- 왼쪽 사이드바 -->


    
    
	
	
<script>
	$(document).ready(function(){  
		<%--  ==== 스마트 에디터 구현 시작 등록창 ==== --%>
		//전역변수
	    var obj = [];
	    
	    //스마트에디터 프레임생성
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: obj,
	        elPlaceHolder: "assetInfo",
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
	  
	  
	  // ================ 대분류 등록버튼 ================ //
	  $("button#addReserBtn").click(function(){
		  
		  <%-- === 스마트 에디터 구현 시작 === --%>
		   // id가 content인 textarea에 에디터에서 대입
	       obj.getById["assetInfo"].exec("UPDATE_CONTENTS_FIELD", []);
		  <%-- === 스마트 에디터 구현 끝 === --%>
		  
		  // === 글제목 유효성 검사 === 
	      const subject = $("input:text[name='assetTitle']").val().trim();	  
	      if(subject == "") {
	    	  alert("대분류명을 입력하세요!!");
	    	  $("input:text[name='assetTitle']").val("");
	    	  return; // 종료
	      }	
		  
		  // === 글내용 유효성 검사(스마트 에디터를 사용할 경우) ===
		  let content_val = $("textarea[name='assetInfo']").val().trim();
		  
	      content_val = content_val.replace(/&nbsp;/gi, "");  // 공백(&nbsp;)을 "" 으로 변환

	      content_val = content_val.substring(content_val.indexOf("<p>")+3);
		  
	      content_val = content_val.substring(0, content_val.indexOf("</p>"));
	     
	      if(content_val.trim().length == 0) {
	    	  alert("소개내용을 입력하세요!!");
	    	  return; // 종료
	      }
	      
	      // 폼(form)을 전송(submit)
	      const frm = document.addReserFrm;
	      frm.method = "post";
	      frm.action = "<%= ctxPath%>/reservation/reservationAdd";
	      frm.submit();
	  });
	  // ================ 대분류 등록버튼 ================ //
	  
		
		
		
		

		  // ================ 소분류 토글 ================ //
		  $(document).on('click', 'div.assetTitleBtn', e=>{
			  
			  if (!$(e.target).hasClass('fa-gear')) {
			  		$(e.target).next().toggle();
			  }
			
		  });
		  // ================ 소분류 토글 ================ //

		  

		  
		  
		  
		  // ================ 대분류 삭제 ================ //
			$(document).on('click', '.deleteAsset', e => {
				
				const thisAssetNo = $(e.target).attr('id'); 
					
				if(confirm("삭제시 모든 자산, 예약 정보가 사라집니다. 정말 삭제하시겠습니까?")){
					
					$.ajax({
				        url: "<%= ctxPath%>/reservation/deleteAsset",
				        type: "post",
				        data: { "assetNo": thisAssetNo },
				        dataType: "json",
				        success: function(json) {
				            if (json.result == 1) {
				            	resetLeftBar();
				            }
				            if (json.result == 0) {
				                alert('삭제가 실패되었습니다.');
				            }
				        },
				        error: function(request, status, error) {
				            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
				        }
				    });
					
				}// end of if --------------------

			});
		  // ================ 대분류 삭제 ================ //
		  
		  
		  
		  
		  
	  });// end of $(document).ready(function(){})-----------
</script>
	
