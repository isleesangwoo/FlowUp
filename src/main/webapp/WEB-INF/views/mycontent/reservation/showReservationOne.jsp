<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@include file="./reservationLeftBar.jsp" %>
 
<style>
a {
  text-decoration: none;
  color: inherit;
}
.tab {
  width: 100%;
  display: flex;
  align-items: center;
  padding: 1rem;
  border-bottom: 1px solid #eee; 
}
.tab__item {
  padding: 0.6rem 1.3rem;
  margin-right: var(--size8);
  font-size: var(--size14);
  
}

.tab__item:hover {
	background-color: #f1f1f1;
}

.tab__item.active {
  display: inline-block;
  color: #000;
  border-bottom: solid 2px #056ac9;
}
.tab__content-wrapper {
  padding: 1rem
}
.tab__content {
  display: none;
}
.tab__content.active {
  display: block;
}

.tab1_info {
	font-size: var(--size14);
	color: #999;
}
</style>
 
<%-- 각자 페이지에 해당되는 css 연결 --%>
<link href="<%=ctxPath%>/css/reservation/reservation_main.css" rel="stylesheet"> 

<%-- 각자 페이지에 해당되는 js 연결 --%>
<script src="<%=ctxPath%>/js/reservation/reservation.js"></script>


	<!-- 오른쪽 바 -->
    <div id="right_bar">
        <div id="right_title_box">
            <span id="right_title">${requestScope.assetTitle}</span>
        </div>



		<ul class="tab">
		  <li class="tab__item active">
		    <a href="#tab1">이용안내</a>
		  </li>
		  <li class="tab__item">
		    <a href="#tab2">자산정보 관리</a>
		  </li>
		  <li class="tab__item">
		    <a href="#tab3">자산관리</a>
		  </li>
		</ul>





		<!-- 탭 내용 영역 -->
		<div class="tab__content-wrapper">
		  	<div id="tab1" class="tab__content active">
				<div class="tab1_info">※ 첫 페이지에 나오는 안내문을 작성할 수 있습니다.</div>
				<div>
					<div style="width: 100%; height: 500px; background-color: #f1f1f1;">
						
					</div>
					<div style="width: 50%; display: flex; justify-content: center; gap:8px; margin: auto; padding-top: 24px;">
						<span>확인</span> <span>취소</span>
					</div>
				</div>
			</div>
		  	<div id="tab2" class="tab__content">
				<div class="tab1_info">※ 자산에 대한 추가 정보란을 삽입할 수 있으며, 변경된 내용은 ‘자산 관리’ 탭에 적용됩니다.</div>
				<div>
					
				</div>
			</div>
		  	<div id="tab3" class="tab__content">
				<div class="tab1_info">※ 자산에 대한 정보를 수정, 삭제할 수 있습니다.</div>
				<div>
					
				</div>
			</div>
		</div>


    </div>
    <!-- 오른쪽 바 -->

<script type="text/javascript">
//1. 탭 버튼과 탭 내용 부분들을 querySelectorAll을 사용해 변수에 담는다.
const tabItem = document.querySelectorAll(".tab__item");
const tabContent = document.querySelectorAll(".tab__content");

// 2. 탭 버튼들을 forEach 문을 통해 한번씩 순회한다.
// 이때 index도 같이 가져온다.
tabItem.forEach((item, index) => {
  // 3. 탭 버튼에 클릭 이벤트를 준다.
  item.addEventListener("click", (e) => {
    // 4. 버튼을 a 태그에 만들었기 때문에, 
    // 태그의 기본 동작(링크 연결) 방지를 위해 preventDefault를 추가한다.
    e.preventDefault(); // a 
    
    // 5. 탭 내용 부분들을 forEach 문을 통해 한번씩 순회한다.
    tabContent.forEach((content) => {
      // 6. 탭 내용 부분들 전부 active 클래스를 제거한다.
      content.classList.remove("active");
    });

    // 7. 탭 버튼들을 forEach 문을 통해 한번씩 순회한다.
    tabItem.forEach((content) => {
      // 8. 탭 버튼들 전부 active 클래스를 제거한다.
      content.classList.remove("active");
    });

    // 9. 탭 버튼과 탭 내용 영역의 index에 해당하는 부분에 active 클래스를 추가한다.
    // ex) 만약 첫번째 탭(index 0)을 클릭했다면, 같은 인덱스에 있는 첫번째 탭 내용 영역에
    // active 클래스가 추가된다.
    tabItem[index].classList.add("active");
    tabContent[index].classList.add("active");
  });
});
</script>

<jsp:include page="../../footer/footer.jsp" /> 