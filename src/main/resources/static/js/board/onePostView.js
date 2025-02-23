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
	
	
	// 삭제 버튼 클릭 시 
	$("#postDel").click(function(){
		if(confirm("정말로 글을 삭제하시겠습니까?")) {
		   const frm = document.postFrm;
		   frm.method = "post";
		   frm.action = ctxPath+"/board/postDel";
		   frm.submit();   
	    }
	});


    


}) // end of $(document).ready(()=>{})---------