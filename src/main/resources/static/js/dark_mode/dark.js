$(document).ready(()=>{

    let dark_cnt = 0;

    $('.dark_btn').click(e=>{

        dark_cnt++;

        if(dark_cnt%2 == 1){
            $(e.target).css({
                'justify-content': 'end'
            })
        }
        else {
            $(e.target).css({
                'justify-content': ''
            })
        }

        
    });

}) // end of $(document).ready(()=>{})---------