$(document).ready(()=>{
	
	getLoadNotification(); // 알림 새로고침(조회)
	
    $('#header_ikon_box li').eq(0).css({
        'background-color': '#2985DB',
    }); 
    $('#header_ikon_box li a span').eq(0).css({
        'color': '#fff',
    })
    $('#header_ikon_box li a i').eq(0).css({
        'color': '#fff',
    })
    // 클릭된 li의 index 번호를 이용해 선택되어 보이게 만들기


    // ========== header 호버 이벤트 ========== //
    $('#header_ikon_box li').hover(e=>{

        const hoverLiIndex = $(e.target).index();

        $('#header_ikon_box li').eq(hoverLiIndex).css({
            'background-color': '#2985DB',
        })
        $('#header_ikon_box li a span').eq(hoverLiIndex).css({
            'color': '#fff',
        })
        $('#header_ikon_box li a i').eq(hoverLiIndex).css({
            'color': '#fff',
        })

    }, e=>{

        const hoverLiIndex = $(e.target).index();

        $('#header_ikon_box li').eq(hoverLiIndex).css({
            'background-color': '',
        })
        $('#header_ikon_box li a span').eq(hoverLiIndex).css({
            'color': '',
        })
        $('#header_ikon_box li a i').eq(hoverLiIndex).css({
            'color': '',
        })
    });
    // ========== header 호버 이벤트 ========== //

    


    // ========== 알림창 나오게 하기 ========== //
    $('.bell').hover(e=>{
        $('.alarm').css({
            'height' : '200px'
        })
    }, e=>{
        $('.alarm').css({
            'height' : ''
        })
    });
    // ========== 알림창 나오게 하기 ========== //




    // ========== 해더 들어갔다 나왔다 기능 ========== //
    $('#header_container').css({
        'width': 'var(--size60)',
        'padding': 'var(--size24) 4px',
		'transition': 'all 0s'
    });

    $('.side_btn').css({
        'left': 'calc(var(--size60) - 4px)',
		'transition': 'all 0s'
    })

    $('#logo_box').css({
        'justify-content': 'center'
    });

    $('#header_ikon_box li a span').css({
        'display': 'none'
    });

    $('#header_ikon_box li a i').css({
        'width': 'auto'
    });

    $('#header_ikon_box li').css({
        'text-align': 'center',
        'justify-content': 'center'
    });


//    $('.bell').css({
//        'display': 'none'
//    });

    $('#header_ikon_container').css({
        'height': '100%',
        'overflow-y': 'none'
    });
    
	setTimeout( ()=>{
		$('#header_container').css({
			'transition': ''
	    });
		$('.side_btn').css({
			'transition': ''
	    });
	}, 100);
	
    let header_cnt = 0;
    
    $('.side_btn').click(e=>{
        header_cnt++;
        if(header_cnt%2 == 0){

            $('#header_container').css({
                'width': 'var(--size60)',
                'padding': 'var(--size24) 4px',
				'transition': ''
            });

            $('.side_btn').css({
                'left': 'calc(var(--size60) - 4px)',
				'transition': ''
            })

            $('#logo_box').css({
                'justify-content': 'center'
            });

            $('#header_ikon_box li a span').css({
                'display': 'none'
            });

            $('#header_ikon_box li a i').css({
                'width': 'auto'
            });

            $('#header_ikon_box li').css({
                'text-align': 'center',
                'justify-content': 'center'
            });


//            $('.bell').css({
//                'display': 'none'
//            });

            $('#header_ikon_container').css({
                'height': '100%',
                'overflow-y': 'none'
            });

            $('.side_btn > i').css({
                'transform': 'rotate(360deg)'
            });
        }
        else {
            $('#header_container').css({
                'width': '',
                'padding': ''
            });

            $('.side_btn').css({
                'left': ''
            })

            $('#logo_box').css({
                'justify-content': ''
            });

            $('#header_ikon_box li a span').css({
                'display': ''
            });

            $('#header_ikon_box li a i').css({
                'width': ''
            });

            $('#header_ikon_box li').css({
                'text-align': '',
                'justify-content': ''
            });


            $('.bell').css({
                'display': ''
            });

            $('#header_ikon_container').css({
                'height': ''
            });

            $('.side_btn > i').css({
                'transform': 'rotate(180deg)'
            });

        }
    });

    // ========== 해더 들어갔다 나왔다 기능 ========== //
});


//////////////////////////////////////////////////////
//////////////// Function Declaration //////////////// 
//////////////////////////////////////////////////////


function getLoadNotification(){ // 읽지 않은 알림 조회하기 ( 최신화에 사용됨 )
	let newAlarm = ``;
	$.ajax({
		     type: "get",
		     url: ctxPath + "/board/getNotification", 
		     dataType: "json",
		     success: function(json) {
				if (json.login_userid == null) {// 로그인이 안된 경우
		             $(".bell").remove(); // 알림 요소를 삭제
		        }
				else if(json.listNotification.length == 0){ // 로그인 사원이 알림을 모두 읽을 시 
					newAlarm += `<div style='text-align:center;line-height:120px; height:100px;'>알림이 없습니다.</div>`;
					$('.alarm ul').append(newAlarm); 
				}
				else{ // 알림 조회 완료 시
					$('.alarm ul').empty(); // 기존 알림 데이터들을 지움
					json.listNotification.forEach(function(item) {
						newAlarm += `
								<li onclick="goPostView('${item.fk_postNo}','${item.boardNo}','${item.notificationNo}','${item.fk_employeeNo}')">
						            <a href="#">
						                <div>
						                    <div class="profile">`;
											
							if(item.profileimg==null){ // 프로필 등록을 안 했을 경우
								newAlarm +=`<i class="fa-solid fa-user"></i>`;
							}
							else{ // 프로필 등록을 했을 경우
								newAlarm +=`<img src='/flowUp/resources/files/${item.fileName}' width='32' height='32' style="border-radius: 50%;"/>`;
							}
											
												
								newAlarm +=`</div> 
						                    <div class="alarm-contants">
						                        <span><b>`;
												
												switch (item.notificationType) { // 알림의 타입
												    case "like":
												        newAlarm += `[좋아요]</b></span><span class="alarm-message"> ${item.senderName}님이 게시글을 좋아합니다.</span> `;
												        break;
												    case "comment":
												        newAlarm += `[댓글]</b></span><span class="alarm-message"> ${item.senderName}님이 댓글을 남겼습니다.</span>`;
												        break;
												    case "reply":
												        newAlarm += `[대댓글]</b></span><span class="alarm-message"> ${item.senderName}님이 대댓글을 남겼습니다. </span>`;
												        break;
												    default:
												}

									newAlarm +=	`
						                    </div>
						                </div>
						                <div class="alarm-info">
						                    <span class="hour-before">${item.timeAgo}</span>
						                    <span class="alarm-member">${item.senderName} ${item.senderPositionName}님</span>
						                </div>
						            </a>
						        </li>`;
								
	                });
					
					// 알림 목록에 추가
					$('.alarm ul').append(newAlarm); 
				}
				
				updateAlarmCount(); // 알림 개수 새로고침
		     },
		     error: function(request, status, error) {}
		 });
	
	
}



// ========== 알림 개수 새로고침(조회) ========== //
function updateAlarmCount() {
    let alarm_cnt = $('.alarm > ul > li').length;

    if(alarm_cnt > 0 && alarm_cnt <= 5) {
        $('.alarm-cnt').css({
            'display' : 'block'
        })
        $('.alarm-cnt').html(alarm_cnt);
    }
    else if(alarm_cnt > 5) {
        $('.alarm-cnt').css({
            'display' : 'block'
        })
        $('.alarm-cnt').html('5+');
    }
    else {
        $('.alarm-cnt').css({
            'display' : ''
        })
    }
}
// ========== 알림 개수 새로고침(조회) ========== //



function goPostView(postNo,boardNo,notificationNo,fk_employeeNo) { // 알림하나 클릭 시 알림에 해당하는 게시글로 이동
	
	$.ajax({
	     type: "post",
	     url: ctxPath + "/board/notificationIsRead", 
	     data: {notificationNo:notificationNo , 	// 알림 번호 
				postNo:postNo,						// 글 번호
				fk_employeeNo: fk_employeeNo, 		// 알림을 받는 사원 번호 (로그인 된 사용자와 알림을 받는 사원번호가 같다면 조회수가 증감되지 않음)
				boardNo : boardNo
		 }, 
	     dataType: "json",
	     success: function(json) {
			if(json){ // 알림 읽음처리가 완료되었을 경우
				getLoadNotification(); // 알침 새로고침
				
				window.location.href = ctxPath + "/board/goViewOnePost?postNo="+postNo+"&goBackURL="+json.goBackURL+"&checkAll_or_boardGroup=1&fk_boardNo="+boardNo;
			}
			else{ // 그 외
				window.location.href = ctxPath + "/";
			}
	     },
	     error: function(request, status, error) {
	         alert("ajax요청 실패");
	     }
	 });

}


function goNotificationReadAll(){ // 전체읽기 클릭 시 알림을 모두 읽음 처리
	
	$.ajax({
	     type: "post",
	     url: ctxPath + "/board/goNotificationReadAll", 
	     dataType: "json",
	     success: function(json) {
			if(json){ // 모두 읽음처리가 된 경우 
				
				getLoadNotification(); // 알침 새로고침
				$('.alarm ul').empty(); // 기존 알림 데이터들을 지움

			}
			else{ // 안된 경우
				window.location.href = ctxPath + "/board/";
			}
	     },
	     error: function(request, status, error) {}
	 });
}


















