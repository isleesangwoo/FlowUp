<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
   String ctxpath = request.getContextPath();
%>
<link href="<%=ctxpath%>/css/board/boardLeftBar.css" rel="stylesheet"> 


<script type="text/javascript">

var ctxPath = "<%= request.getContextPath() %>";

$(document).ready(function() {
	
	
   // === 글작성 할 (접근 권한있는)게시판 목록 <select> 태그에 보여주기=== //
   getAccessBoardList();
   
	$("#isNoticeElmt").hide(); // 공지사항 등록 미체크시 hide 상태
	
	
	
	
	/////////////////////////////////////////////////////////////////
	
	<%-- === jQuery 를 사용하여 드래그앤드롭(DragAndDrop)을 통한 파일 업로드 시작 === --%>
		let file_arr = []; // 첨부된어진 파일 정보를 담아 둘 배열

        // == 파일 Drag & Drop 만들기 == //
	    $("div#fileDrop").on("dragenter", function(e){ /* "dragenter" 이벤트는 드롭대상인 박스 안에 Drag 한 파일이 최초로 들어왔을 때 */ 
	        e.preventDefault();
	        <%-- 
	                  브라우저에 어떤 파일을 drop 하면 브라우저 기본 동작이 실행된다. 
	                  이미지를 drop 하면 바로 이미지가 보여지게되고, 만약에 pdf 파일을 drop 하게될 경우도 각 브라우저의 pdf viewer 로 브라우저 내에서 pdf 문서를 열어 보여준다. 
	                  이것을 방지하기 위해 preventDefault() 를 호출한다. 
	                  즉, e.preventDefault(); 는 해당 이벤트 이외에 별도로 브라우저에서 발생하는 행동을 막기 위해 사용하는 것이다.
	        --%>
	        
	        e.stopPropagation();
	        <%--
	            propagation 의 사전적의미는 전파, 확산이다.
	            stopPropagation 은 부모태그로의 이벤트 전파를 stop 중지하라는 의미이다.
	                     즉, 이벤트 버블링을 막기위해서 사용하는 것이다. 
	                     사용예제 사이트 https://devjhs.tistory.com/142 을 보면 이해가 될 것이다. 
	        --%>
	    }).on("dragover", function(e){ /* "dragover" 이벤트는 드롭대상인 박스 안에 Drag 한 파일이 머물러 있는 중일 때. 필수이벤트이다. dragover 이벤트를 적용하지 않으면 drop 이벤트가 작동하지 않음 */ 
	        e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#ffd8d8");
	    }).on("dragleave", function(e){ /* "dragleave" 이벤트는 Drag 한 파일이 드롭대상인 박스 밖으로 벗어났을 때  */
	        e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#fff");
	    }).on("drop", function(e){      /* "drop" 이벤트는 드롭대상인 박스 안에서 Drag 한것을 Drop(Drag 한 파일(객체)을 놓는것) 했을 때. 필수이벤트이다. */
	        e.preventDefault();
	
	        var files = e.originalEvent.dataTransfer.files;  
	        <%--  
	            jQuery 에서 이벤트를 처리할 때는 W3C 표준에 맞게 정규화한 새로운 객체를 생성하여 전달한다.
	                     이 전달된 객체는 jQuery.Event 객체 이다. 이렇게 정규화된 이벤트 객체 덕분에, 
	                     웹브라우저별로 차이가 있는 이벤트에 대해 동일한 방법으로 사용할 수 있습니다. (크로스 브라우징 지원)
	                     순수한 dom 이벤트 객체는 실제 웹브라우저에서 발생한 이벤트 객체로, 네이티브 객체 또는 브라우저 내장 객체 라고 부른다.
            --%>
	        /*  Drag & Drop 동작에서 파일 정보는 DataTransfer 라는 객체를 통해 얻어올 수 있다. 
                jQuery를 이용하는 경우에는 event가 순수한 DOM 이벤트(각기 다른 웹브라우저에서 해당 웹브라우저의 객체에서 발생되는 이벤트)가 아니기 때문에,
	            event.originalEvent를 사용해서 순수한 원래의 DOM 이벤트 객체를 가져온다.
                Drop 된 파일은 드롭이벤트가 발생한 객체(여기서는 $("div#fileDrop")임)의 dataTransfer 객체에 담겨오고, 
                             담겨진 dataTransfer 객체에서 files 로 접근하면 드롭된 파일의 정보를 가져오는데 그 타입은 FileList 가 되어진다. 
                             그러므로 for문을 사용하든지 또는 [0]을 사용하여 파일의 정보를 알아온다. 
			*/
		//  console.log(typeof files); // object
        //  console.log(files);
            /*
				FileList {0: File, length: 1}
				0: File {name: 'berkelekle단가라포인트03.jpg', lastModified: 1605506138000, lastModifiedDate: Mon Nov 16 2020 14:55:38 GMT+0900 (한국 표준시), webkitRelativePath: '', size: 57641, …}
				         length:1
				[[Prototype]]: FileList
            */
	        if(files != null && files != undefined){
	         <%-- console.log("files.length 는 => " + files.length);  
	             // files.length 는 => 1 이 나온다. 
	         --%>   
	        	
	         <%--
	        	for(let i=0; i<files.length; i++){
	                const f = files[i];
	                const fileName = f.name;  // 파일명
	                const fileSize = f.size;  // 파일크기
	                console.log("파일명 : " + fileName);
	                console.log("파일크기 : " + fileSize);
	            } // end of for------------------------
	          --%>
	            
	            let html = "";
	            const f = files[0]; // 어차피 files.length 의 값이 1 이므로 위의 for문을 사용하지 않고 files[0] 을 사용하여 1개만 가져오면 된다. 
	        	let fileSize = f.size/1024/1024;   /* 파일의 크기는 MB로 나타내기 위하여 /1024/1024 하였음 */
	        	
	        	if(fileSize >= 10) {
	        		alert("10MB 이상인 파일은 업로드할 수 없습니다.!!");
	        		$(this).css("background-color", "#fff");
	        		return;
	        	}
	        	
	        	else {
	        		file_arr.push(f); //  드롭대상인 박스 안에 첨부파일을 드롭하면 파일들을 담아둘 배열인 file_arr 에 파일들을 저장시키도록 한다. 
		        	const fileName = f.name; // 파일명	
	        	
	        	    fileSize = fileSize < 1 ? fileSize.toFixed(3) : fileSize.toFixed(1);
	        	    // fileSize 가 1MB 보다 작으면 소수부는 반올림하여 소수점 3자리까지 나타내며, 
	                // fileSize 가 1MB 이상이면 소수부는 반올림하여 소수점 1자리까지 나타낸다. 만약에 소수부가 없으면 소수점은 0 으로 표시한다.
	                /* 
	                     numObj.toFixed([digits]) 의 toFixed() 메서드는 숫자를 고정 소수점 표기법(fixed-point notation)으로 표시하여 나타난 수를 문자열로 반환해준다. 
	                                     파라미터인 digits 는 소수점 뒤에 나타날 자릿수 로써, 0 이상 20 이하의 값을 사용할 수 있으며, 구현체에 따라 더 넓은 범위의 값을 지원할 수도 있다. 
	                     digits 값을 지정하지 않으면 0 을 사용한다.
	                     
	                     var numObj = 12345.6789;

						 numObj.toFixed();       // 결과값 '12346'   : 반올림하며, 소수 부분을 남기지 않는다.
						 numObj.toFixed(1);      // 결과값 '12345.7' : 반올림한다.
						 numObj.toFixed(6);      // 결과값 '12345.678900': 빈 공간을 0 으로 채운다.
	                */
	        	    html += 
	                    "<div class='fileList'>" +
	                        "<span class='delete'>&times;</span>" +  // &times; 는 x 로 보여주는 것이다.  
	                        "<span class='fileName'>"+fileName+"</span>" +
	                        "<span class='fileSize'>"+fileSize+" MB</span>" +
	                        "<span class='clear'></span>" +  // <span class='clear'></span> 의 용도는 CSS 에서 float:right; 를 clear: both; 하기 위한 용도이다. 
	                    "</div>";
		            $(this).append(html);
	        	}
	        }// end of if(files != null && files != undefined)--------------------------
	        
	        $(this).css("background-color", "#fff");
	    });
		
		
	    // == Drop 되어진 파일목록 제거하기 == // 
	    $(document).on("click", "span.delete", function(e){
	    	let idx = $("span.delete").index($(e.target));
	    //	alert("인덱스 : " + idx );
	    
	    	file_arr.splice(idx,1); // 드롭대상인 박스 안에 첨부파일을 드롭하면 파일들을 담아둘 배열인 file_arr 에서 파일을 제거시키도록 한다. 
	    //	console.log(file_arr);
	    <%-- 
	               배열명.splice() : 배열의 특정 위치에 배열 요소를 추가하거나 삭제하는데 사용한다. 
		                                     삭제할 경우 리턴값은 삭제한 배열 요소이다. 삭제한 요소가 없으면 빈 배열( [] )을 반환한다.
		
		        배열명.splice(start, 0, element);  // 배열의 특정 위치에 배열 요소를 추가하는 경우 
			             start   - 수정할 배열 요소의 인덱스
                         0       - 요소를 추가할 경우
                         element - 배열에 추가될 요소
             
                      배열명.splice(start, deleteCount); // 배열의 특정 위치의 배열 요소를 삭제하는 경우    
                         start   - 수정할 배열 요소의 인덱스
                         deleteCount - 삭제할 요소 개수
		--%>
	    
            $(e.target).parent().remove(); // <div class='fileList'> 태그를 삭제하도록 한다. 	    
	    });

<%-- === jQuery 를 사용하여 드래그앤드롭(DragAndDrop)을 통한 파일 업로드 끝 === --%>
	
	
	
	// === 공지로 등록 체크박스 클릭 시 === //
	 $(document).on("change", "input[name='isNotice']", function(e) {
	 	
		 if($("input[name='isNotice']").is(':checked') == true){ // 체크박스에 체크가 되었을 경우
			$("#isNoticeElmt").show();
		 }
		 else{ // 체크가 안되었을 경우
			$("#isNoticeElmt").hide();
		 }
		 
	 }); // end of $(document).on("change", "input[name='isNotice']", function(e) {}--------------

	
	
	 
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
		                
		                <i class="fa-regular fa-trash-can disableBoardIcon" data-boardno="\${board.boardNo}"></i> <%-- 게시판 삭제 아이콘 --%>
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
    }); // end of $(document).on("click", ".disableBoardIcon", function() {} --------------

    
   	
    
    
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

		if($("select[name='fk_boardNo']").val() == null){
			alert("게시판을 선택해주세요.");
			return;
		}
		
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
	  
        <%-- === 내용 유효성 검사(스마트 에디터 사용 할 경우) 시작 === --%>
	    var contentval = $("textarea#content").val();
	        
	    // 내용 유효성 검사 하기 
	    // alert(contentval); // content에  공백만 여러개를 입력하여 쓰기할 경우 알아보는것.
	    // <p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</p> 이라고 나온다.
	 
	      contentval = contentval.replace(/&nbsp;/gi, ""); // 공백을 "" 으로 변환
	    /*    
		         대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
		     ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
		                  그리고 뒤의 gi는 다음을 의미합니다.
		
		 	 g : 전체 모든 문자열을 변경 global
		 	 i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
		 */ 
	    // alert(contentval);
	    // <p>             </p>
	  
	      contentval = contentval.substring(contentval.indexOf("<p>")+3);
	      contentval = contentval.substring(0, contentval.indexOf("</p>"));
	          
	      if(contentval.trim().length == 0) {
		    alert("내용을 입력하세요!!");
	      return;
	    }
	    <%-- === 내용 유효성 검사(스마트 에디터 사용 할 경우) 끝 === --%>
	    
      var formData = new FormData($("form[name='addPostFrm']").get(0)); // $("form[name='addFrm']").get(0) 폼 에 작성된 모든 데이터 보내기 
     	//console.log("file_arr: " + file_arr.length);
      if(file_arr.length > 0) { // 파일첨부가 있을 경우 
          
    	  // 첨부한 파일의 총합의 크기가 10MB 이상 이라면 메일 전송을 하지 못하게 막는다.
    	  let sum_file_size = 0;
          for(let i=0; i<file_arr.length; i++) {
              sum_file_size += file_arr[i].size;
          }// end of for---------------
            
          if( sum_file_size >= 10*1024*1024 ) { // 첨부한 파일의 총합의 크기가 10MB 이상 이라면 
              alert("첨부한 파일의 총합의 크기가 10MB 이상이라서 파일을 업로드할 수 없습니다.");
        	  return; // 종료
          }
          else { // formData 속에 첨부파일 넣어주기
        	  
        	  file_arr.forEach(function(item){
                  formData.append("file_arr", item);  // 첨부파일 추가하기.  "file_arr" 이 키값이고  item 이 밸류값인데 file_arr 배열속에 저장되어진 배열요소인 파일첨부되어진 파일이 되어진다.    
                                                      // 같은 key를 가진 값을 여러 개 넣을 수 있다.(덮어씌워지지 않고 추가가 된다.)
              });
          }
      }
  	console.log("ctxPath 확인용 : " + ctxPath);
      $.ajax({
          url : ctxPath+"/board/addPost",
          type : "post",
          data : formData,
          processData:false,  // 파일 전송시 설정 
          contentType:false,  // 파일 전송시 설정 
          dataType:"json",
          success:function(json){
        	   console.log("~~~ 확인용 : " + JSON.stringify(json));
              // ~~~ 확인용 : {"result":1}
              if(json.result == 1) {
        	     location.href= ctxPath+"/board/board"; 
              }
              else {
            	  alert("게시글 등록에 실패했습니다.");
              }
          },
          error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		      }
      });
	}); // end of $(document).on("click", "#addPostBtn", function(){}-----------------------
	
	
    
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
	            let options = `<option value="" disabled selected>게시판 선택</option>`; // 기본 옵션
	            $.each(json, function(index, board) {
	                options += `<option value='\${board.boardno}'>`+board.boardname+`</option>`;
	                
	                
	            });
	            $("select[name='fk_boardNo']").html(options);
	        },
	        error: function(xhr, status, error) {
	            console.error("게시판 목록 불러오기 실패:", error);
	            alert("게시판 목록을 불러오는 중 오류가 발생했습니다.");
	        }
	    });
		
	}// end of function getAccessBoardList(){}------------------
	
      
      
</script>

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
					<hr>
					<table>
						<tr>
							<td>제목</td>
							<td><input type="text" name="subject"></td>
						</tr>
						<tr>
							<td>파일첨부</td>
							<td>
								<div id="fileDrop" class="fileDrop border border-secondary">
									<p>이 곳에 파일을 드래그 하세요.</p>
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