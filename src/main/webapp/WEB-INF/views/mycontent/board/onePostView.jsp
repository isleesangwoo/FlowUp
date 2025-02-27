<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../header/header.jsp" %>
<%@include file="./boardLeftBar.jsp" %>

<%-- 각자 페이지에 해당되는 css 연결 --%>
<link href="<%=ctxPath%>/css/board/onePostView.css" rel="stylesheet"> 

<script>
	var ctxPath = "<%= request.getContextPath() %>";
</script>
<%-- 각자 페이지에 해당되는 js 연결 --%>
<input type="hidden" id="goBackURL" value="<%= request.getAttribute("goBackURL") %>">
<script src="<%=ctxPath%>/js/board/onePostView.js"></script>

<!-- 글작성 폼 -->
    <div id="modalEditPost" class="modal_bg">
    </div>
    <div class="modalEditPostContainer">
	    <div style="padding: var(--size22);">
	        <!-- 여기에 글작성 폼을 만들어주세요!! -->
			<span id="modal_title">글수정</span>
			
			<div id="modal_content_page">
				<form name="updatePostFrm" enctype="multipart/form-data">
					<span>To.</span>
					${postvo.boardvo.boardName}
					<hr>
					<table>
						<tr>
							<td>제목</td>
							<td><input type="text" name="subject" id="subject"value="${postvo.subject}" maxlength="60"></td>
						</tr>
						<tr>
							<td>파일첨부</td>
							<td>
								<div id="update_fileDrop" class="fileDrop border border-secondary">
									<p>이 곳에 파일을 드래그 하세요.</p>
									 <c:forEach var="item" items="${postfilevo}">
										 <div class='fileList'>
						                        <span class='delete'>&times;</span>
						                        <span class='fileName'>${item.orgFilename}</span>
						                        <span class='newFileName'  style="display: none">${item.fileName}</span>
						                        <span class='fileNo' style="display: none">${item.fileNo}</span>
						                        <span class='fileSize'>(${item.fileSize}MB)</span> <%-- 매퍼에서 바이트를 메가바이트로 변환 해줌 --%>
						                        <span class='clear'></span>
					                     </div>
				                     </c:forEach>
								</div>
							</td>
						</tr>
						<tr>
						     <td>내 용</td>
						     <td style="width: 767px; border: solid 1px red;">
						 	    <textarea name="content" id="updateContent" rows="10" cols="100" style="width:766px; height:412px;">${postvo.content}</textarea>
						     </td>
					  	</tr>
					  	<tr>
					  		<td>댓글작성</td>
					  		<td>
					  			<input type="radio" id="update_allowYes" name="allowComments" value="1"
								       ${postvo.allowComments eq 1 ? 'checked' : ''}>
								<label for="update_allowYes" style="margin:0;">허용</label>
								
								<input type="radio" id="update_allowNo" name="allowComments" value="0"
								       ${postvo.allowComments eq 0 ? 'checked' : ''}>
								<label for="update_allowNo" style="margin:0;">허용하지 않음</label>
					  		</td>
					  	</tr>
					  	<tr>
					  		<td>공지로 등록</td>
					  		<td>
					  			<input type="checkbox" id="update_isnotice" name="isNotice" value=1 ${postvo.isNotice eq 1 ? 'checked' : ''}>
								<label for="update_isnotice" style="margin:0;">공지로 등록</label>
								<div id="update_isNoticeElmt"> <!-- 미체크시 hide 상태임 -->
									<input type="text" name="startNotice" id="update_datepicker" maxlength="10" autocomplete='off' size="4" readonly/> 
									-
									<input type="text" name="noticeEndDate" id="update_toDate" maxlength="10" autocomplete='off' size="4" readonly/>
								</div> 
					  		</td>
					  	</tr>
					</table>
					
					<button type="button" id="updatePostBtn">수정</button>
				</form>
			</div>
		</div>
    </div> <!-- end of <div class="modal_container"> -->
    <!-- 글작성 폼 -->

	<!-- 오른쪽 바 -->
    <div id="right_bar">
        <div id="right_title_box">
            <span id="right_title">${postvo.boardvo.boardName} </span>
			<span id="boardMaster">운영 : ${postvo.boardvo.createdBy}</span>
            <!-- 오른쪽 바 메뉴버튼들입니다! -->
            
            <div id="right_menu_container">
            
            	<span id="tool_box_left">
                    <span>
                        <span id="re_btn">
                            <button type="button" id="postUpdate" class="btnDefaultDesignNone" ><i class="fa-regular fa-pen-to-square"></i> 수정</button>
                        </span>
                        <span>
                            <button type="button" id="postDel" class="btnDefaultDesignNone"><i class="fa-regular fa-trash-can"></i>삭제</button>
                        </span>
                    </span>
                </span>
	                

                <span id="tool_box_right">
                    <span>
                        <span id="re_btn">
                            <a href="#"><i class="fa-solid fa-arrow-left"></i>이전</a>
                        </span>
                        <span id="sortCnt_btn">
                            <a href="#">다음<i class="fa-solid fa-arrow-right"></i></a>
                        </span>
                        <span>
                            <button type="button" onclick="javascript:location.href='<%= ctxPath%>${requestScope.goBackURL}'" class="btnDefaultDesignNone">
                            	<i class="fa-solid fa-list"></i> 목록
                            </button>
                        </span>
                    </span>
                </span>
            </div>
            <!-- 오른쪽 바 메뉴버튼들입니다! -->
        </div>
        
        <!-- 게시글 하나 내용보여주기 시작  -->
       	<div id="onePostHeader" class="padding">
       		<div style="display: flex; justify-content: space-between;">
	       		<div>
		       		<span id="postSubject">제목 : ${postvo.subject}</span>
		       		<span id="postCommentCount">[${postvo.commentCount}]</span>
	       		</div>
	       		<div id="likeBtn">
	       			<button type="button" class="btnDefaultDesignNone"><i class="fa-solid fa-heart" id="heartIcon"></i></button>
	       		</div> <%-- 좋아요 버튼 --%>
       		</div>
       		<div>
       			<span id="postCreatBy">${postvo.name}</span>
       			<span id="postRegDate">${postvo.regDate}</span>
       		</div>
       	</div>
        <div id="onePostContent" class="padding">
        	${postvo.content}
        </div>
        
        <c:forEach var="item" items="${postfilevo}">
	        <div class="file"><i class="fa-solid fa-paperclip"></i>
	         	<a href="<%= ctxPath%>/board/fileDownload?postNo=${postvo.postNo}&fileNo=${item.fileNo}" class="fileLink">${item.orgFilename}</a>
	         	<span class='fileSize'>(${item.fileSize}MB)</span> <%-- 매퍼에서 바이트를 메가바이트로 변환 해줌 --%>
	        </div>
        </c:forEach>
        
        <div id="ViewOption" class="padding">
        	<span class="tranBlock">댓글 ${postvo.commentCount}개</span>
        	<span class="tranBlock">조회 ${postvo.readCount}</span>
        	<span class="tranBlock">좋아요 누른 사람 0명</span>
        </div>
        <div class="padding">
	        <div class="commentOfpost ">
	        	<span id="profile"> P </span>
	        	<div id="commentInfo" class="CommentMarginLeft">
	        		<div class="topInfoBox">
	        			<div class="infoBox">
			        		<span>이상우 대표이사</span>
			        		<span class="comment_regDate_Color" id="commentElmt"><i class="fa-solid fa-reply" id="commentIcon"></i>댓글</span>
			        		<span class="comment_regDate_Color">2021-10-07(목) 09:15</span>
		        		</div>
		        		
		        		<div class="deleteBtnBox">
		        			<span><i class="fa-regular fa-pen-to-square"></i></span> <!-- 수정 -->
		        			<span><i class="fa-regular fa-trash-can"></i></span> <!-- 삭제 -->
		        		</div>
	        		</div>
	        		<div>댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.댓글 내용입니다.</div>
	        	</div>
	        		
	        </div>
	        
			<!-- 대댓글 UI 시작 -->
			<div id="reCommentCreate" >
	        	<span id="profile"> P </span>
	        	<div id="commentEdit">
	        		<input type="text" name="content" placeholder="댓글을 남겨보세요" id="reCommentContent">
	        		<div id="commentBottom">
	        			<button id="commentEnterBtn" class="btnDefaultDesignNone">등록</button>
	        		</div>
	        	</div>
	        </div>
			<!-- 대댓글 UI 끝 -->
        </div>
        
        <div id="commentCreate" class="padding">
        	<span id="profile"> P </span>
        	<div id="commentEdit">
        		<input type="text" name="content" placeholder="댓글을 남겨보세요" id="commentContent">
        		<div id="commentBottom">
        			<button id="commentEnterBtn" class="btnDefaultDesignNone">등록</button>
        		</div>
        	</div>
        </div>
        	<table id="preoOrNextPostElmt">
        	<c:if test="${postvo.previouspostNo ne null}">
        		<tr class="onePostElmt" onclick="goView('${postvo.previouspostNo}')">
        			<td>이전글</td>
        			<td>${postvo.previoussubject}</td>
        			<td>${postvo.previousname}</td>
        			<td>${postvo.previousregDate}</td>
        			<td>${postvo.previousreadCount}</td>
					<td>14</td>
        		</tr>
        	</c:if>	
        		<tr class="onePostElmt" id="currentPost" style="background-color: #f2f2f2; ">
        			<td> <span class="currentPost"><i class="fa-solid fa-angles-right"></i> 현재글</span></td>
        			<td><span class="currentPost">${postvo.subject}</span></td>
        			<td>${postvo.name}</td>
        			<td>${postvo.regDate}</td>
        			<td>${postvo.readCount}</td>
					<td>좋아요개발중</td>
        		</tr>
        	<c:if test="${postvo.nextpostNo ne null}">	
        		<tr class="onePostElmt" onclick="goView('${postvo.nextpostNo}')">
        			<td>다음글</td>
        			<td>${postvo.nextsubject}</td>
        			<td>${postvo.name}</td>
        			<td>${postvo.nextregDate}</td>
        			<td>${postvo.nextreadCount}</td>
					<td>14</td>
        		</tr>
        	</c:if>		
        	</table>
<%--     <div style="margin-bottom: 1%;">이전글&nbsp;제목&nbsp;&nbsp;<span class="move" onclick="goView('${requestScope.boardvo.previousseq}')">${requestScope.boardvo.previoussubject}</span></div>  --%>
<%-- 	 <div style="margin-bottom: 1%;">다음글&nbsp;제목&nbsp;&nbsp;<span class="move" onclick="goView('${requestScope.boardvo.nextseq}')">${requestScope.boardvo.nextsubject}</span></div> --%>
	        
	     <div id="noticeEndDate" style="display: none;">${postvo.noticeEndDate}</div>   
        <form name="postFrm">
	        <div>
		        게시글 번호 : <input type="text" name="postNo" value="${postvo.postNo}"><br> <%-- 필요한 것임 지우지말 것 --%>
		        상세보기 페이지 이전 url : <input type="text" name="goBackURL" value="<%= request.getAttribute("goBackURL") %>"/><%-- 필요한 것임 지우지말 것 --%>
		        댓글 허용 여부 : ${postvo.allowComments}<br>
		        공지글 여부 : ${postvo.isNotice}<br>
		        공지글 종료일 : ${postvo.noticeEndDate}<br>
				게시판 번호 : ${postvo.fk_boardNo}<br>
				작성자 번호 : ${postvo.fk_employeeNo}<br>
			</div>
		</form>
	<%-- 이전글제목 보기, 다음글제목 보기시 POST 방식으로 넘기기 위한것 --%>
	<form name="postFrm_2">
	   <input type="hidden" name="postNo" />
	   <input type="hidden" name="goBackURL" />
	</form>
		
   </div>




<jsp:include page="../../footer/footer.jsp" /> 