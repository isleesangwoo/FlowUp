<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
   String ctxpath = request.getContextPath();
%>
<style>
/* === 모달 시작 === */
.modal_bg{
    display: none;
    position: fixed;
    top: 0px;
    left: 0px;
    width: 100vw;
    height: 100vh;
    z-index: 10;
    background-color: rgba(0,0,0,0.2);
}

.modal_container{
    position: fixed;
    
    top: 0px;
    right: 0px;
    width: 0%;
    height: 100vh;
    z-index: 11;
    background-color: #fff;
    transition: all 0.5s cubic-bezier(0.23, 1, 0.320, 1);
}

#modal_title {
    font-size: var(--size24);
    padding-bottom: var(--size12);
    display: block;
}
/* === 모달 끝 === */


#main_section {
    display: flex;
    box-sizing: border-box;
}
#left_bar {
    position: sticky;
    top: var(--size60);
    width: var(--size250);
    height: 100vh;
    background-color: #eff4fc;
    box-sizing: border-box;
    padding: var(--size20);
    border-right: 1px solid #c8c8c8;
}

#writePostBtn {
    width: 100%;
    height: var(--size44);
    font-size: var(--size18);
    transition-duration: 150ms;
    border-width: 1px;
    border-style: solid;
    border-radius: calc(var(--size2) + var(--size2));
    align-items: center;
    text-wrap: nowrap;
    background-color: #2985db;
    border-color: #056ac9;
    color: #fff;
    margin-bottom: var(--size10);
}

.board_menu_container{
    width: 100%;
    height: auto;
}

.board_menu_container > ul li {
    width: 100%;
    height: var(--size38);
    font-size: var(--size15);
    user-select: none;
    cursor: pointer;
    display: flex;
    align-items: center;
    box-sizing: border-box;
    padding-left: var(--size10);
}

.board_menu_container > ul > li > a {
    color: #333;
    text-decoration: none;
}

.board_menu_container > ul > li:hover {
    background-color: var(--baseColor1);
}



/* 현재 페이지에 이렇게 넣어주세요! */
.board_menu_container > ul li:nth-child(1){
    background-color: #dae8f8 !important;
    color: #056ac9;
    font-weight: 600;
}

.board_menu_container > ul li:nth-child(1) > a {
    color: #056ac9;
}

/* 게시판 설정하기 링크 */
.upateBoard{
	display:inline-block;
	margin-left: auto;
}

/* 게시판 추가하기 링크 */
#addBoardContainer {
    position: absolute;
    bottom: 60px;
    width: 100%;
    left: 50%;
    transform: translateX(-50%);
    text-align: center;
   
}

#addBoard{
 	text-decoration: none;
}
/* 현재 페이지에 이렇게 넣어주세요! */
</style>


<script type="text/javascript">

var ctxPath = "<%= request.getContextPath() %>";

$(document).ready(function() {
	
	$("#isNoticeElmt").hide(); // 공지사항 등록 미체크시 hide 상태
	
	
	
 	//console.log("테스트"+$("input[name='isnotice']").is(':checked'));
	
	
	
	// === 공지로 등록 체크박스 클릭 시 === //
	 $(document).on("change", "input[name='isnotice']", function(e) {
	 	
		 if($("input[name='isnotice']").is(':checked') == true){ // 체크박스에 체크가 되었을 경우
			$("#isNoticeElmt").show();
		 }
		 else{ // 체크가 안되었을 경우
			$("#isNoticeElmt").hide();
		 }
		 
	 }); // end of $(document).on("click", "#disableBoardIcon", function() {} --------------

	
	
	 
	// === 게시판 목록 boardLeftBar에 나열하기 === //
    $.ajax({
        url: ctxPath + "/board/selectBoardList",
        type: "GET",
        dataType: "json",
        success: function(json) {
            let v_html = "";
            $.each(json, function(index, board) {
               v_html += `
               		
	                <li>
		                <a href='#'>`+board.boardName+`</a> 
			            <a href='<%=ctxpath%>/board/updateBoardView?boardNo=\${board.boardNo}' class='upateBoard'>
			                <i class="fa-solid fa-gear" style="margin-right:9px;"></i> <%-- 게시판 수정 아이콘 --%> 
		                </a>
		                
		                <i class="fa-solid fa-trash disableBoardIcon" data-boardno="\${board.boardNo}"></i> <%-- 게시판 삭제 아이콘 --%>
		                
	                </li>`; 
            });
            $(".board_menu_container ul li").not(":first").remove(); // 첫 번째 항목 제외하고 삭제
            $(".board_menu_container ul").append(v_html); // 새 목록 추가
        },
        error: function() {
        }
    });
    
    
    
    // === 게시판 삭제(비활성화) confirm === // 
    $(document).on("click", ".disableBoardIcon", function(e) {
    	
    	const boardNo = $(this).data("boardno");
    	
        if (confirm("해당 게시판을 삭제하시겠습니까?")) {
        	
			let listItem = $(this).closest("li"); 
			//현재 클릭한 요소에서 가장 가까운 li 요소를 찾음.
			//자신이 li이면 그대로 반환, 아니라면 부모 요소를 찾음
			
			if (!boardNo) { // boardNo가 제대로 안 넘어올 경우 오류 방지
		        alert("삭제할 게시판 번호를 찾을 수 없습니다.");
		        return;
		    }
			
            $.ajax({
                url: ctxPath + "/board/disableBoard",
                type: "POST",
                data: { "boardNo": boardNo },
                dataType: "json",
                success: function(json) {
                    if (json.n) {
                        alert("게시판이 비활성화되었습니다.");
                        listItem.remove(); // 삭제된 항목만 목록에서 제거 ==> 클릭된 아이콘의 li를 의미.
                    } else {
                        alert("비활성화 실패: " + json.message);
                    }
                },
                error: function() {
                    alert("오류가 발생했습니다.");
                }
            });
        }
    }); // end of $(document).on("click", "#disableBoardIcon", function() {} --------------

    
   	
    
    
 	// ========= 글쓰기버튼 토글 ========= //

    $('#writePostBtn').click(e=>{

        $('#modal').fadeIn();
        $('.modal_container').css({
            'width': '70%'
        })
  
    }) // end of $('#writePostBtn').click(e=>{})-----------

    $('.modal_bg:not(.modal_container)').click(e=>{

        $('#modal').fadeOut();
        $('.modal_container').css({
            'width': '0%'
        })

    })
    // ========= 글쓰기버튼 토글 ========= //
    
    
    // === 글쓰기 버튼 클릭 시 글작성 할 (접근 권한있는)게시판 목록 <select> 태그에 보여주기=== //
    $(document).on("click", "#goWrite", function() {
    	getAccessBoardList();
    });
    
    
    <%--  ==== 스마트 에디터 구현 시작 ==== --%>
	//전역변수
    var obj = [];
    
    //스마트에디터 프레임생성
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: obj,
        elPlaceHolder: "content",
        sSkinURI: "<%= ctxpath%>/smarteditor/SmartEditor2Skin.html",
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
	
	
	// === datepicker 시작 === //
    $("input#datepicker").datepicker({
        dateFormat: 'yy-mm-dd'  //Input Display Format 변경
       ,showOtherMonths: true   //빈 공간에 현재월의 앞뒤월의 날짜를 표시
       ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
       ,changeYear: true        //콤보박스에서 년 선택 가능
       ,changeMonth: true       //콤보박스에서 월 선택 가능                
   //  ,showOn: "both"          //button:버튼을 표시하고,버튼을 눌러야만 달력 표시됨. both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시됨.  
   //  ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
   //  ,buttonImageOnly: true   //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
   //  ,buttonText: "선택"       //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
       ,yearSuffix: "년"         //달력의 년도 부분 뒤에 붙는 텍스트
       ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
       ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
       ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
       ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
   //  ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
   //  ,maxDate: "+1M" //최대 선택일자(+1D:하루후, +1M:한달후, +1Y:일년후)                
   });

   // 초기값을 오늘 날짜로 설정
	$('input#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후) 

   // === 전체 datepicker 옵션 일괄 설정하기 ===  
   //     한번의 설정으로 $("input#fromDate"), $('input#toDate')의 옵션을 모두 설정할 수 있다.
    $(function() {
        //모든 datepicker에 대한 공통 옵션 설정
        $.datepicker.setDefaults({
             dateFormat: 'yy-mm-dd' //Input Display Format 변경
            ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
            ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
            ,changeYear: true //콤보박스에서 년 선택 가능
            ,changeMonth: true //콤보박스에서 월 선택 가능                
         // ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시됨. both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시됨.  
         // ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
         // ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
         // ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
            ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
            ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
            ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
            ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
            ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
         // ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
         // ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
        });
 
        // input을 datepicker로 선언
        $("input#fromDate").datepicker();                    
        $("input#toDate").datepicker();
        
        // From의 초기값을 오늘 날짜로 설정
        $('input#fromDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
        
        // To의 초기값을 3일후로 설정
        $('input#toDate').datepicker('setDate', '+3D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
     });

    ////////////////////////////////////////////////////////////////////
    
    $("input#datepicker").bind("keyup", e => {
        $(e.target).val("").next().show();
    }); // 공지사항 등록일에 키보드로 입력하는 경우 
    
 	// === datepicker 끝 === //
	
 	
 	// === 게시글 등록 버튼 클릭 시 === // 
	$(document).on("click", "#addPostBtn", function(){
		goaddPost(obj);
	});
	
	
    
}); // end of $(document).ready(function() {})----------------------
    
    
    
	//////////Function Declare //////////
	
	// === 글쓰기 버튼 클릭 시 글작성 할 (접근 권한있는)게시판 목록 <select> 태그에 보여주기 === //
	function getAccessBoardList(){
		
		$.ajax({
	        url: ctxPath + "/board/getAccessibleBoardList",
	        type: "GET",
	        data: { "employeeNo": "100013" }, // 로그인된 직원의 사원번호를 내가 임의로 입력해줌 추후 변경 해야함.
	        dataType: "json",
	        success: function(json) {
	            let options = `<option value="">게시판 선택</option>`; // 기본 옵션
	            let inputTag;
	            $.each(json, function(index, board) {
	                options += `<option value='\${board.boardno}'>`+board.boardname+`</option>`;
	                inputTag += `<input type="text" name="fk_boardno" value='\${board.boardno}'/>`;
	                
	                
	            });
	            $("select[name='fk_boardNo']").html(options);
	            $("#inputTag").html(inputTag);
	        },
	        error: function(xhr, status, error) {
	            console.error("게시판 목록 불러오기 실패:", error);
	            alert("게시판 목록을 불러오는 중 오류가 발생했습니다.");
	        }
	    });
		
	}// end of function getAccessBoardList(){}------------------
	
	// === 글 등록하기 함수 === // 
	function goaddPost(obj){
		
	   <%-- === 스마트 에디터 구현 시작 === --%>
	   // id가 content인 textarea에 에디터에서 대입
       obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	   <%-- === 스마트 에디터 구현 끝 === --%>
	  
	  
	  // === 글제목 유효성 검사 === //
      const subject = $("input:text[name='subject']").val().trim();	  
      if(subject == "") {
    	  alert("글제목을 입력해주세요.");
    	  $("input:text[name='subject']").val("");
    	  return; // 종료
      }	
	  
	  // === 글내용 유효성 검사(스마트 에디터를 사용할 경우) ===
	  let content_val = $("textarea[name='content']").val().trim();
	  
  	  //  alert(content_val);  // content 에 공백만 여러개를 입력하여 쓰기할 경우 알아보는 것.
      //  <p>&nbsp; &nbsp; &nbsp; &nbsp;</p> 이라고 나온다.
    
      content_val = content_val.replace(/&nbsp;/gi, "");  // 공백(&nbsp;)을 "" 으로 변환
      /*    
	         대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
		   ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
		               그리고 뒤의 gi는 다음을 의미합니다.
		
		   g : 전체 모든 문자열을 변경 global
		   i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
      */
      // alert(content_val);
      // <p>                                      </p>
   
      content_val = content_val.substring(content_val.indexOf("<p>")+3);
      // alert(content_val);
	  //                                       </p>
	  
      content_val = content_val.substring(0, content_val.indexOf("</p>"));
      // alert(content_val);
     
      if(content_val.trim().length == 0) {
    	  alert("글 내용을 입력해주세요.");
    	  return; // 종료
      }
      
      
    	  
      // 폼(form)을 전송(submit)
      const frm = document.addPostFrm;
      frm.method = "post";
      frm.action = ctxPath + "/board/addPost";
      frm.submit();
	
      }// end of function goaddPost(){}--------------------------------
      
      
</script>


<style>

#uploadFile{
	width : 100%;
	border: dashed 1px gray;
}

</style>


<!-- 글작성 폼 -->
    <div id="modal" class="modal_bg">
    </div>
    <div class="modal_container">
	    <div style="padding: var(--size22);">
	        <!-- 여기에 글작성 폼을 만들어주세요!! -->
			<span id="modal_title">글쓰기</span>
			
			<div id="modal_content_page">
				<form name="addPostFrm" enctype="multipart/form-data">
					<span>To.</span>
					<select name="fk_boardNo">
					</select>
					<div id="inputTag"></div>
					<hr>
					
					<table>
						<tr>
							<td>제목</td>
							<td><input type="text" name="subject"></td>
						</tr>
						<tr>
							<td>파일첨부</td>
							<td>
								<div id="uploadFile">
									<p>이 곳에 파일을 드래그 하세요. 또는</p>
									<span class="btn_file">
										<span class="txt">파일선택</span>
										<input type="file" name="file" title="파일선택" multiple="" accept="undefined">
									</span>
								</div>
							</td>
						</tr>
						<tr>
						     <td>내 용</td>
						     <td style="width: 767px; border: solid 1px red;">
						 	    <textarea name="content" id="content" rows="10" cols="100" style="width:766px; height:412px;"></textarea>
						     </td>
					  	</tr>
					  	<tr>
					  		<td>댓글작성</td>
					  		<td>
					  			<input type="radio" id="allowYes" name="allowComments" value="1" checked>
								<label for="allowYes" style="margin:0;" >허용</label>
								
								<input type="radio" id="allowNo" name="allowComments" value="0">
								<label for="allowNo" style="margin:0;">허용하지 않음</label>
					  		</td>
					  	</tr>
					  	<tr>
					  		<td>공지로 등록</td>
					  		<td>
					  			<input type="checkbox" id="isnotice" name="isNotice" value=1>
								<label for="isnotice" style="margin:0;">공지로 등록</label>
								
								<div id="isNoticeElmt"> <!-- 미체크시 hide 상태임 -->
									<input type="text" name="startNotice" id="datepicker" maxlength="10" autocomplete='off' size="4"/> 
									-
									<input type="text" name="noticeEndDate" id="toDate" maxlength="10" autocomplete='off' size="4"/>
								</div> 
					  		</td>
					  	</tr>
					</table>
					
					<button type="button" id="addPostBtn">등록</button><button type="reset">취소</button>
				</form>
			</div>
		</div>
    </div> <!-- end of <div class="modal_container"> -->
    <!-- 글작성 폼 -->
    
    
<!-- 왼쪽 사이드바 -->
  <div id="left_bar">

      <!-- === 글작성 버튼 === -->
      <button id="writePostBtn">
          <i class="fa-solid fa-plus"></i>
          <span id="goWrite">글쓰기</span>
      </button>
      <!-- === 글작성 버튼 === -->

      <div class="board_menu_container">
          <ul>
              <li>
                  <a href="#">게시판 목록</a>
              </li>
          </ul>
          
      </div>
      <div id="addBoardContainer"><a href="<%=ctxpath%>/board/addBoardView" id="addBoard">게시판 생성하기+</a></div>
  </div>
 <!-- 왼쪽 사이드바 -->