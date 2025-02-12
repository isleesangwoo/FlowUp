$(document).ready(()=>{
	
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
	


}) // end of $(document).ready(()=>{})---------

//Function

// 게시판 생성하기
function goAddBoardGroup(){
	const frm = document.addBoardGroup;
    frm.method = "POST";
    frm.action = "<%= ctxPath%>/board/addBoard";
    frm.submit();  
}