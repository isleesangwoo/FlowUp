<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();
    //     /myspring
%>

<jsp:include page="../../header/header.jsp" />
 
<%-- 각자 페이지에 해당되는 css 연결 --%>
<link href="<%=ctxPath%>/css/email/email_main.css" rel="stylesheet">

<%-- 각자 페이지에 해당되는 js 연결 --%>
<script src="<%=ctxPath%>/js/email/email.js"></script>

<script type="text/javascript">

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
	  
	  <%-- 별(중요표시) 클릭시 변경 ajax 시작 --%>
      $(".toggle_star").on("click", function(){
          const $star = $(this);
          const mailNo = $star.data("mailno");    // data-mailno 값
          // const current = $star.data("important"); // 현재 상태

          $.ajax({
              url: "<%=request.getContextPath()%>/mail/toggleImportant",
              type: "POST",
              data: { mailNo: mailNo },
              success: function(importantStatus) {
                  // 서버가 반환한 새로운 상태("0" 또는 "1")
                  if(importantStatus === "1") {
                      // 중요 상태가 됨 => CSS 색 변경, 아이콘 변경 등
                      $star.removeClass("fa-regular").addClass("fa-solid")
                           .css("color", "yellow");
                  } 
                  else {
                      // 중요 상태 해제 => 기본 아이콘/색상
                      $star.removeClass("fa-solid").addClass("fa-regular")
                           .css("color", "");
                  }
              },
              error: function() {
                  alert("서버와 통신 중 오류가 발생했습니다.");
              }
          });
      });
      <%-- 별(중요표시) 클릭시 변경 ajax 끝 --%>
       
   });
	  
</script>	

	<%-- 이곳에 각 해당되는 뷰 페이지를 작성해주세요 --%>
	<!-- 메일작성 폼 -->
    <div id="modal" class="modal_bg">
    </div>
    <div class="modal_container">
    
	    <!-- 모달 창 -->
	    <div id="modal_bar" style="overflow-y: auto;">
	        <div id="modal_title_box">
	            <span id="modal_title">메일쓰기</span>
	
	            <!-- 메일 작성 공간 -->
	            <div id="modal_menu_container">
	                <span>
	                    <a href="#">
	                    	<i class="fa-regular fa-paper-plane"></i>
	                    	<button type="button" id="btnWrite">
	                    		<span>보내기</span>
	                    	</button>
	                    </a>
	                </span>
	                
	                <span>
	                    <a href="#">
	                    	<i class="fa-regular fa-floppy-disk"></i>
	                    	<button type="button" id="btnSave">
	                        	<span>임시저장</span>
	                        </button>
	                    </a>
	                </span>
	                <span>
	                    <a href="#">
	                    	<i class="fa-regular fa-eye"></i>
	                    	<button type="button" id="btnSpoiler">
	                        	<span>미리보기</span>
	                        </button>
	                    </a>
	                </span>
	
	            </div>
	        </div>
	        
	        
	    <div id="writeArea">
	    
			  <table id="writeAreaTable">
			    <!-- 받는사람 -->
			    <tr>
			    
			      <th>
			      받는사람
			      
			      <label id="meWrite"><input type="checkbox" /> 내게쓰기</label>
			      
			      </th>
			      <td id="mailWriteReference" colspan="2">
			      
		      		<div id="mailWriteReferenceDiv">
		      		
		      			<div id="addrWrap">
			      			<ul class="nameTag">
			      				<li class="addrCreate">
			      					<div class="addrInput">
				        				<textarea id="addrWrite" type="text" style="display:inline; white-pace:nowrap;" autocomplete="off"></textarea>
				        			</div>
				        		</li>
				        	</ul>
			        	</div>
			        	
			        	<select id="addrSelect">
			        		<option value='' selected>최근주소</option>
			        	</select>
			        	
			        	<span class="btnWrap">
				        	<a class="btnAddr">
				        		<span class="text">주소록</span>
				        	</a>
			        	</span>
			        	
		      		</div>
		      		
			      </td>
			      
			    </tr>
			    
			    <!-- 참조 -->
			    <tr>
			    
			      <th>참조</th>
			      <td id="mailWriteReference" colspan="2">
			      
		      		<div id="mailWriteReferenceDiv">
		      		
		      			<div id="addrWrap">
			      			<ul class="nameTag">
			      				<li class="addrCreate">
			      					<div class="addrInput">
				        				<textarea id="addrWrite" type="text" style="display:inline; white-pace:nowrap;" autocomplete="off"></textarea>
				        			</div>
				        		</li>
				        	</ul>
			        	</div>
			        	
			        	<select id="addrSelect">
			        		<option value='' selected>최근주소</option>
			        	</select>
			        	
			        	<span class="btnWrap">
				        	<a class="btnAddr">
				        		<span class="text">주소록</span>
				        	</a>
			        	</span>
			        	
		      		</div>
		      		
			      </td>
			      
			    </tr>
			    
			    <!-- 제목 -->
			    <tr>
			      <th>제목</th>
			      <td id="mailWriteTitle" colspan="2">
			        <input id="mailWriteTitleBox" type="text" />
			      </td>
			    </tr>
			    
			    <!-- 파일첨부 -->
			    <tr>
			      <th>파일첨부</th>
			      <td colspan="2">
			        <!-- 파일첨부 영역 (기존과 동일) -->
			        <div class="file-upload-area">
			          <div class="file-btn-group">
			            <input type="file" id="fileInput" multiple style="display: none;" />
			            <button type="button" id="btnFileSelect">파일선택</button>
			            <button type="button" id="btnFileArchive">자료실</button>
			            <button type="button" id="btnFileDeleteAll">모두삭제</button>
			            
			            <span class="file-limit-info">
			              일반 (0Byte / 20MB), 대용량 (0Byte / 500.0MB)
			            </span>
			          </div>
			          
			          <div class="file-drag-drop-zone" id="dragDropZone">
			            여기에 첨부 파일을 끌어오세요.
			            <br />
			            또는 
			            <button type="button" class="inline-file-btn" id="btnFileSelect2">파일선택</button>
			          </div>
			          <ul class="file-list" id="fileList"></ul>
			        </div>
			      </td>
			    </tr>
			    
			  </table>
	        
	    	<div id="smartedit">
	    		<textarea style="width: 100%; height: 612px; padding: var(--size24);" id="content"></textarea>
		    </div>
	
	   		<div style="margin: 20px;">
	            <button type="button" id="btnReservationMail">예약메일</button>
	        </div>
        </div>

	    </div>
    </div>
    <!-- 메일작성 폼 -->

	
	<!-- 왼쪽 사이드바 -->
    <div id="left_bar" >

        <!-- === 메일 작성 버튼 === -->
        <button id="goMail">
            <i class="fa-solid fa-plus"></i>
            <span>메일쓰기</span>
        </button>
        <!-- === 메일 작성 버튼 === -->

        <div class="mail_menu_container">
            <ul>
                <li id="receivedMail">
                    <a href="<%=request.getContextPath()%>/mail">받은메일함</a>
                    <span class="mail_cnt">${totalCount}</span> <!-- 콤마처리 해주세요 -->
                </li>
                <li id="sendMail"><a href="#">보낸메일함</a></li>
                <li id="saveMail"><a href="#">임시보관함</a></li>
                <li id="tagMail"><a href="#">태그메일함</a></li>
                <li id="importantMail">
                	<a href="#" id="importantMailLink">중요메일함</a>
                </li>
                <li id="deleteMail"><a href="#">휴지통</a></li>
            </ul>
        </div>
    </div>
    <!-- 왼쪽 사이드바 -->

    <!-- 오른쪽 바 -->
    <div id="right_bar" style="overflow-y: auto;">
        <div id="right_title_box">
            <span id="right_title">Inbox</span>
            <span id="right_info">
                <span>
                    All
                    <span class="right_info_cnt">${totalCount}</span> <!-- 전체 메일의 개수를 띄워주세요! -->
                </span>
                <span>/</span>
                <span>
                    Unread
                    <span class="right_info_cnt">${unreadCount}</span> <!-- 읽은 메일의 개수를 띄워주세요! -->
                </span>
            </span>

            <!-- 오른쪽 바 메뉴버튼들입니다! -->
            <div id="right_menu_container">
                <input id="mailListAllCheck" type="checkbox" />
                <span>
                    <a href="#">
                        <i class="fa-solid fa-share" style="transform: scaleX:(-1);"></i>
                        <span>답장</span>
                    </a>
                </span>
                
                <span>
                    <a href="#">
                    	<i class="fa-regular fa-trash-can"></i>
                        <span>삭제</span>
                    </a>
                </span>
                <span>
                    <a href="#">
                    	<i class="fa-solid fa-tags"></i>
                        <span>태그</span>
                    </a>
                </span>
                <span>
                    <a href="#">
                    	<i class="fa-regular fa-envelope-open"></i>
                        <span>읽음</span>
                    </a>
                </span>
                <span>
                    <a href="#">
                    	<i class="fa-solid fa-arrow-up-right-from-square"></i>
                        <span>메일이동</span>
                    </a>
                </span>


                <span id="reBtn_box">
                    <span>
                        <span id="preBtn" title="이전 메일">
                            <i class="fa-solid fa-arrow-up"></i>
                        </span>
                        <span id="nextBtn" title="다음 메일">
                            <i class="fa-solid fa-arrow-right"></i>
                        </span>
                    </span>
                </span>
                
            </div>
            <!-- 오른쪽 바 메뉴버튼들입니다! -->
        </div>
        


<!-- 메일 상세 테이블 (mailContentTable) -->
<table id="mailContentTable" style="width: 100%; border-collapse: collapse;">
    <tbody>
        <!-- [1] 제목 + 별 아이콘 (th 없이, colspan=2) -->
        <tr style="border-bottom: 1px solid #ddd;">
            <td colspan="2" style="padding: 12px; font-size: 1.4em; font-weight: bold;">
                <!-- 중요표시 별아이콘 -->
                <c:choose>
                    <c:when test="${mailvo.importantStatus == 1}">
                        <!-- 채워진 별 + 노란색 -->
                        <i class="fa-solid fa-star toggle_star" 
                           style="color: yellow; cursor: pointer;"
                           data-mailno="${mailvo.mailNo}">
                        </i>
                    </c:when>
                    <c:otherwise>
                        <!-- 빈 별 (기본) -->
                        <i class="fa-regular fa-star toggle_star" 
                           style="cursor: pointer;"
                           data-mailno="${mailvo.mailNo}">
                        </i>
                    </c:otherwise>
                </c:choose>
                <!-- 메일 제목 -->
                ${mailvo.subject}
            </td>
        </tr>

        <!-- [2] 보낸사람 (이름 + 이메일) -->
        <tr style="border-bottom: 1px solid #ddd;">
            <th style="width: 120px; text-align: left; padding: 8px;">보낸사람</th>
            <td style="padding: 8px;">
                ${mailvo.employeevo.name}
                (<span style="color: #555;">${mailvo.employeevo.email}</span>)
            </td>
        </tr>

        <!-- [3] 날짜 -->
        <tr style="border-bottom: 1px solid #ddd;">
            <th style="text-align: left; padding: 8px;">보낸날짜</th>
            <td style="padding: 8px;">
                ${mailvo.sendDate}
            </td>
        </tr>

        <!-- [4] 첨부파일 -->
        <tr style="border-bottom: 1px solid #ddd;">
            <th style="text-align: left; padding: 8px;">첨부파일</th>
            <td style="padding: 8px;">
                <c:if test="${not empty mailfilevo}">
                <p>첨부파일 개수: ${mailfilevo.size()}</p>
                    <c:forEach var="mailfile" items="${mailfilevo}">
                        <div>
                            <!-- 파일 다운로드 링크 예시 -->
                            
                            <i class="fa-solid fa-paperclip"></i><a href="<%=ctxPath%>/mail/download?fileName=${mailfile.fileName}&orgFileName=${mailfile.orgFileName}">
                                ${mailfile.orgFileName} (${mailfile.fileSize}KB)
                            </a>
                        </div>
                    </c:forEach>
                </c:if>
                <c:if test="${empty mailfilevo}">
                    첨부파일 없음
                </c:if>
            </td>
        </tr>

        <!-- [5] 메일 내용 (th 없이, colspan=2, 폰트 크게) -->
        <tr>
            <td colspan="2" style="padding: 12px; font-size: 1.2em; line-height: 1.6;">
                <!-- mailvo.content에 HTML 태그가 들어있다면 escapeXml="false" 필요 -->
                <c:out value="${mailvo.content}" escapeXml="false" />
            </td>
        </tr>
    </tbody>
</table>





    </div>
    <!-- 오른쪽 바 -->
	<%-- 이곳에 각 해당되는 뷰 페이지를 작성해주세요 --%>
	
<jsp:include page="../../footer/footer.jsp" /> 