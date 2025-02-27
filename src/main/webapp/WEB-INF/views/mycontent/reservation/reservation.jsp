<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

 
<%@include file="./reservationLeftBar.jsp" %>

<%-- 각자 페이지에 해당되는 css 연결 --%>
<link href="<%=ctxPath%>/css/reservation/reservation_main.css" rel="stylesheet"> 

<%-- 각자 페이지에 해당되는 js 연결 --%>
<script src="<%=ctxPath%>/js/reservation/reservation.js"></script>

	
    <!-- 오른쪽 바 -->
    <div id="right_bar">
        <div id="right_title_box">
            <span id="right_title">자산 예약 현황</span>
        </div>

		<!-- 시간표 달력을 보여주는 요소 전체 박스-->
		<div id="postContainer"> 
			<jsp:include page="../../common/time_calendar.jsp" /> 
		</div>
		<!-- 시간표 달력을 보여주는 요소 전체 박스-->
		
		<!-- 내 예약/ 대여 현황 테이블 -->
        <div>
			<div class="mytitle">
					내 예약 / 대여 현황
			</div>
			
			<div>
				<table border="1" class="my_table">
					<thead>
						<tr>
							<th>자산</th>
							<th>이름</th>
							<th>예약종류</th>
							<th>예약 시간 (대여 시작 시간)</th>
							<th>취소/반납</th>
						</tr>
					</thead>
					<tbody class="my_tbody">
					
					
						<tr>
							<td>차</td>
							<td>모닝1122</td>
							<td>대여</td>
							<td>09:00</td>
							<td>반납</td>
						</tr>
						
						
					</tbody>
				</table>
			</div>
		</div>
		<!-- 내 예약/ 대여 현황 테이블 -->
		<!-- 시간표 달력을 보여주는 요소 전체 박스-->
		<%-- 이곳에 각 해당되는 뷰 페이지를 작성 끝 --%>
    </div>
    <!-- 오른쪽 바 -->
    
	
	
<script>
	$(document).ready(function(){  
		  
		  
		  // ================ 들어오자마자 보이는 내 대여 현황 ================ //
		  <%--
		  $.ajax({
			  url:"<%= ctxPath%>/reservation/showMyReservation",
			  type:"get",
			  data:{"employeeNo":"${sessionScope.loginuser.employeeNo}"},
			  dataType:"json",
			  success:function(json){
				  
			  console.log("ajax 뽑아옴 : ", JSON.stringify(json));

			  
			  let v_html = ``;
			  
			  $.each(json, function(index, item){
				  v_html += `<tr>
								<td>\${item.}</td>
								<td>모닝1122</td>
								<td>대여</td>
								<td>09:00</td>
								<td>반납</td>
							</tr>`;
			  });
			  
			  
			  
			  },
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }   
		  });
		  --%>
		  // ================ 들어오자마자 보이는 내 대여 현황 ================ //
		  
		  
	  });// end of $(document).ready(function(){})-----------
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	//================ 대분류 소분류 뿌려주기 ================ //
	  function resetLeftBar() {
		  let assetDetailListArr;
		  
		  $.ajax({
		  	  url: "<%= ctxPath%>/reservation/selectReservationSubTitle",
		      type: "get",
		      dataType: "json",
		      success: function(json) {
		          console.log(JSON.stringify(json))
		          
		          	  assetDetailListArr = json;
		          
		          	  // alert(assetDetailListArr)
		          
		          	  
		          
		      },
		      error: function(request, status, error) {
		          alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
		      }
		  });
		  
		  // ================ 소분류 끝나고 대분류 조회 시작 후 뿌려주기 ================ //
		  let TitleArr;
		  let html = ``;
		  
		  $.ajax({
		  	  url: "<%= ctxPath%>/reservation/selectReservationTitle",
		      type: "get",
		      dataType: "json",
		      success: function(json) {
		          // console.log(JSON.stringify(json))
		          
		          TitleArr = JSON.stringify(json);
		          
		          // alert(TitleArr)
		          
				  $('.board_menu_container > ul').empty();
			
		          $.each(json, function(index, Title){
		        	    let detailListHtml = ''; // 자산 상세 리스트를 저장할 빈 문자열 초기화
		        	          
		        	    // assetDetailListArr 배열을 순회하면서 자산 세부 항목들을 생성
		        	    $.each(assetDetailListArr, function(i, subTitle){
		        	        // 실제 if문을 넣어서 조건을 처리합니다.
		        	        if (Title.assetNo == subTitle.fk_assetNo) {
		        	            // 조건이 맞으면 해당 항목을 detailListHtml에 추가
		        	            detailListHtml += `<a href='<%= ctxPath %>/reservation/showReservationDeOne?assetDetailNo=\${subTitle.assetDetailNo}&assetName=\${subTitle.assetName}'>
		        	                                   <div>\${subTitle.assetName}</div>
		        	                                </a>`;
		        	        } else {
		        	            
		        	        	// detailListHtml += `<div>없습니다.</div>`
		        	        }
		        	    });

		        	    // 자산 상세 HTML을 최종적으로 추가
		        	    
		        	    
		        	    $('.board_menu_container > ul').append(`
		        	        <li>
		        	            <div>
		        	                <div class="assetTitleBtn" style="justify-content: space-between; display: flex;">
		        	                    <span><a href='<%= ctxPath %>/reservation/assetDetailPage?assetNo=\${Title.assetNo}&assetTitle=\${Title.assetTitle}'>\${Title.assetTitle}</a></span>
		        	                    <span>
		        	                        <a href="<%= ctxPath %>/reservation/showReservationOne?assetNo=\${Title.assetNo}">
		        	                            <i class="fa-solid fa-gear"></i>
		        	                        </a>
		        	                        <i class="fa-solid fa-trash disableBoardIcon deleteAsset" id="\${Title.assetNo}"></i>
		        	                    </span>
		        	                </div> <!-- 대분류 명 -->
		        	                <div class="assetDetailList" id="\${Title.assetNo}" style="display:none;">
		        	                    \${detailListHtml} <!-- 동적으로 생성된 자산 세부 항목들 -->
		        	                </div>
		        	            </div>
		        	        </li>
		        	    `);
		        	});

		      },
		      error: function(request, status, error) {
		          alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
		      }
		  });
	  }
	  resetLeftBar();
	  // ================ 대분류 소분류 뿌려주기 ================ //
</script>
	
	
	
<jsp:include page="../../footer/footer.jsp" /> 
