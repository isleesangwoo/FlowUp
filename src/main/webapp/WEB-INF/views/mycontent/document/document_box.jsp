<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();
%>


<div id="right_title_box">
    <h3 id="doc_title"></h3>

    <!-- 오른쪽 바 메뉴버튼들입니다! -->
	<div id="right_menu_container">
		<%--
		<span>
			<a href="#">
				<span>목록 다운로드</span>
				<i class="fa-solid fa-download"></i>
			</a>
		</span>
		--%>
		
		<span class="doc_delete" style="display:none;">
			<a href="#">
				<span>삭제</span>
				<i class="fa-regular fa-trash-can"></i>
			</a>
		</span>

		<span>
			<input id="searchWord" class="doc_search_text" type="text" placeholder="검색" />
			<a class="doc_search_btn">
				<i class="fa-solid fa-magnifying-glass"></i>
           	</a>
		</span>

		<span id="reBtn_box">
			<span id="re_btn" title="새로고침">
				<i class="fa-solid fa-rotate-right"></i>
			</span>
			<span id="sortCnt_btn">
				<span>10</span>
				<i style="transform: rotate(90deg)" class="fa-solid fa-angle-right"></i>
				<ul>
					<li>5</li>
					<li>10</li>
					<li>20</li>
				</ul>
			</span>
        </span>
    </div>
    <!-- 오른쪽 바 메뉴버튼들입니다! -->
</div>