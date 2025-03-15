$(document).ready(()=>{
	
    // ========= 정렬 인원수 버튼 토글 ========= //
    $('#sortCnt_btn').click(e=>{

        $('#sortCnt_btn > ul').fadeToggle();

    });

    $('#sortCnt_btn > ul li').click(e=>{
        
        const listIndex = $(e.target).index();
        const liInfo = $('#sortCnt_btn > ul li').eq(listIndex).text();
        $('#sortCnt_btn > span:nth-child(1)').html(liInfo);

    });
    // ========= 정렬 인원수 버튼 토글 ========= //


    // ========= 새 결재 버튼 토글 ========= //
    $('#goDoc').click(e=>{

        $('#modal').fadeIn();
        $('#doc_menu_container').css({
            'display': 'block'
        });
  
    });

    $('.modal_bg:not(.modal_container)').click(e=>{

        $('#modal').fadeOut();
        $('#doc_menu_container').css({
            'display': ''
        });

    });
    // ========= 새 결재 버튼 토글 ========= //

	
	// ========= 결재양식 버튼 토글 ========= //
	$('#documentType_btn').click(e=>{

        $('#documentType_btn > ul').fadeToggle();

    });

    $('#documentType_btn > ul li').click(e=>{
        
        const listIndex = $(e.target).index();
        let liInfo = $('#documentType_btn > ul li').eq(listIndex).text();
		if(liInfo == "전체") {
			liInfo = "결재양식";
		}
        $('#documentType_btn > span:nth-child(1)').html(liInfo);

    });
	// ========= 결재양식 버튼 토글 ========= //
	

}) // end of $(document).ready(()=>{})---------