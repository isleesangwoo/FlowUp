$(document).ready(()=>{
    
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
    let header_cnt = 0;
    
    $('.side_btn').click(e=>{
        header_cnt++;
        if(header_cnt%2 == 1){

            $('#header_container').css({
                'width': 'var(--size60)',
                'padding': 'var(--size24) 4px'
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

            $('#header_ikon_box li').css({
                'text-align': 'center',
                'justify-content': 'center'
            });

            $('#goToWork').css({
                'display': 'none'
            });

            $('.bell').css({
                'display': 'none'
            });

            $('#header_ikon_container').css({
                'height': '100%',
                'overflow-y': 'none'
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

            $('#header_ikon_box li').css({
                'text-align': '',
                'justify-content': ''
            });

            $('#goToWork').css({
                'display': ''
            });

            $('.bell').css({
                'display': ''
            });

            $('#header_ikon_container').css({
                'height': ''
            });
        }
    });

    // ========== 해더 들어갔다 나왔다 기능 ========== //




});