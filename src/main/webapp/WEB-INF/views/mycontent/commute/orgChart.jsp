<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String ctxPath = request.getContextPath();
//     /myspring

%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../../header/header.jsp" />

<script src="<%= ctxPath%>/Highcharts-10.3.1/code/highcharts.js"></script>
<script src="<%= ctxPath%>/Highcharts-10.3.1/code/modules/sankey.js"></script>
<script src="<%= ctxPath%>/Highcharts-10.3.1/code/modules/organization.js"></script>
<script src="<%= ctxPath%>/Highcharts-10.3.1/code/modules/exporting.js"></script>
<script src="<%= ctxPath%>/Highcharts-10.3.1/code/modules/accessibility.js"></script>

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

:root {
	--size2: clamp(2px, 0.1042vw, 200px);
	--size8: clamp(6px, 0.4167vw, 200px);
	--size12: clamp(10px, 0.6250vw, 200px);
	--size14: clamp(12px, 0.7292vw, 200px);
	--size15: clamp(14px, 0.7813vw, 200px);
	--size16: clamp(16px, 0.8333vw, 200px);
	--size18: clamp(17px, 0.9375vw, 200px);
	--size20: clamp(18px, 1.0417vw, 200px);
	--size24: clamp(24px, 1.2500vw, 200px);
	--size30: clamp(28px, 1.5625vw, 200px);
	--size32: clamp(30px, 1.6667vw, 200px);
	--size40: clamp(36px, 2.0833vw, 200px);
	--size52: clamp(48px, 2.7083vw, 200px);
	--size60: clamp(50px, 3.1250vw, 200px);
	--size65: clamp(60px, 3.3854vw, 200px);
	--size98: clamp(80px, 5.1042vw, 2000px);
	--size100: clamp(80px, 5.2083vw, 2000px);
	--size120: clamp(100px, 6.2500vw, 2000px);
	--size200: clamp(200px, 10.4167vw, 2000px);
	--size300: clamp(300px, 15.6250vw, 2000px);
	--size400: clamp(380px, 20.8333vw, 2000px);
	--size500: clamp(500px, 26.0417vw, 2000px);
	--size670: clamp(650px, 34.8958vw, 2000px);
	--size700: clamp(680px, 36.4583vw, 3000px);
	--size930: clamp(900px, 48.4375vw, 10000px);
	--whiteColor: #fff;
	--baseColor1: #F9FAFB;
	--baseColor2: #f1f2f3;
	--pointColor: #2985DB;
	--keyColor: #21255b;
	--darkBgColor: #0C1929;
	--darkBaseColor: #141C30;
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
	padding: calc(var(--size2)+ var(--size2)) calc(var(--size2)+ var(--size2));
	margin-top: calc(var(--size2)+ var(--size2));
	font-size: var(--size12);
}

#now:hover {
	background-color: #eee;
}

.calendar_container {
	position: relative;
}

table {
	border-collapse: collapse;
	font-size: var(--size14);
	border: 1px solid #ddd;
	width: 100%;
	table-layout: fixed;
	border-collapse: collapse;
	border-spacing: 0;
}

table tr th, .info {
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

.info span {
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

table td {
	position: relative;
	z-index: 1;
}

div.hoverDiv:hover {
	cursor: pointer;
}


.openDiv {
	display: block;
}

.closeDiv {
	display: none;
}

.highcharts-figure,
.highcharts-data-table table {
    min-width: 360px;
    max-width: 800px;
    margin: 1em auto;
}

.highcharts-data-table table {
    font-family: Verdana, sans-serif;
    border-collapse: collapse;
    border: 1px solid #ebebeb;
    margin: 10px auto;
    text-align: center;
    width: 100%;
    max-width: 500px;
}

.highcharts-data-table caption {
    padding: 1em 0;
    font-size: 1.2em;
    color: #555;
}

.highcharts-data-table th {
    font-weight: 600;
    padding: 0.5em;
}

.highcharts-data-table td,
.highcharts-data-table th,
.highcharts-data-table caption {
    padding: 0.5em;
}

.highcharts-data-table thead tr,
.highcharts-data-table tr:nth-child(even) {
    background: #f8f8f8;
}

.highcharts-data-table tr:hover {
    background: #f1f7ff;
}

#container h4 {
    text-transform: none;
    font-size: 14px;
    font-weight: normal;
}

#container p {
    font-size: 13px;
    line-height: 16px;
}

@media screen and (max-width: 600px) {
    #container h4 {
        font-size: 2.3vw;
        line-height: 3vw;
    }

    #container p {
        font-size: 2.3vw;
        line-height: 3vw;
    }
}

</style>

<div style="font-size:24pt; width: 100%; text-align:center; margin: 20px 0;"><span style="color:#2985DB; font-weight: bold;">flow up</span>&nbsp;조직도</div>

<div id="chart_container"></div>

<script>

    $(document).ready(() => {
    	
    	getChart();
  
    }); // end of $(document).ready(() => {})-------------

    function getChart() {
    	
    	$.ajax({
			url:"<%= ctxPath%>/commute/getOrgChartInfo",
			dataType:"json",
			success:function(json) {
				
//				console.log(JSON.stringify(json));
    			
				if(json.CEOList.length > 0) {
					
					let aArr = [];
					
					
					$.each(json.CEOList, (indexCEO,itemCEO)=>{
						
			    		let bArr = [];
			    			
			    		bArr.push("CEO"+indexCEO);
			    		bArr.push('경영관리본부');
			    			
			    		aArr.push(bArr);
			    		
			    		
						if(json.deptList.length > 0 ) {
							
							$.each(json.deptList, (indexDept,itemDept)=>{
					    		
				    			let bArr = [];
				    			let cArr = [];
				    	    	
				    			bArr.push('경영관리본부');
				    			bArr.push("deptMNo"+indexDept);
				    			
				    			aArr.push(bArr);
				    			
				    			cArr.push("deptMNo"+indexDept);
				    			cArr.push("deptNo"+indexDept);
				    			
				    			aArr.push(cArr);
						
								if(json.teamList.length > 0 ) {
									
									$.each(json.teamList, (indexTeam,itemTeam)=>{
					    				
					    				if(itemDept.departmentNo == itemTeam.fk_departmentNo) {
					    					
					    					let dArr = [];
					        				let eArr = [];
					        				
					        				dArr.push("deptNo"+indexDept);
					        				dArr.push("teamMNo"+indexTeam);
					        				
					        				aArr.push(dArr);
					        				
					        				eArr.push("teamMNo"+indexTeam);
					        				eArr.push("teamNo"+indexTeam);
					        				
					        				aArr.push(eArr);
					    				};
					    				
					    			});// each
									
								} // if
						
							});//  each
							
							
						} // if
						
			    			
			    	}); // each
					
					
			    	let nodesArr = [];
		    		
			    	$.each(json.CEOList, (indexCEO,itemCEO)=>{
		    			
		    			let obj = {id:"CEO"+indexCEO
		    					  ,name:"대표 "+itemCEO.name};
		    			
		    			nodesArr.push(obj);
		    		
			    	});	
		    		
		    		nodesArr.push({id:'경영관리본부'});
		    		
		    		$.each(json.deptList, (indexDept,itemDept)=>{
		    			
		    			let obj = {id:"deptMNo"+indexDept
		    					  ,name:itemDept.departmentName+" 부서장 "+itemDept.deptManagerName};
		    			
		    			nodesArr.push(obj);
		    			
		    			let objj = {id:"deptNo"+indexDept
		    					   ,name:itemDept.departmentName};
		    			
		    			nodesArr.push(objj);
		    		});
		    		
		    		$.each(json.teamList, (indexTeam,itemTeam)=>{
		    			
		    			let obj = {id:"teamMNo"+indexTeam
		    					  ,name:itemTeam.teamName +" 팀장 "+ itemTeam.teamManagerName};
		    			
						nodesArr.push(obj);
		    			
		    			let objj = {id:"teamNo"+indexTeam
		    					   ,name:itemTeam.teamName};
		    			
		    			nodesArr.push(objj);
		    			
		    		});
			    	
		    		Highcharts.chart('chart_container', {
		        	    chart: {
		        	        height: 600,
		        	        inverted: true
		        	    },

		        	    title: {
		        	        text: ''
		        	    },

		        	    accessibility: {
		        	        point: {
		        	            descriptionFormatter: function (point) {
		        	                var nodeName = point.toNode.name,
		        	                    nodeId = point.toNode.id,
		        	                    nodeDesc = nodeName === nodeId ? nodeName : nodeName + ', ' + nodeId,
		        	                    parentDesc = point.fromNode.id;
		        	                return point.index + '. ' + nodeDesc + ', reports to ' + parentDesc + '.';
		        	            }
		        	        }
		        	    },

		        	    series: [{
		        	        type: 'organization',
		        	        name: 'Highsoft',
		        	        keys: ['from', 'to'],
		        	        data: aArr,
		        	        
		        	        levels: [{
		        	            level: 0,
		        	            color: 'silver',
		        	            dataLabels: {
		        	                color: 'black'
		        	            },
		        	            height: 25
		        	        }, {
		        	            level: 1,
		        	            color: 'silver',
		        	            dataLabels: {
		        	                color: 'black'
		        	            },
		        	            height: 0
		        	        }, {
		        	            level: 2,
		        	            color: '#980104'
		        	        }, {
		        	            level: 3,
		        	            color: '#359154'
		        	        },
		        	        {
		        	            level: 5,
		        	            color: '#359154'
		        	        },
		        	        {
		        	            level: 6,
		        	            color: '#359154'
		        	        }
		        	        ],
		        	        
		        	        nodes: nodesArr,
		        	        
		        	        colorByPoint: false,
		        	        color: '#007ad0',
		        	        dataLabels: {
		        	            color: 'white'
		        	        },
		        	        borderColor: 'white',
		        	        nodeWidth: 65
		        	    }],
		        	    tooltip: {
		        	        outside: true
		        	    },
		        	    exporting: {
		        	        allowHTML: true,
		        	        sourceWidth: 800,
		        	        sourceHeight: 600
		        	    }

		        	});
			    		
			    	
				} // if
    	
				
			},
			error: function(request, status, error){
	        	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
			
		});
    	
    	
    }
    
</script>

<jsp:include page="../../footer/footer.jsp" />
