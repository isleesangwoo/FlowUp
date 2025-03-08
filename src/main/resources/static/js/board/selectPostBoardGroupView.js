$(document).ready(()=>{
	
	let saveRows = localStorage.getItem("selectedRowCount"); //  저장된 값 가져오기

	    if (!saveRows) saveRows = "20"; // 기본값 20개

	    $('#sortCnt_btn > span:nth-child(1)').html(saveRows); // 선택한 개수 표시

		//  현재 URL의 쿼리 문자열(query string, ? 뒤에 붙는 파라미터들) 을 가져옴.
	    const urlParams = new URLSearchParams(window.location.search);// "?boardNo=100035&currentShowPageNo=3"
	    let currentPage = urlParams.get("currentShowPageNo") ? parseInt(urlParams.get("currentShowPageNo")) : 1;
		// urlParams.get("currentShowPageNo") => 3
		// urlParams.get("boardNo") => 100035
		
	    fetchBoardData(saveRows, currentPage);
	
    // ========= 정렬 인원수 버튼 토글 ========= //
    $('#sortCnt_btn').click(e=>{
		
        $('#sortCnt_btn > ul').fadeToggle();

    }); // end of $('#sort_btn').click(e=>{})-------------

	$('#sortCnt_btn > ul li').click(e => {
	    const listIndex = $(e.target).index();
	    const selectedRows = $('#sortCnt_btn > ul li').eq(listIndex).text(); // 선택한 개수

	    $('#sortCnt_btn > span:nth-child(1)').html(selectedRows);
	    localStorage.setItem("selectedRowCount", selectedRows); //  선택한 값 저장

	    fetchBoardData(selectedRows); //  데이터 불러오기
	});

    // ========= 정렬 인원수 버튼 토글 ========= //
	
	
	
	// ========= 글쓰기버튼 토글 ========= //

    $('.writePostBtn').click(e=>{
		
		if($("#isExit").text() == ""){
    		alert("로그인 후 이용하실 수 있습니다.");
    		return;
    	}

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
	
	
}) // end of $(document).ready(()=>{})---------




// Function Declaration
function goView(postNo) {
	const frm = document.goViewFrm;
    frm.postNo.value = postNo;
    frm.checkAll_or_boardGroup.value = "1"; // 글 상세페이지의 이전/다음글 을 전체게시판 기준으로 조회할지, 해당게시판 조건으로 조회할지
	// 1이면 해당게시판을 조건으로, 값이 없으면 전체게시판(조건없음)
    frm.method = "get";
    frm.action = ctxPath + "/board/goViewOnePost";
    frm.submit();
}


// 로컬 스토리지 저장한 것(선택한 행 개수) 을 활용하여 행 개수를 보여주는 함수
function fetchBoardData(sizePerPage, currentPage = 1) {
    const boardNo = $("input[name='fk_boardNo']").val();

    $.ajax({
        url: ctxPath + "/board/getChoicePostRow",
        data: {
            "sizePerPage": sizePerPage,
            "boardNo": boardNo,
            "currentShowPageNo": currentPage
        },
        dataType: "json",
        success: function(map) {
            const json = map.postList; //  게시글 목록
            const totalCount = map.totalCount; //  총 게시물 수 (서버에서 받아옴)
			
            $("#postContainer tr:not(:first)").remove(); // 기존 게시글 삭제

            let html = "";
			let postNull = "";
            if (json.length === 0) {
            } else {
                json.forEach((post, index) => {
                    let rowNumber = totalCount - (currentPage  - 1) * sizePerPage - index;
					if (rowNumber < 1) return; // 순번이 1이 되면 종료

                    html += ``;
								 
					if (`${post.isNotice}` == "1" && `${post.noticeEndDate}` >=`${post.currentDate}` ) {  // 공지글이고 공지종료일이 현재시각보다 이전이 아닌 경우 
					    html += `<tr class="onePostElmt" style="background-color : #f4f4f4;">
						         <td><i class="fa-solid fa-bullhorn"></i></td>
								 <td class="postSubject" onclick="goView('${post.postNo}')">[공지] ${post.subject}</td>`;
					} 
					else { // 일반 게시글 또는 공지 종료일이 지난 게시글(공지글)일 시 
					    html += `<tr class="onePostElmt">
						         <td>${rowNumber}</td>
								 <td class="postSubject" onclick="goView('${post.postNo}')">${post.subject}</td>`;
					}

								 
                   html +=`<td>${post.name} ${post.positionName}</td>
                             <td>${post.regDate}</td>
                             <td>${post.readCount}</td>
                             <td>${post.likeCount}</td>
                         </tr>`;
                });
            }
			const newUrl = ctxPath + `/board/selectPostBoardGroupView?boardNo=${boardNo}&currentShowPageNo=${currentPage}`;
			history.pushState({ path: newUrl }, '', newUrl); //url을 동적으로 변경.

			// URL 변경
            //const newUrl = `/board/selectPostBoardGroupView?boardNo=${boardNo}&currentShowPageNo=${currentPage}`;
			$("input[name='goBackURL']").val(`/board/selectPostBoardGroupView?boardNo=${boardNo}&currentShowPageNo=${currentPage}`);
					
			$("#postNull").append(postNull);	
            $("#postContainer tbody").append(html);
			createPagination(totalCount, sizePerPage, currentPage);
        },
        error: function(request, status, error) {
            alert("code: " + request.status + "\nmessage: " + request.responseText + "\nerror: " + error);
        }
    });
} // end of function fetchBoardData(sizePerPage, currentPage = 1) {}---------------------

// 페이징 바를 선택한 행 수에 맞게 다시 생성하는 함수
function createPagination(totalCount, sizePerPage, currentPage) {
    const totalPage = Math.ceil(totalCount / sizePerPage); // 총 페이지 수 계산

    let pageBar = "<ul style='list-style:none;'>";
    
    //  기존 페이징 바 삭제 후 새로 생성
    $("#paginationContainer").empty();

    //  [맨 처음] 버튼
    if (currentPage > 1) {
        pageBar += `<li style='display:inline-block; width:30px; font-size:12pt;'><a href="#" class="pageLink" data-page="1"><i style='transform: scaleX(-1)' class=\'fa-solid fa-forward-step\'></i></a></li>`;
    }

    //  [이전] 버튼
    if (currentPage > 1) {
        pageBar += `<li style='display:inline-block; width:30px; font-size:12pt;'><a href="#" class="pageLink" data-page="${currentPage - 1}"><i class=\"fa-solid fa-chevron-left\"></i></a></li>`;
    }

    //  페이지 번호들 (최대 10개까지만 표시)
    let startPage = Math.floor((currentPage - 1) / 10) * 10 + 1;
    let endPage = Math.min(startPage + 9, totalPage);

    for (let i = startPage; i <= endPage; i++) {
        if (i === currentPage) {
            pageBar += `<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; padding:2px 4px;'><span>${i}</span></li>`;
        } else {
            pageBar += `<li style='display:inline-block; width:30px; font-size:12pt;'><a href="#" class="pageLink" data-page="${i}">${i}</a></li>`;
        }
    }

    //  [다음] 버튼
    if (currentPage < totalPage) {
        pageBar += `<li style='display:inline-block; width:30px; font-size:12pt;'><a href="#" class="pageLink" data-page="${currentPage + 1}"><i class=\"fa-solid fa-chevron-right\"></i></a></li>`;
    }

    //  [마지막] 버튼
    if (currentPage < totalPage) {
        pageBar += `<li style='display:inline-block; width:30px; font-size:12pt;'><a href="#" class="pageLink" data-page="${totalPage}"><i class=\"fa-solid fa-forward-step\"></i></a></li>`;
    }

    pageBar += "</ul>";
	
	

    $("#paginationContainer").html(pageBar);  //  페이징 바 업데이트

    //  페이징 이벤트추가  (동적으로 생성된 요소에 이벤트 추가)
    $(".pageLink").click(function (e) {
        e.preventDefault(); // 기본 이동 방지
        const selectedPage = $(this).data("page"); // 클릭한 페이지 번호 가져오기
        fetchBoardData(sizePerPage, selectedPage); //  선택한 페이지로 게시글 로드 (ajax 요청)
    });
	
	
} // end of function createPagination(totalCount, sizePerPage, currentPage) {}-------------------







