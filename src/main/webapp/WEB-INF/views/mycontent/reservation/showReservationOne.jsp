<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@include file="./reservationLeftBar.jsp" %>
 

 
<%-- 각자 페이지에 해당되는 css 연결 --%>
<link href="<%=ctxPath%>/css/reservation/reservation_main.css" rel="stylesheet"> 
<link href="<%=ctxPath%>/css/reservation/reservation_one.css" rel="stylesheet"> 

<%-- 각자 페이지에 해당되는 js 연결 --%>
<script src="<%=ctxPath%>/js/reservation/reservation.js"></script>

	
	<!-- 오른쪽 바 -->
    <div id="right_bar">
        <div id="right_title_box">
            <span id="right_title">${requestScope.assetvo.assetTitle}</span>
        </div>



		<ul class="tab">
		  <li class="tab__item active">
		    <a href="#tab1">이용안내</a>
		  </li>
		  <li class="tab__item">
		    <a href="#tab2">자산정보 관리</a>
		  </li>
		  <li class="tab__item">
		    <a href="#tab3">자산관리</a>
		  </li>
		</ul>



		

		<!-- 탭 내용 영역 -->
		<div class="tab__content-wrapper">
		  	<div id="tab1" class="tab__content active">
				<div class="tab1_info">※ 첫 페이지에 나오는 안내문을 작성할 수 있습니다.</div>
				<div>
					<div style="width: 100%; height: auto; border: 0px solid red;">
					<form name="addReserFrm" enctype="multipart/form-data">
						<textarea name="assetInfoUpdate" id="assetInfoUpdate" rows="10" cols="100" style="width:100%; height:500px;">${requestScope.assetvo.assetInfo}</textarea>
					</form>
					</div>
					<div style="width: 50%; display: flex; justify-content: center; gap:8px; margin: auto; padding-top: 24px;">
						
						<button class="okBtn">확인</button> <button class="resetBtn">취소</button>
					</div>
				</div>
			</div>
		  	<div id="tab2" class="tab__content">
				<div class="tab1_info">※ 자산에 대한 추가 정보란을 삽입할 수 있으며, 변경된 내용은 ‘자산 관리’ 탭에 적용됩니다.</div>
				<div>
					
					<div>
						<i class="fa-solid fa-plus"></i>
						<span>추가하기</span>
					</div>
					<div>
						<table  class="baseTable">
							<thead>
								<tr>
									<th>필드명</th>
									<th>공개 / 비공개 여부</th>
									<th>삭제</th>
									
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>ID값</td>
									<td><input type="checkbox" id="mailOneCheck" /></td>
									<td>삭제불가</td>
								</tr>
								
								<tr>
									<td>항목명</td>
									<td><input type="checkbox" id="mailOneCheck" /></td>
									<td>삭제불가</td>
								</tr>

								<tr>
									<td>빔프로젝트</td>
									<td><input type="checkbox" id="mailOneCheck" /></td>
									<td><i class="fa-solid fa-trash disableBoardIcon"></i></td>
								</tr>
							</tbody>
						</table>
						
						<div style="width: 50%; display: flex; justify-content: center; gap:8px; margin: auto; padding-top: 24px;">
						
							<button class="okBtn">확인</button> <button class="resetBtn">취소</button>
						</div>
					</div>

				</div>
			</div>
		  	<div id="tab3" class="tab__content">
				<div class="tab1_info">※ 자산에 대한 정보를 추가, 수정, 삭제할 수 있습니다.</div>
				<div>
					<i class="fa-solid fa-plus"></i>
					<span>자산 추가</span>
				</div>
				<div>
					<table class="baseTable">
							<thead>
								<tr>
									<th>코드</th>
									<th>항목명</th>
									<th>빔프로젝트</th>
									<th>설정</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>100001</td>
									<td>행복 1실</td>
									<td>X</td>
									<td><i class="fa-solid fa-gear"></i></td>
								</tr>
								
								<tr>
									<td>100001</td>
									<td>희망 2실</td>
									<td>O</td>
									<td><i class="fa-solid fa-gear"></i></td>
								</tr>
								
							</tbody>
						</table>
						
						
						<div style="width: 50%; display: flex; justify-content: center; gap:8px; margin: auto; padding-top: 24px;">
						
							<button class="okBtn">확인</button> <button class="resetBtn">취소</button>
						</div>
				</div>
			</div>
		</div>


    </div>
    <!-- 오른쪽 바 -->

<script type="text/javascript">
	//1. 탭 버튼과 탭 내용 부분들을 querySelectorAll을 사용해 변수에 담는다.
	const tabItem = document.querySelectorAll(".tab__item");
	const tabContent = document.querySelectorAll(".tab__content");
	
	// 2. 탭 버튼들을 forEach 문을 통해 한번씩 순회한다.
	// 이때 index도 같이 가져온다.
	tabItem.forEach((item, index) => {
	  // 3. 탭 버튼에 클릭 이벤트를 준다.
	  item.addEventListener("click", (e) => {
	    // 4. 버튼을 a 태그에 만들었기 때문에, 
	    // 태그의 기본 동작(링크 연결) 방지를 위해 preventDefault를 추가한다.
	    e.preventDefault(); // a 
	    
	    // 5. 탭 내용 부분들을 forEach 문을 통해 한번씩 순회한다.
	    tabContent.forEach((content) => {
	      // 6. 탭 내용 부분들 전부 active 클래스를 제거한다.
	      content.classList.remove("active");
	    });
	
	    // 7. 탭 버튼들을 forEach 문을 통해 한번씩 순회한다.
	    tabItem.forEach((content) => {
	      // 8. 탭 버튼들 전부 active 클래스를 제거한다.
	      content.classList.remove("active");
	    });
	
	    // 9. 탭 버튼과 탭 내용 영역의 index에 해당하는 부분에 active 클래스를 추가한다.
	    // ex) 만약 첫번째 탭(index 0)을 클릭했다면, 같은 인덱스에 있는 첫번째 탭 내용 영역에
	    // active 클래스가 추가된다.
	    tabItem[index].classList.add("active");
	    tabContent[index].classList.add("active");
	  });
	});





	<%--  ==== 스마트 에디터 구현 시작 ==== --%>
	//전역변수
    var obj = [];
    
    //스마트에디터 프레임생성
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: obj,
        elPlaceHolder: "assetInfoUpdate",
        sSkinURI: "<%= ctxPath%>/smarteditor/SmartEditor2Skin.html",
        htParams : {
            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseToolbar : true,            
            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer : true,    
            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger : true,
        }
    });
  <%--  ==== 스마트 에디터 구현 끝 ==== --%>
  
  
  // ================ 대분류 등록버튼 ================ //
  $("button#addReserBtn").click(function(){
	  
	  <%-- === 스마트 에디터 구현 시작 === --%>
	   // id가 content인 textarea에 에디터에서 대입
       obj.getById["assetInfoUpdate"].exec("UPDATE_CONTENTS_FIELD", []);
	  <%-- === 스마트 에디터 구현 끝 === --%>
	  
	  
	  // === 글내용 유효성 검사(스마트 에디터를 사용할 경우) ===
	  let content_val = $("textarea[name='assetInfoUpdate']").val().trim();
	  
      content_val = content_val.replace(/&nbsp;/gi, "");  // 공백(&nbsp;)을 "" 으로 변환

      content_val = content_val.substring(content_val.indexOf("<p>")+3);
	  
      content_val = content_val.substring(0, content_val.indexOf("</p>"));
     
      if(content_val.trim().length == 0) {
    	  alert("소개내용을 입력하세요!!");
    	  return; // 종료
      }
      
	  
	  
	  
    	  
      // 폼(form)을 전송(submit)
      const frm = document.addReserFrm;
      frm.method = "post";
      frm.action = "<%= ctxPath%>/reservation/reservationAdd";
      frm.submit();
  });
  // ================ 대분류 등록버튼 ================ //
  
  
  <%-- === 해당 페이지 들어오자마자 ajax 자산정보 관리 불러옴 === --%>
  $.ajax({
	 url:"<%= ctxPath%>/reservation/middleTapInfo",
	 type:"post",
	 data:{"assetNo":${requestScope.assetvo.assetNo}},
	 dataType:"json",
	 success:function(json) {
		 console.log(JSON.stringify(json));
		 
		 
	 },
	 error: function(request, status, error){
		 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	 }  
  });
  
  <%-- === 해당 페이지 들어오자마자 ajax 자산정보 관리 불러옴 === --%>
		  
		  
</script>

<jsp:include page="../../footer/footer.jsp" /> 