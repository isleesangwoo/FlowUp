$(document).ready(()=>{
	


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
          error: function(request, status, error){}
      });
}





