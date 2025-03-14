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

// 좋아요 버튼 클릭 시 
function goLike(postNo,fk_employeeNo) {
	
	if($("#login_userid").text() == "" || $("#login_userid").text()== null){
			alert("로그인 후 이용하실 수 있습니다.");
			return;
	}
	let btn = $(this);	
	let likeCounter = btn.closest(".onePostElmt").find(".likeCount");
	$.ajax({
          url : ctxPath+"/board/like",
          type : "post",
		  data : { "postNo": postNo, 
				   "login_userid": $("#login_userid").text() ,
				   "notificationtype":"like",
				   "fk_employeeNo": fk_employeeNo
		  },
          dataType:"json",
          success:function(json){
              if(json.likeStatus == 1) {
				  btn.html("<i class='fa-solid fa-heart'></i>");
			  }
              else {
				  btn.html("<i class='fa-regular fa-heart'></i>");
              }
			  likeCounter.html(json.likeCnt);
          },
          error: function(request, status, error){
			  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  }
      });
}





