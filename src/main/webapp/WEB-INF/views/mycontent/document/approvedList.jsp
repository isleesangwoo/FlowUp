<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>

<jsp:include page="document_main.jsp" />

<jsp:include page="document_box.jsp" />

<script type="text/javascript">

	$(document).ready(function(){
		
		<%-- 컨트롤러에서 넘어온 값들 넣어주기 --%>
		$("h3#doc_title").text("결재문서함"); // 문서함 이름
		
		$("span#sortCnt_btn span").text("${requestScope.sizePerPage}");	// 컨트롤러에서 넘어온 페이지에 보여줄 문서 갯수 넣어주기
		$("input#searchWord").val("${requestScope.searchWord}");		// 컨트롤러에서 넘어온 검색어 넣어주기
		
		$("div.documentStatus_tab button").each(function(index, item){	
			if($(this).val() == "${requestScope.status}"){ // 컨트롤러에서 넘어온 결재상태 확인
				$("div.documentStatus_tab button").removeClass("active");
				$(this).addClass("active"); // 해당 결재상태 탭 활성화
			}
		});
		
		if("${requestScope.documentType}" == "") {
			$("span#documentType").text("결재양식"); // 컨트롤러에서 넘어온 결재양식이 공백이라면 '결재양식' 넣어주기
		}
		else {
			$("span#documentType").text("${requestScope.documentType}"); // 컨트롤러에서 넘어온 결재상태 넣어주기
		}
		<%-- 컨트롤러에서 넘어온 값들 넣어주기 --%>
		
		<%-- 새로고침 버튼을 눌렀을 때 이벤트 --%>
		$("span#re_btn").click(e=>{
			location.href = `<%= ctxPath%>/document/approvedList`;
		});
		
		<%-- 검색 아이콘을 클릭했을 때 이벤트 --%>
		$("a.doc_search_btn").click(e=>{
			getDocumentList();
		});
		
		<%-- 검색창에서 엔터 키를 눌렀을 때 이벤트 --%>
		$("input#searchWord").on("keydown", function(e){
			if(e.keyCode===13){
				getDocumentList();
			}
		});
		
		<%-- 정렬 갯수를 클릭했을 때 이벤트 --%>
		$("span#sortCnt_btn ul li").on("click", function() {
			getDocumentList();
		});
		
		<%-- 결재 상태 탭을 클릭했을 때 이벤트 --%>
		$("div.documentStatus_tab button").click(e=>{
			$("div.documentStatus_tab button").removeClass("active");
			$(e.target).addClass("active");
			
			getDocumentList();
		});
		
		<%-- 결재 양식 탭을 클릭했을 때 이벤트 --%>
		$('#documentType_btn > ul li').click(e=>{
			getDocumentList();
		});
		
		
	}); // end of $(document).ready(function(){})-------------------------------------------------
	
	function getDocumentList() {
		let pageSize = $("span#sortCnt_btn span").text().trim();	// 한 페이지에 보여줄 문서 갯수
		let searchWord = $("input#searchWord").val().trim(); 		// 검색어
		let documentType = $("span#documentType").text().trim();	// 결재양식
		if(documentType == "결재양식") {
			documentType = "";
		}
		
		let approvalStatus = 0;	// 결재상태
		
		$("div.documentStatus_tab button").each(function(index, item){
			if($(this).hasClass("active")){		// 선택된 탭
				approvalStatus = $(this).val();	// 결재상태
			}
		});
		
		location.href = "<%= ctxPath%>/document/approvedList?currentShowPageNo=1"
						+ "&sizePerPage=" + pageSize
						+ "&searchWord=" + searchWord
						+ "&approvalStatus=" + approvalStatus
						+ "&documentType=" + documentType;
		
	}
	
</script>

	<div>
		<%-- 결재상태 선택 탭 --%>
		<div class="documentStatus_tab">
			<button class="tablinks" value="">전체</button>
			<button class="tablinks" value="0">진행중</button>
			<button class="tablinks" value="1">완료</button>
			<button class="tablinks" value="2">반려</button>
		</div>
		
		<%-- 문서 목록이 들어오는 곳 --%>
		<table class="table">
			<thead class="doc_box_thead">
				<tr>
					<th>
						<%-- 전체 선택 체크박스 --%>
						<input type="checkbox" id="check_all"/>
					</th>
					<th>
						<span>기안일</span>
					</th>
					<th>
						<span>완료일</span>
					</th>
					<th>
						<span>긴급</span>
					</th>
					<th>
						<%-- 결재 양식 선택 버튼 --%>
						<span id="documentType_btn">
							<span id="documentType">결재양식</span>
							<i style="transform: rotate(90deg)" class="fa-solid fa-angle-right"></i>
							<ul>
								<li>전체</li>
								<li>휴가신청서</li>
								<li>연장근무신청서</li>
								<li>지출품의서</li>
								<li>업무기안</li>
							</ul>
						</span>
					</th>
					<th>
						<span>제목</span>
					</th>
					<th>
						<span>첨부</span>
					</th>
					<th>
						<span>기안자</span>
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
				<c:if test="${not empty requestScope.approvedList}">
					<c:forEach var="approved" items="${requestScope.approvedList}">
						<tr class="document" onclick="location.href='<%= ctxPath%>/document/documentView?documentNo=${approved.documentNo}&documentType=${approved.documentType}';">
							<td>
								<%-- 체크 박스 클릭 시에는 tr의 onclick 이 작동하지 않도록 --%>
								<input type="checkbox" class="document_check" onclick='event.cancelBubble=true;'>
							</td>
							<td>
								<span>${approved.draftDate}</span>
							</td>
							<td>
								<span>${approved.approvalDate}</span>
							</td>
							<td>
								<%-- 긴급 문서일 경우 --%>
								<c:if test="${approved.urgent == 1}"><span class="p-1 urgent">긴급</span></c:if>
							</td>
							<td>
								<span>${approved.documentType}</span>
							</td>
							<td>
								<span>${approved.subject}</span>
							</td>
							<td>
								<span></span>
							</td>
							<td>
								<span>${approved.name}</span>
							</td>
							<td>
								<span>${approved.documentNo}</span>
							</td>
							<td>
								<%-- 결재양식에 따라 색 주기 --%>
								<c:if test="${approved.status == 0}"><span class="p-1 in_progress">진행중</span></c:if>
								<c:if test="${approved.status == 1}"><span class="p-1 approved">완료</span></c:if>
								<c:if test="${approved.status == 2}"><span class="p-1 rejected">반려</span></c:if>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty requestScope.approvedList}">
					<tr>
						<td colspan="10"><span>문서가 존재하지 않습니다.</span></td>
					</tr>
				</c:if>
			</tbody>
		</table>
		
		<c:if test="${not empty requestScope.approvedList}">
			<%-- 페이지바 보여주기 --%>
			<div align="center" style="border: solid 0px gray; width: 80%; margin: 30px auto;">
				${requestScope.pageBar}
			</div>
		</c:if>
	</div>
</div>
<jsp:include page="../../footer/footer.jsp" /> 