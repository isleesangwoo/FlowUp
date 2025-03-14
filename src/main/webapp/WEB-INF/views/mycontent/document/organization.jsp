<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
   String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>

<!-- ikon -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />

<!-- jsTree -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />

<!-- jsTree boot jQ cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>





<script type="text/javascript">
	
	$(document).ready(function(){
	
		<%-- jsTree 에 들어갈 객체 배열 --%>
		let jsonData = [];
		
		<%-- jsTree 조직도에 들어갈 부서 목록 가져오기 --%>
		$.ajax({
			url:"<%= ctxPath%>/document/getDepartmentList",
			dataType:"json",
			async:false,
			success: function(json){
				$.each(json, function(index, item){
					// id 구분을 위해 부서에는 D 를 붙여준다.
					let data = { "id" : "D-" + item.departmentNo, "parent" : "#", "text" : item.departmentName, "icon" : "fa-solid fa-building" }
					jsonData.push(data);
				}); // end of $.each--------------
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of $.ajax-------------------
  
		<%-- jsTree 조직도에 들어갈 팀 목록 가져오기 --%>
		$.ajax({
			url:"<%= ctxPath%>/document/getTeamList",
			dataType:"json",
			async:false,
			success: function(json){
				$.each(json, function(index, item){
					// id 구분을 위해 팀에는 T 를 붙여준다.
					let data = { "id" : "T-" + item.teamNo, "parent" : "D-" + item.fk_departmentNo , "text" : item.teamName, "icon" : "fa-solid fa-users-between-lines" }
					jsonData.push(data);
				}); // end of $.each--------------
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of $.ajax-------------------
		
		<%-- jsTree 조직도에 들어갈 사원 목록 가져오기 --%>
		$.ajax({
			url:"<%= ctxPath%>/document/getEmployeeList",
			dataType:"json",
			async:false,
			success: function(json){
				$.each(json, function(index, item){
					let data = { "id" : item.employeeNo, "parent" : "T-" + item.fk_teamNo , "text" : item.name, "icon" : "fa-solid fa-user" }
					jsonData.push(data);
				}); // end of $.each--------------
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of $.ajax-------------------
		
		<%-- jsTree 띄우는 이벤트 --%>
		$('#jstree').jstree({
			'plugins': ["search", "html"], // 플러그인 배열 합침
			'core' : {
				"check_callback": true,
				'data' : jsonData,
 				'state': {
 					'opened': true
 				},
			},
			"search": {
		        "case_sensitive": false,	// 대소문자 구분하지 않음
		        "show_only_matches": true,  // 일치하는 노드만 검색
		        "search_leaves_only": true  // 리프노드만 검색
		    }
		});
		
		<%-- 사원명 검색시 해당 노드만 펼쳐지는 이벤트 --%>
		$("input:text[name='member_name']").on("keyup", function(e){
			
			const member_name = $(e.target).val();
			$('#jstree').jstree(true).search(member_name);
		});
		
		<%-- show 버튼을 누르면 모든 노드를 펼치는 이벤트 --%>
		$("button#btnShow").click(function() {
			$('#jstree').jstree("open_all");
		});

		<%-- hide 버튼을 누르면 모든 노드를 접는 이벤트 --%>
		$("button#btnHide").click(function() {
			$('#jstree').jstree("close_all");
		});
		
	});
		
</script>

	<div>
		<button type="button" id="btnShow" class="doc_btn">Show</button>
		<button type="button" id="btnHide" class="doc_btn">Hide</button>
		<input type="text" name='member_name' placeholder="사원 검색" class="my-1"/>
		<div id="jstree" style="overflow: scroll; max-height: 250px; border: solid 1px #333;"></div>
	</div>
	
</html>