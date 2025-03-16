<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

 
<%@include file="./reservationLeftBar.jsp" %>

<%-- 각자 페이지에 해당되는 css 연결 --%>
<link href="<%=ctxPath%>/css/reservation/reservation_main.css" rel="stylesheet"> 
<link href="<%=ctxPath%>/css/reservation/reservation_time.css" rel="stylesheet"> 

<%-- 각자 페이지에 해당되는 js 연결 --%>
<script src="<%=ctxPath%>/js/reservation/reservation.js"></script>

	
    <!-- 오른쪽 바 -->
    <div id="right_bar">
        <div id="right_title_box">
            <span id="right_title">자산 예약 현황</span>
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
					
					<span class="selectHere">
						
						
					</span>
			    </div>
				

			    <!-- 시간 표기란 -->
			    <div class="calendar_container">
			        <div class="time_table">
						<div class="innerTimeTable">
														
						</div>

						<div id="timeLine"></div>
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
		  
	<%-- ================================ 들어오자마자 보이는 내 예약 현황 ================================ --%>
	  const now = new Date(); // 반납, 취소를 띄어주기 위한 지금날짜 변수 저장
	  
	  function showMyReservation(){
		  $.ajax({
			  url:"<%= ctxPath%>/reservation/showMyReservation",
			  type:"get",
			  data:{"employeeNo":"${sessionScope.loginuser.employeeNo}"},
			  dataType:"json",
			  success:function(json){
				  
			  // console.log("ajax 뽑아옴 : ", JSON.stringify(json));
			  /*
			  	[{"assetReservationNo":"100023","reservationEnd":"2025-03-04 12:30:00","fk_assetDetailNo":"100030","reservationStart":"2025-03-04 09:00:00","assetTitle":"본사 1,2층 공용 회의실","assetName":"Whale","reservationDay":"2025-02-28 12:06:05","fk_employeeNo":"100012"}
				,{"assetReservationNo":"100025","reservationEnd":"2025-03-04 15:30:00","fk_assetDetailNo":"100042","reservationStart":"2025-03-04 10:00:00","assetTitle":"본사 1,2층 공용 회의실","assetName":"Chrome","reservationDay":"2025-02-28 18:11:12","fk_employeeNo":"100012"}]
			  */
			  
			  
			  let v_html = ``;
			  
			  if(json.length == 0) {
				v_html += `<tr><td colspan="5" style="height:120px; text-align: center; vertical-align: middle; color: #999;">예약된 자산이 없습니다.</td></tr>`;
			  }
			  else{
			  
				  $.each(json, function(index, item){
					
					var sd = new Date(`\${item.reservationStart}`); // startdate
					var ed = new Date(`\${item.reservationEnd}`); // enddate
					let status = ``;
					
					  if(now < sd) {
						status = "취소"
					  }
					  else if(sd <= now && now >= ed) {
						status = "반납"
					  }
					
					  // alert(`\${item.reservationStart.split(" ")[1].split("\:")[0]}:\${item.reservationStart.split(" ")[1].split("\:")[1]}`)
					  v_html += `<tr>
									<td>\${item.assetTitle}</td>
									<td>\${item.assetName}</td>
									<td>대여</td>
									<td>\${item.reservationStart.split(" ")[1].split("\:")[0]}:\${item.reservationStart.split(" ")[1].split("\:")[1]}</td>
									<td><input type="hidden" name="assetReservationNo" value="\${item.assetReservationNo}" /><span class="status" id="\${item.assetName}" style="cursor:pointer;">\${status}</span></td>
								</tr>`;
				  });
			  }
			  $('.my_tbody').empty();
			  $('.my_tbody').append(v_html);
			  
			  },
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }   
		  });
	  }
	  showMyReservation();
	  
	  
	  
	  <%-- 취소 또는 반납버튼 클릭시 --%>
	  $(document).on('click', '.status', e=>{
		
		if(confirm(`정말로 \${$(e.target).attr('id')}의 예약건을 \${$(e.target).text()} 하시겠습니까?`)){
			$.ajax({
			    url: "<%= ctxPath%>/reservation/deleteAssetReservationNo",
			    type: "post",
			    data: { "assetReservationNo": $(e.target).prev().val() },
			    dataType: "json",
			    success: function(json) {
			        if (json.result == 1) {

						showMyReservation();
						selectNowReservation();
			        }
			        if (json.result == 0) {
			            alert('삭제가 실패되었습니다.');
			        }
			    },
			    error: function(request, status, error) {
			        alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
			    }
			});
		}
		
	  })
	  <%-- 취소 또는 반납버튼 클릭시 --%>
	  <%-- ================================ 들어오자마자 보이는 내 예약 현황 ================================ --%>
	  
	  
	  
	  
	  
	  
	  
	  
	<%-- ================================ 대분류 소분류 뿌려주기 ================================ --%>
	let cntTitle = 0;
	
	  function resetLeftBar() {
		  let assetDetailListArr;
		  $('.selectHere').empty();
		  
		  $.ajax({
		  	  url: "<%= ctxPath%>/reservation/selectReservationSubTitle",
		      type: "get",
		      dataType: "json",
			  async: false ,  // 자꾸 안 보이는 현상 때문에 번호표 매기기
		      success: function(json) {
		          console.log(JSON.stringify(json))
		          
				  	  // let html = ``;
		          	  assetDetailListArr = json; // 대분류 저장
		          
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
			  async: false ,
		      success: function(json) {
		          // console.log(JSON.stringify(json))
		          
		          TitleArr = JSON.stringify(json);
		          let html = ``;
				  
		          // alert(TitleArr)
		          
				  $('.board_menu_container > ul').empty();
				  
				  if(json.length == 0){
					$('.board_menu_container > ul').append(`<li>등록된 자산이 없습니다.</li>`);
				  }
				  else if(json.length != 0){
			          $.each(json, function(index, Title){
						
							////////////////////// select 태그 쌓아주기 //////////////////////
							cntTitle++;
							
							if(cntTitle == 1){
								html += `<option value="\${Title.assetNo}" selected>\${Title.assetTitle}</option>`;
							}
							else{
								html += `<option value="\${Title.assetNo}">\${Title.assetTitle}</option>`;
							}
							////////////////////// select 태그 쌓아주기 //////////////////////
							
							
							////////////////////// 왼쪽 바 채워주기 //////////////////////
			        	    let detailListHtml = ''; // 자산 상세 리스트를 저장할 빈 문자열 초기화
							
			        	    // assetDetailListArr 배열을 순회하면서 자산 세부 항목들을 생성
			        	    $.each(assetDetailListArr, function(i, subTitle){
								
								<%-- 대분류 하나에 해당하는 소분류 분리 --%>
			        	        // 실제 if문을 넣어서 조건을 처리합니다.
			        	        if (Title.assetNo == subTitle.fk_assetNo) {
			        	            // 조건이 맞으면 해당 항목을 detailListHtml에 추가
			        	            detailListHtml += `<a href='<%= ctxPath %>/reservation/showReservationDeOne?assetDetailNo=\${subTitle.assetDetailNo}&assetName=\${subTitle.assetName}'>
			        	                                   <div>\${subTitle.assetName}</div>
			        	                                </a>`;
			        	        } else {
			        	            
			        	        	// detailListHtml += `<div>없습니다.</div>`
			        	        }
								<%-- 대분류 하나에 해당하는 소분류 분리 --%>
			        	    });
	
			        	    // 자산 상세 HTML을 최종적으로 추가
			        	    
			        	    <%-- 대분류, 소분류 쌓아주기 --%>
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
							<%-- 대분류, 소분류 쌓아주기 --%>
							////////////////////// 왼쪽 바 채워주기 //////////////////////
			        	});
						
						
						////////////////////// select 태그 쌓아주기 //////////////////////
						$('.selectHere').append(`
						  <select name="titleAssetNo">
							  <option value="" hidden>선택하세요</option>
							  \${html}
						  </select>
						`);
						////////////////////// select 태그 쌓아주기 //////////////////////
					}			  
					  

		      },
		      error: function(request, status, error) {
		          alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
		      }
		  });
	  }
	  resetLeftBar();
	  <%-- ================================ 대분류 소분류 뿌려주기 ================================ --%>
	  
	  
	  
	  
	  
	  
	  
	  <%-- ================================ 예약정보, 회의실들 뿌려주기 ================================ --%>
	  <%-- select 태그 변경시 회의실, 예약정보 갖고오기 --%>
	  $('select[name="titleAssetNo"]').change(e=>{
		// alert('das')
		// resetLeftBar();
		$('tbody#tbody').empty();

		$.ajax({
	  		url:"<%= ctxPath%>/reservation/selectAssetDe",
	  		type:"post",
	  		data:{"fk_assetNo":$('select[name="titleAssetNo"]').val()},
	  		dataType:"json",
	  		async:false,
	  		success:function(json){
				assCnt =[];
				// console.log(JSON.stringify(json));
				$('.innerTimeTable').empty();

				$.each(json, function(index, item){
					assCnt.push(item)
				})
				
				$.each(json, function(index, item){
					$('.innerTimeTable').append(`<div class="reservationTimeLisnDisplay" id="\${item.assetDetailNo}" style="width:100%; height:var(--size30); position: relative;"></div>`);
				}) // end of $.each(json, function(index, item){})---------------
	  		},
	  	    error: function(request, status, error){
	  	 	    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	  	    } 
	  	})
		
		
   		updateDate();
		selectNowReservation();
		// titleAssetNo();
	  })
	  <%-- select 태그 변경시 회의실, 예약정보 갖고오기 --%>
	  
	  
	  
	  <%-- 회의실들 불러오기 --%>
	  	let assCnt =[];
	  	
		function titleAssetNo(){
			
			if($('select[name="titleAssetNo"]').val() != null){
			
			  	$.ajax({
			  		url:"<%= ctxPath%>/reservation/selectAssetDe",
			  		type:"post",
			  		data:{"fk_assetNo":$('select[name="titleAssetNo"]').val()},
			  		dataType:"json",
			  		async:false,
			  		success:function(json){
						console.log(JSON.stringify(json));
						
						$('.innerTimeTable').empty();
						/*
							[{"assetDetailRegisterday":"2025-02-27 14:30:06","assetDetailNo":"100030","assetName":"Whale","fk_assetNo":"100031"}
							,{"assetDetailRegisterday":"2025-02-27 18:13:10","assetDetailNo":"100042","assetName":"Chrome","fk_assetNo":"100031"}
							,{"assetDetailRegisterday":"2025-02-27 14:29:53","assetDetailNo":"100029","assetName":"Edge","fk_assetNo":"100031"}]
						*/
						
						
						$.each(json, function(index, item){
							assCnt.push(item)
						})
						
						//////////////////////////////////////////////////////////////////
						
						$.each(json, function(index, item){
							$('.innerTimeTable').append(`<div class="reservationTimeLisnDisplay" id="\${item.assetDetailNo}" style="width:100%; height:var(--size30); position: relative;"></div>`);
						}) // end of $.each(json, function(index, item){})---------------
						
						
						
						// alert("사이즈 : ", assCnt.length)
			  		},
			  	    error: function(request, status, error){
			  	 	    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  	    } 
			  	})
			}
		}
		titleAssetNo();
	  	<%-- 회의실들 불러오기 --%>
	  
	  
	  
		// ============== 타임라인 바 ============== //
		updateTimelinePosition();
		setInterval(() => {
			updateTimelinePosition();
		}, 100000);
	
		function updateTimelinePosition() {
			// console.log('되는중')
			const totalWidth = $('.time_table_back_form').outerWidth() - 240;
			// console.log("totalWidth: ", totalWidth); // totalWidth를 확인
		
			// 15시로 시간 설정
			const now = new Date();
			// now.setHours(15, 0, 0, 0); // 15시 0분으로 설정
			// console.log("현재 시간: ", now); // 현재 시간이 15시로 잘 설정되었는지 확인
		
			const startHour = 9; // 9시
			const endHour = 21;  // 21시
		
			// 9시부터 현재 시간까지 경과한 분
			const startTime = new Date(now);
			startTime.setHours(startHour, 0, 0, 0); // 오늘 9시 기준
			const minutesPassed = (now - startTime) / (1000 * 60); // 경과 시간 (분)
			console.log("경과 시간: ", minutesPassed, "분"); // 경과한 시간이 360분인지 확인
		
			// 타임라인의 총 분 (9시부터 21시까지 720분)
			const totalMinutes = (endHour - startHour) * 60;
		
			// 비율로 계산하여 left 값 설정
			const leftPercentage = (minutesPassed / totalMinutes) * totalWidth ;
			// console.log("leftPercentage: ", leftPercentage); // leftPercentage가 정상적으로 계산되는지 확인
			
			// 타임라인의 스타일 업데이트
			$("#timeLine").css({
			    'left': leftPercentage + "px",
				'top': '0px',
				'z-index': '0'
			});
		}
	
		
		$(window).resize(function() {
	        updateTimelinePosition(); // 윈도우 크기 변경 시 위치 업데이트
	    });
	 	// ============== 타임라인 바 ============== //
		<%-- ================================ 예약정보, 회의실들 뿌려주기 ================================ --%>
		
		
	      	
	    
		
		
		<%-- ================================ 날짜 리모컨 기능 생성 ================================ --%>  	
	    let today = new Date(); // 현재 날짜 저장
	    let currentDate = new Date(); // 오늘을 저장하는 변수

	    // 이전 버튼 클릭 시
	    $('#prev').click(() => {
	        today.setDate(today.getDate() - 1);
	        updateDate();
			selectNowReservation();
	    });

	    // 다음 버튼 클릭 시
	    $('#next').click(() => {
	        today.setDate(today.getDate() + 1);
	        updateDate();
			selectNowReservation();
	    });

	    // 오늘 버튼 클릭 시
	    $('#now').click(() => {
	        today = new Date(currentDate); // 저장된 currentDate 날짜로 복구
	        updateDate();
			selectNowReservation();
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
			
		   if(assCnt.length == 0){
	   			html += `<tr><td colspan="27" style="color:#999; height: 120px; text-align: center; vertical-align: middle;">해당 자산에 등록된 자산정보가 없습니다.</td></tr>`;
	   			
	   			$('#timeLine').css({
	   				'display':'none'
	   			})
	   	   }
	   	   else{
	   			$('#timeLine').css({
	   				'display':'block'
	   			})

		       //-- DB 연동시 foreach로 바꿀것 --//
		       assCnt.forEach(function(item){
		    	   // console.log("dddddd :   ",item.assetName)
		           html += `<tr>`;
	
		           html += `
		               <td class="info">
		                   <span class="name" title="\${item.assetName}"><input type="hidden" name="assetDetailNo" value="\${item.assetDetailNo}"/>\${item.assetName}</span>
		               </td>
		           `;
	
	
		           for(let i=0; i<26; i++) {
		               let timeStr = (9 + i/2);
	
							if (!isNaN(timeStr) && timeStr !== "" && timeStr !== " ") {
							    if (isInteger(timeStr)) { 
							        html += `<td><input class="clickTime" type="hidden" value="\${timeString + ' '+String(timeStr).padStart(2, '0') +':00'}"/></td>`;
							    } else {
							        html += `<td><input class="clickTime" type="hidden" value="\${timeString + ' '+String(parseInt(timeStr, 10)).padStart(2, '0') +':30'}"/></td>`;
							    }
							} else {
							    console.error("Invalid timeStr value:", timeStr);
							}
	
		               
		           }
	
		           html += `</tr>`;
		       })
		       //-- DB 연동시 foreach로 바꿀것 --//
	       }
	       $('tbody#tbody').empty();
	       $('tbody#tbody').append(html);
		   
	   // ====================== table tr 생성 ====================== //

	   } // end of function updateDate()------------

	   // 페이지 로드 시 현재 날짜 표시
	   updateDate();
	   <%-- ================================ 날짜 리모컨 기능 생성 ================================ --%>  	
	          

	   
	   
	   
	   
	   
	   <%-- ================================ 예약정보 갖고오기 ================================ --%>
       function selectNowReservation() {
   	
   	   let assetDetailNo_arr = Array.from($('input[name="assetDetailNo"]'));
   	   let assetDetailNo_arr_str = [];
   	   
	   if(assetDetailNo_arr.length != 0){
	   
   	   assetDetailNo_arr.forEach(function(item, index) { 
   	       assetDetailNo_arr_str.push($(item).val()); 
   	   });
   	   
   	   // alert(assetDetailNo_arr_str.join(","))
   	   // alert($('#today').text().split(" ")[0])
   	   $.ajax({
   			url:"<%=ctxPath%>/reservation/selectNowReservation",
   			type:"get",
   			data:{"assetDetailNo_arr_str":assetDetailNo_arr_str.join(","),
   				  "reservationStart":$('#today').text().split(" ")[0]},
   			dataType:"json",
   			success:function(json){
   				//console.log(JSON.stringify(json))
   				/*
   					[{"assetReservationNo":"100023","reservationEnd":"2025-03-04 12:30:00","fk_assetDetailNo":"100030","reservationStart":"2025-03-04 09:00:00","name":"강이훈 ","reservationcontents":"되나","fk_employeeNo":"100012"}
   					,{"assetReservationNo":"100025","reservationEnd":"2025-03-04 15:30:00","fk_assetDetailNo":"100042","reservationStart":"2025-03-04 10:00:00","name":"강이훈 ","reservationcontents":"테스트","fk_employeeNo":"100012"}
   					,{"assetReservationNo":"100026","reservationEnd":"2025-03-04 14:00:00","fk_assetDetailNo":"100030","reservationStart":"2025-03-04 10:30:00","name":"강이훈 ","reservationcontents":"웨일 테스트","fk_employeeNo":"100012"}]
   				*/
   				$('.reservationTimeLisnDisplay').empty();
   				
   				Array.from($('.reservationTimeLisnDisplay')).forEach(function(elmt, i){
   					// alert($(elmt).attr('id'))
   					$.each(json, function(index, item){
   						
   						// alert(item.fk_assetDetailNo)
   						if($(elmt).attr('id') == item.fk_assetDetailNo){ // 예약 정보의 pk를 이용해 같은 tr에 쌓기
   							
   							const startTimeOne = parseInt(((item.reservationStart).split(/\s+/g)[1]).split(':')[0]); // 12
   							const endTimeOne = parseInt(((item.reservationEnd).split(/\s+/g)[1]).split(':')[0]);    // 14
   							
   							const startTimeTwo = parseInt(((item.reservationStart).split(/\s+/g)[1]).split(':')[1]); // 00
   							const endTimeTwo = parseInt(((item.reservationEnd).split(/\s+/g)[1]).split(':')[1]);    // 30
   							
   							// 예약 시작시간과 끝시간의 차를 구해 30단위로 끊은 것의 개수 구하기
   							const timeSum = ((endTimeOne * 60 + endTimeTwo) - (startTimeOne * 60 + startTimeTwo)) / 30;
   							
   							const startabsolute = ((startTimeOne * 60 + startTimeTwo) - (9 * 60)) / 30; // 9시부터 예약 시작시간의 차를 30분 단위로 쪼갠 개수
   							// alert(startabsolute)
   							
   							// td 하나당 width
   							const oneCell = $('#tbody > tr:nth-child(1) > td:nth-child(2)').outerWidth();
   							// alert(oneCell)
   							
   							const cellWidth = timeSum * oneCell;
   							const cellAbsolute = startabsolute * oneCell;
   							 
   							$(elmt).append(`<div class="reservationBar"
   											style="width:\${cellWidth}px; left: \${cellAbsolute}px;">
   											   \${((item.reservationStart).split(/\s+/g)[1]).split(':')[0]}:\${((item.reservationStart).split(/\s+/g)[1]).split(':')[1]} ~
   											   \${((item.reservationEnd).split(/\s+/g)[1]).split(':')[0]}:\${((item.reservationEnd).split(/\s+/g)[1]).split(':')[1]}  \${item.name} &nbsp;&nbsp; 사유 : \${item.reservationcontents}
   										 	</div>`);
   						} // end of if($(elmt).attr('id') == item.fk_assetDetailNo){})------------
   					})
   					
   				})
   				
   			},
   			error: function(request, status, error){
   				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
   			} 
   	   })
	   }
      }
      selectNowReservation();
      
      $(window).resize(e=>{
   		selectNowReservation();
      })
      
      <%-- ================================ 예약정보 갖고오기 ================================ --%>
	   
	   

	    // === 정수 체크 함수 === //
	  	function isInteger(number) {
	  	    return !isNaN(number) && Number.isInteger(Number(number));
	  	}
	    // === 정수 체크 함수 === //
</script>
	
	
	
<jsp:include page="../../footer/footer.jsp" /> 
