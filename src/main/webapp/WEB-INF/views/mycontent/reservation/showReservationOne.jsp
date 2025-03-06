<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@include file="./reservationLeftBar.jsp"%>



<%-- 각자 페이지에 해당되는 css 연결 --%>
<link href="<%=ctxPath%>/css/reservation/reservation_main.css"
	rel="stylesheet">
<link href="<%=ctxPath%>/css/reservation/reservation_one.css"
	rel="stylesheet">

<%-- 각자 페이지에 해당되는 js 연결 --%>
<script src="<%=ctxPath%>/js/reservation/reservation.js"></script>


<!-- 오른쪽 바 -->
<div id="right_bar">
	<div id="right_title_box">
		<span id="right_title">${requestScope.assetvo.assetTitle}</span>
	</div>



	<ul class="tab">
		<li class="tab__item active"><a href="#tab1">이용안내</a></li>
		<li class="tab__item"><a href="#tab2">자산정보 관리</a></li>
		<li class="tab__item"><a href="#tab3">자산관리</a></li>
	</ul>





	<!-- 탭 내용 영역 -->
	<div class="tab__content-wrapper">

		<%-- 첫번째 탭 내용물 --%>
		<div id="tab1" class="tab__content active">
			<div class="tab1_info">※ 첫 페이지에 나오는 안내문을 작성할 수 있습니다.</div>
			<div>
				<div style="width: 100%; height: auto; border: 0px solid red;">
					<form name="addReserFrm2" enctype="multipart/form-data">
						<input type="hidden" name="updateAssetNo" value="${requestScope.assetvo.assetNo}" />
						<input type="hidden" name="updateAssetTitle" value="${requestScope.assetvo.assetTitle}" />
						<!-- 스마트 에디터 -->
						<textarea name="assetInfoUpdate" id="assetInfoUpdate" rows="10"
							cols="100" style="width: 100%; height: 500px;">${requestScope.assetvo.assetInfo}</textarea>
						<!-- 스마트 에디터 -->
					</form>
				</div>

				<!-- bottom 버튼 영역 -->
				<div class="bottom_btn_box">
					<button class="okBtn" id="updateOkBtn">확인</button>
					<button class="resetBtn">취소</button>
				</div>
				<!-- bottom 버튼 영역 -->
			</div>
		</div>
		<%-- 첫번째 탭 내용물 --%>

		<%-- 두번째 탭 내용물 --%>
		<div id="tab2" class="tab__content">
			<div class="tab1_info">※ 자산에 대한 추가 정보란을 삽입할 수 있으며, 변경된 내용은 ‘자산
				관리’ 탭에 적용됩니다.</div>
			<div>

				<div class="top_btn_box">
					<!-- 비품 추가 버튼 -->
					<div id="addFixtures">
						<i class="fa-solid fa-plus"></i> <span>비품추가하기</span>
					</div>
					<div class="selectHere"></div>
					<!-- 비품 추가 버튼 -->
				</div>
				<div>
					<table class="baseTable">
						<thead>
							<tr>
								<th>필드명</th>
								<th>공개 / 비공개 여부</th>
								<th>삭제</th>

							</tr>
						</thead>
						<tbody id="appendTrMiddle">

							<tr>
								<td colspan="3"
									style="text-align: center; height: 100px; vertical-align: middle; color: #999;">비품추가를
									원하는 자산을 선택해주세요</td>
							</tr>

							<!-- tbl_assetInformation 테이블 컬럼이 들어올 자리 -->
							<!-- tbl_assetInformation 테이블 컬럼이 들어올 자리 -->
							<!-- tbl_assetInformation 테이블 컬럼이 들어올 자리 -->

						</tbody>
					</table>

					<!-- bottom 버튼 영역 -->
					<div class="bottom_btn_box">
						<button class="okBtn" id="insertFixtures">확인</button>
						<button class="resetBtn" id="resetFixtures">취소</button>
					</div>
					<!-- bottom 버튼 영역 -->
				</div>

			</div>
			<input type="hidden" name="totalFixturesName" /> 
			<input type="hidden" name="totalFixtures" /> 
			<input type="hidden" name="totalInformationContents" /> 

		</div>
		<%-- 두번째 탭 내용물 --%>

		<%-- 세번째 탭 내용물 --%>
		<div id="tab3" class="tab__content">
			<div class="tab1_info">※ 자산에 대한 정보를 추가, 수정, 삭제할 수 있습니다.</div>
			<div class="top_btn_box">
				<!-- 비품 추가 버튼 -->
				<div id="addAsset">
					<i class="fa-solid fa-plus"></i> <span>자산 추가</span>
				</div>
				<!-- 비품 추가 버튼 -->
			</div>
			<div>
				<table class="baseTable">
					<thead>
						<tr>
							<th>코드</th>
							<th>항목명</th>
							<!--<th>빔프로젝트</th>-->
							<th>설정</th>
							<th>삭제</th>
						</tr>
					</thead>
					<tbody id="appendTrFinal">


					</tbody>
				</table>

				<!-- bottom 버튼 영역 -->
				<!--
					<div class="bottom_btn_box">
						<button class="okBtn">확인</button> <button class="resetBtn">취소</button>
					</div>
					-->
				<!-- bottom 버튼 영역 -->
			</div>

			<div id="assetModalBg" class="modal_bg"></div>
			<div id="assetModal" class="modal_containerAsset">
				<label class="assetNameTitle">자산명</label><input type="text"
					name="assetName" />
				<div id="goAddAsset">확인</div>
			</div>

			
			
			
			
			<div id="assetModalBg2" class="modal_bg"></div>
			<div id="assetModal2" class="modal_containerAssetFix">
				<div>
					<label class="assetNameTitle">ID값</label> <span class="fixNo"></span>
				</div>
				
				<div>
					<label class="assetNameTitle">항목명</label><input class="assetName" type="text" name="assetName" />
				</div>
				
				<table class="baseTable" style="margin-top:12px;">
					<thead>
						<tr>
							<th>자산명</th>
							<th>공개 / 비공개 여부</th>
							<th>유무 상태</th>
						</tr>
					</thead>
					<tbody class="informationTitleAppend">
						<!-- 여기는 추가된 항목들 목록 -->
						
						<!-- 여기는 추가된 항목들 목록 -->
					</tbody>
				</table>
				
				
				<div class="bottom_btn_box">
					<button class="okBtn" id="GofixInfo">확인</button>
					<button class="resetBtn" id="closeAssetModal2">취소</button>
				</div>
			</div>
		</div>
		<%-- 세번째 탭 내용물 --%>
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





	<%--  ==== 스마트 에디터 구현 시작 수정창  ==== --%>
	//전역변수
    var obj1 = [];
    
    //스마트에디터 프레임생성
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: obj1,
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
  $("#updateOkBtn").click(function(){
	  
	  <%-- === 스마트 에디터 구현 시작 === --%>
	   // id가 content인 textarea에 에디터에서 대입
       obj1.getById["assetInfoUpdate"].exec("UPDATE_CONTENTS_FIELD", []);
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
      const frm = document.addReserFrm2;
      frm.method = "post";
      frm.action = "<%= ctxPath%>/reservation/assetInfoUpdate";
      frm.submit();
  });
  // ================ 대분류 등록버튼 ================ //
  
  
  
  
  
  
  
  
  
    
  
  
  
  
  
  
  
  
  
  
  <%-- ============== 2번째 탭 ============== --%>
  <%-- === 해당 페이지 들어오자마자 ajax 자산정보 관리 불러옴 === --%>
  $.ajax({
	 url:"<%= ctxPath%>/reservation/middleTapInfo",
	 type:"post",
	 data:{"assetNo":${requestScope.assetvo.assetNo}},
	 dataType:"json",
	 success:function(json) {
		 // console.log(JSON.stringify(json));
		 
		 /*
		 	[{"assetInformationNo":"100001","fk_assetDetailNo":"100014","InformationContents":"X","InformationTitle":"빔프로젝트","fk_assetNo":"100029"}]
		 */
		 
		 $.each(json, function(index, item){
		
			 $('#appendTrMiddle').append(`<tr>
											 <td>\${item.InformationTitle}</td>
											 <td><input type="checkbox" id="mailOneCheck" /></td>
											 <td><i class="fa-solid fa-trash disableBoardIcon"></i></td>
										 </tr>`);
			 
		 }) // end of $.each(json, function(index, item)) {} ------------------- 
		 
	 },
	 error: function(request, status, error){
		 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	 }  
  });
  
  <%-- === 해당 페이지 들어오자마자 ajax 자산정보 관리 불러옴 === --%>
		  
  
  
  <%-- === 비품을 insert 하기 위한 것 === --%>
  <!-- 비품추가하기 버튼 클릭시 -->
  let fixturesCnt = 0;  // 각자 다른 input태그의 name 값을 주기 위해 설정
  let totalfixturesArr = [];
  let fixturesArr = []; // 위에서 만든 name값들을 배열에 담기 위함
  let InformationContentsArr = [];
  
  $('#addFixtures').click(e=>{
	  
	  if($('#selectAsset').val() == '선택하세요'){
		  alert('비품추가를 원하는 자산을 먼저 선택해주세요');
		  return;
	  }
	  
	  
	  // == 한번에 3개 이상 넘어가면 안 이뻐서 제한 == //
	  if(fixturesCnt > 2) {
		  alert('비품은 한번에 3개까지 추가할 수 있습니다.');
		  return;
	  }
	  // == 한번에 3개 이상 넘어가면 안 이뻐서 제한 == //
	  
	  fixturesCnt++;
	  
	  $('#appendTrMiddle').append(`<tr class="addFixtures_tr">
									 <td><input class="InformationTitle" name="InformationTitle\${fixturesCnt}" type="text" /></td>
									 <td><input class="InformationContents\${fixturesCnt} InformationContents" name="InformationContents" type="checkbox" id="mailOneCheck" value="0" checked /></td>
									 <td>생성중</td>
								 </tr>`);
								 
								 
	   totalfixturesArr.push(`InformationTitle\${fixturesCnt}`);
	   let str_totalfixturesArr = totalfixturesArr.join(",");
	 	  
	   $('input[name="totalFixturesName"]').val(str_totalfixturesArr);
	  //////////////////////////////////////////////////////////////// 비품명 들어갈 자리
	  
	  InformationContentsArr.push($(`.InformationContents\${fixturesCnt}`).val());
	  let str_InformationContentsArr = InformationContentsArr.join(",");
	  
	  $('input[name="totalInformationContents"]').val(str_InformationContentsArr);
	  //////////////////////////////////////////////////////////////// 체크박스 상태 들어갈 자리
	  
  });
  <!-- 비품추가하기 버튼 클릭시 -->
  
  
  // === 소분류 pk === //
  let assetDetailNoArr = [];
  
  const assetDetailNo_list = $('input[name="assetDetailNo"]');
  
  const assetDetailNo_arr = Array.from(assetDetailNo_list);
  
  assetDetailNo_arr.forEach(function(item, index){
	
	assetDetailNoArr.push($(item).val());
	
  });
  let str_assetDetailNoArr = assetDetailNoArr.join(",");
  $('input[name="totalAssetDetailNo"]').val(str_assetDetailNoArr);
  // === 소분류 pk === //
  
  
  
  
  // === 비품 체크박스 클릭 == //
  $(document).on('click', 'input.InformationContents', e=>{
	  InformationContentsArr = [];	
	
	  const informationContents_list = $('input.InformationContents');
	  
	  const informationContents_arr = Array.from(informationContents_list);
	  
	  informationContents_arr.forEach(function(item, index){
		if (item.checked) {
            $(item).val('0');  // 체크된 경우 값 0
        } else {
            $(item).val('1');  // 체크 안 된 경우 값 1
        }
				
		InformationContentsArr.push($(item).val());
	  });
	  let str_InformationContentsArr = InformationContentsArr.join(",");
	  $('input[name="totalInformationContents"]').val(str_InformationContentsArr);
  });
  // === 비품 체크박스 클릭 == //
  
  
  // === 비품 취소버튼 == //
  $('#resetFixtures').click(e=>{
	  
	  inputReset(); // 모든 배열, input태그를 reset해주는 메소드
	  
	  
  });
  // === 비품 취소버튼 == //
  
  
  
  // === 비품 추가버튼 == //
  $('#insertFixtures').click(e=>{
	  
	
	  let cnt = 0;
	  let pass = false;
	  let str_nameList = $('input[name="totalFixturesName"]').val();
	  
	  // ===== 배열에 있는 값들을 이용해 하는 유효성 검사 ===== //
	  if(str_nameList != "") { // str_nameList 에 내용물이 있다는 것은 추가컬럼이 생겼다는 뜻
	  
		  let nameList_arr = str_nameList.split(","); // for문을 돌리기 위해 배열로 변경
		  
		  nameList_arr.forEach(function(name, index){
			  
			  if($(`input[name="\${name}"]`).val() == "") {
				 cnt++; // 비어있는 input 태그 하나당 +1
			  } 
		  });
		  
		  if(cnt > 0) { // 경고문구를 한번만 띄우기 위함
			 alert("비품명을 입력해주세요", cnt);
		  }
		  else{
			//////////////////////////////////////
	 	    fixturesArr = [];	
	 				
	 	    const InformationTitle_list = $('input.InformationTitle');
	 	  
	 	    const InformationTitle_arr = Array.from(InformationTitle_list);
	 	  
	 	    InformationTitle_arr.forEach(function(item, index){
	 		
	 		  fixturesArr.push($(item).val());
	 	    });
	 	    let str_fixturesArr = fixturesArr.join(",");
	 	    $('input[name="totalFixtures"]').val(str_fixturesArr);  
	 	    //////////////////////////////////////
			
			 pass = true;
			 
			 
				  
		  }
		  
	  }
	  // ===== 배열에 있는 값들을 이용해 하는 유효성 검사 ===== //
	  
	  
	  if(pass) { // pass 상태가 true라면 ajax 데이터 전송
		  
		
		
		  $.ajax({
			  url:"<%=ctxPath%>/reservation/addFixtures",
			  type:"post",
			  data:{"str_informationTitle":$('input[name="totalFixtures"]').val(),					/* 비품 이름들 str */
					"fk_assetdetailno":$('#selectAsset').val(),										/* 비품 이름 넣을 pk */
					"str_release":$('input[name="totalInformationContents"]').val()},               /* 비품 공개여부 str */
			  dataType:"json",
			  success:function(json){
				  
				  if(json.result == 1){
				  	  alert('저장되었습니다.');
				  	  // ====== 다시 불러주기 ====== //
				  	  
				  	  inputReset(); // input, 배열 모든 거 리셋
				  	  appendInformation(); // 정보들 다시 쌓아주기 
				  	  
				  	  // ====== 다시 불러주기 ====== //
				  }
				  else{
					  alert('비품등록에 실패하였습니다.');  
				  }
				  
				  
			  },
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  } 
		  });
		  
	  }
	  else if(!pass & str_nameList == "") {
		  alert('비품추가하기 버튼을 클릭 또는 비품명을 입력해주세요');
	  }
	  
	 
  });
  // === 비품 추가버튼 == //
  <%-- === 비품을 insert 하기 위한 것 === --%>
		  
  
  
  
  
  
  
  
  
  
  // === 비품추가 모달창 띄우기 === //
  $('#addAsset').click(e=>{
	
	$('#assetModalBg').fadeIn();
	$('.modal_containerAsset').fadeIn();
	
  });
  
  
  $('#assetModalBg:not(#assetModal)').click(e=>{

      $('#assetModalBg').fadeOut();
	  $('.modal_containerAsset').fadeOut();

  })
  // === 비품추가 모달창 띄우기 === //
  

  
  $('#goAddAsset').click(e=>{
	
	  if($('input[name="assetName"]').val() == "") {
		  alert('자산명을 입력해주세요')
	  }
	  else{
		  $.ajax({
			url:"<%=ctxPath%>/reservation/addAsset",
		    type:"post",
		    data:{"assetName":$('input[name="assetName"]').val(),
				  "fk_assetNo":"${requestScope.assetvo.assetNo}"},
		    dataType:"json",
		    success:function(json){
				if(json.result == 1){
				  	  alert('저장되었습니다.');
				  	  // ====== 다시 불러주기 ====== //
					  $('#appendTrFinal').empty();
				  	  
					  $('#assetModalBg').fadeOut();
					  $('.modal_containerAsset').fadeOut();

					  resetLeftBar(); // 왼쪽바 새로고침
					  
					  selectAssetDe(); // 자산 새로 불러주기
				  	  // ====== 다시 불러주기 ====== //
				  }
				  else{
					  alert('자산등록에 실패하였습니다.');  
				  }
		    },
		    error: function(request, status, error){
		 	    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		    } 
		  })
	  }
	
  })
  
  
  // ======= 자산정보들 불러주기 ======= //
  selectAssetDe();
  
  function selectAssetDe() {
	  $('#appendTrFinal').empty();
	  
	  
	  $.ajax({
		url:"<%=ctxPath%>/reservation/selectAssetDe",
	    type:"post",
	    data:{"fk_assetNo":"${requestScope.assetvo.assetNo}"},
	    dataType:"json",
	    success:function(json){
			// console.log(JSON.stringify(json));
			let t_html = ``;
			
			if(json.length == 0){
				$('#appendTrFinal').append(`<tr>
												<td colspan="4" style="color: #999;">등록된 자산정보가 없습니다.</td>
											</tr>`);
			}
			else{

				$.each(json, function(index, item){
						
					 $('#appendTrFinal').append(`<tr>
													<td>\${item.assetDetailNo}</td>
													<td>\${item.assetName}</td>
													<!--<td>X</td>-->
													<td><i style="cursor:pointer;" class="fa-solid fa-gear fixbtn" id="\${item.assetDetailNo}"></i></td>
													<td><i class="fa-solid fa-trash trashbtn" id="\${item.assetDetailNo}" style="cursor:pointer;"></i></td>
												</tr>`);
					 
					 t_html += `<option value="\${item.assetDetailNo}">\${item.assetName}</option>`;
					 
				 }) // end of $.each(json, function(index, item)) {} ------------------- 
				
				 
			 }
			 $('.selectHere').empty();
 			 $('.selectHere').append(`
 					 <select id="selectAsset" style="font-size: 14px;">
 					 	<option hidden>선택하세요</option>
 					 	\${t_html}
 					 </select>
 			 `);
			 
			 
			 
		},
	    error: function(request, status, error){
	 	    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	    } 
	  });
  }
  
  
  
  // ======= 두번째 탭에서 select 태그 변경 ======= //
  $(document).on('change', '#selectAsset', e=>{
	  // alert( $(e.target).val())
	  appendInformation();
	  
  })
  // ======= 두번째 탭에서 select 태그 변경 ======= //
  
  
  // ======= 두번째 탭에서 삭제버튼 (비품 하나 삭제하기) ======= //
  $(document).on('click', '.midDeleteOne', e=>{
	  
	  // alert($(e.target).attr('id'));
	  
	  $.ajax({
		  url:"<%= ctxPath%>/reservation/midDeleteOne",
		  type:"post",
		  data:{"assetInformationNo":$(e.target).attr('id')},
		  dataType:"json",
		  success:function(json){
			
			if(json.result == 1){
				alert('비품삭제에 성공했습니다.')
				 
				//selectAssetDe(); // 자산 새로 불러주기
				appendInformation(); // 비품 새로고침
			}
			else {
				alert('해당 비품삭제에 실패했습니다.')
			}
			  
		  },
		  error: function(request, status, error){
  	 	      alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
  	      } 
		  
	  })
	  
  }); // end of $(document).on('click', '.midDeleteOne', e=>{})----------
//======= 두번째 탭에서 삭제버튼 (비품 하나 삭제하기) ======= //
  
  <%-- ============== 2번째 탭 ============== --%>
  
  
  
  
  <%-- ============== 3번째 탭 ============== --%>
  //================ 대분류 소분류 뿌려주기 ================ //
  function resetLeftBar() {
	  let assetDetailListArr;
	  
	  $.ajax({
	  	  url: "<%= ctxPath%>/reservation/selectReservationSubTitle",
	      type: "get",
	      dataType: "json",
	      async:false,
	      success: function(json) {
	          // console.log(JSON.stringify(json))
	          
	          	  assetDetailListArr = json;
	          
	          	  // alert(assetDetailListArr)
	          
	          	  
	          
	      },
	      error: function(request, status, error) {
	          alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
	      }
	  });
	  
	  // ================ 소분류 끝나고 대분류 조회 시작 후 뿌려주기 ================ //
	  let TitleArr;
	  let html = ``;
	  
	  $.ajax({
	  	  url: "<%= ctxPath%>/reservation/selectReservationTitle",
	      type: "get",
	      dataType: "json",
	      async:false,
	      success: function(json) {
	          // console.log(JSON.stringify(json))
	          
	          TitleArr = JSON.stringify(json);
	          
	          // alert(TitleArr)
	          
			  $('.board_menu_container > ul').empty();
		
	          $.each(json, function(index, Title){
	        	    let detailListHtml = ''; // 자산 상세 리스트를 저장할 빈 문자열 초기화
	        	          
	        	    // assetDetailListArr 배열을 순회하면서 자산 세부 항목들을 생성
	        	    $.each(assetDetailListArr, function(i, subTitle){
	        	        // 실제 if문을 넣어서 조건을 처리합니다.
	        	        if (Title.assetNo == subTitle.fk_assetNo) {
	        	            // 조건이 맞으면 해당 항목을 detailListHtml에 추가
	        	            detailListHtml += `<a href='<%= ctxPath %>/reservation/showReservationDeOne?assetDetailNo=\${subTitle.assetDetailNo}&assetName=\${subTitle.assetName}'>
	        	                                   <div>\${subTitle.assetName}</div>
	        	                                </a>`;
	        	        } else {
	        	            
	        	        	// detailListHtml += `<div>없습니다.</div>`
	        	        }
	        	    });

	        	    // 자산 상세 HTML을 최종적으로 추가
	        	    
	        	    
	        	    $('.board_menu_container > ul').append(`
	        	        <li>
	        	            <div>
	        	                <div class="assetTitleBtn" style="justify-content: space-between; display: flex;">
	        	                <span><a href='<%= ctxPath %>/reservation/assetDetailPage?assetNo=\${Title.assetNo}&assetTitle=\${Title.assetTitle}'>\${Title.assetTitle}</a></span>
	        	                    <span>
	        	                        <a href="<%= ctxPath %>/reservation/showReservationOne?assetNo=\${Title.assetNo}">
	        	                            <i class="fa-solid fa-gear"></i>
	        	                        </a>
	        	                        <i class="fa-solid fa-trash disableBoardIcon deleteAsset" id="\${Title.assetNo}"></i>
	        	                    </span>
	        	                </div> <!-- 대분류 명 -->
	        	                <div class="assetDetailList" id="\${Title.assetNo}" style="display:none;">
	        	                    \${detailListHtml} <!-- 동적으로 생성된 자산 세부 항목들 -->
	        	                </div>
	        	            </div>
	        	        </li>
	        	    `);
	        	});

	      },
	      error: function(request, status, error) {
	          alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
	      }
	  });
  }
  resetLeftBar();
  // ================ 대분류 소분류 뿌려주기 ================ //
  
  
  
  $(document).on('click', '.trashbtn', function(e){
	  
	  // alert($(e.target).attr('id'))
	  
	  if(confirm("삭제시 코드 "+$(e.target).attr('id')+"에 대한 예약 정보가 사라집니다. 정말 삭제하시겠습니까?")){
	  
		  $.ajax({
			  url:"<%=ctxPath%>/reservation/deleteAssetNo",
			  type:"post",
			  data:{"assetDetailNo":$(e.target).attr('id')},
			  dataType:"json",
			  success:function(json){
				  
				  if(json.result == 1) {
					  alert('삭제가 완료되었습니다.')
					  
					  resetLeftBar();
					  selectAssetDe();
				  }
				  else{
					  alert('삭제가 실패되었습니다.')
				  }
				  
				  
			  },
			  error: function(request, status, error){
			 	  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  } 
		  })
	  
	  }
	  
  }); // end of $(document).on('click', 'trashbtn', e=>{})----------- 
  
  
  
  
  // ============ 수정버튼 클릭시 해당 비품 불러와서 modal 띄우기 ============ //
  $(document).on('click', '.fixbtn', e=>{
  
	// 모달창 title 값 뿌려두기 //
	$('.fixNo').text($(e.target).attr('id'));
	$('input.assetName').val($(e.target).parent().prev().text());
	// 모달창 title 값 뿌려두기 //
	
	$('.informationTitleAppend').empty();
	
	// alert($(e.target).attr('id'))
	$.ajax({
	  url:"<%=ctxPath%>/reservation/fixSelectAssetNo",
	  type:"post",
	  data:{"fk_assetDetailNo":$(e.target).attr('id')},
	  dataType:"json",
	  success:function(json){
		console.log(JSON.stringify(json))
		/*
		[{"assetInformationNo":"100006","InformationContents":"X","release":"0","assetDetailNo":"100029","InformationTitle":"확인","assetName":"Edge"}
		,{"assetInformationNo":"100009","InformationContents":"X","release":"0","assetDetailNo":"100029","InformationTitle":"테스트","assetName":"Edge"}]
		*/
		
		let c_html = ``;
		let appendcheck = ``;
		
		if(json.length == 0) { // 비품이 존재하지 않는 경우
			c_html += `<tr><td colspan="3" style="text-align: center; color:#999;">등록된 비품이 없습니다.</td></tr>`;
		}
		else{ // 비품이 존재하는 경우

			$.each(json, function(index, item){
				
				c_html += `<tr>
		                   	 <td> <input type="text" name="InformationTitle" value="\${item.InformationTitle}"/> <input type="hidden" name="assetInformationNo" value="\${item.assetInformationNo}" /></td>`;
				
				if(item.release == '0') { // 공개 / 비공개 여부가 0인 경우
					c_html+= `<td><input type="checkbox" name="release" id="mailOneCheck" checked /></td>`;
				}
				else{ // 공개 / 비공개 여부가 1인 경우
					c_html+= `<td><input type="checkbox" name="release" id="mailOneCheck" /></td>`;
				}
				
				
	            c_html += `<td> <input type="text" name="InformationContents" value="\${item.InformationContents}"/> </td></tr>`;
		    });
		}
		
		$('.informationTitleAppend').append(c_html);
		
		
		$('#assetModalBg2').fadeIn();
		$('#assetModal2').fadeIn();
		  
	  },
	  error: function(request, status, error){
	 	  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	  } 
  })
	
	
	
  }) // end of $(document).on('click', '.fixbtn', e=>{})----------------
  // ============ 수정버튼 클릭시 해당 비품 불러와서 modal 띄우기 ============ //
  
  
  // === 비품수정창 모달창 닫기 === //
  $('#assetModalBg2:not(#assetModal2)').click(e=>{
    $('#assetModalBg2').fadeOut();
    $('#assetModal2').fadeOut();
  })
  
  $('#closeAssetModal2').click(e=>{
	$('#assetModalBg2').fadeOut();
	$('#assetModal2').fadeOut();
  })
  // === 비품수정창 모달창 닫기 === //
  
  
  
  
  $('#GofixInfo').click(e=>{
	// alert('go!')
	
	// alert($('.fixNo').text())      				// 자산명 변경시 pk
	// alert($('input.assetName').val()) 			// 자산명 변경시 자산명
	
	//////////////// 비품들 정보 구하기 ///////////////
	InformationTitle_arr = Array.from( $('input[name="InformationTitle"]'));
	InformationTitle_arr_str = [];
	
	InformationContents_arr = Array.from($('input[name="InformationContents"]'));
	InformationContents_arr_str = [];
	
	assetInformationNo_arr = Array.from($('input:hidden[name="assetInformationNo"]'));
	assetInformationNo_arr_str = [];
	
	for(let i=0; i<InformationTitle_arr.length; i++){
		// console.log(InformationTitle_arr[i])
		InformationTitle_arr_str.push($(InformationTitle_arr[i]).val())         // 비품명
		InformationContents_arr_str.push($(InformationContents_arr[i]).val())	// 비품 상태
		assetInformationNo_arr_str.push($(assetInformationNo_arr[i]).val())		// 비품 pk
	}
	InformationTitle_str = InformationTitle_arr_str.join(",");			// 비품명
	InformationContents_str = InformationContents_arr_str.join(",");	// 비품 상태
	assetInformationNo_str = assetInformationNo_arr_str.join(",");		// 비품 pk
	// alert(InformationTitle_str) // 비품명
	
	/////////////////////// 아래는 체크박스를 위한 것
	
	release_arr = Array.from($('input[name="release"]'));
	release_arr_str = [];
	
	release_arr.forEach(function(item, index){
		if (item.checked) {
            $(item).val('0');  // 체크된 경우 값 0
        } else {
            $(item).val('1');  // 체크 안 된 경우 값 1
        }
		
		release_arr_str.push($(item).val());
	})
	
	release_str = release_arr_str.join(",");							// 비품 공개유무
	//////////////// 비품들 정보 구하기 ///////////////
	
	//console.log("InformationTitle_str 확인 : ", InformationTitle_str);
	//console.log("InformationContents_str 확인 : ", InformationContents_str);
	//console.log("release_str 확인 : ", release_str);
	/*
		InformationTitle_str 확인 :  화이트보드,빔프로젝트
		InformationContents_str 확인 :  O,X
		release_str 확인 :  0,1
	*/
	
	
	
	$.ajax({
		url:"<%= ctxPath%>/reservation/GofixInfo",
		data:{"assetDetailNo": $('.fixNo').text(),
			  "assetName":$('input.assetName').val(),
		  	  "InformationTitle_str":InformationTitle_str,
		  	  "InformationContents_str":InformationContents_str,
		      "release_str":release_str,
		  	  "assetInformationNo_str":assetInformationNo_str},
		type:"post",
		dataType:"json",
		success:function(json) {
			console.log(JSON.stringify(json));
			
			if(json.result == 1){
				alert('비품수정이 완료되었습니다.')
				
				$('#assetModalBg2').fadeOut();
				$('#assetModal2').fadeOut();
				
				//// 새로고침 ////
				selectAssetDe();
				$('#appendTrMiddle').empty();
				$('#appendTrMiddle').append(`
				 <tr>
                    <td colspan="3"
                       style="text-align: center; height: 100px; vertical-align: middle; color: #999;">비품추가를
                       원하는 자산을 선택해주세요</td>
                 </tr>
				`);
			}
			else{
				alert('비품 수정에 실패하였습니다.')
			}
			
		},
		error: function(request, status, error){
	 	    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	    } 
	})
		
  }) // end of $('#GofixInfo').click(e=>{})-----------
  
  
  <%-- ============== 3번째 탭 ============== --%>
  
  
  
  
  
  function inputReset() {
	  fixturesCnt = 0;
	  fixturesArr = [];
	  InformationContentsArr = [];
	  totalfixturesArr = [];
	  
	  $('.addFixtures_tr').remove();
	  $('input[name="totalFixtures"]').val("");
	  $('input[name="totalFixturesName"]').val("");
	  $('input[name="totalInformationContents"]').val("");
  }
  
  
  
  function appendInformation() {
	  $.ajax({
		 url:"<%= ctxPath%>/reservation/selectInformation",
		 data:{"fk_assetdetailno": $('#selectAsset').val()},
		 type:"get",
		 dataType:"json",
		 success:function(json) {
			 console.log(JSON.stringify(json));
			 // 타이틀 공개여부
			 $('#appendTrMiddle').empty();
			 
			 
			 $('#appendTrMiddle').append(`
				 <tr>
					<td>ID값</td>
					<td><input type="checkbox" id="mailOneCheck" style="pointer-events: none;" checked /></td>
					<td>삭제불가</td>
				 </tr>
				
				 <tr>
					<td>항목명</td>
					<td><input type="checkbox" id="mailOneCheck" style="pointer-events: none;" checked/></td>
					<td>삭제불가</td>
				 </tr>
			 `);
			 
			 
			 let appendList = ``;
			 
			 $.each(json, function(index, item){
				 appendList+= `<tr>
							     <td>\${item.InformationTitle}</td>`;

									if(item.release == '0') {
										appendList+= `<td><input type="checkbox" id="mailOneCheck" style="pointer-events: none;" checked /></td>`;
									}
									else{
										appendList+= `<td><input type="checkbox" id="mailOneCheck" style="pointer-events: none;" /></td>`;
									}
							
				 appendList+= `<td><span class="midDeleteOne" id="\${item.assetInformationNo}">삭제</span></td>
						 </tr>`;
			 
			 })
			 $('#appendTrMiddle').append(`\${appendList}`);
			 
		 },
		 error: function(request, status, error){
	 	     alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	     } 
	  });
  }
  
</script>

<jsp:include page="../../footer/footer.jsp" />
