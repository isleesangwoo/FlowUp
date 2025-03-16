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


    // ========= 메일버튼 토글 ========= //

    $('#goMail').click(e=>{

        $('#modal').fadeIn();
        $('.modal_container').css({
            'width': '70%'
        })
  
    }) // end of $('#goMail').click(e=>{})-----------

    $('.modal_bg:not(.modal_container)').click(e=>{

        $('#modal').fadeOut();
        $('.modal_container').css({
            'width': '0%'
        })

    })
    // ========= 메일버튼 토글 ========= //

   $(document).ready(function() {
       let $menuItems = $('.mail_menu_container > ul li');

       // 페이지 로드 시 첫 번째 메뉴(받은메일함)에 default-active 클래스 추가
       $menuItems.first().addClass('default-active');

       $menuItems.click(function() {
           // 모든 메뉴에서 active-menu-item과 default-active 클래스 제거
           $menuItems.removeClass('active-menu-item default-active');

           // 클릭된 메뉴에 active-menu-item 클래스 추가
           $(this).addClass('active-menu-item');
       });
   });
   
   
   
   /* 체크박스 체크 처리 메서드 */
   // 마스터 체크박스 클릭 시
   $('#mailListAllCheck').on('click', function(){
     // 마스터 체크 상태에 따라 모든 개별 체크박스의 체크 상태 변경
     var isChecked = $(this).prop('checked');
     $('input.mailOneCheck').prop('checked', isChecked);
   });

   // 개별 체크박스 클릭 시
   $('input.mailOneCheck').on('click', function(){
     // 모든 개별 체크박스 중 체크된 개수가 전체와 같으면 마스터 체크, 아니면 해제
     if ($('input.mailOneCheck:checked').length === $('input.mailOneCheck').length) {
       $('#mailListAllCheck').prop('checked', true);
     } else {
       $('#mailListAllCheck').prop('checked', false);
     }
   });

   // 정렬 버튼
   $("#sortCnt_btn ul li").on("click", function() {
       let pageSize = $(this).text().trim();
       $("#sortCnt_btn > span:nth-child(1)").text(pageSize);
       location.href = ctxPath + "/mail?currentShowPageNo=1&sizePerPage=" + pageSize;
   });
   
   
}) // end of $(document).ready(()=>{})---------