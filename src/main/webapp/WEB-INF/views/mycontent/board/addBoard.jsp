<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 생성</title>
<%@include file="../../header/header.jsp" %>
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
	
	$(document).on("click", "#addBoardGroup", function(){ // 생성 버튼 클릭 이벤트
 		goAddBoardGroup(); // 게시판 생성하기
	});
	
	
}); // end of $(document).ready(function () {}---------


//Function

// 게시판 생성하기
function goAddBoardGroup(){
	const frm = document.addBoardGroup;
    frm.method = "POST";
    frm.action = "<%= ctxPath%>/board/addBoard";
    frm.submit();  
}

		
		
</script>
</head>
<body>
게시판 생성 페이지

<form name="addBoardGroup">

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
			<input type="text" name="createdBy" value=""/>
		</td>
	</tr>
	</table>
	<button type="button" id="addBoardGroup">생성</button> <button type="button">취소</button>
</form>
</body>
</html>