$(document).ready(()=>{
	getLoadNotification();
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
    });

    $('.side_btn').css({
        'left': 'calc(var(--size60) - 4px)'
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


    $('.bell').css({
        'display': 'none'
    });

    $('#header_ikon_container').css({
        'height': '100%',
        'overflow-y': 'none'
    });
    
    let header_cnt = 0;
    
    $('.side_btn').click(e=>{
        header_cnt++;
        if(header_cnt%2 == 0){

            $('#header_container').css({
                'width': 'var(--size60)',
                'padding': 'var(--size24) 4px',
            });

            $('.side_btn').css({
                'left': 'calc(var(--size60) - 4px)'
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


            $('.bell').css({
                'display': 'none'
            });

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
		     data: { }, // 로그인된 사원의 정보를 서버로 넘겨줌, '알림 받는 사람' 컬럼에 조건으로 설정하여 조회함.
		     dataType: "json",
		     success: function(json) {
				if (json.login_userid == null) {
		             //alert("로그인된 사용자가 없습니다.")
		        }
				else{ // 알림 조회 완료 시
					//alert("로그인된 사용자가 있습니다.")
					
					json.listNotification.forEach(function(item) {
						newAlarm += `
								<li onclick="goPostView('${item.fk_postNo}','${item.boardNo}')">
						            <a href="#">
						                <div>
						                    <div class="profile">`;
											
							if(item.profileimg==null){ // 프로필 등록을 안 했을 경우
								newAlarm +=`<i class="fa-solid fa-user"></i>`;
							}
							else{
								newAlarm +=`사진있음경로설정하시오`;
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
					$("input[name='goBackURL']").val(ctxPath+ json.goBackURL);
					
					//$("#login_userid").html(json.login_userid); // 헤더에 로그인 사원번호를 뿌려줌 
				}
				
				updateAlarmCount();
		     },
		     error: function(request, status, error) {
		         alert("댓글을 불러오는 데 실패했습니다.");
		     }
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



function goPostView(postNo,boardNo) { // 알림하나 클릭 시 알림에 해당하는 게시글로 이동
	
	
	alert(postNo);
	
	window.location.href = ctxPath + "/board/goViewOnePost?postNo="+postNo+"&goBackURL=&checkAll_or_boardGroup=1&fk_boardNo="+boardNo;

	
//	const frm = document.goPostViewFrm;
//    frm.postNo.value = postNo;
//	frm.fk_boardNo.value = boardNo;
//    frm.checkAll_or_boardGroup.value = "1"; // 글 상세페이지의 이전/다음글 을 전체게시판 기준으로 조회할지, 해당게시판 조건으로 조회할지
//	// 1이면 해당게시판을 조건으로, 값이 없으면 전체게시판(조건없음)
//    frm.method = "get";
//    frm.action = ctxPath + "/board/goViewOnePost";
//    frm.submit();
}






















