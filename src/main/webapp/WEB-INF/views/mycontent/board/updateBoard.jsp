<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../header/header.jsp" %>
<%@include file="./boardLeftBar.jsp" %>

<%-- 각자 페이지에 해당되는 css 연결 --%>
<link href="<%=ctxPath%>/css/board/updateBoard.css" rel="stylesheet"> 
<script>
//     let boardAccessList = `${boardAccessList}`;
</script>
<%-- 각자 페이지에 해당되는 js 연결 --%>
<script src="<%=ctxPath%>/js/board/updateBoard.js"></script>
<%-- <div id="boardAccessListJson"> ${boardAccessListJson}</div> --%>
<!-- 오른쪽 바 -->
    <div id="right_bar">
        <div id="right_title_box">
            <span id="right_title">게시판 수정</span>
		</div>
	



        <div id="updateBoardGroupFrmTag">
		    <form name="updateBoardGroup">
				<input type="hidden" name="boardNo" value="${boardvo.boardNo}"/>
				<table>
					<tr>
						<td class="columnTitle">
							제목  
						</td>
						<td style="width: 100%;">
							<input type="text" value='${boardvo.boardName}' name="boardName" id="updateBoardName" class="w_max"/>
						</td>
					</tr>
					
					<tr>
						<td class="columnTitle">
							설명
						</td>
						<td>
							<input type="text" value='${boardvo.boardDesc}' name="boardDesc" id="updateBoardDesc" class="w_max"/>
						</td>
					</tr>
					
					<tr>
					    <td class="columnTitle">공개 설정</td>
					    <td>
					        <div class="radio-container">
							    <label>
							        <input type="radio" name="isPublicUpdate" value="0" class="isPublicUpdate"
							        <c:if test="${boardvo.isPublic eq '0'}"> checked</c:if> /> 부서별
							    </label>
							    <label>
							        <input type="radio" name="isPublicUpdate" value="1" class="isPublicUpdate"
							        <c:if test="${boardvo.isPublic eq '1'}"> checked</c:if> /> 전체
							    </label>
							</div>
					    </td>
					</tr>
					<tr>
						<td class="columnTitle">
							운영자
						</td>
						<td>
							<input type="text" name="createdBy" value="${boardvo.createdBy}"  class="w_max" readonly/>
						</td>
					</tr>
					
					<tr id="departmentSelect">
						<td class="columnTitle">
							<p style="font-weight: bold;margin: 0px;">공개 부서<br>선택하기</p>
						</td>
						<td>
							<div id="isPublicDeptUpdate">
						<!-- 기존 선택된 부서 목록을 화면에 출력 -->
						<div id="updateSelectDeptList">
							<c:if test="${not empty boardAccessList}">
							    
							        <c:forEach var="dept" items="${boardAccessList}" varStatus="loop">
							            <span class="select-dept" data-dept-no="${dept.fk_departmentNo}" data-index="${loop.index}">
							                ${dept.departmentName}
							                <button type="button" class="remove-dept btnDefaultDesignNone" data-dept-no="${dept.fk_departmentNo}">
							                    <i class="fa-solid fa-circle-xmark"></i>
							                </button>
							            </span>
							            
							            <!-- 서버에 전송할 hidden input -->
							            <input type="hidden" name="fk_departmentNo_update" value="${dept.fk_departmentNo}">
	 						            <input type="hidden" name="fk_departmentName_update" value="${dept.departmentName}"> 
							        </c:forEach>
							</c:if>
						</div>
						<input type="text" name="updateSearchWord" id="updateSearchWord" size="50" autocomplete="off" placeholder="부서를 검색하세요." />
						<input type="text" style="display: none;"/> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%>	  
					<div id="displayList"  style="border:solid 1px gray; border-top:0px; height:100px; margin-top:-1px; margin-bottom:30px; overflow:auto;"></div>
				</div>
						</td>
					</tr>
				</table>
				
				
				<div id="selectDeptHideInputWithUpdate"> <%--  여기에 선택된 부서들의 hidden input이 추가됨 --%> </div> 
				
			</form>
			    
			<div id="updateBoardGroupFrmButtonTag">
				<button type="button" id="updateBoardGroup">수정</button> 
			</div>	
		</div>
    </div>
    <!-- 오른쪽 바 -->



<jsp:include page="../../footer/footer.jsp" /> 