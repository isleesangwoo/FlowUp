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


    
	
	
	
	


}) // end of $(document).ready(()=>{})---------