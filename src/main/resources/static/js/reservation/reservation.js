$(document).ready(()=>{
	


    // ========= 대분류 토글 ========= //
	/*
    $('#writePostBtn').click(e=>{

        $('#modal').fadeIn();
        $('.modal_container_ass').css({
            'opacity': '1'
        })
  
    }) // end of $('#writePostBtn').click(e=>{})-----------

    $('.modal_bg:not(.modal_container)').click(e=>{

        $('#modal').fadeOut();
        $('.modal_container_ass').css({
            'opacity': '0'
        })

    })
	*/
    // ========= 대분류 토글 ========= //
	
	
	
	// ========= 자산추가 토글 ========= //
	
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
		
	// ========= 자산추가 토글 ========= //


}) // end of $(document).ready(()=>{})---------