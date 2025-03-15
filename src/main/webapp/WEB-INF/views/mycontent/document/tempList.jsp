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
		
		$("h1#doc_title").text("임시저장함");
		$("span.doc_delete").show();
		
		$("span.doc_delete").click(e=>{
			
			if($('input.document_check:checked').length == 0) {
				alert("문서를 선택해주세요.")
				return;
			}
			
			let checked_arr = []
			
			$('input.document_check:checked').each(function(index, item){
				checked_arr.push(item.value);
			});
			
			
			$.ajax({
				url:"<%= ctxPath%>/document/deleteTempList",
				dataType:"json",
				traditional: true,
				data:{"checked_arr":checked_arr},
				success:function(json){
					if(json.n > 0 ){
						alert("삭제가 완료되었습니다.");
						location.reload();
					}
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
		});
		
		
		$("input#check_all").click(e=>{
			let checked = $(e.target).is(':checked');
			
			if(checked) {
				$('input.document_check').prop('checked', true);
			}
			else {
				$('input.document_check').prop('checked', false);
			}
		});
		
		$("div#jstreeView").load("<%=ctxPath%>/document/getOrganization");
			
		
	}); // end of $(document).ready(function(){})-------------------------------------------------
	
</script>
	
	<div id="jstreeView"></div>
	<div>
		<table class="table">
			<thead>
				<tr>
					<th>
						<input type="checkbox" id="check_all"/>
					</th>
					<th>
						<span>생성일</span>
					</th>
					<th>
						<span>긴급</span>
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
						<span>결재상태</span>
					</th>
				</tr>
			</thead>
			<tbody id="tempList">
				<c:if test="${not empty requestScope.tempList}">
					<c:forEach var="temp" items="${requestScope.tempList}">
						<tr class="document" onclick="location.href='<%= ctxPath%>/document/documentView?documentNo=${temp.documentNo}&documentType=${temp.documentType}';">
							<td>
								<input type="checkbox" class="document_check" value="${temp.documentNo}" onclick='event.cancelBubble=true;'/>
							</td>
							<td>
								<span>${temp.draftDate}</span>
							</td>
							<td>
								<c:if test="${temp.urgent == 1}"><span class="p-1 urgent">긴급</span></c:if>
							</td>
							<td>
								<span>${temp.documentType}</span>
							</td>
							<td>
								<span>${temp.subject}</span>
							</td>
							<td>
								<span></span>
							</td>
							<td>
								<span>임시저장</span>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty requestScope.tempList}">
					<tr>
						<td colspan="6"><span>임시 저장 문서가 없습니다.</span></td>
					</tr>
				</c:if>
			</tbody>
		</table>
		
	</div>
</div>
<jsp:include page="../../footer/footer.jsp" /> 