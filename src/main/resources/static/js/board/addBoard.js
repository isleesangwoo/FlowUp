$(document).ready(()=>{

	// 처음에는 부서 선택 박스를 숨김.
	$("#isPublicDept").hide(); 
	
	// ========= 부서 검색 input ( 부서별 공개 라디오 버튼 선택 후 input 태그에 글자 입력 시 ) ========= //
	$("input[name='searchWord']").on("input", function() {
			  
		   const wordLength = $(this).val().trim().length;
		   // 검색어에서 공백을 제거한 길이를 알아온다.
		   
		   if(wordLength == 0) {
			   // 검색어가 공백이거나 검색어 입력후 백스페이스키를 눌러서 검색어를 모두 지우면 모든 부서가 조회되도록 함.
			   goSearchAllDept();  // 검색어가 없을 경우 모든 부서가 조회 됨.
		   }
		   
		   else {
				   $.ajax({
					   url: ctxPath + "/board/addBoardSearchDept",
					   type:"get",
					   data:{
							"searchWord":$("input[name='searchWord']").val()
					   },
					   dataType:"json",
					   success:function(json){
						   if(json.length > 0){
							   // 검색된 데이터가 있는 경우임.
							   
							   let v_html = ``;
							   
							   $.each(json, function(index, item){
								   const departmentname = item.departmentname;
								   const departmentno = item.departmentno;
								   
								   const idx = departmentname.toLowerCase().indexOf($("input[name='searchWord']").val().toLowerCase());
								   
							       const len = $("input[name='searchWord']").val().length; 
								   
							       const result = departmentname.substring(0, idx) + "<span style='color:purple;'>"+departmentname.substring(idx, idx+len)+"</span>" + departmentname.substring(idx+len); 
							       
								   v_html += `<span style='cursor:pointer;' class='result'>${result}[${departmentno}]</span><br>`;
								   
							   }); // end of $.each(json, function(index, item){})-----------
							   
							   const input_width = $("input[name='searchWord']").css("width"); // 검색어 input 태그 width 값 알아오기  
							   
							   $("div#displayList").css({"width":input_width}); // 검색결과 div 의 width 크기를 검색어 입력 input 태그의 width 와 일치시키기 
							   
							   $("div#displayList").html(v_html).show();
						   }
						   else{
							 $("div#displayList").hide();
						   }
					   },
					   error: function(request, status, error){
						   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					   }    
				   });
				   
		   }
	   }); // end of $("input[name='searchWord']").on("input", function() {})--------
	   
	   $(document).on("click", "span.result", function(e){
	   	   const word = $(e.target).text();
	   	   $("input[name='searchWord']").val(word); // 텍스트박스에 검색된 결과의 문자열을 입력해줌.
	   	   $("div#displayList").hide();
	   });
	   
	   
	
	// 공개 범위 라디오 버튼에 change 이벤트 핸들러 추가
	$("input[name='isPublic']").change(function() {
		// 선택된 값이 부서별 공개(isPublicDepart)일 때
		if ($(".isPublic:checked").val() == "0") {
			$("#isPublicDept").show();  // 부서 선택 박스를 표시
			//$("div#displayList").hide(); // 검색 부서들이 나오는 박스도 숨김.(라디오 선택 시 검색을 한 것이 아니기때문)
			
			goSearchAllDept(); // 부서 전체 조회
			
		} else {
			$("#isPublicDept").hide();  // 부서 선택 박스를 숨김
			$("input[name='searchWord']").val("");
		}
	});
	
	$(document).on("click", "#addBoardGroup", function(){ // 생성 버튼 클릭 이벤트
 		goAddBoardGroup(); // 게시판 생성하기
	});
	


}) // end of $(document).ready(()=>{})---------------------------








//////////// Function Declare ////////////

// ===== 부서 전체 조회하기(부서공개라디오 클릭 시) ===== //
function goSearchAllDept(){
	$.ajax({ //게시판 생성의 공개여부 부서 설정 시 부서 전체 검색(부서 검색)
		   url: ctxPath + "/board/addBoardSearchAllDept",
		   type:"get",
		   dataType:"json",
		   success:function(json){
			   if(json.length > 0){
				   // 검색된 데이터가 있는 경우임.
				   
				   let v_html = ``;
				   
				   $.each(json, function(index, item){
					   const departmentname = item.departmentname;
					   const departmentno = item.departmentno;
					   
					   const idx = departmentname.toLowerCase().indexOf($("input[name='searchWord']").val().toLowerCase());
					   
				       const len = $("input[name='searchWord']").val().length; 
					   
				       const result = departmentname.substring(0, idx) + "<span style='color:purple;'>"+departmentname.substring(idx, idx+len)+"</span>" + departmentname.substring(idx+len); 
				       
					   v_html += `<span style='cursor:pointer;' class='result'>${result}[${departmentno}]</span><br>`;
					   
				   }); // end of $.each(json, function(index, item){})-----------
				   
				   const input_width = $("input[name='searchWord']").css("width"); // 검색어 input 태그 width 값 알아오기  
				   
				   $("div#displayList").css({"width":input_width}); // 검색결과 div 의 width 크기를 검색어 입력 input 태그의 width 와 일치시키기 
				   
				   $("div#displayList").html(v_html).show();
			   }
		   },
		   error: function(request, status, error){
			   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   }    
	   });
} 

// ===== 게시판 생성하기 ===== //
function goAddBoardGroup(){
	const frm = document.addBoardGroup;
    frm.method = "POST";
    frm.action = ctxPath + "/board/addBoard";
    frm.submit();  
}