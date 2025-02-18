<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   String ctxPath = request.getContextPath();
   //     /myspring 
%>      

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	* {
	    font-family: "Noto Sans KR", sans-serif;
	    font-optical-sizing: auto;
	    margin: 0px;
	    padding: 0px;
	}
	
	*::after {
	    margin: 0px;
	    padding: 0px;
	}
	
	*::before {
	    margin: 0px;
	    padding: 0px;
	}

	:root{
	    --size2  : clamp(2px, 0.1042vw, 200px);
	    --size8  : clamp(6px, 0.4167vw, 200px);
	    --size12 : clamp(10px, 0.6250vw, 200px);
	    --size14 : clamp(12px, 0.7292vw, 200px);
	    --size15 : clamp(14px, 0.7813vw, 200px);
	    --size16 : clamp(16px, 0.8333vw, 200px);
	    --size18 : clamp(17px, 0.9375vw, 200px);
	    --size20 : clamp(18px, 1.0417vw, 200px);
	    --size24 : clamp(24px, 1.2500vw, 200px);
	    
	    --size30 : clamp(28px, 1.5625vw, 200px);
	    --size32 : clamp(30px, 1.6667vw, 200px);
	    --size40 : clamp(36px, 2.0833vw, 200px);
	    --size52 : clamp(48px, 2.7083vw, 200px);
	    --size60 : clamp(50px, 3.1250vw, 200px);
	    --size65 : clamp(60px, 3.3854vw, 200px);
	
	    --size98  : clamp(80px, 5.1042vw, 2000px);
	    --size100 : clamp(80px, 5.2083vw, 2000px);
	    --size120 : clamp(100px, 6.2500vw, 2000px);
	    --size200 : clamp(200px, 10.4167vw, 2000px);
	    --size300 : clamp(300px, 15.6250vw, 2000px);
	    --size400 : clamp(380px, 20.8333vw, 2000px);
	    --size500 : clamp(500px, 26.0417vw, 2000px);
	    --size670 : clamp(650px, 34.8958vw, 2000px);
	    --size700 : clamp(680px, 36.4583vw, 3000px);
	    --size930 : clamp(900px, 48.4375vw, 10000px);
	
	    --whiteColor : #fff;
	    --baseColor1 : #F9FAFB;
	    --baseColor2 : #f1f2f3;
	    --pointColor : #2985DB;
	    --keyColor : #21255b;
	
	    --darkBgColor : #0C1929;
	    --darkBaseColor : #141C30;
	}
	
	.dateController {
        width: 100%; 
        margin: auto;
    }

    .dateTopBar {
        display: flex;
        gap: var(--size16);
        align-items: center;
        justify-content: space-between;
		padding: 0px var(--size24);
        margin-bottom: var(--size30);
    }
	
	.dateTopBtn {
		display: flex;
        gap: var(--size16);
        align-items: center;
        justify-content: center;
	}
    #today {
        font-size: var(--size24);
        font-weight: 500;
    }

    #now {
        box-sizing: border-box;
        padding: calc(var(--size2) + var(--size2)) calc(var(--size2) + var(--size2));
        margin-top: calc(var(--size2) + var(--size2));
        font-size: var(--size12);
    }

    #now:hover {
        background-color: #eee;
    }

    .calendar_container {
        position: relative;
    }

    table {
        border-collapse : collapse;
        font-size: var(--size14);
    }

    .time_table_back_form {
        border: 1px solid #ddd;
        width: 100%;
        table-layout: fixed;
        border-collapse: collapse;
        border-spacing: 0;
    }
	
	.my_table {
		border: 1px solid #ddd;
        width: 100%;
        table-layout: fixed;
        border-collapse: collapse;
        border-spacing: 0;
	}
	
	.my_table tr th {
		height: var(--size30);
        font-weight: bold;
		text-align: left;
		padding-left: var(--size8);
	}

    .time_table_back_form tr th,
    .info {
        height: var(--size30);
        font-weight: normal;
		text-align: center;
    }

    .info {
        vertical-align: middle;
        overflow: hidden;
        text-align: center;
        border-left: 0;
    }

    .info span{
        display: block;
        color: #333;
        text-align: left;
        margin: 2px 5px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        max-width: 100%;
        cursor: pointer;
        font-size: 13px;
    }
</style>


<script>
    $(document).ready(() => {


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
            $('tbody#tbody').empty();
            // 왜 이렇게 따로 빼두었나?? - td 26개 생성하기 귀찮아서,,, for문 돌릴 생각 하다가 이렇게 번짐
            let html = ``;
            let assCnt = [{'title' : '회의실1'},{'title' : '회의실2'},{'title' : '회의실3'},{'title' : '회의실4'},{'title' : '회의실5'}]; // 아직 DB연동 X
            // 회의실 개수가 들어올 자리 이 개수를 토대로 회의실 table 개수가 올라감
            // DB 연동시 assCnt = ${requestScope.List} 로 지정해두고 assCnt 를 이용해 foreach 돌릴 예정


            //-- DB 연동시 foreach로 바꿀것 --//
            assCnt.forEach(function(item, idx){
                html += `<tr>`;

                html += `
                    <td class="info">
                        <span class="name" title="\${item.title}">\${item.title}</span>
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
            
            $('tbody#tbody').append(html);
        // ====================== table tr 생성 ====================== //

        } // end of function updateDate()------------

        // 페이지 로드 시 현재 날짜 표시
        updateDate();
        // ====================== 날짜 리모컨 기능 생성 ====================== //

        
    }); // end of $(document).ready(() => {})-------------


    // === 정수 체크 함수 === //
	function isInteger(number) {
	    return !isNaN(number) && Number.isInteger(Number(number));
	}
    // === 정수 체크 함수 === //
</script>





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
			<select name="ass" id="ass">
				<option value="">선택하세요</option>
				<option value="">회의실1</option>
			</select>
			
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
