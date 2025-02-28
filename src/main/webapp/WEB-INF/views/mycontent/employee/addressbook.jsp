<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String ctxPath = request.getContextPath();
   //     /flowUp
%> 
<jsp:include page="../../header/header.jsp" />
<%@include file="./addressbookbar.jsp" %>

<link href="<%=ctxPath%>/css/employeeCss/addressbook.css" rel="stylesheet"> 

<div id="right-bar">
	<div id="right_title_box">
		<span id="right_title">주소록</span><span class="sidetitle">in 공용주소록(<span class="addresscount">10</span>건)</span>
	</div>


<div id="toolbar">
	 <div>
		<button class="toolbtn">빠른 등록</button>
		<button class="toolbtn">삭제</button>
		<button class="toolbtn">메일발송</button>
	 </div>
</div>

<div class="navtab_spelling">
	<button class="listall list">전체</button>
	<button class="spelling list" id="a">ㄱ</button>
	<button class="spelling list" id="b">ㄴ</button>
	<button class="spelling list" id="c">ㄷ</button>
	<button class="spelling list" id="d">ㄹ</button>
	<button class="spelling list" id="e">ㅁ</button>
	<button class="spelling list" id="f">ㅂ</button>
	<button class="spelling list" id="g">ㅅ</button>
	<button class="spelling list" id="h">ㅇ</button>
	<button class="spelling list" id="i">ㅈ</button>
	<button class="spelling list" id="j">ㅊ</button>
	<button class="spelling list" id="k">ㅋ</button>
	<button class="spelling list" id="l">ㅌ</button>
	<button class="spelling list" id="m">ㅍ</button>
	<button class="spelling list" id="o">ㅎ</button>
	<button class="spelling list" id="alphabet">A~Z</button>
	<button class="spelling list" id="number">1~9</button>
</div>

<div class="addressbookcontent">

	<table class="addressbooktable">
		<thead>
			<tr>
			<th class="thcss thcheck"><input type="checkbox"></th>
			<th class="thcss"><span class="tabletitle">이름(표시명)</span></th>
			<th class="thcss"><span class="tabletitle">직위</span></th>
			<th class="thcss"><span class="tabletitle">이메일</span></th>
			<th class="thcss"><span class="tabletitle">휴대폰</span></th>
			<th class="thcss"><span class="tabletitle">부서</span></th>
			<th class="thcss"><span class="tabletitle">회사</span></th>
			<th class="thcss"><span class="tabletitle">회사주소</span></th>
			<th class="thcss"><span class="tabletitle">내선번호</span></th>
			</tr>
		</thead>
		
		<tbody>
		<tr>
			<td class="tdcss imgcenter"><div class="profileimg"></div></td>
			<td class="tdcss"><span class="tabletitle">이지혜</span></td>
			<td class="tdcss"><span class="tabletitle">관리자</span></td>
			<td class="tdcss"><span class="tabletitle">banana5092@naver.com</span></td>
			<td class="tdcss"><span class="tabletitle">010-2070-6651</span></td>
			<td class="tdcss"><span class="tabletitle">물류부</span></td>
			<td class="tdcss"><span class="tabletitle">FLOWUP</span></td>
			<td class="tdcss"><span class="tabletitle">서울특별시 마포구 서교동 447-5 풍성빌딩</span></td>
			<td class="tdcss"><span class="tabletitle">021-0909-1212</span></td>
		</tr>	
		</tbody>
		
	</table>

</div>

</div>















