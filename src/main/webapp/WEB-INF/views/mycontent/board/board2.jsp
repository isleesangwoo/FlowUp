<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%
   String ctxPath = request.getContextPath();
%>      
<%-- 각자 페이지에 해당되는 css 연결 --%>
<link href="<%=ctxPath%>/css/board/board_main2.css" rel="stylesheet"> 

<style>

.onePostElmt.tbodyTr:nth-child(even){
	background-color: rgba(242, 247, 253, 0.5);
}

</style>

<script>
	var ctxPath = "<%= request.getContextPath() %>";
	const goBackURL = "<%= request.getAttribute("goBackURL") %>";
</script>
<%-- 각자 페이지에 해당되는 js 연결 --%>
<script src="<%=ctxPath%>/js/board/board2.js"></script>


	<%-- 이곳에 각 해당되는 뷰 페이지를 작성해주세요 --%>
	

    <!-- 오른쪽 바 -->
    <div >
        
        
        <%-- 이곳에 각 해당되는 뷰 페이지를 작성 시작 --%>
		<div id="postContainer"> <!-- 게시글 보여주는 요소 전체 박스-->
			<div style="width:100%;">
			 
			 	<div id="allPostElmt">
					
						
					
				</div>
				<%-- === 페이지바 보여주기 === --%>
			    <div id="pageBar" align="center" style="border: solid 0px gray; width: 80%; margin: 30px auto;">
			    	
			    </div>
			  
			  
			</div>
			
		</div>
		<%-- 이곳에 각 해당되는 뷰 페이지를 작성 끝 --%>
        
    </div>
    <!-- 오른쪽 바 -->

<!-- onClick="goView" 로 클린된 함수에 폼을 같이 넘겨주기위함. 함수에서 폼의 input에 값을 넣어줌.-->    
<form name="goViewFrm">
   <input type="hidden" name="postNo" />
   <input type="hidden" name="goBackURL" />
</form>	     
    
<span id="login_userid" style="display: none;">${sessionScope.loginuser.employeeNo}</span>	<%-- 필요한 것 --%>
	
	
	
	
	
	
	
	
	
	
	
<script>
goViewBoard(1);

function goViewBoard(currentShowPageNo) {
	
	$.ajax({
		url:"<%= ctxPath%>/board/boardOfMain",
		data:{"currentShowPageNo":currentShowPageNo},
		dataType:"json",
		success:function(json) {
			console.log(JSON.stringify(json));
			
			$('#allPostElmt').empty();
			
			let v_html = ``;
			
			if(json.length > 0) {
				$.each(json, function(index, item){
					const sunbun = json.length - (currentShowPageNo - 1) * 5 - index
					
					//{"postNo":"100201","fk_boardNo":"100035","fk_employeeNo":"100013","name":"이상우","subject":"부춘게시판 제 14"
					//,"content":"<p>부춘게시판 제 14부춘게시판 제 14부춘게시판 제 14부춘게시판 제 14부춘게시판 제 14부춘게시판 제 14부춘게시판 제 14부춘게시판 제 14<img src=\"/flowUp/board_resources/photo_upload/2025030217381515192103605600.png\" title=\"2025030217381515192103605600.png\">&nbsp;</p>"
					//,"readCount":"2","regDate":"2025-03-02 17:38:16","commentCount":"0","allowComments":"1","status":null
					//,"isNotice":"0","noticeEndDate":null,"likeCount":"0","previouspostNo":null,"previoussubject":null
					//,"previousname":null,"previousregDate":null,"previousreadCount":null,"previouslikeCount":null,"nextpostNo":null
					//,"nextsubject":null,"nextname":null,"nextregDate":null,"nextreadCount":null,"nextlikeCount":null
					//,"currentDate":"2025-03-16 04:17:46","profileImg":null,"positionName":"상무","liked":false,"login_userid":null
					//,"login_userName":null,"fileName":null,"boardvo":null,"postfilevo":null}
					
					
					v_html += `
					<div class="onePostElmt">
						<div style="display: flex; justify-content: space-between;">
							<div class="article_wrap">
								<span class="postBoard">\${item.boardvo.boardName}</span>
								<span onclick="goView('\${item.postNo}')">
									<span class="postSubject">\${item.subject}</span><span class="postCommentCount"><i class="fa-regular fa-comment"></i> \${item.commentCount}</span>
									<span class="postContent">\${item.content}</span>
								</span>
							</div>
							<div>
							
								<div class="likeBtn" onclick="goLike.call(this, '\${item.postNo}','\${item.fk_employeeNo}', '\${currentShowPageNo}')"><i class="`;
								
								if(item.liked){
									v_html += `fa-solid`;
								}
								else {
									v_html += `fa-regular`;
								}
					v_html +=	` fa-heart"></i></div>
								<div class="likeCount">\${item.likeCount}</div><%-- 좋아요 --%>
							
							</div>
						</div>
						
						
						<span id="profileImg">`
							
						if(item.fileName == null) {
							v_html += `<i class="fa-solid fa-user"></i>`;
						}
						else{
							v_html += `<span><img src='/flowUp/resources/files/\${item.fileName}' width='32' height='32'/></span>`;
						}
						
					v_html +=`</span>
						<span class="postCreateBy">\${item.name} \${item.positionName}</span>
						<span class="postCreateAt">\${item.regDate}</span>
					</div>
					`;
					
					
					
					
				}); // end of $.each(json, function(index, item){})--------------
				
				// === #128. 페이지바 함수 호출 === //
				const totalPage = Math.ceil( 30 / 5 );
				console.log("totalPage : ", totalPage);
				
				makeCommentPageBar(currentShowPageNo, totalPage);
				
			}
			else {
				v_html += `<div style="width:100%; height:100%; justify-content:center; font-size:14px; color: #999; text-align: center; display:flex; align-items:center;">
								<div >
									<p style="margin-bottom:0px;">현재 게시물이 없습니다.</p>
									<p>게시물을 작성하여 다른 사람들과 소통해보세요!</p>
									<div style="margin:auto; justify-content:center; display:flex; align-items:center;" class="writePostBtn">
										<a style="color:#fff; font-size:14px;" href="<%= ctxPath%>/board/">작성하기</a>
									</div>
								</div>
						   </div>
						  
						   `;
			}
			
			
			$('#allPostElmt').append(v_html);
			
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}	
	})
	
} // end of function goViewComment(currentShowPageNo) {}---------------------------------------------------




<%-- === #125. 페이지바 함수 만들기 === --%>
function makeCommentPageBar(currentShowPageNo, totalPage) {
	
	const blockSize = 10;
	// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수이다.
	
	let loop = 1;
	/*
		loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
	*/
	
	let pageNo = Math.floor((currentShowPageNo - 1)/blockSize) * blockSize + 1;
	// *** !! 공식이다. !! *** //
      
	
	let pageBar_HTML = "<ul style='list-style:none;'>";
	
	// === [맨처음][이전] 만들기 === //
	pageBar_HTML += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='javascript:goViewBoard(1)'><i style='transform: scaleX(-1)' class=\'fa-solid fa-forward-step\'></i></a></li>";
	
	if(pageNo != 1) {
		pageBar_HTML += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='javascript:goViewBoard("+(pageNo-1)+")'><i class=\"fa-solid fa-chevron-left\"></i></a></li>"; 
	}

	while( !(loop > blockSize || pageNo > totalPage) ) {
		if(pageNo == currentShowPageNo) {
			pageBar_HTML += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; padding:2px 4px;'>"+pageNo+"</li>";
		}
		else {
			pageBar_HTML += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='javascript:goViewBoard("+pageNo+")'>"+pageNo+"</a></li>"; 
		}
		loop++;
		pageNo++;
	}// end of while------------------------

	// === [다음][마지막] 만들기 === //
	if(pageNo <= totalPage) {
		pageBar_HTML += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='javascript:goViewBoard("+pageNo+")'><i class=\"fa-solid fa-chevron-right\"></i></a></li>";
	}
	
	pageBar_HTML += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='javascript:goViewBoard("+totalPage+")'><i class=\"fa-solid fa-forward-step\"></i></a></li>"; 

	pageBar_HTML += "</ul>";
	
	
	<%-- === #127. 댓글 페이지바 출력하기 === --%>
	$("div#pageBar").html(pageBar_HTML);

} // end of function makeCommentPageBar(currentShowPageNo, totalPage)--------------------------------



</script>
	
	
	
