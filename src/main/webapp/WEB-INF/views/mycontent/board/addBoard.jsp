<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="../../header/header.jsp" %>
<%@include file="./boardLeftBar.jsp" %>

<%-- 각자 페이지에 해당되는 css 연결 --%>
<link href="<%=ctxPath%>/css/board/addBoard.css" rel="stylesheet"> 
<script>
	var ctxPath = "<%= request.getContextPath() %>";
</script>

<%-- 각자 페이지에 해당되는 js 연결 --%>
<script src="<%=ctxPath%>/js/board/addBoard.js"></script>

   <!-- 오른쪽 바 -->
    <div id="right_bar">
        <div id="right_title_box">
            <span id="right_title">게시판 생성</span>
		</div>
	
	
        <div id="addBoardGroupFrmTag">
		    <form name="addBoardGroup">
		
				<table>
					<tr>
						<td class="columnTitle">
							제목
						</td>
						<td style="width: 90%;">
							<input type="text" name="boardName"  class="w_max"/>
						</td>
					</tr>
					
					<tr>
						<td class="columnTitle">
							설명
						</td>
						<td>
							<input type="text" name="boardDesc" class="w_max"/>
						</td>
					</tr>
					
					<tr>
					    <td class="columnTitle">공개 범위 설정</td>
					    <td>
					        <div class="radio-container">
					            <label>
					                <input type="radio" name="isPublic" value="0" class="isPublic" /> 부서별 공개
					            </label>
					            <label>
					                <input type="radio" name="isPublic" value="1" class="isPublic" /> 전체공개
					            </label>
					        </div>
							
					        
					    </td>
					</tr>
				
					
					<tr>
						<td class="columnTitle">
							운영자(생성자)
						</td>
						<td>
							<input type="text" name="createdBy" value=""  class="w_max"/>
						</td>
					</tr>
				</table>
				<div id="addBoardGroupFrmButtonTag">
					<button type="button" id="addBoardGroup">생성</button> <button type="button">취소</button>
				</div>
			</form>
			
			<div id="isPublicDept">
				<form name="searchFrm" style="margin-top: 20px;">
					<p>부서선택하기</p>
					<input type="text" name="searchWord" size="50" autocomplete="off" placeholder="부서를 검색하세요." />
					<input type="text" style="display: none;"/> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%>
				</form>		  
				<div id="displayList"  style="border:solid 1px gray; border-top:0px; height:100px; margin-top:-1px; margin-bottom:30px; overflow:auto;">
				</div>
			</div>      
							
		</div>
    </div>
    <!-- 오른쪽 바 -->





<jsp:include page="../../footer/footer.jsp" /> 