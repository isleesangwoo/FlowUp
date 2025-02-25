$(document).ready(()=>{
	let deleteFileList = []; // 삭제할 파일을 저장할 배열
//	<%-- === jQuery 를 사용하여 드래그앤드롭(DragAndDrop)을 통한 파일 업로드 시작 === --%>
			let file_arr = []; // 첨부된어진 파일 정보를 담아 둘 배열

	        // == 파일 Drag & Drop 만들기 == //
		    $("div#update_fileDrop").on("dragenter", function(e){ /* "dragenter" 이벤트는 드롭대상인 박스 안에 Drag 한 파일이 최초로 들어왔을 때 */ 
		        e.preventDefault();
		        e.stopPropagation();
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
		        if(files != null && files != undefined){
		        	for(let i=0; i<files.length; i++){
		                const f = files[i];
		                const fileName = f.name;  // 파일명
		                const fileSize = f.size;  // 파일크기
		            } // end of for------------------------
		            
		            let html = "";
		            const f = files[0]; // 어차피 files.length 의 값이 1 이므로 위의 for문을 사용하지 않고 files[0] 을 사용하여 1개만 가져오면 된다. 
		        	let fileSize = f.size/1024/1024;   /* 파일의 크기는 MB로 나타내기 위하여 /1024/1024 하였음 */
		        	
		        	if(fileSize >= 10) {
		        		alert("10MB 이상인 파일은 업로드할 수 없습니다.");
		        		$(this).css("background-color", "#fff");
		        		return;
		        	}
		        	
		        	else {
		        		file_arr.push(f); //  드롭대상인 박스 안에 첨부파일을 드롭하면 파일들을 담아둘 배열인 file_arr 에 파일들을 저장시키도록 한다. 
			        	const fileName = f.name; // 파일명	
		        	
		        	    fileSize = fileSize < 1 ? fileSize.toFixed(2) : fileSize.toFixed(1);
		        	    
		        	    html += 
		                    "<div class='fileList'>" +
		                        "<span class='delete'>&times;</span>" +  // &times; 는 x 로 보여주는 것이다.  
		                        "<span class='fileName'> "+fileName+"</span>" +
		                        "<span class='fileSize'> ("+fileSize+"MB)</span>" +
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
		    	//alert("인덱스 : " + idx );
				var fileNo = $(this).siblings(".fileNo").text(); // `.delete`와 같은 `.fileList` 안에 있는 `.fileNo` 찾기
				var fileName = $(this).siblings(".fileName").text();
				var newFileName = $(this).siblings(".newFileName").text();
		    	file_arr.splice(idx,1); // 드롭대상인 박스 안에 첨부파일을 드롭하면 파일들을 담아둘 배열인 file_arr 에서 파일을 제거시키도록 한다. 
		   
				deleteFileList.push({
				            fileNo: fileNo,
				            fileName: fileName,
				            newFileName: newFileName
				        });
				    
	            $(e.target).parent().remove(); // <div class='fileList'> 태그를 삭제하도록 한다. 	    
		    });

	
			//전역변수
		    var obj = [];
		    
		    //스마트에디터 프레임생성
		    nhn.husky.EZCreator.createInIFrame({
		        oAppRef: obj,
		        elPlaceHolder: "updateContent",
		        sSkinURI: ctxPath+"/smarteditor/SmartEditor2Skin.html",
		        htParams : {
		            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		            bUseToolbar : true,            
		            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		            bUseVerticalResizer : true,    
		            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		            bUseModeChanger : true,
		        }
		    });
			
	$("#update_isNoticeElmt").hide(); // 공지사항 등록 미체크시 hide 상태
	if($("input[name='isNotice']").is(':checked') == true){ // 체크박스에 체크가 되었을 경우
				$("#update_isNoticeElmt").show();
			 }
    // ========= 정렬버튼 토글 ========= //
    $('#sort_btn').click(e=>{

        $('#sort_btn > ul').fadeToggle();

    }); // end of $('#sort_btn').click(e=>{})-------------
    // ========= 정렬버튼 토글 ========= //



    // ========= 정렬 인원수 버튼 토글 ========= //
    $('#sortCnt_btn').click(e=>{

        $('#sortCnt_btn > ul').fadeToggle();

    }); // end of $('#sort_btn').click(e=>{})-------------

    $('#sortCnt_btn > ul li').click(e=>{
        
        const listIndex = $(e.target).index();
        const liInfo = $('#sortCnt_btn > ul li').eq(listIndex).text();
        $('#sortCnt_btn > span:nth-child(1)').html(liInfo);

    });
    // ========= 정렬 인원수 버튼 토글 ========= //
	
	// ========= 글쓰기버튼 토글 ========= //

    $('#postUpdate').click(e=>{

        $('#modalEditPost').fadeIn();
        $('.modalEditPostContainer').css({
            'width': '70%'
        })
  
    }) // end of $('#writePostBtn').click(e=>{})-----------

    $('.modal_bg:not(.modal_container)').click(e=>{

        $('#modalEditPost').fadeOut();
        $('.modalEditPostContainer').css({
            'width': '0%'
        })

    })
    // ========= 글쓰기버튼 토글 ========= //
	
	
	
	// 삭제 버튼 클릭 시 
	$("#postDel").click(function(){
		if(confirm("정말로 글을 삭제하시겠습니까?")) {
		   const frm = document.postFrm;
		   frm.method = "post";
		   frm.action = ctxPath+"/board/postDel";
		   frm.submit();   
	    }
	});

	// === 공지로 등록 체크박스 클릭 시 === //
    $(document).on("change", "input[name='isNotice']", function(e) {
 	
	    if($("input[name='isNotice']").is(':checked') == true){ // 체크박스에 체크가 되었을 경우
		$("#update_isNoticeElmt").show();
	    }
	    else{ // 체크가 안되었을 경우
		   $("#update_isNoticeElmt").hide();
	    }
    }); // end of $(document).on("change", "input[name='isNotice']", function(e) {}--------------
	 
	 
	// === datepicker 시작 === //
    $("input#update_datepicker").datepicker({
         dateFormat: 'yy-mm-dd' 
        ,showOtherMonths: true  
        ,showMonthAfterYear:true 
        ,changeYear: true  
        ,changeMonth: true           
 	       ,yearSuffix: "년" 
 	       ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12']
 	       ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] 
 	       ,dayNamesMin: ['일','월','화','수','목','금','토'] 
 	       ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일']             
 	  });

     // 초기값을 오늘 날짜로 설정
	 $('input#update_datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후) 

     $(function() {
         $.datepicker.setDefaults({
              dateFormat: 'yy-mm-dd' 
             ,showOtherMonths: true 
             ,showMonthAfterYear:true
             ,changeYear: true
             ,changeMonth: true               
             ,yearSuffix: "년" 
             ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] 
             ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
             ,dayNamesMin: ['일','월','화','수','목','금','토'] 
             ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일']                
         });
  
         // input을 datepicker로 선언
         $("input#fromDate").datepicker();                    
         $("input#update_toDate").datepicker();
         
         // From의 초기값을 오늘 날짜로 설정
         $('input#fromDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
         
		 // 기존의 값이 존재하면 toDate의 초기값으로 설정
         var existingDate = $("#noticeEndDate").text(); // 기존 DB에 저장된 날짜
        
         if(existingDate) { 
             $('input#update_toDate').datepicker('setDate', existingDate); 
         } else { 
             $('input#update_toDate').datepicker('setDate', '+3D'); // 값이 없으면 3일 후로 기본 설정
         } //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
      });

     ////////////////////////////////////////////////////////////////////
     
  	 // === datepicker 끝 === //		 
	 
	 // 공지 종료일을 시작일보다 빠르게 한 경우 //
	 $(document).on("change", "#update_toDate", function() {
		if($("#update_datepicker").val() > $("#update_toDate").val()){
			alert("공지 종료일을 정확하게 입력해주세요.");
			$("#update_toDate").val("");
		}
     });
			
	
		 
	

    
	 // === 게시글 수정 버튼 클릭 시 === // 
	 	$(document).on("click", "#updatePostBtn", function(){
			
		  // 스마트 에디터 구현 시작 
		  // id가 content인 textarea에 에디터에서 대입
	      obj.getById["updateContent"].exec("UPDATE_CONTENTS_FIELD", []);
    	  // 스마트 에디터 구현 끝
		  
		  
		  // === 글제목 유효성 검사 === //
	      const subject = $("#subject").val().trim();	  
	      if(subject == "") {
	    	  alert("글제목을 입력해주세요.");
	    	  $("input:text[name='subject']").val("");
	    	  return; // 종료
	      }	
		  
		//내용 유효성 검사(스마트 에디터 사용 할 경우) 시작
          var contentval = $("textarea#updateContent").val();
          contentval = contentval.replace(/&nbsp;/gi, "");
  
          contentval = contentval.substring(contentval.indexOf("<p>")+3);
          contentval = contentval.substring(0, contentval.indexOf("</p>"));
	          
	      if(contentval.trim().length == 0) {
		      alert("내용을 입력하세요!!");
	        return;
	      }
		  //내용 유효성 검사(스마트 에디터 사용 할 경우) 끝
		    
	      var formData = new FormData($("form[name='updatePostFrm']").get(0)); // $("form[name='updatePostFrm']").get(0) 폼 에 작성된 모든 데이터 보내기 
	     	console.log("file_arr: " + file_arr.length);
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
		  
		  // 삭제 요청된 파일 목록을 formData에 추가
	      if (deleteFileList.length > 0) {
			formData.append("deleteFiles", JSON.stringify(deleteFileList)); // 배열을 문자열로 변환하여 추가
	      }

		formData.append("postNo", $("input[name='postNo']").val());  // 수정할 게시글의 번호가 필요함.
		
		 // 공지사항 체크 시 공지사항 종료일 입력 유효성 검사 
		 if($("#update_toDate").val() == "") {
		      alert("공지 종료일을 선택해주세요.");
	        return;
	      }
				  
	      $.ajax({
	          url : ctxPath+"/board/updatePost",
	          type : "post",
	          data : formData,
	          processData:false,  // 파일 전송시 설정 
	          contentType:false,  // 파일 전송시 설정 
	          dataType:"json",
	          success:function(json){
	        	   console.log("~~~ 확인용 : " + JSON.stringify(json));
	              // ~~~ 확인용 : {"result":1}
	              if(json.result == 1) {
					//post 방식인 글 조회를 get 방식으로 바꿔주어서 이렇게 함.
					location.href = location.href;
					//history.go(-1);
					
					//location.href = location.href; 
	        	    //window.location.href = ctxPath + "/board/goViewOnePost?postNo=" + $("input[name='postNo']").val()+"&goBackURL="+goBackURL;
	              }
	              else {
	            	  alert("게시글 수정에 실패했습니다.");
	              }
	          },
	          error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			      }
	      });
			
			
	 	}); // end of $(document).on("click", "#updatePostBtn", function(){}-----------

}) // end of $(document).ready(()=>{})---------