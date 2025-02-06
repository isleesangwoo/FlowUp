<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	String ctxPath = request.getContextPath();
	//     /myspring
%>

<jsp:include page="../../header/header1.jsp" />

<style type="text/css">
   
	span.move  {cursor: pointer; color: navy;}
	.moveColor {color: #660029; font-weight: bold; background-color: #ffffe6;}

	td.comment {text-align: center;}

	a {text-decoration: none !important;}
	
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
	//	goReadComment(); // 페이징 처리 안한 댓글 읽어오기
		
		// === #116. Ajax 로 불러운 댓글내용들을 페이징 처리하기 === //
		goViewComment(1); // 페이징 처리한 댓글 읽어오기
	
		$("span.move").hover(function(e){
			$(e.target).addClass("moveColor");
		}, function(e){
			$(e.target).removeClass("moveColor");  
		});
		
		$("input:text[name='content']").bind("keydown", function(e){
			if(e.keyCode == 13) { // 엔터
				goAddWrite();
			}
			
		});
		
		
		// === 댓글 수정 === //
		let origin_comment_content = "";
		
		$(document).on('click', 'button.btnUpdateComment', function(e){
			
			const $btn = $(e.target);
			// 관습상 변수가 아닌 엘리먼트라면 변수명 앞에 $를 붙인다.(서영학 강사님 스타일)
			
			if( $btn.text() == "수정" ) {
				// alert("댓글수정");
				// 	alert($btn.parent().parent().find("td:nth-child(2)").text()) // 수정 전 댓글내용
				const $content = $btn.parent().parent().find("td:nth-child(2)");
				origin_comment_content = $content.text();
				
				$content.html(`<input id='comment_update' type='text' value='\${origin_comment_content}' size='40' />`); // 댓글내용을 수정할 수 있도록 input 태그를 만들어 준다.
				$btn.text("완료").removeClass("btn-secondary").addClass("btn-info");
				$btn.next().text("취소").removeClass("btn-secondary").addClass("btn-danger");
				
				$(document).on("keyup", "input#comment_update", function(e){
					if(e.keyCode == 13) {
						// alert($btn.text()); // "완료"
						$btn.click();
					}
				});
			}
			else if($btn.text() == "완료") {
				// alert("댓글수정완료");
				// alert($btn.val());	// 수정해야할 댓글시퀀스 번호
				// alert($btn.parent().parent().children("td:nth-child(2)").children("input").val()); // 수정후 댓글 내용
				const content = $btn.parent().parent().children("td:nth-child(2)").children("input").val();
				
				$.ajax({
					url:"${pageContext.request.contextPath}/board/updateComment",
					type:"put",
					data:{
						"seq":$btn.val(),
						"content":content
					},
					dataType:"json",
					success:function(json){
						console.log(JSON.stringify(json));
						// {"n":1}
						
						if(json.n == 1) {
							// goReadComment(); // 페이징 처리 안한 댓글 읽어오기
							goViewComment(1);
						}
						
						$btn.text("수정").removeClass("btn-info").addClass("btn-secondary");
						$btn.next().text("삭제").removeClass("btn-danger").addClass("btn-secondary");
						
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
			}
			
		}); // end of $(document).on('click', 'button.btnUpdateComment', function(e){})---------------------------
		
		
		// === 댓글수정취소 / 댓글 삭제 === //
		$(document).on('click', 'button.btnDeleteComment', function(e){
			
			const $btn = $(e.target);
			
			if( $btn.text() == "취소" ) {
				// alert("댓글수정취소");
				
				// alert( $btn.parent().parent().children("td:nth-child(2)").html() );
				// <input id="comment_update" type="text" value="다섯번째 댓글1111" size="40">
				
				const $content = $btn.parent().parent().children("td:nth-child(2)");
				$content.html(`\${origin_comment_content}`);
				
				$btn.prev().text("수정").removeClass("btn-info").addClass("btn-secondary");
				$btn.text("삭제").removeClass("btn-danger").addClass("btn-secondary");
			}
			
			else if($btn.text() == "삭제") {
				// alert("댓글삭제");
				alert($btn.val());	// 삭제해야할 댓글시퀀스 번호
				
				if(confirm("정말로 삭제하시겠습니까?")) {
					
					$.ajax({
						url:"${pageContext.request.contextPath}/board/deleteComment",
						type:"delete",
						data:{
							"seq":$btn.val(),
							"parentSeq":"${requestScope.boardvo.seq}"
						},
						dataType:"json",
						success:function(json){
							console.log(JSON.stringify(json));
							// {"n":1}
							
							if(json.n == 1) {
								// goReadComment(); // 페이징 처리 안한 댓글 읽어오기
								goViewComment(1);
							}
						},
						error: function(request, status, error){
							alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						}
					});
				}
			}
			
		}); // end of $(document).on('click', 'button.btnDeleteComment', function(e){})------------------------------
		
		
	}); // end of $(document).ready(function(){})-------------------------
	
	
	// Function Declaration
	
	// === #42. 이전글제목, 다음글제목 보기 === //
	function goView(seq) {
		
	<%--
		location.href = `<%= ctxPath%>/board/view?seq=\${seq}`;
	--%>
		
		// === #110. 이전글제목, 다음글제목 을 클릭해주면 목록보기에서 글제목을 클릭했을 때와 동일하게 POST 방식으로 전송해주어야 한다.
		// 먼저 위의 location.href 을 주석처리 한 이후에 아래처럼 한다.
		
		const goBackURL = "${requestScope.goBackURL}";
		// console.log(goBackURL);
		// /board/list?searchType=subject&searchWord=%EC%9E%85%EB%8B%88%EB%8B%A4&currentShowPageNo=7
		
	<%--
		아래처럼 get 방식으로 보내면 안된다. 왜나하면 get 방식에서는 &는 데이터의 구분자로 사용되기 때문이다.!!!!
		그래서 BoardController의 @GetMapping("view")에 가서 @RequestParam String goBackURL 에 저장된 값을 꺼내보면
		/board/list?searchType=subject&searchWord=입니다&currentShowPageNo=7 와 같이 나오지 않고
		/board/list?searchType=subject 만 나온다.
		그래서 보내줄 데이터에 & 가 들어가 있는 경우라면 get 방식이 아닌 post 방식으로 전달해주어야 한다.
	--%>

	<%--
		그러므로 데이터의 구분자로 사용하지 않고 글자 그대로 인식하도록 하기 위해 post 방식으로 보내야 한다.
		아래의 본문에 #105 에 표기된 form 태그를 먼저 만든다.
	--%>
		const frm = document.goViewFrm;
		frm.seq.value = seq;
		frm.goBackURL.value = goBackURL;
		
		// BoardController defaultValue를 "" 으로 주었으므로 
		// BoardController 에서 넘어온 searchType 이 "" 이 아니면 검색한 타입이 있는것이다
		
		if(${not empty requestScope.paraMap }) { // 검색조건이 있을 경우
			frm.searchType.value = "${requestScope.paraMap.searchType}";
			frm.searchWord.value = "${requestScope.paraMap.searchWord}";
		}
		
		frm.method = "post",
		<%-- frm.action = "<%= ctxPath%>/board/view"; --%>
		
		<%-- === #113. 이전글제목보기, 다음글제목보기를 할 때 글조회수 증가를 하기 위한 것이다. === --%>
		frm.action = "<%= ctxPath%>/board/view_2";
		frm.submit();
		
	} // end of function goView(seq)--------------------------------------------------------
	
	
	// === 댓글쓰기 === //
	function goAddWrite() {
		
		// 내용 유효성 검사
		const comment_content = $("input:text[name='content']").val().trim();
		if (comment_content == "") {
			alert("댓글 내용을 입력하세요!!");
			return; // 종료
		}
		
		// 첨부파일이 없는 댓글 쓰기
		goAddWrite_noAttach();
		
	} // end of function goAddWrite()-------------------------------------------
	
	
	// 첨부파일이 없는 댓글 쓰기
	function goAddWrite_noAttach() {
		
		<%--
			// 보내야할 데이터를 선정하는 또 다른 방법
			// jQuery에서 사용하는 것으로써,
			// form태그의 선택자.serialize(); 을 해주면 form 태그내의 모든 값들을 name값을 키값으로 만들어서 보내준다. 
			const queryString = $("form[name='addWriteFrm']").serialize();
		--%>		
		
		const queryString = $("form[name='addWriteFrm']").serialize();
		// alert(queryString);
		/*
			fk_userid=kimsh&name=김성훈&content=댓글쓰기내용&parentSeq=3
		*/
		
		$.ajax({
			url:"<%= ctxPath%>/board/addComment",
			/*
				data:{
					"fk_userid":$("input:hidden[name='fk_userid']").val(),
					"name":$("input:text[name='name']").val(),
					"content":$("input:text[name='content']").val(),
					"parentSeq":$("input:hidden[name='parentSeq']").val()
				}
			*/
			// 또는
			data:queryString,
			type:"post",
			dataType:"json",
			success:function(json) {
				console.log(JSON.stringify(json));
				// {"name":"김성훈","n":1}
				// 또는
				// {"name":"김성훈","n":0}
				
				if(json.n == 0) {
					alert(json.name + "님의 포인트는 300점을 초과할 수 없으므로 댓글쓰기가 불가합니다.");
				}
				else {
				//	goReadComment(); // 페이징 처리 안한 댓글 읽어오기
					
					// === #129. 페이징 처리 한 댓글 읽어오기 === //
					goViewComment(1);
				}
				
				$("input:text[name='content']").val("");
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		})
		
	} // end of function goAddWrite_noAttach()-----------------------------------
	
	
	// 페이징 처리 안한 댓글 읽어오기
	function goReadComment() {
		
		$.ajax({
			url:"<%= ctxPath%>/board/readComment",
			data:{"parentSeq":"${requestScope.boardvo.seq}"},
			dataType:"json",
			success:function(json) {
				console.log(JSON.stringify(json));
				/*
					[{"seq":"6","fk_userid":"kimsh","name":"김성훈","content":"리스트","regDate":"2025-01-24 11:39:14","parentSeq":null,"status":null}
					,{"seq":"5","fk_userid":"kimsh","name":"김성훈","content":"dd","regDate":"2025-01-24 10:55:47","parentSeq":null,"status":null}
					,{"seq":"4","fk_userid":"kimsh","name":"김성훈","content":"dd","regDate":"2025-01-24 10:55:00","parentSeq":null,"status":null}
					,{"seq":"3","fk_userid":"kimsh","name":"김성훈","content":"dd","regDate":"2025-01-24 10:54:44","parentSeq":null,"status":null}
					,{"seq":"2","fk_userid":"kimsh","name":"김성훈","content":"ㅇㅇ","regDate":"2025-01-24 10:53:41","parentSeq":null,"status":null}
					,{"seq":"1","fk_userid":"kimsh","name":"김성훈","content":"ㅇㅇ","regDate":"2025-01-24 10:53:02","parentSeq":null,"status":null}]
			
					// 또는
					[]
				*/
				
				let v_html = ``;
				if(json.length > 0) {
					$.each(json, function(index, item){
						v_html += `<tr>
									<td>\${index+1}</td>
									<td>\${item.content}</td>
									<td class='comment'>\${item.name}</td>
									<td class='comment'>\${item.regDate}</td>`;
									
						if( ${sessionScope.loginuser != null } &&
							"${sessionScope.loginuser.userid}" == item.fk_userid ) {
							v_html += `<td class='comment'>
										<button type='button' class='btn btn-secondary btn-sm btnUpdateComment' value='\${item.seq}'>수정</button>&nbsp;<button type='button' class='btn btn-secondary btn-sm btnDeleteComment' value='\${item.seq}'>삭제</button>&nbsp;
										</td>`;
						}
						
						else {
							v_html += `<td>&nbsp;</td>`;
						}
						
						v_html += `</tr>`;
						
					});
				}
				else {
					v_html = `<tr>
								<td colspan="4">댓글이 없습니다</td>
							</tr>`;
				}
				
				$("tbody#commentDisplay").html(v_html);
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}	
		})
		
	} // end of function goReadComment()------------------------------------------
	
	
	// === #117. Ajax 로 불러운 댓글내용들을 페이징 처리하기 === //
	function goViewComment(currentShowPageNo) {
		
		$.ajax({
			url:"<%= ctxPath%>/board/commentList",
			data:{"parentSeq":"${requestScope.boardvo.seq}"
				 ,"currentShowPageNo":currentShowPageNo},
			dataType:"json",
			success:function(json) {
				console.log(JSON.stringify(json));
				/*
					[{"name":"김성훈","regDate":"2025-02-05 10:43:22","totalCount":100,"sizePerPage":3,"fk_userid":"kimsh","seq":"121","content":"댓글연습 99"}
					,{"name":"김성훈","regDate":"2025-02-05 10:43:21","totalCount":100,"sizePerPage":3,"fk_userid":"kimsh","seq":"120","content":"댓글연습 98"}
					,{"name":"김성훈","regDate":"2025-02-05 10:43:21","totalCount":100,"sizePerPage":3,"fk_userid":"kimsh","seq":"119","content":"댓글연습 97"}]
			
					// 또는
					[]
				*/
				
				let v_html = ``;
				if(json.length > 0) {
					$.each(json, function(index, item){
						const sunbun = item.totalCount - (currentShowPageNo - 1) * item.sizePerPage - index
						<%--
							>>> 페이징 처리시 보여주는 순번 공식 <<<
							데이터개수 - (페이지번호 - 1) * 1페이지당보여줄개수 - 인덱스번호 => 순번 
							
							<예제>
							데이터개수 : 12
							1페이지당보여줄개수 : 5
							
							==> 1 페이지       
							12 - (1-1) * 5 - 0  => 12
							12 - (1-1) * 5 - 1  => 11
							12 - (1-1) * 5 - 2  => 10
							12 - (1-1) * 5 - 3  =>  9
							12 - (1-1) * 5 - 4  =>  8
							
							==> 2 페이지
							12 - (2-1) * 5 - 0  =>  7
							12 - (2-1) * 5 - 1  =>  6
							12 - (2-1) * 5 - 2  =>  5
							12 - (2-1) * 5 - 3  =>  4
							12 - (2-1) * 5 - 4  =>  3
							
							==> 3 페이지
							12 - (3-1) * 5 - 0  =>  2
							12 - (3-1) * 5 - 1  =>  1 
						--%>
							
						v_html += `<tr>
									<td>\${sunbun}</td>
									<td>\${item.content}</td>
									<td class='comment'>\${item.name}</td>
									<td class='comment'>\${item.regDate}</td>`;
									
						if( ${sessionScope.loginuser != null } &&
							"${sessionScope.loginuser.userid}" == item.fk_userid ) {
							v_html += `<td class='comment'>
										<button type='button' class='btn btn-secondary btn-sm btnUpdateComment' value='\${item.seq}'>수정</button>&nbsp;<button type='button' class='btn btn-secondary btn-sm btnDeleteComment' value='\${item.seq}'>삭제</button>&nbsp;
										</td>`;
						}
						
						else {
							v_html += `<td>&nbsp;</td>`;
						}
						
						v_html += `</tr>`;
						
					});
					
					// === #128. 페이지바 함수 호출 === //
					const totalPage = Math.ceil( json[0].totalCount / json[0].sizePerPage );
					console.log("totalPage : ", totalPage);
					
					makeCommentPageBar(currentShowPageNo, totalPage);
				}
				else {
					v_html = `<tr>
								<td colspan="4">댓글이 없습니다</td>
							</tr>`;
				}
				
				$("tbody#commentDisplay").html(v_html);
				
				
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
		/*
						  1  2  3  4  5  6  7  8  9 10 [다음][마지막]  -- 1개블럭
			[맨처음][이전]  11 12 13 14 15 16 17 18 19 20 [다음][마지막]  -- 1개블럭
			[맨처음][이전]  21 22 23
		*/
		
		let loop = 1;
		/*
			loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
		*/
		
		let pageNo = Math.floor((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		// *** !! 공식이다. !! *** //
	      
		/*
			currentShowPageNo 가 3페이지 이라면 pageNo 는 1 이 되어야 한다.
			((3 - 1)/10) * 10 + 1;
			( 2/10 ) * 10 + 1;
			( 0.2 ) * 10 + 1;
	      
			Math.floor( 0.2 ) * 10 + 1;  // 소수부가 있을시 Math.floor(0.2) 은 0.2 보다 작은 최대의 정수인 0을 나타낸다.
			0 * 10 + 1 
			1

			currentShowPageNo 가 11페이지 이라면 pageNo 는 11 이 되어야 한다.
			((11 - 1)/10) * 10 + 1;
			( 10/10 ) * 10 + 1;
			( 1 ) * 10 + 1;
			Math.floor( 1 ) * 10 + 1;  // 소수부가 없을시 Math.floor(1) 은 그대로 1 이다.
			1 * 10 + 1
			11

			currentShowPageNo 가 20페이지 이라면 pageNo 는 11 이 되어야 한다.
			((20 - 1)/10) * 10 + 1;
			( 19/10 ) * 10 + 1;
			( 1.9 ) * 10 + 1;
			Math.floor( 1.9 ) * 10 + 1;  // 소수부가 있을시 Math.floor(1.9) 은 1.9 보다 작은 최대의 정수인 1을 나타낸다.
			1 * 10 + 1
			11

			1  2  3  4  5  6  7  8  9  10  -- 첫번째 블럭의 페이지번호 시작값(pageNo)은 1 이다.
			11 12 13 14 15 16 17 18 19 20  -- 두번째 블럭의 페이지번호 시작값(pageNo)은 11 이다.
			21 22 23 24 25 26 27 28 29 30  -- 세번째 블럭의 페이지번호 시작값(pageNo)은 21 이다.

			currentShowPageNo         pageNo
			----------------------------------
			1                      1 = Math.floor((1 - 1)/10) * 10 + 1
			2                      1 = Math.floor((2 - 1)/10) * 10 + 1
			3                      1 = Math.floor((3 - 1)/10) * 10 + 1
			4                      1
			5                      1
			6                      1
			7                      1 
			8                      1
			9                      1
			10                     1 = Math.floor((10 - 1)/10) * 10 + 1

			11                    11 = Math.floor((11 - 1)/10) * 10 + 1
			12                    11 = Math.floor((12 - 1)/10) * 10 + 1
			13                    11 = Math.floor((13 - 1)/10) * 10 + 1
			14                    11
			15                    11
			16                    11
			17                    11
			18                    11 
			19                    11 
			20                    11 = Math.floor((20 - 1)/10) * 10 + 1

			21                    21 = Math.floor((21 - 1)/10) * 10 + 1
			22                    21 = Math.floor((22 - 1)/10) * 10 + 1
			23                    21 = Math.floor((23 - 1)/10) * 10 + 1
			..                    ..
			29                    21
			30                    21 = Math.floor((30 - 1)/10) * 10 + 1       
		*/
		
		let pageBar_HTML = "<ul style='list-style:none;'>";
		
		// === [맨처음][이전] 만들기 === //
		pageBar_HTML += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='javascript:goViewComment(1)'>[맨처음]</a></li>";
		
		if(pageNo != 1) {
			pageBar_HTML += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='javascript:goViewComment("+(pageNo-1)+")'>[이전]</a></li>"; 
		}

		while( !(loop > blockSize || pageNo > totalPage) ) {
			if(pageNo == currentShowPageNo) {
				pageBar_HTML += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";
			}
			else {
				pageBar_HTML += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='javascript:goViewComment("+pageNo+")'>"+pageNo+"</a></li>"; 
			}
			loop++;
			pageNo++;
		}// end of while------------------------

		// === [다음][마지막] 만들기 === //
		if(pageNo <= totalPage) {
			pageBar_HTML += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='javascript:goViewComment("+pageNo+")'>[다음]</a></li>";
		}
		
		pageBar_HTML += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='javascript:goViewComment("+totalPage+")'>[마지막]</a></li>"; 

		pageBar_HTML += "</ul>";
		
		
		<%-- === #127. 댓글 페이지바 출력하기 === --%>
		$("div#pageBar").html(pageBar_HTML);

	} // end of function makeCommentPageBar(currentShowPageNo, totalPage)--------------------------------
	
	


	
	
	
</script>

<div style="display: flex;">
 	<div style="margin: auto; padding-left: 3%;">

		<h2 style="margin-bottom: 30px;">글내용보기</h2>
		
		<c:if test="${not empty requestScope.boardvo}">
			<table class="table table-bordered table-dark" style="width: 1024px; word-wrap: break-word; table-layout: fixed;">
				<tr>
					<th style="width: 15%">글번호</th>
					<td>${requestScope.boardvo.seq}</td>
				</tr>
				<tr>
					<th>성명</th>
					<td>${requestScope.boardvo.name}</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>${requestScope.boardvo.subject}</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<p style="word-break: break-all;">
						${requestScope.boardvo.content}
						<%-- 
							style="word-break: break-all; 은 공백없는 긴영문일 경우 width 크기를 뚫고 나오는 것을 막는 것임. 
							그런데 style="word-break: break-all; 나 style="word-wrap: break-word; 은
							테이블태그의 <td>태그에는 안되고 <p> 나 <div> 태그안에서 적용되어지므로 <td>태그에서 적용하려면
							<table>태그속에 style="word-wrap: break-word; table-layout: fixed;" 을 주면 된다.
						--%>
					</p>
					</td>
				</tr>
				<tr>
					<th>조회수</th>
					<td>${requestScope.boardvo.readCount}</td>
				</tr>
				<tr>
					<th>날짜</th>
					<td>${requestScope.boardvo.regDate}</td>
				</tr>
			</table>
		</c:if>
		
		<c:if test="${empty requestScope.boardvo}">
			<div style="padding: 20px 0; font-size: 16pt; color: red;" >존재하지 않습니다</div>		
		</c:if>
		
		<div class="mt-5">
			
			<%-- ==== 이전글제목, 다음글제목 보기 시작 ==== --%>
			<c:if test="${not empty requestScope.boardvo}">
				<div style="margin-bottom: 1%;">이전글&nbsp;제목&nbsp;&nbsp;<span class="move" onclick="goView('${requestScope.boardvo.previousseq}')">${requestScope.boardvo.previoussubject}</span></div>
				<div style="margin-bottom: 1%;">다음글&nbsp;제목&nbsp;&nbsp;<span class="move" onclick="goView('${requestScope.boardvo.nextseq}')">${requestScope.boardvo.nextsubject}</span></div>
			</c:if>
			<%-- ==== 이전글제목, 다음글제목 보기 끝 ==== --%>
			
			<br>
			
			<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%=ctxPath%>/board/list'">전체목록보기</button>
			<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%=ctxPath%>${requestScope.goBackURL}'">검색된결과목록보기</button>
			
			<c:if test="${not empty sessionScope.loginuser && sessionScope.loginuser.userid == requestScope.boardvo.fk_userid}">
				<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%=ctxPath%>/board/edit/${requestScope.boardvo.seq}'">글수정하기</button>
				<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%=ctxPath%>/board/del/${requestScope.boardvo.seq}'">글삭제하기</button>
			</c:if>
			
			
			<%-- === #132. 어떤 글에 답변글쓰기는 로그인 되어진 회원의 gradelevel 컬럼의 값이 10인 직원들만 답변글쓰기가 가능하다. === --%>
			<c:if test="${not empty sessionScope.loginuser && sessionScope.loginuser.gradelevel == 10}">
				<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%= ctxPath%>/board/add?subject=${requestScope.boardvo.subject}&fk_seq=${requestScope.boardvo.seq}&groupno=${requestScope.boardvo.groupno}&depthno=${requestScope.boardvo.depthno}'">답변 글쓰기</button>
			</c:if>
			
			<%-- === #58. 댓글쓰기 폼 추가 === --%>
			<c:if test="${not empty sessionScope.loginuser}">
				<h3 style="margin-top: 50px;">댓글쓰기</h3>
				
				<form name="addWriteFrm" id="addWriteFrm" style="margin-top: 20px;">
					<table class="table" style="width: 1024px">
						<tr style="height: 30px;">
							<th width="10%">성명</th>
							<td>
								<input type="hidden" name="fk_userid" value="${sessionScope.loginuser.userid}" readonly/>
								<input type="text" name="name" value="${sessionScope.loginuser.name}" readonly/>
							</td>
						</tr>
						<tr style="height: 30px;">
							<th>댓글내용</th>
							<td>
								<input type="text" name="content" size="100" maxlength="1000"/>
								
								<%-- 댓글에 달리는 원게시물 글번호(즉, 댓글의 부모글 글번호) --%>
								<input type="hidden" name="parentSeq" value="${requestScope.boardvo.seq}" readonly/>
							</td>
						</tr>

						<tr>
							<th colspan="2">
								<button type="button" class="btn btn-success btn-sm mr-3" onclick="goAddWrite()">댓글쓰기 확인</button>
								<button type="reset" class="btn btn-success btn-sm">댓글쓰기 취소</button>
							</th>
						</tr>
					</table>
				</form>
			</c:if>
			
			<%-- === #67. 댓글 내용 보여주기 === --%>
			<h3 style="margin-top: 50px;">댓글내용</h3>
			<table class="table"
				style="width: 1024px; margin-top: 2%; margin-bottom: 3%;">
				<thead>
					<tr>
						<th style="width: 6%">순번</th>
						<th style="text-align: center;">내용</th>

						<%-- === 댓글쓰기에 첨부파일이 있는 경우 시작 === --%>


						<%-- === 댓글쓰기에 첨부파일이 있는 경우 끝 === --%>

						<th style="width: 8%; text-align: center;">작성자</th>
						<th style="width: 12%; text-align: center;">작성일자</th>
						<th style="width: 12%; text-align: center;">수정/삭제</th>
					</tr>
				</thead>
				<tbody id="commentDisplay"></tbody>
			</table>
			
			<%-- === #126. 댓글 페이지바가 보여지는 곳 === --%>
			<div style="display: flex; margin-bottom: 50px;">
				<div id="pageBar" style="margin: auto; text-align: center;"></div>
			</div>

		</div>
	</div>
</div>

<%-- === #111. 이전글제목 보기, 다음글제목 보기시 POST 방식으로 넘기기 위한 것 === --%>
<form name="goViewFrm">
	<input type="hidden" name="seq" />
	<input type="hidden" name="goBackURL" />
	<input type="hidden" name="searchType" />
	<input type="hidden" name="searchWord" />
</form>

<%-- === #132. 답변글쓰기를 위한 폼태그 만들기 === --%>
<form name="replyWriteFrm">
	<input type="text" name="fk_userid">
	<input type="text" name="name">
	<input type="text" name="subject">
</form>

<jsp:include page="../../footer/footer1.jsp" />