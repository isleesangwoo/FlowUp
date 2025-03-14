<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>

<jsp:include page="document_main.jsp" />

<jsp:include page="document_box.jsp" />

<style type="text/css">
	
	.document:hover {
		cursor: pointer;
		background-color: gray;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("h1#doc_title").text("기안문서함"); // 문서함 이름
		
		$("span#sortCnt_btn span").text("${requestScope.sizePerPage}");	// 페이지를 이동하더라도 한 페이지에 보여줄 문서 갯수가 저장되도록
		$("input#searchWord").val("${requestScope.searchWord}");		// 페이지를 이동하더라도 검색어가 저장되도록
		
		// 검색 아이콘을 클릭했을 때
		$("a.doc_search_btn").click(e=>{
			getDocumentList();
		});
		
		// 정렬 갯수를 클릭했을 때
		$("span#sortCnt_btn ul li").on("click", function() {
			getDocumentList();
		});
		
		// 검색창에서 엔터 키를 눌렀을 때
		$("input#searchWord").on("keydown", function(e){
			if(e.keyCode===13){
				getDocumentList();
			}
		});
		
		// 새로고침 버튼을 눌렀을 때
		$("span#re_btn").click(e=>{
			location.href = `<%= ctxPath%>/document/myDocumentList`;
		});
		
		// 결재 상태 탭을 클릭했을 때
		$("div.documentStatus_tab button").click(e=>{
			$("div.documentStatus_tab button").removeClass("active");
			$(e.target).addClass("active");
			
			// getDocumentList();
		});
		
		
		
	}); // end of $(document).ready(function(){})-------------------------------------------------
	
	function getDocumentList() {
		let pageSize = $("span#sortCnt_btn span").text().trim(); // 한 페이지에 보여줄 문서 갯수
		let searchWord = $("input#searchWord").val().trim(); // 검색어
		let status = 0;
		$("div.documentStatus_tab button").each(function(index, item){
			if($(this).hasClass("active")){
				status = $(this).val();	// 결재상태
			}
		});
		location.href = `<%= ctxPath%>/document/myDocumentList?currentShowPageNo=1&sizePerPage=\${pageSize}&searchWord=\${searchWord}`;
	}
	
</script>

	<div>
		<div class="documentStatus_tab">
			<button class="tablinks active" value="">전체</button>
			<button class="tablinks" value="0">진행중</button>
			<button class="tablinks" value="1">완료</button>
			<button class="tablinks" value="2">반려</button>
		</div>
		<table id="myDocumentList" class="table">
			<thead class="doc_box_thead">
				<tr>
					<th>
						<input type="checkbox" id="check_all"/>
					</th>
					<th>
						<span>기안일</span>
					</th>
					<th>
						<span>결재양식</span>
					</th>
					<th>
						<span>제목</span>
					</th>
					<th>
						<span>첨부</span>
					</th>
					<th>
						<span>문서번호</span>
					</th>
					<th>
						<span>결재상태</span>
					</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty requestScope.myDocumentList}">
					<c:forEach var="myDocument" items="${requestScope.myDocumentList}">
						<tr class="document" onclick="location.href='<%= ctxPath%>/document/documentView?documentNo=${myDocument.documentNo}&documentType=${myDocument.documentType}';">
							<td>
								<input type="checkbox" class="document_check" onclick='event.cancelBubble=true;'>
							</td>
							<td>
								<span>${myDocument.draftDate}</span>
							</td>
							<td>
								<span>${myDocument.documentType}</span>
							</td>
							<td>
								<span>${myDocument.subject}</span>
							</td>
							<td>
								<span></span>
							</td>
							<td>
								<span>${myDocument.documentNo}</span>
							</td>
							<td>
								<c:if test="${myDocument.status == 0}"><span class="p-1 in_progress">진행중</span></c:if>
								<c:if test="${myDocument.status == 1}"><span class="p-1 approved">완료</span></c:if>
								<c:if test="${myDocument.status == 2}"><span class="p-1 rejected">반려</span></c:if>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty requestScope.myDocumentList}">
					<tr>
						<td colspan="6"><span>기안 문서가 없습니다.</span></td>
					</tr>
				</c:if>
			</tbody>
		</table>
		
		<%-- === #103. 페이지바 보여주기 === --%>
		<div align="center" style="border: solid 0px gray; width: 80%; margin: 30px auto;">
			${requestScope.pageBar}
		</div>
		
	</div>
</div>
<jsp:include page="../../footer/footer.jsp" /> 