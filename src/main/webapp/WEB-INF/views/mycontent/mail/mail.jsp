<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();
    //     /myspring
%>

<jsp:include page="../../header/header.jsp" />
 
<%-- 각자 페이지에 해당되는 css 연결 --%>
<link href="<%=ctxPath%>/css/email/email_main.css" rel="stylesheet">

<%-- 각자 페이지에 해당되는 js 연결 --%>
<script src="<%=ctxPath%>/js/email/email.js"></script>

<script type="text/javascript">

const ctxPath = '<%=request.getContextPath() %>';
let goBackURL = '<%= (String)request.getAttribute("goBackURL") %>';


  $(document).ready(function(){  
	  
	  
	  <%--  ==== 스마트 에디터 구현 시작 ==== --%>
		//전역변수
	    var obj = [];
	    
	    //스마트에디터 프레임생성
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: obj,
	        elPlaceHolder: "content",
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
	  
	  
	  
	  <%-- === jQuery 를 사용하여 드래그앤드롭(DragAndDrop)을 통한 파일 업로드 시작 === --%>
		let file_arr = []; // 첨부된어진 파일 정보를 담아 둘 배열

      // == 파일 Drag & Drop 만들기 == //
	    $("div#dragDropZone").on("dragenter", function(e){ /* "dragenter" 이벤트는 드롭대상인 박스 안에 Drag 한 파일이 최초로 들어왔을 때 */ 
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
		
	  
	  
	  
	  <%-- ==== 메일함 통합 ajax 시작 ==== --%>
	  function loadMailList(mailbox, currentShowPageNo = 1) {
		    const sizePerPage = 20; // 페이지 크기 (기본값)
		    
		    $.ajax({
		        url: ctxPath + "/mail/mailList", // 공통 메서드 매핑
		        type: "GET",
		        data: {
		            mailbox: mailbox, // 현재 조회중인 메일함 정보 전달
		            currentShowPageNo: currentShowPageNo, // 현재 페이지 번호
		            sizePerPage: sizePerPage // 페이지 크기
		        },
		        dataType: "json",
		        success: function(response) {
		            const data = response.mailList; // 메일 목록
		            const totalPage = response.totalPage; // 전체 페이지 수
		            const sizePerPage = response.sizePerPage; // 페이지 크기

		            // 테이블 내용 새로 채움
		            let html = "";
		            $.each(data, function(index, mail){
		                // 별 아이콘
		                let starIcon = (mail.importantStatus == 1)
		                    ? `<i class="fa-solid fa-star toggle_star" style="color:yellow;cursor:pointer;" data-mailno="${mail.mailNo}"></i>`
		                    : `<i class="fa-regular fa-star toggle_star" style="cursor:pointer;" data-mailno="${mail.mailNo}"></i>`;

		                // 메일 아이콘
		                let mailIcon = (mail.readStatus == 1)
		                    ? `<i class="fa-regular fa-envelope-open toggle_mail" style="cursor:pointer;" data-mailno="${mail.mailNo}"></i>`
		                    : `<i class="fa-regular fa-envelope toggle_mail" style="cursor:pointer;color:black;" data-mailno="${mail.mailNo}"></i>`;

		                let name = mail.employeevo ? mail.employeevo.name : '발신자 없음';
		                let size = mail.fileSize ? mail.fileSize + "KB" : "";
		                const ctxPath = "<%= ctxPath %>";
		                
		                html += `
		                <tr class="mailReadTitle">
		                    <td>
		                        <input type="checkbox" class="mailOneCheck" style="padding:4px"/>
		                    </td>
		                    <td>
		                        \${starIcon}
		                        \${mailIcon}
		                        <i class="fa-solid fa-paperclip"></i>
		                    </td>
		                    <td id="mailName">\${name}</td>
		                    <td id="mailTitle">
	                   			<a href="\${ctxPath}/mail/viewMail?mailNo=\${mail.mailNo}">
								    \${mail.subject}
								</a>
		                    </td>

		                    <td id="right-content">
		                        <span id="sendDate">\${mail.sendDate}</span>
		                        <span id="fileSize">\${size}</span>
		                    </td>
		                </tr>
		                `;
		            });

		            // 페이지바 생성
		            let pageBar = "<ul style='list-style:none;'>";
		            for (let i = 1; i <= totalPage; i++) {
		                pageBar += `<li style='display:inline-block; width:30px; font-size:12pt;'>
		                            <a href='javascript:loadMailList("${mailbox}", ${i})'>${i}</a>
		                         </li>`;
		            }
		            pageBar += "</ul>";

		            // 기존 목록 지우고 새 목록 삽입
		            $("#mailTable tbody").html(html);

		            // 페이지바 삽입
		            $("#pageBar").html(pageBar);

		            // 새 목록에 별/메일 아이콘 이벤트 재바인딩
		            bindStarToggle();
		            bindMailToggle();
		        },
		        error: function(err){
		            console.log(err);
		            alert("메일 조회 중 오류 발생");
		        }
		    });
		}
	  
	  	
		// 이벤트 위임을 사용하여 동적 요소에 이벤트 바인딩
		$(document).on("click", `#mailTable a[href^='${ctxPath}/mail/viewMail']`, function(e) {
		    e.preventDefault(); // 기본 동작(페이지 이동) 막기
		    const url = $(this).attr("href"); // 클릭한 링크의 URL 가져오기
		    window.location.href = url; // 해당 URL로 이동
		});
	  	

		// 받은메일함 조회
		$("#receivedMail").on("click", function(e){
		    e.preventDefault(); // a 태그 이동 막기
		    loadMailList("default"); // 받은메일함 조회
		});
		
		// 보낸메일함 조회
		/* 
		$("#sendMail").on("click", function(e){
		    e.preventDefault(); // a 태그 이동 막기
		    loadMailList("send"); // 보낸메일함 조회
		});
		 */
	  	
		// 휴지통 조회
		$("#deleteMail").on("click", function(e){
		    e.preventDefault(); // a 태그 이동 막기
		    loadMailList("trash"); // 휴지통 조회
		});
		
		 
		// 중요메일함 조회
		$("#importantMail").on("click", function(e){
		    e.preventDefault(); // a 태그 이동 막기
		    loadMailList("important"); // 중요메일함 조회
		});
		
		// 임시메일함 조회
		$("#saveMail").on("click", function(e){
		    e.preventDefault(); // a 태그 이동 막기
		    loadMailList("save"); // 중요메일함 조회
		});
		<%-- ==== 메일함 통합 ajax 끝 ==== --%>
	  
	  

	  <%-- 별(중요표시) 클릭시 변경 ajax 함수 시작 --%>
	    function bindStarToggle() {
	        // 혹시 기존 이벤트가 있을 수 있으니 off() 후 on()
	        $(".toggle_star").off("click").on("click", function(){
	            const $star = $(this);
	            const mailNo = $star.data("mailno"); // data-mailno 값
	           // const current = $star.data("important"); // 현재 상태
	            $.ajax({
	                url: ctxPath + "/mail/toggleImportant",
	                type: "POST",
	                data: { mailNo: mailNo },
	                success: function(importantStatus) {
						// 서버가 반환한 새로운 상태("0" 또는 "1")
	                    if(importantStatus === "1") {
							// 중요 상태가 됨 => CSS 색 변경, 아이콘 변경 등
	                        $star.removeClass("fa-regular").addClass("fa-solid").css("color","yellow");
	                    } else {
							// 중요 상태 해제 => 기본 아이콘/색상
	                        $star.removeClass("fa-solid").addClass("fa-regular").css("color","");
	                    }
	                },
	                error: function() {
	                    alert("서버와 통신 중 오류가 발생했습니다.(important)");
	                }
	            });
	        });
	    }
       <%-- 별(중요표시) 클릭시 변경 ajax 함수 끝 --%>
       
       
 	  <%-- 메일 아이콘 클릭시 변경 ajax 시작 --%>
	 	 function bindMailToggle() {
	      $(".toggle_mail").on("click", function(){
	          const $mail = $(this);
	          const mailNo = $mail.data("mailno");    // data_mailno 값
	          // const current = $star.data("important"); // 현재 상태
	
	          $.ajax({
	              url: "<%=request.getContextPath()%>/mail/toggleReadMail",
	              type: "POST",
	              data: { mailNo: mailNo },
	              success: function(readStatus) {
	                  // 서버가 반환한 새로운 상태("0" 또는 "1")
	                  if(readStatus === "1") {
	                      // 읽음 상태 => CSS 색 변경, 아이콘 변경 등
	                      $mail.removeClass("fa-regular fa-envelope").addClass("fa-regular fa-envelope-open")
	                      .css("color", "");
	                  } 
	                  else {
	                      // 안읽음 상태 => 기본 아이콘/색상
	                      $mail.removeClass("fa-regular fa-envelope-open").addClass("fa-regular fa-envelope")
	                      .css("color", "black");
	                  }
	              },
	              error: function() {
	                  alert("서버와 통신 중 오류가 발생했습니다.");
	              }
	          });
	       });
	 	 }
       <%-- 메일 아이콘 클릭시 변경 ajax 끝 --%>
       
       // === 페이지 로드 시, 기존 목록에 대해서 이벤트 바인딩 ===
       bindStarToggle();
       bindMailToggle();

       
       <%-- 정렬 버튼 클릭시 변경 ajax 시작 --%>
       // === 정렬 li 클릭 시 Ajax 요청 ===
       $("#sort_btn ul li.sortOption").on("click", function() {
           const sortKey = $(this).data("sortkey"); // 예: 'subject', 'sendDate', 'fileSize'

           $.ajax({
               url: ctxPath + "/mail/sortMail",
               type: "GET",
               data: { sortKey: sortKey },  // 서버에 sortKey 전송
               dataType: "json",
               success: function(data) {
                   // data: 정렬된 List<MailVO> (JSON)
                   let html = "";
                   $.each(data, function(i, mail){
                       // 별 아이콘
                       let starIcon = "";
                       if(mail.importantStatus == 1) {
                           starIcon = `<i class="fa-solid fa-star toggle_star" style="color: yellow; cursor: pointer;"
                                         data-mailno="${mail.mailNo}"></i>`;
                       } else {
                           starIcon = `<i class="fa-regular fa-star toggle_star" style="cursor: pointer;"
                                         data-mailno="${mail.mailNo}"></i>`;
                       }

                       // 메일 아이콘
                       let mailIcon = "";
                       if(mail.readStatus == 1) {
                           mailIcon = `<i class="fa-regular fa-envelope-open toggle_mail" style="cursor: pointer;"
                                         data-mailno="${mail.mailNo}"></i>`;
                       } else {
                           mailIcon = `<i class="fa-regular fa-envelope toggle_mail" style="cursor: pointer; color: black;"
                                         data-mailno="${mail.mailNo}"></i>`;
                       }

                       // 파일크기 표시 (있다면)
                       let size = mail.fileSize ? mail.fileSize + "KB" : "";
                       // 보낸사람 이름
                       let name = mail.employeevo ? mail.employeevo.name : "";

                       // 테이블 행 HTML
                       html += `
                       <tr class="mailReadTitle">
                           <td>
                               <input type="checkbox" class="mailOneCheck" style="padding: 4px"/>
                           </td>
                           <td>
                               \${starIcon}
                               \${mailIcon}
                               <i class="fa-solid fa-paperclip"></i>
                           </td>
                           <td id="mailName">\${name}</td>
                           <td id="mailTitle">
                               <a href="${ctxPath}/mail/viewMail?mailNo=${mail.mailNo}">
                                   \${mail.subject}
                               </a>
                           </td>
                           <td id="right-content">
                               <span id="sendDate">\${mail.sendDate}</span>
                               <span id="fileSize">\${size}</span>
                           </td>
                       </tr>
                       `;
                   });

                   // 기존 목록을 새 목록으로 교체
                   $("#mailTable tbody").html(html);

                   // 새로 추가된 요소들에 다시 이벤트 바인딩
                   bindStarToggle();
                   bindMailToggle();
               },
               error: function(err){
                   console.log(err);
                   alert("정렬 목록 조회 중 오류 발생");
               }
           });
       });
       <%-- 정렬 버튼 클릭시 변경 ajax 끝 --%>
       
       
       
       
       
       <%-- 삭제 버튼 클릭 ajax 시작 --%>
       // 삭제 버튼 클릭
       $("#deleteMailBtn").on("click", function(e){
           e.preventDefault(); // a 태그 이동 막기

           // 1. 체크된 메일 번호 저장
           let mailNoArray = [];
           $("input.mailOneCheck:checked").each(function(){
               let mailNo = $(this).data("mailno"); 
               mailNoArray.push(mailNo);
           });

           if(mailNoArray.length === 0) {
               alert("삭제할 메일을 선택하세요.");
               return;
           }

           // 2. Ajax로 deleteStatus = 1 로 업데이트
           $.ajax({
               url: ctxPath + "/mail/deleteMail",
               type: "POST",
               traditional: true,  
               // jQuery가 mailNoArray를 mailNo=1&mailNo=2... 형태로 전송하도록
               data: { mailNo: mailNoArray },
               success: function(response){
                   // 성공 후, 목록 갱신 or 해당 행 제거 or 새로고침
                   // 예) 새로고침
                   location.reload();
               },
               error: function(err){
                   console.log(err);
                   alert("메일 삭제 중 오류 발생");
               }
           });
       });
       <%-- 삭제 버튼 클릭 ajax 끝 --%>
       
       
       <%-- 읽음 버튼 클릭 ajax 시작 --%>
       // 읽음 버튼 클릭
		$("#readMailBtn").on("click", function(e){
		    e.preventDefault(); // a 태그 이동 막기
		
		    // 1. 체크된 메일 번호 저장
		    let mailNoArray = [];
		    $("input.mailOneCheck:checked").each(function(){
		        let mailNo = $(this).data("mailno"); 
		        mailNoArray.push(mailNo);
		    });
		
		    if(mailNoArray.length === 0) {
		        alert("읽음 처리 할 메일을 선택하세요.");
		        return;
		    }
		
		    // 2. Ajax로 readStatus = 1 로 업데이트
		    $.ajax({
		        url: ctxPath + "/mail/readMail",
		        type: "POST",
		        traditional: true,  
		        data: { mailNo: mailNoArray },
		        success: function(response){
		            if(response.status === "success") {
		                // 3. 업데이트된 메일의 아이콘 변경
		                response.updatedMails.forEach(function(mail) {
		                    const $mailIcon = $(".toggle_mail[data-mailno='" + mail.mailNo + "']");
		                    if(mail.readStatus === "1") {
		                        // 읽음 상태 => 아이콘 변경
		                        $mailIcon.removeClass("fa-regular fa-envelope").addClass("fa-regular fa-envelope-open")
		                                .css("color", "");
		                    } else {
		                        // 안읽음 상태 => 기본 아이콘/색상
		                        $mailIcon.removeClass("fa-regular fa-envelope-open").addClass("fa-regular fa-envelope")
		                                .css("color", "black");
		                    }
		                });
		            }
		        },
		        error: function(err){
		            console.log(err);
		            alert("메일 읽음 처리 중 오류 발생");
	        }
    });
});
       <%-- 읽음 버튼 클릭 ajax 끝 --%>
       
       
   });
	  
   
   $(document).ready(function() {
	    loadPage(1); // 처음 페이지 로드 시 1페이지 데이터를 불러옴
   });
   
</script>	

	<%-- 이곳에 각 해당되는 뷰 페이지를 작성해주세요 --%>
	<!-- 메일작성 폼 -->
    <div id="modal" class="modal_bg">
    </div>
    <div class="modal_container">
    
	    <!-- 모달 창 -->
	    <div id="modal_bar" style="overflow-y: auto;">
	        <div id="modal_title_box">
	            <span id="modal_title">메일쓰기</span>
	
	            <!-- 메일 작성 공간 -->
	            <div id="modal_menu_container">
	                <span>
	                    <a href="#">
	                    	<i class="fa-regular fa-paper-plane"></i>
	                    	<button type="button" id="btnWrite">
	                    		<span>보내기</span>
	                    	</button>
	                    </a>
	                </span>
	                
	                <span>
	                    <a href="#">
	                    	<i class="fa-regular fa-floppy-disk"></i>
	                    	<button type="button" id="btnSave">
	                        	<span>임시저장</span>
	                        </button>
	                    </a>
	                </span>
	                <span>
	                    <a href="#">
	                    	<i class="fa-regular fa-eye"></i>
	                    	<button type="button" id="btnSpoiler">
	                        	<span>미리보기</span>
	                        </button>
	                    </a>
	                </span>
	
	            </div>
	        </div>
	        
   <form name="addFrm" enctype="multipart/form-data">
	    <div id="writeArea">
	    
			  <table id="writeAreaTable">
			    <!-- 받는사람 -->
			    <tr>
			    
			      <th>
			      받는사람
			      
			      <label id="meWrite"><input type="checkbox" /> 내게쓰기</label>
			      
			      </th>
			      <td id="mailWriteReference" colspan="2">
			      
		      		<div id="mailWriteReferenceDiv">
		      		
		      			<div id="addrWrap">
			      			<ul class="nameTag">
			      				<li class="addrCreate">
			      					<div class="addrInput">
				        				<textarea id="addrWrite" type="text" style="display:inline; white-pace:nowrap;" autocomplete="off"></textarea>
				        			</div>
				        		</li>
				        	</ul>
			        	</div>
			        	
			        	<select id="addrSelect">
			        		<option value='' selected>최근주소</option>
			        	</select>
			        	
			        	<span class="btnWrap">
				        	<a class="btnAddr">
				        		<span class="text">주소록</span>
				        	</a>
			        	</span>
			        	
		      		</div>
		      		
			      </td>
			      
			    </tr>
			    
			    <!-- 참조 -->
			    <tr>
			    
			      <th>참조</th>
			      <td id="mailWriteReference" colspan="2">
			      
		      		<div id="mailWriteReferenceDiv">
		      		
		      			<div id="addrWrap">
			      			<ul class="nameTag">
			      				<li class="addrCreate">
			      					<div class="addrInput">
				        				<textarea id="addrWrite" type="text" style="display:inline; white-pace:nowrap;" autocomplete="off"></textarea>
				        			</div>
				        		</li>
				        	</ul>
			        	</div>
			        	
			        	<select id="addrSelect">
			        		<option value='' selected>최근주소</option>
			        	</select>
			        	
			        	<span class="btnWrap">
				        	<a class="btnAddr">
				        		<span class="text">주소록</span>
				        	</a>
			        	</span>
			        	
		      		</div>
		      		
			      </td>
			      
			    </tr>
			    
			    <!-- 제목 -->
			    <tr>
			      <th>제목</th>
			      <td id="mailWriteTitle" colspan="2">
			        <input id="mailWriteTitleBox" type="text" />
			      </td>
			    </tr>
			    
			    <!-- 파일첨부 -->
			    <tr>
			      <th>파일첨부</th>
			      <td colspan="2">
			        <!-- 파일첨부 영역 (기존과 동일) -->
			        <div class="file-upload-area">
			          <div class="file-btn-group">
			            <input type="file" id="fileInput" multiple style="display: none;" />
			            <button type="button" id="btnFileSelect">파일선택</buztton>
			            <button type="button" id="btnFileArchive">자료실</button>
			            <button type="button" id="btnFileDeleteAll">모두삭제</button>
			            
			            <span class="file-limit-info">
			              일반 (0Byte / 20MB), 대용량 (0Byte / 500.0MB)
			            </span>
			          </div>
			          
			          <div class="file-drag-drop-zone" id="dragDropZone">
			            여기에 첨부 파일을 끌어오세요.
			            <br />
<!-- 			            	<br />
			            	<input class="filePick" style="text-align: center" type="file" name="attach" multiple/>
			            <button type="button" class="inline-file-btn" id="btnFileSelect2">파일선택</button>
			          </div>
			          <ul class="file-list" id="fileList"></ul> -->
		              <span style="text-align: center;">
				        또는<!--  <label class="inline-file-btn" id="btnFileSelect2" for="fileInput">파일 선택</label> -->
				    	<br />
				    </span>
				    <input type="file" id="fileInput" class="fileInput" name="attach" multiple/>
			        </div>
			      </td>
			    </tr>
			    
			  </table>
	        
	    	<div id="smartedit">
	    		<textarea style="width: 100%; height: 612px; padding: var(--size24);" id="content"></textarea>
		    </div>
	
	   		<div style="margin: 20px;">
	            <button type="button" id="btnReservationMail">예약메일</button>
	        </div>
        </div>
		</form>
    </div>
	    
    </div>
    <!-- 메일작성 폼 -->

	
	<!-- 왼쪽 사이드바 -->
    <div id="left_bar" >

        <!-- === 메일 작성 버튼 === -->
        <button id="goMail">
            <i class="fa-solid fa-plus"></i>
            <span>메일쓰기</span>
        </button>
        <!-- === 메일 작성 버튼 === -->

        <div class="mail_menu_container">
            <ul>
                <li id="receivedMail">
                    <a href="<%=request.getContextPath()%>/mail">받은메일함</a>
                    <span class="mail_cnt">${totalCount}</span> <!-- 콤마처리 해주세요 -->
                </li>
                <li id="sendMail"><a href="#">보낸메일함</a></li>
                <li id="saveMail"><a href="#">임시보관함</a></li>
                <li id="tagMail"><a href="#">태그메일함</a></li>
                <li id="importantMail">
                	<a href="#" id="importantMailLink">중요메일함</a>
                </li>
                <li id="deleteMail">
                	<a href="#">휴지통</a>
                </li>
            </ul>
        </div>
    </div>
    <!-- 왼쪽 사이드바 -->

    <!-- 오른쪽 바 -->
    <div id="right_bar" style="overflow-y: auto;">
        <div id="right_title_box">
            <span id="right_title">Inbox</span>
            <span id="right_info">
                <span>
                    All
                    <span class="right_info_cnt">${totalCount}</span> <!-- 전체 메일의 개수를 띄워주세요! -->
                </span>
                <span>/</span>
                <span>
                    Unread
                    <span class="right_info_cnt">${unreadCount}</span> <!-- 읽은 메일의 개수를 띄워주세요! -->
                </span>
            </span>

            <!-- 오른쪽 바 메뉴버튼들입니다! -->
            <div id="right_menu_container">
                <input id="mailListAllCheck" type="checkbox" />
                <span>
                    <a href="#">
                        <i class="fa-solid fa-share" style="transform: scaleX:(-1);"></i>
                        <span>답장</span>
                    </a>
                </span>
                
                <span id="deleteBtnBox">
                    <a href="#" id="deleteMailBtn">
                    	<i class="fa-regular fa-trash-can"></i>
                        <span>삭제</span>
                    </a>
                </span>
                <span>
                    <a href="#">
                    	<i class="fa-solid fa-tags"></i>
                        <span>태그</span>
                    </a>
                </span>
                <span>
                    <a href="#" id="readMailBtn">
                    	<i class="fa-regular fa-envelope-open"></i>
                        <span>읽음</span>
                    </a>
                </span>
                <span>
                    <a href="#">
                    	<i class="fa-solid fa-arrow-up-right-from-square"></i>
                        <span>메일이동</span>
                    </a>
                </span>


                <span id="reBtn_box">
                    <span>
                        <span id="sort_btn" title="정렬"> <!-- 정렬 버튼입니다! -->
                            <i class="fa-solid fa-arrow-down-short-wide"></i>
                            <ul>
                                <li class="list_title">정렬순서</li>
                                <!-- 각 li 태그 마다 ajax 보내주세요 -->
                                <li class="sortOption" data-sortkey="subject">제목</li>
                                <li class="sortOption" data-sortkey="sendDate">받은날짜</li>
                                <li class="sortOption" data-sortkey="fileSize">크기</li>

                                <li class="list_title">빠른검색</li>
                                <li>중요메일</li>
                                <li>안읽은 메일</li>
                                <li>읽은 메일</li>
                                <!-- 각 li 태그 마다 ajax 보내주세요 -->
                            </ul>
                        </span>
                        <span id="re_btn" title="새로고침">
                        <a class="fa-solid fa-rotate-right" href="javascript:self.document.location.reload()"></a>
                        </span>
                        <span id="sortCnt_btn">
                            <span>${sizePerPage}</span>
                            <i class="fa-solid fa-angle-right"></i>
                            <ul>
                                <li>10</li>
                                <li>20</li>
                                <li>40</li>
                            </ul>
                        </span>
                    </span>
                </span>
            </div>
            <!-- 오른쪽 바 메뉴버튼들입니다! -->
        </div>
        
	   <table id="mailTable">
	       <tbody>
	           <c:forEach var="mail" items="${ReceivedMailList}">
	               <tr class="mailReadTitle">
	                   	<td>
                      		<input type="checkbox" class="mailOneCheck" data-mailno="${mail.mailNo}" style="padding: 4px"/>
	                   	</td>
	                   	<td>
	                      	<!-- importantStatus가 1이면 채워진 별 아니면 빈 별 -->
	                    	<c:choose>
		                        <c:when test="${mail.importantStatus == 1}">
		                            <!-- 채워진 별 + 노란색 -->
		                            <i class="fa-solid fa-star toggle_star" style="color: yellow; cursor: pointer;"
		                               data-mailno="${mail.mailNo}">
		                            </i>
		                        </c:when>
		                        <c:otherwise>
		                            <!-- 빈 별 (기본) -->
		                            <i class="fa-regular fa-star toggle_star" style="cursor: pointer;"
		                               data-mailno="${mail.mailNo}">
		                            </i>
		                        </c:otherwise>
	                    	</c:choose>
	                    	
	                    	<!-- readStatus가 1 이면 열린 메일 아니면 닫힌 메일 -->
	                    	<c:choose>
		                        <c:when test="${mail.readStatus == 1}">
		                            <!-- 열린 메일 (검은색) -->
		                            <i class="fa-regular fa-envelope-open toggle_mail" style="cursor: pointer;"
		                               data-mailno="${mail.mailNo}">
		                            </i>
		                        </c:when>
		                        <c:otherwise>
		                            <!-- 닫힌 메일 (기본) -->
		                            <i class="fa-regular fa-envelope toggle_mail" style="cursor: pointer; color: black;"
		                               data-mailno="${mail.mailNo}">
		                            </i>
		                        </c:otherwise>
	                    	</c:choose>
	                    	
	                    	<i class="fa-solid fa-paperclip"></i>
	                 	</td>
                   		<td id="mailName">${mail.employeevo.name}</td>
                   		<td id="mailTitle" >
                   			<%-- <span onclick="goView('${mail.mailNo}')">${mail.subject}</span> --%>
                   			
                   			<a href="<%= ctxPath %>/mail/viewMail?mailNo=${mail.mailNo}">
							    ${mail.subject}
							</a>
                   		</td>
					    <td id="right-content">
					        <span id="sendDate">${mail.sendDate}</span>
					        <span id="fileSize">${MailFileVO.fileSize}</span>
					    </td>
	               		</tr>
	           </c:forEach>
	       </tbody>
	       		
	   </table>
        
        <%-- === 페이지바 === --%>
		<div align="center" style="border: solid 0px gray; width: 80%; margin: 30px auto;">
			${requestScope.pageBar}
		</div>
    </div>
    <!-- 오른쪽 바 -->
	<%-- 이곳에 각 해당되는 뷰 페이지를 작성해주세요 --%>

	<%--
<form name="goViewFrm">
   <input type="text" name="mailNo" />
   <input type="text" name="goBackURL" />
</form>	     
    --%>
	
	
	
<jsp:include page="../../footer/footer.jsp" /> 