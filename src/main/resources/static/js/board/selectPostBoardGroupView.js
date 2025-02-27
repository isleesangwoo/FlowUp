$(document).ready(()=>{
	
	// === 게시글 하나에 마우스 호버 시 시작 === //
	$(".onePostElmt").hover(function(){
		 $(this).css('background-color', '#f9f9f9');
	 }, function(){
		 $(this).css('background-color', '');
	 });
	// === 게시글 하나에 마우스 호버 시 끝 === //	
	 


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

    $('.writePostBtn').click(e=>{

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
    frm.goBackURL.value = goBackURL;
   
    frm.method = "get";
    frm.action = ctxPath + "/board/goViewOnePost";
    frm.submit();
}





