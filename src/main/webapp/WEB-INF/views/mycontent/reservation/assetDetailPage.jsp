<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

 
<%@include file="./reservationLeftBar.jsp" %>

<%-- 각자 페이지에 해당되는 css 연결 --%>
<link href="<%=ctxPath%>/css/reservation/reservation_main.css" rel="stylesheet"> 
<link href="<%=ctxPath%>/css/reservation/assetDetailPage.css" rel="stylesheet">



<%-- 각자 페이지에 해당되는 js 연결 --%>


	
    <!-- 오른쪽 바 -->
    <div id="right_bar">
        <div id="right_title_box">
            <span id="right_title">${requestScope.assetTitle}</span>
            
            <div style="width: 100%; height: 200px; background-color: #eee; margin: 24px 0px 0px 0px; border: 1px solid #dcdcdc;">
        </div>
        
        
        
        </div>

		<!-- 시간표 달력을 보여주는 요소 전체 박스-->
		<div id="postContainer"> 
			 <div class="dateController">
			    <div class="dateTopBar">
					
					<div></div>
					
					<div class="dateTopBtn">
				        <span id="prev" style="cursor: pointer;">&#60;</span>   <!-- 이전날짜 버튼 -->
				        <div id="today" style="text-align: center;">today</div> <!-- 날짜 표기 -->
				        <span id="next" style="cursor: pointer;">&#62;</span>   <!-- 다음날짜 버튼 -->
				
				        <span id="now" style="cursor: pointer;">오늘</span>
					</div>
					
					<span>
					</span>
			    </div>
				
			
			    <!-- 시간 표기란 -->
			    <div class="calendar_container">
			        <div class="time_table">
			
			
			        </div>
			        <div id="timeLine">
			
			        </div>
			        <table border="1" class="time_table_back_form">
			            <thead>
			                <th style="width: 120px;"></th>
			                <!-- 하루의 시작은 9시부터 21시까지 고정 -->
			                <th colspan="2">09</th>
			                <th colspan="2">10</th>
			                <th colspan="2">11</th>
			                <th colspan="2">12</th>
			                <th colspan="2">13</th>
			                <th colspan="2">14</th>
			                <th colspan="2">15</th>
			                <th colspan="2">16</th>
			                <th colspan="2">17</th>
			                <th colspan="2">18</th>
			                <th colspan="2">19</th>
			                <th colspan="2">20</th>
			                <th colspan="2">21</th>
			                <!-- 하루의 시작은 9시부터 21시까지 고정 -->
			            </thead>
			            <tbody id="tbody">
			
			                <!-- 회의실, 시간표 들어올 자리 -->
			                <!-- 회의실, 시간표 들어올 자리 -->
			                <!-- 회의실, 시간표 들어올 자리 -->
			                <!-- 회의실, 시간표 들어올 자리 -->
			
			            </tbody>
			        </table>
			    </div>
			</div>
		</div>
		<!-- 시간표 달력을 보여주는 요소 전체 박스-->
		
		<!-- 내 예약/ 대여 현황 테이블 -->
        <div>
			<div class="mytitle">
					자산별 상세 정보
			</div>
			
			<div>
				<table border="1" class="my_table">
					<thead>
						<tr>
							<th>자산</th>
							<th>이름</th>
							<th>상세정보</th>
							<th>예약</th>
						</tr>
					</thead>
					<tbody class="my_tbody">
					
					
						<tr>
							<td>본사 1,2층 공용 회의실</td>
							<td>Safari</td>
							<td>상세정보</td>
							<td>예약하기</td>
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
		          // console.log(JSON.stringify(json))
		          
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
		        	                    <span><a href="<%=ctxPath%>/reservation/assetDetailPage?assetNo=\${Title.assetNo}&assetTitle=\${Title.assetTitle}">\${Title.assetTitle}</a></span>
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
	  
	  
	  
	  
	  
	  

	  
	  
	// ======= 지금 페이지 회의실들 불러오기 ======= //
	let assCnt =[];
	
	$.ajax({
		url:"<%= ctxPath%>/reservation/selectAssetDe",
		type:"post",
		data:{"fk_assetNo":${requestScope.assetNo}},
		dataType:"json",
		async:false,
		success:function(json){
			// console.log(JSON.stringify(json));
			
			$.each(json, function(index, item){
				assCnt.push(item)
			})
			
			// alert("사이즈 : ", assCnt.length)
			
		},
	    error: function(request, status, error){
	 	    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	    } 
	})
	// ======= 지금 페이지 회의실들 불러오기 ======= //
	  
	
	  
	  

	
   	// ============== 타임라인 바 ============== //
   	$(window).on('resize', function(){

   		// console.log('되는중')
   		
   		const totalWidth = $('.time_table_back_form').width();
   		// alert(totalWidth);
   		
   		// 현재 시간
   		const now = new Date();
   		const startHour = 9; // 9시
   		const endHour = 21;  // 21시

   		// 9시부터 현재 시간까지 경과한 분
   		const startTime = new Date(now);
   		startTime.setHours(startHour, 0, 0, 0); // 오늘 9시 기준
   		const minutesPassed = Math.floor((now - startTime) / (1000 * 60)); // 경과 시간 (분)

   		// 타임라인의 총 분 (9시부터 21시까지 720분)
   		const totalMinutes = (endHour - startHour) * 60;

   		// 비율로 계산하여 left 값 설정
   		const leftPercentage = (minutesPassed / totalMinutes) * totalWidth;

   		// 타임라인의 스타일 업데이트 (여기서는 예시로 div 요소)
   		const timelineElement = $("#timeline");
   		timelineElement.css({
   			'left' : leftPercentage + "%"
   		})
   	});
 	// ============== 타임라인 바 ============== //
   	
   	
    // ====================== 날짜 리모컨 기능 생성 ====================== //
    let today = new Date(); // 현재 날짜 저장
    let currentDate = new Date(); // 오늘을 저장하는 변수

    // 이전 버튼 클릭 시
    $('#prev').click(() => {
        today.setDate(today.getDate() - 1);
        updateDate();
    });

    // 다음 버튼 클릭 시
    $('#next').click(() => {
        today.setDate(today.getDate() + 1);
        updateDate();
    });

    // 오늘 버튼 클릭 시
    $('#now').click(() => {
        today = new Date(currentDate); // 저장된 currentDate 날짜로 복구
        updateDate();
    });

    // 날짜 업데이트 함수
    function updateDate() {
        const daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];
        const year = today.getFullYear();
        const month = String(today.getMonth() + 1).padStart(2, '0'); // 1월부터 시작
        const day = String(today.getDate()).padStart(2, '0');
        const dayOfWeek = daysOfWeek[today.getDay()]; // 요일

        const timeString = `\${year}-\${month}-\${day} (\${dayOfWeek})`;
        $('#today').text(timeString);








       // ====================== table tr 생성 ====================== //
       
       // 왜 이렇게 따로 빼두었나?? - td 26개 생성하기 귀찮아서,,, for문 돌릴 생각 하다가 이렇게 번짐
       let html = ``;
       // 회의실 개수가 들어올 자리 이 개수를 토대로 회의실 table 개수가 올라감
       // DB 연동시 assCnt = ${requestScope.List} 로 지정해두고 assCnt 를 이용해 foreach 돌릴 예정


       //-- DB 연동시 foreach로 바꿀것 --//
       assCnt.forEach(function(item){
    	   console.log("dddddd :   ",item.assetName)
           html += `<tr>`;

           html += `
               <td class="info">
                   <span class="name" title="\${item.assetName}">\${item.assetName}</span>
               </td>
           `;


           for(let i=0; i<26; i++) {
               let timeStr = (9 + i/2);

					if (!isNaN(timeStr) && timeStr !== "" && timeStr !== " ") {
					    if (isInteger(timeStr)) { 
					        html += `<td><input class="clickTime" type="hidden" value="\${timeString + ' '+timeStr+':00'}"/></td>`;
					    } else {
					        html += `<td><input class="clickTime" type="hidden" value="\${timeString + ' '+parseInt(timeStr, 10)+':30'}"/></td>`;
					    }
					} else {
					    console.error("Invalid timeStr value:", timeStr);
					}

               
           }

           html += `</tr>`;
       })
       //-- DB 연동시 foreach로 바꿀것 --//
       
       $('tbody#tbody').empty();
       $('tbody#tbody').append(html);
   // ====================== table tr 생성 ====================== //

   } // end of function updateDate()------------

   // 페이지 로드 시 현재 날짜 표시
   updateDate();
   // ====================== 날짜 리모컨 기능 생성 ====================== //

        



    // === 정수 체크 함수 === //
	function isInteger(number) {
	    return !isNaN(number) && Number.isInteger(Number(number));
    }
    // === 정수 체크 함수 === //
</script>
	
	
	
<jsp:include page="../../footer/footer.jsp" /> 
