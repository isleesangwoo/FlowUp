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





    // ========== 알림 개수 나오게 하기 ========== //
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
    // ========== 알림 개수 나오게 하기 ========== //





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
	
	$.ajax({
		     type: "get",
		     url: ctxPath + "/board/getNotification", 
		     data: { }, // 로그인된 사원의 정보를 서버로 넘겨줌, '알림 받는 사람' 컬럼에 조건으로 설정하여 조회함.
		     dataType: "json",
		     success: function(json) {
				if (json.login_userid == null) {
		             alert("로그인된 사용자가 없습니다.")
		        }
				else{ // 알림 조회 완료 시
					alert("로그인된 사용자가 있습니다.")
					
					json.listNotification.forEach(function(item) {
						console.log("item.notificationNo : " + item.notificationNo);
//	                    $('#login_userid').append(
//							item.notificationNo
//						);
	                });
					
					$("#login_userid").html(json.login_userid); // 헤더에 로그인 사원번호를 뿌려줌 
				}
		     },
		     error: function(request, status, error) {
		         alert("댓글을 불러오는 데 실패했습니다.");
		     }
		 });
	
	
}



















