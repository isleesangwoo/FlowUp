<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>조직도</title>
</head>
<body>

	<aside class="go_organogram" id="organogram"
		style="height: 430px; width: 300px; display: block;">
		<h1>
			<ins class="ic"></ins>
			<span class="txt">조직도</span><span class="btn_wrap" id="orgToggleWrap"><span
				id="orgToggle" class="ic_gnb ic_show_down2" data-slide="true"
				title="닫기"></span></span>
		</h1>
		<div class="search_wrap">
			<form name="orgSearch" onsubmit="return false;">
				<input class="search" type="text" placeholder="이름/아이디/부서/직위/직책/전화"
					title="이름/아이디/부서/직위/직책/전화" style="width: 100%;"><input
					class="btn_search" type="submit" value="검색" title="검색">
			</form>
		</div>
		<div class="tab_wrap" style="display: block;">
			<div id="tabOrgTree" class="content_tab_wrap" style="height: 400px">
				<div id="orgSideTree"
					class="jstree jstree-1 jstree-focused jstree-default"
					style="min-height: 375px; max-height: 375px;">
					<ul>
						<li title="김상후 대표이사" rel="MASTER" nodeid="457" id="MASTER_457"
							class="jstree-leaf"><ins class="jstree-icon">&nbsp;</ins><a
							title="" rel="MASTER" nodeid="457" id="MASTER_457" href="#"
							data-bypass="1" class=""><ins class="jstree-icon worker"></ins>김상후
								대표이사</a></li>
						<li title="구정모 사장" rel="MEMBER" nodeid="260" id="MEMBER_260"
							class="jstree-leaf"><ins class="jstree-icon">&nbsp;</ins><a
							title="" rel="MEMBER" nodeid="260" id="MEMBER_260" href="#"
							data-bypass="1"><ins class="jstree-icon worker"></ins>구정모 사장</a></li>
						<li title="이재오 전무" rel="MEMBER" nodeid="481" id="MEMBER_481"
							class="jstree-leaf"><ins class="jstree-icon">&nbsp;</ins><a
							title="" rel="MEMBER" nodeid="481" id="MEMBER_481" href="#"
							data-bypass="1"><ins class="jstree-icon worker"></ins>이재오 전무</a></li>
						<li title="영업본부" rel="org" nodeid="123" id="org_123"
							class="jstree-open"><ins class="jstree-icon">&nbsp;</ins><a
							title="" rel="org" nodeid="123" id="org_123" href="#"
							data-bypass="1" class=""><ins class="jstree-icon">&nbsp;</ins>영업본부</a>
						<ul style="">
								<li title="마장웅 상무" rel="MASTER" nodeid="332" id="MASTER_332"
									class="jstree-leaf"><ins class="jstree-icon">&nbsp;</ins><a
									title="" rel="MASTER" nodeid="332" id="MASTER_332" href="#"
									data-bypass="1" class=""><ins class="jstree-icon worker"></ins>마장웅
										상무</a></li>
								<li title="허각 이사" rel="MEMBER" nodeid="181" id="MEMBER_181"
									class="jstree-leaf"><ins class="jstree-icon">&nbsp;</ins><a
									title="" rel="MEMBER" nodeid="181" id="MEMBER_181" href="#"
									data-bypass="1"><ins class="jstree-icon worker"></ins>허각 이사</a></li>
								<li title="김다우 과장" rel="MEMBER" nodeid="454" id="MEMBER_454"
									class="jstree-leaf"><ins class="jstree-icon">&nbsp;</ins><a
									title="" rel="MEMBER" nodeid="454" id="MEMBER_454" href="#"
									data-bypass="1"><ins class="jstree-icon worker"></ins>김다우
										과장</a></li>
								<li title="고단비 대리" rel="MEMBER" nodeid="471" id="MEMBER_471"
									class="jstree-leaf"><ins class="jstree-icon">&nbsp;</ins><a
									title="" rel="MEMBER" nodeid="471" id="MEMBER_471" href="#"
									data-bypass="1" class=""><ins class="jstree-icon worker"></ins>고단비
										대리</a></li>
								<li title="김사원 사원" rel="MEMBER" nodeid="470" id="MEMBER_470"
									class="jstree-leaf"><ins class="jstree-icon">&nbsp;</ins><a
									title="" rel="MEMBER" nodeid="470" id="MEMBER_470" href="#"
									data-bypass="1"><ins class="jstree-icon worker"></ins>김사원
										사원</a></li>
								<li title="apple-tester " rel="MEMBER" nodeid="490"
									id="MEMBER_490" class="jstree-leaf"><ins
										class="jstree-icon">&nbsp;</ins><a title="" rel="MEMBER"
									nodeid="490" id="MEMBER_490" href="#" data-bypass="1" class=""><ins
											class="jstree-icon worker"></ins>apple-tester </a></li>
								<li title="영업팀" rel="org" nodeid="130" id="org_130"
									class="jstree-closed"><ins class="jstree-icon">&nbsp;</ins><a
									title="" rel="org" nodeid="130" id="org_130" href="#"
									data-bypass="1"><ins class="jstree-icon">&nbsp;</ins>영업팀</a></li>
								<li title="마케팅팀" rel="org" nodeid="131" id="org_131"
									class="jstree-closed jstree-last"><ins class="jstree-icon">&nbsp;</ins><a
									title="" rel="org" nodeid="131" id="org_131" href="#"
									data-bypass="1" class=""><ins class="jstree-icon">&nbsp;</ins>마케팅팀</a></li>
							</ul></li>
						<li title="경영지원본부" rel="org" nodeid="124" id="org_124"
							class="jstree-closed"><ins class="jstree-icon">&nbsp;</ins><a
							title="" rel="org" nodeid="124" id="org_124" href="#"
							data-bypass="1" class=""><ins class="jstree-icon">&nbsp;</ins>경영지원본부</a></li>
						<li title="개발본부" rel="org" nodeid="178" id="org_178"
							class="jstree-closed"><ins class="jstree-icon">&nbsp;</ins><a
							title="" rel="org" nodeid="178" id="org_178" href="#"
							data-bypass="1" class=""><ins class="jstree-icon">&nbsp;</ins>개발본부</a></li>
						<li title="서비스본부" rel="org" nodeid="182" id="org_182"
							class="jstree-closed jstree-last"><ins class="jstree-icon">&nbsp;</ins><a
							title="" rel="org" nodeid="182" id="org_182" href="#"
							data-bypass="1" class=""><ins class="jstree-icon">&nbsp;</ins>서비스본부</a></li>
					</ul>
				</div>
			</div>
			<div id="tabOrgMembers" class="content_tab_wrap"
				style="display: none; height: 400px"></div>
		</div>
	</aside>

</body>
</html>