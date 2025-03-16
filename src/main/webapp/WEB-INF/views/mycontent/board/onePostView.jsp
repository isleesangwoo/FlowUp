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
    <div class="modalEditPostContainer" style="overflow-y: auto;">
	    <div>
	        <!-- 여기에 글작성 폼을 만들어주세요!! -->
			<span id="modal_title">글수정</span>
			
			<div id="modal_content_page">
				<form name="updatePostFrm" enctype="multipart/form-data">
					<span id="updateBoardGroup">To.
					${postvo.boardvo.boardName}
					</span>
					<div style="padding:var(--size22);">
						<table style="width: 100%;">
							<tr>
								<td style="width: 95px;">제목</td>
								<td><input type="text" name="subject" id="subject"value="${postvo.subject}"></td>
							</tr>
							<tr>
								<td>파일첨부</td>
								<td>
									<div id="update_fileDrop" class="fileDrop"><%-- class="fileDrop border border-secondary" --%>
										<p style="text-align: center;">이 곳에 파일을 드래그 하세요.</p>
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
							     <td style="width: 767px;">
							 	    <textarea name="content" id="updateContent" rows="10" cols="100" style="width: 100%;height:450px;">${postvo.content}</textarea>
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
						  		<td>공지 유무</td>
						  		<td>
						  			<input type="checkbox" id="update_isnotice" name="isNotice" value=1 ${postvo.isNotice eq 1 ? 'checked' : ''}>
									<label for="update_isnotice" style="margin:0;">클릭 시 선택</label>
									<span id="updatePostBtnElmt">
										<button type="button" id="updatePostBtn" class="btnDefaultDesignNone"><i class="fa-solid fa-pencil"></i> 수정</button>
									</span>
									<div id="update_isNoticeElmt"> <!-- 미체크시 hide 상태임 -->
										<input type="text" name="startNotice" id="update_datepicker" maxlength="10" autocomplete='off' size="4" readonly/> 
										-
										<input type="text" name="noticeEndDate" id="update_toDate" maxlength="10" autocomplete='off' size="4" readonly/>
									</div> 
						  		</td>
						  	</tr>
						</table>
					</div>
					
				</form>
			</div>
		</div>
    </div> <!-- end of <div class="modal_container"> -->
    <!-- 글작성 폼 -->

	<!-- 오른쪽 바 -->
    <div id="right_bar">
        <div id="right_title_box">
            <a href="<%=ctxpath%>/board/selectPostBoardGroupView?boardNo=${postvo.fk_boardNo}" id="right_title_a">
            	<span id="right_title">${postvo.boardvo.boardName}</span>
            </a> 
			<span id="boardMaster">운영 : ${postvo.boardvo.createdBy}</span>
            <!-- 오른쪽 바 메뉴버튼들입니다! -->
            
            <div id="right_menu_container">
            
            
            	<span id="tool_box_left">
                   <c:if test="${postvo.fk_employeeNo eq login_userid}"> <%-- 글 작성자사번과 로그인 사번이 같다면 수정/삭제 렌더링 --%>
						<span id="re_btn">
                           <button type="button" id="postUpdate" class="btnDefaultDesignNone" ><i class="fa-regular fa-pen-to-square"></i> 수정</button>
                        </span>
                        <span>
                           <button type="button" id="postDel" class="btnDefaultDesignNone"><i class="fa-regular fa-trash-can"></i>삭제</button>
                        </span>
					</c:if>     
                </span>
	                

                <span id="tool_box_right">
                    <span>
                    <span id="preOrNextBtn">
                    <c:if test="${postvo.previouspostNo ne null}">
                        <span id="re_btn">
                            <button type="button" onclick="goView('${postvo.previouspostNo}')" class="btnDefaultDesignNone"><i class="fa-solid fa-caret-left"></i>이전</button>
                        </span>
                    </c:if>   
                    <c:if test="${postvo.nextpostNo ne null}"> 
                        <span id="sortCnt_btn">
                            <button type="button" onclick="goView('${postvo.nextpostNo}')" class="btnDefaultDesignNone">다음<i class="fa-solid fa-caret-right"></i></button> 
                        </span>
                    </c:if>  
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
		       		<span id="postCommentCount"><%-- ajax를 통하여 댓글 개수가 렌더링 됨 --%></span>
	       		</div>
	       		<div id="likeBtn">
		       		<c:if test="${likeCnt == 1}"> <%-- 좋아요를 한 상태--%>
		       			<button type="button" id="postLitkBtn" class="btnDefaultDesignNone"><i class='fa-solid fa-heart' id='heartIcon'></i></button>
		       		</c:if>
		       		<c:if test="${likeCnt == 0}"> <%-- 좋아요를 하지않은 상태--%>
		       			<button type="button" id="postLitkBtn" class="btnDefaultDesignNone"><i class='fa-regular fa-heart' id='heartIcon'></i></button>
		       		</c:if>
		       		<div id="likeCount">${postvo.likeCount}</div><%-- 좋아요 개수 --%>
	       		</div> <%-- 좋아요 버튼 --%>
	       		
       		</div>
       		<div>
       			<span id="postCreatBy">${postvo.name} ${postvo.positionName}</span>
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
        	<i class="fa-regular fa-comment" style="font-size: 12px;"></i> 
        	<span class="tranBlock" id="commentCount"><%-- 댓글의 개 수가 ajax를 통해 렌더링 됨 --%></span>
        	<span class="tranBlock"><i class="fa-regular fa-eye"></i> 조회 ${postvo.readCount}</span>
        	<span class="tranBlock" id="likeListElmt"><i class="fa-regular fa-heart" ></i> 좋아요 누른 사람 <span id="span_likeCount">${postvo.likeCount}</span>명</span>
        	<!-- 모달 -->
			<div id="likeModal" class="modal">
			    <div class="modal-content">
			        <span>좋아요 누른 사람 목록</span>
		            <!-- 좋아요 누른 사람 목록이 동적으로 추가될 공간 -->
			        <table id="likeUserList">
			        </table>
		        	<span class="close">확인</span>
			    </div>
			</div>
			<!-- 모달 -->
        </div>
        <div id="commentListElmt">
	        <%-- ajax로 페이지가 로드 될 때 댓글 목록이 같이 조회되는 공간 --%>
        </div>
        
        <%-- 댓글 작성 시 ajax로 서버에 넘김 --%>
		<input type="hidden" name="name" value="이상우"/><%-- 로그인한 사원명이 됨. 추후 수정 --%>
		<c:if test="${postvo.allowComments == 1}"> <%-- 댓글이 허용이라면 댓글입력 요소를 보여줌. --%>
	        <div id="commentCreate" class="padding">
	        	<span id="profile"> <%-- 이 곳은 로그인된 사원의 프로필이 들어올 자리 --%>
	        	<c:if test="${login_fileName != null}">
	        		<img src='/flowUp/resources/files/${login_fileName}' width='32' height='32' style="border-radius: 50%;"/>
	        	</c:if>
	        	<c:if test="${login_fileName == null}">
	        		<i class="fa-solid fa-user"></i>
	        	</c:if> 
	        	 </span>
	        	<div id="commentEdit">
	        		<input type="text" name="content" id="commentContent" placeholder="댓글을 남겨보세요" autocomplete='off'>
	        		<div id="commentBottom">
	        			<button id="commentEnterBtn" class="btnDefaultDesignNone">등록</button>
	        		</div>
	        	</div>
	        </div>
        </c:if>
        <%-- 댓글 작성 시 ajax로 서버에 넘김 --%>
        
       	<table id="preoOrNextPostElmt">
        	<c:if test="${postvo.previouspostNo ne null}">
        		<tr class="onePostInfoElmt">
	        		<td>글</td>
	        		<td>제목</td>
	        		<td>작성자</td>
	        		<td>작성일</td>
	        		<td>조회</td>
	        		<td>좋아요</td>
        		</tr>
        		<tr class="onePostElmt" onclick="goView('${postvo.previouspostNo}')">
        			<td>이전글</td>
        			<td>${postvo.previoussubject}</td>
        			<td>${postvo.previousname}</td>
        			<td>${postvo.previousregDate}</td>
        			<td>${postvo.previousreadCount}</td>
					<td>${postvo.previouslikeCount}</td>
        		</tr>
        	</c:if>	
        		<tr class="onePostElmt" id="currentPost" style="background-color: #f2f2f2; ">
        			<td> <span class="currentPost"><i class="fa-solid fa-angles-right"></i> 현재글</span></td>
        			<td><span class="currentPost">${postvo.subject}</span></td>
        			<td><span class="currentPost">${postvo.name}</span></td>
        			<td><span class="currentPost">${postvo.regDate}</span></td>
        			<td>${postvo.readCount}</td>
					<td id="td_likeCnt">${postvo.likeCount}</td>
        		</tr>
        	<c:if test="${postvo.nextpostNo ne null}">	
        		<tr class="onePostElmt" onclick="goView('${postvo.nextpostNo}')">
        			<td>다음글</td>
        			<td>${postvo.nextsubject}</td>
        			<td>${postvo.name}</td>
        			<td>${postvo.nextregDate}</td>
        			<td>${postvo.nextreadCount}</td>
					<td>${postvo.nextlikeCount}</td>
        		</tr>
        	</c:if>		
       	</table>
	     <div id="noticeEndDate" style="display: none;">${postvo.noticeEndDate}</div>   
	     
		<form name="postFrm">
			<div>
			  <input type="hidden" name="postNo" value="${postvo.postNo}"><br> 
			  <input type="hidden" name="goBackURL" value="<%= request.getAttribute("goBackURL") %>"/><br>
			  <input type="hidden" name="checkAll_or_boardGroup" value="${checkAll_or_boardGroup}"> <%-- 전체 or 게시판별 게시글 구분 번호  --%><br>
			  <input type="hidden" name="boardNo" value="${postvo.fk_boardNo}"> <%-- 필요한 것임 지우지말 것 --%><br>
			  <span id="login_userid" style="display: none">${login_userid}</span><br><%-- 로그인 사원번호 :  --%>
			</div>
		</form>
		
		<%-- 이전글제목 보기, 다음글제목 보기시 POST 방식으로 넘기기 위한것 --%>
		<form name="postFrm_2">
			<input type="hidden" name="postNo" />
			<input type="hidden" name="goBackURL" />
			<input type="hidden" name="fk_boardNo" value="${postvo.fk_boardNo}"/>
			<input type="hidden" name="checkAll_or_boardGroup" value="${checkAll_or_boardGroup}"> 
		</form>
		
		<span style="display: none">
			공지글 여부 : ${postvo.isNotice}<br>
			공지글 종료일 : ${postvo.noticeEndDate}<br>
			작성자 번호 : <span id="fk_employeeNo">${postvo.fk_employeeNo}</span><%-- $(document).on("click", "#commentEnterBtn", function(){})에서 사용 --%><br>
			댓글 허용 여부 : <span id="allowComments">${postvo.allowComments}</span> <%-- loadComment()에서 사용 --%><br>
			로그인 사원번호 : <span id="login_userid">${login_userid}</span><%-- addReply()에서 사용 --%><br>
			로그인 사원이름 : <span id="login_name">${login_name}</span><%-- addReply()에서 사용 --%><br>
			로그인 사원 프로필 이미지 : <span id="login_fileName">${login_fileName}</span><br> <%-- loadComment(postNo, page = 1,reload)에서 사용 --%>
			좋아요 여부 : ${likeCnt}<br>
		</span>

</div>




<jsp:include page="../../footer/footer.jsp" /> 