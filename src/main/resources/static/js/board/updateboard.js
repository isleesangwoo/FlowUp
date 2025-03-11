

let selectDepartmentUpdate = [];

$(document).ready(()=>{
	
		
		
    // ========= 정렬버튼 토글 ========= //
    $('#sort_btn').click(e=>{

        $('#sort_btn > ul').fadeToggle();

    }); // end of $('#sort_btn').click(e=>{})-------------
    // ========= 정렬버튼 토글 ========= //



    // ========= 정렬 인원수 버튼 토글 시작 ========= //
    $('#sortCnt_btn').click(e=>{

        $('#sortCnt_btn > ul').fadeToggle();

    }); // end of $('#sort_btn').click(e=>{})-------------

    $('#sortCnt_btn > ul li').click(e=>{
        
        const listIndex = $(e.target).index();
        const liInfo = $('#sortCnt_btn > ul li').eq(listIndex).text();
        $('#sortCnt_btn > span:nth-child(1)').html(liInfo);

    });
    // ========= 정렬 인원수 버튼 토글 끝 ========= //


    
	
	
	// 처음에는 부서 선택 박스를 숨김.
	$("#isPublicDeptUpdate").hide(); 
	$("#departmentSelect").hide();
	// 공개 범위 라디오 버튼 변경 시
    $("input[name='isPublicUpdate']").change(function() {
        if ($(".isPublicUpdate:checked").val() == "0") {
            $("#isPublicDeptUpdate").show();
			$("#departmentSelect").show();
            goSearchAllDept(); // 부서 전체 조회
        } else {
            $("#isPublicDeptUpdate").hide();
			$("#departmentSelect").hide();
           	selectDepartmentUpdate = []; // 전체 공개 시 선택된 부서 초기화 (이유 : 부서를 설정했다가 전체공개로 바꿀 시 input에 부서번호가 남아있으면 안됨.)
            updateSelectDepartmentWithUpdate();
        }
    });
	
	// ========= 부서 검색 input ( 부서별 공개 라디오 버튼 선택 후 input 태그에 글자 입력 시 ) ========= //
	$("#updateSearchWord").on("input", function() {
			  
		   const wordLength = $(this).val().trim().length;
		   // 검색어에서 공백을 제거한 길이를 알아온다.
		   
		   if(wordLength == 0) {
			   // 검색어가 공백이거나 검색어 입력후 백스페이스키를 눌러서 검색어를 모두 지우면 모든 부서가 조회되도록 함.
			   goSearchAllDept();  // 검색어가 없을 경우 모든 부서가 조회 됨.
		   }
		   
		   else {
				   $.ajax({
					   url: ctxPath + "/board/addBoardSearchDept", // 해당부서 검색과 부서 전체조회 add(게시판 추가)에서 쓰던 것을 그대로 써도 됨.
					   type:"get",
					   data:{
							"searchWord":$("input[name='updateSearchWord']").val()
					   },
					   dataType:"json",
					   success:function(json){
						   if(json.length > 0){
							   // 검색된 데이터가 있는 경우임.
							   
							   let v_html = ``;
							   
							   $.each(json, function(index, item){
								   const departmentname = item.departmentname;
								   const departmentno = item.departmentno;
								   
								   const idx = departmentname.toLowerCase().indexOf($("input[name='updateSearchWord']").val().toLowerCase());
								   
							       const len = $("input[name='updateSearchWord']").val().length; 
								   
							       const result = departmentname.substring(0, idx) + "<span style='color:blue;'>"+departmentname.substring(idx, idx+len)+"</span>" + departmentname.substring(idx+len); 
							       
								   v_html += `<span style='cursor:pointer;' class='updateResult'>${result}[${departmentno}]</span><br>`;
								   
							   }); // end of $.each(json, function(index, item){})-----------
							   
							   const input_width = $("input[name='updateSearchWord']").css("width"); // 검색어 input 태그 width 값 알아오기  
							   
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
	   	   $("input[name='updateSearchWord']").val(word); // 텍스트박스에 검색된 결과의 문자열을 입력해줌.
	   	   $("div#displayList").hide();
	   });
	   
	   
	
	// 공개 범위 라디오 버튼에 change 이벤트 핸들러 추가
	$("input[name='isPublicUpdate']").change(function() {
		// 선택된 값이 부서별 공개(isPublicDepart)일 때
		if ($(".isPublicUpdate:checked").val() == "0") {
			$("#isPublicDeptUpdate").show();  // 부서 선택 박스를 표시
			//$("div#displayList").hide(); // 검색 부서들이 나오는 박스도 숨김.(라디오 선택 시 검색을 한 것이 아니기때문)
			
			goSearchAllDept(); // 부서 전체 조회
			
		} else {
			$("#isPublicDeptUpdate").hide();  // 부서 선택 박스를 숨김
			$("input[name='updateSearchWord']").val("");
		}
	});
	
	$(document).on("click", "#updateBoardGroup", function(){ // 수정 버튼 클릭 이벤트
		
		if($("#updateBoardName").val() == ""){
			alert("게시판 제목을 입력해주세요.");
			return;
		}
		
		if($("#updateBoardName").val().length > 15){
			alert("게시판 제목을 15자 이하로 입력해주세요.")
			return;
		}
		
		if($("#updateBoardDesc").val() == ""){
			alert("게시판 설명을 입력해주세요.")
			return;
		}
		
		if($("#updateBoardDesc").val().length > 500){
			alert("게시판 설명을 500자 이내로 입력해주세요.")
			return;
		}
		
		if($("input[name='isPublicUpdate']:checked").val() == 0 ){
			if($("#updateSelectDeptList").text() == ""){ // 부서 목록이 없데이트 되는 요소에 아무 값이 없다면
				alert("게시판을 공개할 대상 부서를 선택하세요.");
				return;
			}
		}
		
 		goUpdateBoardGroup(); // 게시판 수정하기
	});
	

    // 라디오 버튼 상태 체크하여 '부서별' 공개일 경우 자동으로 부서 선택 표시
    if ($(".isPublicUpdate:checked").val() == "0") {
		$("#isPublicDeptUpdate").show();
		$("#departmentSelect").show();
        updateSelectDepartmentWithUpdate(); // 기존 선택된 부서 목록 렌더링
        goSearchAllDept(); // 부서 목록 조회
    }

}) // end of $(document).ready(()=>{})---------------------------








//////////// Function Declare ////////////

// ===== 부서 전체 조회하기(부서공개라디오 클릭 시) ===== //
function goSearchAllDept(){
	$.ajax({ //게시판 생성의 공개여부 부서 설정 시 부서 전체 검색(부서 검색)
		   url: ctxPath + "/board/addBoardSearchAllDept", // 해당부서 검색과 부서 전체조회 add(게시판 추가)에서 쓰던 것을 그대로 써도 됨.
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
					   
				       const result = departmentname.substring(0, idx) + "<span style='color:blue;'>"+departmentname.substring(idx, idx+len)+"</span>" + departmentname.substring(idx+len); 
				       
					   v_html += `<span data-dept-no='${departmentno}' data-dept-name='${departmentname}' style='cursor:pointer;' class='updateResult'>${result}[${departmentno}]</span><br>`;
					   
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

// 부서 선택 이벤트 (클릭 시 선택 목록에 추가)
$(document).on("click", "span.updateResult", function() {
    const deptNo = String($(this).data("dept-no"));
    const deptName = $(this).data("dept-name");
	

    // 중복 선택 방지
    if (!selectDepartmentUpdate.some(dept => dept.deptNo === deptNo)) { // 선택한 부서가 selectDepartmentUpdate에 있다면 true 
    	selectDepartmentUpdate.push({ deptNo, deptName }); // 배열에 부서 추가 
        updateSelectDepartmentWithUpdate();					 // 선택한 부서를 부서목록에 추가
    }

    $("#displayList").hide();
    $("input[name='searchWord']").val(""); // 검색어 초기화
    goSearchAllDept();
});

// 선택한 부서 목록 업데이트 (  선택한 부서목을 담고 있는 selectDepartmentUpdate 배열을 통해 업데이트)
function updateSelectDepartmentWithUpdate() { 
    let html = "";
    let updateHiddenInput = "";
    
    selectDepartmentUpdate.forEach((dept, index) => {
    	html += `<span class="select-dept" data-index="\${index}">
			${dept.deptName}
			<button type="button" class="remove-dept btnDefaultDesignNone" data-index="${index}">
				<i class="fa-solid fa-circle-xmark"></i>
			</button>
			</span> `;

	        updateHiddenInput += `<input type="hidden" name="fk_departmentNo_update" value="${dept.deptNo}">`; // form에 hidden input 추가 (배열을 폼으로 전송하기위해)
	    });
    $("#updateSelectDeptList").html(html);
    $("#selectDeptHideInputWithUpdate").html(updateHiddenInput);
}

// 선택한 부서 삭제 이벤트
$(document).on("click", ".remove-dept", function() {
    const index = $(this).data("index"); // 선택한 부서 목록의 index를 활용함
    selectDepartmentUpdate.splice(index, 1);   // 배열에서 해당 인덱스 요소를 삭제
    updateSelectDepartmentWithUpdate();
});

// ===== 게시판 수정하기 ===== //
function goUpdateBoardGroup(){
	const frm = document.updateBoardGroup;
    frm.method = "POST";
    frm.action = ctxPath + "/board/updateBoard";
    frm.submit();  
}


document.addEventListener("DOMContentLoaded", function () {
		let deptNo = null;
		let deptName = null;
		
	    // jsp에서 hidden input에 있는 기존 부서 목록을 배열에 추가
	    document.querySelectorAll("input[name='fk_departmentNo_update']").forEach((input, index) => {
			
			deptName = document.querySelectorAll("input[name='fk_departmentName_update']")[index].value;
			deptNo = document.querySelectorAll("input[name='fk_departmentNo_update']")[index].value;

	        selectDepartmentUpdate.push({deptNo,deptName});
			
			
	    });
});
