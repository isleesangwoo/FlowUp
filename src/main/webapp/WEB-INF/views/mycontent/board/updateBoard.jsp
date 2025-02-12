<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../header/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 수정</title>
<script type="text/javascript">
$(document).ready(function () {
	
	// 처음에는 부서 선택 박스를 숨깁니다.
	$("#selectDepartment").hide(); 
	
	// 공개 범위 라디오 버튼에 change 이벤트 핸들러 추가
	$("input[name='isPublic']").change(function() {
		// 선택된 값이 부서별 공개(isPublicDepart)일 때
		if ($(".isPublic:checked").val() == "0") {
			$("#selectDepartment").show();  // 부서 선택 박스를 표시
		} else {
			$("#selectDepartment").hide();  // 부서 선택 박스를 숨김
		}
	});
	
	$(document).on("click", "#updateBoardGroup", function(){ // 수정 버튼 클릭 이벤트
		goUpadteBoardGroup(); // 게시판 수정하기
	});
	
	$(document).on("click", "#deleteBoardGroup", function(){ // 삭제 버튼 클릭 이벤트
		goDeleteBoardGroup(); // 게시판 삭제(status 변경)하기
	});
	
	
}); // end of $(document).ready(function () {}---------


// === Function === //

// 게시판 수정하기
function goUpadteBoardGroup(){
	const frm = document.updateBoardGroup;
    frm.method = "POST";
    frm.action = "<%= ctxPath%>/board/updateBoard";
    frm.submit();  
}	

// 게시판 삭제(status 변경)하기
function goDeleteBoardGroup(){
	const frm = document.deleteBoardGroup;
    frm.method = "POST";
    frm.action = "<%= ctxPath%>/board/deleteBoard";
    frm.submit();  
}	
</script>
</head>
<body>

게시판 수정 페이지
<form name="updateBoardGroup">

	<table>
	<tr>
		<td>
			제목
		</td>
		<td>
			<input type="text" name="boardName"/>
		</td>
	</tr>
	
	<tr>
		<td>
			설명
		</td>
		<td>
			<input type="text" name="boardDesc"/>
		</td>
	</tr>
	
	<tr>
		<td>
			공개 범위 설정
		</td>
		<td>
			부서별 공개 <input type="radio" name="isPublic" value="0" class="isPublic" /> <!-- 부서별 -->
			전체공개 <input type="radio" name="isPublic" value="1" class="isPublic"/> <!-- 전체공개 -->
			
			<div id="selectDepartment">
				<div style="border:solid 1px red;">
					<p>공유부서 선택</p>
					<div >
					<!-- 부서들 나열 -->
					영업부서<br>
					인사부서<br>
					.<br>
					.<br>
					</div>
				</div>
			</div>
		</td>
	</tr>
	
	<tr>
		<td>
			운영자(생성자)
		</td>
		<td>
			<input type="text" name="createdBy" value="게시판을 생성한 자의 이름을 넣을 것" readonly/>
		</td>
	</tr>
	</table>
	<button type="button" id="updateBoardGroup">수정</button> 
</form>

<form name="deleteBoardGroup">
	<input type="text" name="boardNo" value="" placeholder="삭제될 게시판그룹번호">
	<button type="button" id="deleteBoardGroup" >게시판 삭제</button>
</form>

</body>
</html>