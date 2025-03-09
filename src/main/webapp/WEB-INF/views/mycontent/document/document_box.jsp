<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();
%>

<div id="right_title_box">
    <h1 id="doc_title"></h1>

    <!-- 오른쪽 바 메뉴버튼들입니다! -->
        <div id="right_menu_container">
            <span>
				<a href="#">
					<span>목록 다운로드</span>
					<i class="fa-solid fa-download"></i>
				</a>
			</span>
            
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
                <span>
                    <span id="sort_btn" title="정렬"> <!-- 정렬 버튼입니다! -->
                    <i class="fa-solid fa-arrow-down-short-wide"></i>
                    <ul>
                        <li class="list_title">정렬순서</li>
                        <!-- 각 li 태그 마다 ajax 보내주세요 -->
                        <li>제목</li> 
                        <li>받은날짜</li>
                        <li>크기</li>

                        <li class="list_title">빠른검색</li>
                        <li>중요메일</li>
                        <li>안읽은 메일</li>
                        <li>읽은 메일</li>
                        <li>오늘온 메일</li>
                        <li>어제온 메일</li>
                        <!-- 각 li 태그 마다 ajax 보내주세요 -->
                    </ul>
                </span>
                <span id="re_btn" title="새로고침">
                    <i class="fa-solid fa-rotate-right"></i>
                </span>
                <span id="sortCnt_btn">
                    <span>20</span>
                    <i class="fa-solid fa-angle-right"></i>
                    <ul>
                        <li>5</li>
                        <li>10</li>
                        <li>20</li>
                    </ul>
                </span>
            </span>
        </span>
    </div>
    <!-- 오른쪽 바 메뉴버튼들입니다! -->
</div>