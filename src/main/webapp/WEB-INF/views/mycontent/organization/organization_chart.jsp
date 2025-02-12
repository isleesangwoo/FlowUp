<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>FlowUp 조직도</title>

<style type="text/css">
.highcharts-figure, .highcharts-data-table table {
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

.highcharts-data-table td, .highcharts-data-table th,
	.highcharts-data-table caption {
	padding: 0.5em;
}

.highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even)
	{
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
</head>


<body>
	<script src="../../code/highcharts.js"></script>
	<script src="../../code/modules/sankey.js"></script>
	<script src="../../code/modules/organization.js"></script>
	<script src="../../code/modules/exporting.js"></script>
	<script src="../../code/modules/accessibility.js"></script>

	<figure class="highcharts-figure">
		<div id="container" data-highcharts-chart="0" aria-hidden="false"
			role="region"
			aria-label="Highcharts Org Chart. Highcharts interactive chart."
			style="overflow: hidden;">
			<div id="highcharts-screen-reader-region-before-0"
				aria-hidden="false" style="position: relative;">
				<div aria-hidden="false"
					style="position: absolute; width: 1px; height: 1px; overflow: hidden; white-space: nowrap; clip: rect(1px, 1px, 1px, 1px); margin-top: -3px; opacity: 0.01;">
					<p>FlowUp 조직도</p>
					<div>Chart with 13 data points.</div>
					<div>Organization charts are a common case of hierarchical
						network charts, where the parent/child relationships between nodes
						are visualized. Highcharts includes a dedicated organization chart
						type that streamlines the process of creating these types of
						visualizations.</div>
				</div>
			</div>
			<div aria-hidden="false" class="highcharts-announcer-container"
				style="position: relative;">
				<div aria-hidden="false" aria-live="polite"
					style="position: absolute; width: 1px; height: 1px; overflow: hidden; white-space: nowrap; clip: rect(1px, 1px, 1px, 1px); margin-top: -3px; opacity: 0.01;"></div>
				<div aria-hidden="false" aria-live="assertive"
					style="position: absolute; width: 1px; height: 1px; overflow: hidden; white-space: nowrap; clip: rect(1px, 1px, 1px, 1px); margin-top: -3px; opacity: 0.01;"></div>
				<div aria-hidden="false" aria-live="polite"
					style="position: absolute; width: 1px; height: 1px; overflow: hidden; white-space: nowrap; clip: rect(1px, 1px, 1px, 1px); margin-top: -3px; opacity: 0.01;"></div>
			</div>
			<div id="highcharts-0ozgdaj-0" dir="ltr"
				class="highcharts-container "
				style="position: relative; overflow: hidden; width: 800px; height: 600px; text-align: left; line-height: normal; z-index: 0; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); user-select: none; touch-action: manipulation; outline: none;"
				aria-hidden="false" tabindex="0">
				<div aria-hidden="false"
					class="highcharts-a11y-proxy-container-before"
					style="top: 0px; left: 0px; white-space: nowrap; position: absolute;"></div>
				<svg version="1.1" class="highcharts-root"
					style="font-family: &amp; quot; Lucida Grande&amp;quot; , &amp; quot; Lucida Sans Unicode&amp;quot; , Arial , Helvetica, sans-serif; font-size: 12px;"
					xmlns="http://www.w3.org/2000/svg" width="800" height="600"
					viewBox="0 0 800 600" aria-hidden="false"
					aria-label="Interactive chart">
					<desc aria-hidden="true">Created with Highcharts 10.3.1</desc>
					<defs aria-hidden="true">
					<clipPath id="highcharts-0ozgdaj-1-">
					<rect x="0" y="0" width="532" height="780" fill="none"></rect></clipPath>
					<clipPath id="highcharts-0ozgdaj-15-">
					<rect x="0" y="0" width="532" height="780" fill="none"></rect></clipPath></defs>
					<rect fill="#ffffff" class="highcharts-background" x="0" y="0"
						width="800" height="600" rx="0" ry="0" aria-hidden="true"></rect>
					<rect fill="none" class="highcharts-plot-background" x="10" y="53"
						width="780" height="532" aria-hidden="true"></rect>
					<rect fill="none" class="highcharts-plot-border" data-z-index="1"
						x="10" y="53" width="780" height="532" aria-hidden="true"></rect>
					<g class="highcharts-series-group" data-z-index="3"
						aria-hidden="false">
					<g
						class="highcharts-series highcharts-series-0 highcharts-organization-series highcharts-tracker"
						data-z-index="0.1" opacity="1"
						transform="translate(790,585) rotate(90) scale(-1,1) scale(1 1)"
						clip-path="url(#highcharts-0ozgdaj-15-)" aria-hidden="false"
						width="780" height="532">
					<path fill="none" d="M 466.5 390.5 L 438.5 390.5" r="3"
						stroke="#666666" stroke-width="1" opacity="0.5"
						class="highcharts-link highcharts-point highcharts-null-point"
						tabindex="-1" role="img"
						aria-label="0. Board, reports to Shareholders."
						style="outline: none;"></path>
					<path fill="none" d="M 373.5 390.5 L 345.5 390.5" r="3"
						stroke="#666666" stroke-width="1" opacity="0.5"
						class="highcharts-link highcharts-point highcharts-null-point"
						tabindex="-1" role="img"
						aria-label="1. Atle Sivertsen, CEO, reports to Board."
						style="outline: none;"></path>
					<path fill="none"
						d="M 280.5 390.5 L 275.5 390.5 C 265.5 390.5 265.5 390.5 265.5 400.5 L 265.5 676.5 C 265.5 686.5 265.5 686.5 255.5 686.5 L 251.5 686.5"
						r="3" stroke="#666666" stroke-width="1" opacity="0.5"
						class="highcharts-link highcharts-point highcharts-null-point"
						tabindex="-1" role="img"
						aria-label="2. Christer Vasseng, CTO, reports to CEO."
						style="outline: none;"></path>
					<path fill="none"
						d="M 280.5 390.5 L 275.5 390.5 C 265.5 390.5 265.5 390.5 265.5 400.5 L 265.5 479.5 C 265.5 489.5 265.5 489.5 255.5 489.5 L 251.5 489.5"
						r="3" stroke="#666666" stroke-width="1" opacity="0.5"
						class="highcharts-link highcharts-point highcharts-null-point"
						tabindex="-1" role="img"
						aria-label="3. Torstein Hønsi, CPO, reports to CEO."
						style="outline: none;"></path>
					<path fill="none"
						d="M 280.5 390.5 L 275.5 390.5 C 265.5 390.5 265.5 390.5 265.5 380.5 L 265.5 301.5 C 265.5 291.5 265.5 291.5 255.5 291.5 L 251.5 291.5"
						r="3" stroke="#666666" stroke-width="1" opacity="0.5"
						class="highcharts-link highcharts-point highcharts-null-point"
						tabindex="-1" role="img"
						aria-label="4. Anita Nesse, CSO, reports to CEO."
						style="outline: none;"></path>
					<path fill="none"
						d="M 280.5 390.5 L 275.5 390.5 C 265.5 390.5 265.5 390.5 265.5 380.5 L 265.5 104.5 C 265.5 94.5 265.5 94.5 255.5 94.5 L 251.5 94.5"
						r="3" stroke="#666666" stroke-width="1" opacity="0.5"
						class="highcharts-link highcharts-point highcharts-null-point"
						tabindex="-1" role="img"
						aria-label="5. Anne Jorunn Fjærestad, HR, reports to CEO."
						style="outline: none;"></path>
					<path fill="none"
						d="M 186.5 686.5 L 182.5 686.5 C 172.5 686.5 172.5 686.5 172.5 676.5 L 172.5 597.5 C 172.5 587.5 172.5 587.5 162.5 587.5 L 158.5 587.5"
						r="3" stroke="#666666" stroke-width="1" opacity="0.5"
						class="highcharts-link highcharts-point highcharts-null-point"
						tabindex="-1" role="img"
						aria-label="6. Product developers, Product, reports to CTO."
						style="outline: none;"></path>
					<path fill="none"
						d="M 186.5 686.5 L 182.5 686.5 C 172.5 686.5 172.5 686.5 172.5 676.5 L 172.5 400.5 C 172.5 390.5 172.5 390.5 162.5 390.5 L 158.5 390.5"
						r="3" stroke="#666666" stroke-width="1" opacity="0.5"
						class="highcharts-link highcharts-point highcharts-null-point"
						tabindex="-1" role="img"
						aria-label="7. Web devs, sys admin, Web, reports to CTO."
						style="outline: none;"></path>
					<path fill="none"
						d="M 186.5 291.5 L 182.5 291.5 C 172.5 291.5 172.5 291.5 172.5 281.5 L 172.5 203.5 C 172.5 193.5 172.5 193.5 162.5 193.5 L 158.5 193.5"
						r="3" stroke="#666666" stroke-width="1" opacity="0.5"
						class="highcharts-link highcharts-point highcharts-null-point"
						tabindex="-1" role="img"
						aria-label="8. Sales team, Sales, reports to CSO."
						style="outline: none;"></path>
					<path fill="none"
						d="M 186.5 94.5 L 89.5 94.5 C 79.5 94.5 79.5 94.5 79.5 104.5 L 79.5 380.5 C 79.5 390.5 79.5 390.5 69.5 390.5 L 65.5 390.5"
						r="3" stroke="#666666" stroke-width="1" opacity="0.5"
						class="highcharts-link highcharts-point highcharts-null-point"
						tabindex="-1" role="img"
						aria-label="9. Marketing team, Market, reports to HR."
						style="outline: none;"></path>
					<path fill="none"
						d="M 186.5 291.5 L 89.5 291.5 C 79.5 291.5 79.5 291.5 79.5 301.5 L 79.5 380.5 C 79.5 390.5 79.5 390.5 69.5 390.5 L 65.5 390.5"
						r="3" stroke="#666666" stroke-width="1" opacity="0.5"
						class="highcharts-link highcharts-point highcharts-null-point"
						tabindex="-1" role="img"
						aria-label="10. Marketing team, Market, reports to CSO."
						style="outline: none;"></path>
					<path fill="none"
						d="M 186.5 94.5 L 89.5 94.5 C 79.5 94.5 79.5 94.5 79.5 104.5 L 79.5 380.5 C 79.5 390.5 79.5 390.5 69.5 390.5 L 65.5 390.5"
						r="3" stroke="#666666" stroke-width="1" opacity="0.5"
						class="highcharts-link highcharts-point highcharts-null-point"
						tabindex="-1" role="img"
						aria-label="11. Marketing team, Market, reports to HR."
						style="outline: none;"></path>
					<path fill="none"
						d="M 186.5 686.5 L 89.5 686.5 C 79.5 686.5 79.5 686.5 79.5 676.5 L 79.5 400.5 C 79.5 390.5 79.5 390.5 69.5 390.5 L 65.5 390.5"
						r="3" stroke="#666666" stroke-width="1" opacity="0.5"
						class="highcharts-link highcharts-point highcharts-null-point"
						tabindex="-1" role="img"
						aria-label="12. Marketing team, Market, reports to CTO."
						style="outline: none;"></path>
					<rect x="466.5" y="296.5" width="65" height="187" display=""
						fill="silver" rx="3" ry="3" stroke="white" stroke-width="1"
						opacity="1"
						class="highcharts-node highcharts-point highcharts-node"></rect>
					<rect x="373.5" y="296.5" width="65" height="187" display=""
						fill="silver" rx="3" ry="3" stroke="white" stroke-width="1"
						opacity="1"
						class="highcharts-node highcharts-point highcharts-node"></rect>
					<rect x="280.5" y="296.5" width="65" height="187" display=""
						fill="#980104" rx="3" ry="3" stroke="white" stroke-width="1"
						opacity="1"
						class="highcharts-node highcharts-point highcharts-node"></rect>
					<rect x="186.5" y="592.5" width="65" height="187" display=""
						fill="#007ad0" rx="3" ry="3" stroke="white" stroke-width="1"
						opacity="1"
						class="highcharts-node highcharts-point highcharts-node"></rect>
					<rect x="186.5" y="395.5" width="65" height="187" display=""
						fill="#007ad0" rx="3" ry="3" stroke="white" stroke-width="1"
						opacity="1"
						class="highcharts-node highcharts-point highcharts-node"></rect>
					<rect x="186.5" y="197.5" width="65" height="187" display=""
						fill="#007ad0" rx="3" ry="3" stroke="white" stroke-width="1"
						opacity="1"
						class="highcharts-node highcharts-point highcharts-node"></rect>
					<rect x="186.5" y="0.5" width="65" height="187" display=""
						fill="#007ad0" rx="3" ry="3" stroke="white" stroke-width="1"
						opacity="1"
						class="highcharts-node highcharts-point highcharts-node"></rect>
					<rect x="93.5" y="493.5" width="65" height="187" display=""
						fill="#359154" rx="3" ry="3" stroke="white" stroke-width="1"
						opacity="1"
						class="highcharts-node highcharts-point highcharts-node"></rect>
					<rect x="93.5" y="296.5" width="65" height="187" display=""
						fill="#359154" rx="3" ry="3" stroke="white" stroke-width="1"
						opacity="1"
						class="highcharts-node highcharts-point highcharts-node"></rect>
					<rect x="93.5" y="99.5" width="65" height="187" display=""
						fill="#359154" rx="3" ry="3" stroke="white" stroke-width="1"
						opacity="1"
						class="highcharts-node highcharts-point highcharts-node"></rect>
					<rect x="0.5" y="296.5" width="65" height="187" display=""
						fill="#359154" rx="3" ry="3" stroke="white" stroke-width="1"
						opacity="1"
						class="highcharts-node highcharts-point highcharts-node"></rect></g>
					<g
						class="highcharts-markers highcharts-series-0 highcharts-organization-series"
						data-z-index="0.1" opacity="1"
						transform="translate(790,585) rotate(90) scale(-1,1) scale(1 1)"
						clip-path="none" aria-hidden="true"></g></g>
					<g class="highcharts-exporting-group" data-z-index="3"
						aria-hidden="true">
					<g
						class="highcharts-no-tooltip highcharts-button highcharts-contextbutton"
						stroke-linecap="round" style="cursor: pointer;"
						transform="translate(766,10)">
					<title>Chart context menu</title>
					<rect fill="#ffffff" class="highcharts-button-box" x="0.5" y="0.5"
						width="24" height="22" rx="2" ry="2" stroke="none"
						stroke-width="1"></rect>
					<path fill="#666666"
						d="M 6 6.5 L 20 6.5 M 6 11.5 L 20 11.5 M 6 16.5 L 20 16.5"
						class="highcharts-button-symbol" data-z-index="1" stroke="#666666"
						stroke-width="3"></path>
					<text x="0" data-z-index="1" y="15.5"
						style="color: rgb(51, 51, 51); font-weight: normal; fill: rgb(51, 51, 51);"></text></g></g>
					<text x="400" text-anchor="middle" class="highcharts-title"
						data-z-index="4"
						style="color: rgb(51, 51, 51); font-size: 18px; fill: rgb(51, 51, 51);"
						y="24" aria-hidden="true">Highcharts Org Chart</text>
					<text x="400" text-anchor="middle" class="highcharts-subtitle"
						data-z-index="4"
						style="color: rgb(102, 102, 102); fill: rgb(102, 102, 102);"
						y="52" aria-hidden="true"></text>
					<text x="10" text-anchor="start" class="highcharts-caption"
						data-z-index="4"
						style="color: rgb(102, 102, 102); fill: rgb(102, 102, 102);"
						y="597" aria-hidden="true"></text>
					<g
						class="highcharts-data-labels highcharts-series-0 highcharts-organization-series highcharts-tracker"
						data-z-index="6" opacity="1"
						transform="translate(10,53) scale(1 1)" aria-hidden="true">
					<g
						class="highcharts-label highcharts-data-label highcharts-data-label-color-undefined highcharts-tracker"
						data-z-index="1" transform="translate(302,6)">
					<rect fill="none"
						class="highcharts-label-box highcharts-data-label-box" x="0" y="0"
						width="98" height="31" rx="0" ry="0"></rect></g>
					<g
						class="highcharts-label highcharts-data-label highcharts-data-label-color-undefined highcharts-tracker"
						data-z-index="1" transform="translate(302,99)">
					<rect fill="none"
						class="highcharts-label-box highcharts-data-label-box" x="0" y="0"
						width="49" height="31" rx="0" ry="0"></rect></g>
					<g
						class="highcharts-label highcharts-data-label highcharts-data-label-color-undefined highcharts-tracker"
						data-z-index="1" transform="translate(302,192)">
					<rect fill="none"
						class="highcharts-label-box highcharts-data-label-box" x="0" y="0"
						width="71" height="68" rx="0" ry="0"></rect></g>
					<g
						class="highcharts-label highcharts-data-label highcharts-data-label-color-undefined highcharts-tracker"
						data-z-index="1" transform="translate(6,286)">
					<rect fill="none"
						class="highcharts-label-box highcharts-data-label-box" x="0" y="0"
						width="66" height="68" rx="0" ry="0"></rect></g>
					<g
						class="highcharts-label highcharts-data-label highcharts-data-label-color-undefined highcharts-tracker"
						data-z-index="1" transform="translate(203,286)">
					<rect fill="none"
						class="highcharts-label-box highcharts-data-label-box" x="0" y="0"
						width="66" height="68" rx="0" ry="0"></rect></g>
					<g
						class="highcharts-label highcharts-data-label highcharts-data-label-color-undefined highcharts-tracker"
						data-z-index="1" transform="translate(401,286)">
					<rect fill="none"
						class="highcharts-label-box highcharts-data-label-box" x="0" y="0"
						width="50" height="68" rx="0" ry="0"></rect></g>
					<g
						class="highcharts-label highcharts-data-label highcharts-data-label-color-undefined highcharts-tracker"
						data-z-index="1" transform="translate(598,286)">
					<rect fill="none"
						class="highcharts-label-box highcharts-data-label-box" x="0" y="0"
						width="76" height="89" rx="0" ry="0"></rect></g>
					<g
						class="highcharts-label highcharts-data-label highcharts-data-label-color-undefined highcharts-tracker"
						data-z-index="1" transform="translate(105,379)">
					<rect fill="none"
						class="highcharts-label-box highcharts-data-label-box" x="0" y="0"
						width="84" height="52" rx="0" ry="0"></rect></g>
					<g
						class="highcharts-label highcharts-data-label highcharts-data-label-color-undefined highcharts-tracker"
						data-z-index="1" transform="translate(302,379)">
					<rect fill="none"
						class="highcharts-label-box highcharts-data-label-box" x="0" y="0"
						width="52" height="94" rx="0" ry="0"></rect></g>
					<g
						class="highcharts-label highcharts-data-label highcharts-data-label-color-undefined highcharts-tracker"
						data-z-index="1" transform="translate(499,379)">
					<rect fill="none"
						class="highcharts-label-box highcharts-data-label-box" x="0" y="0"
						width="44" height="52" rx="0" ry="0"></rect></g>
					<g
						class="highcharts-label highcharts-data-label highcharts-data-label-color-undefined highcharts-tracker"
						data-z-index="1" transform="translate(302,472)">
					<rect fill="none"
						class="highcharts-label-box highcharts-data-label-box" x="0" y="0"
						width="78" height="52" rx="0" ry="0"></rect></g></g>
					<g class="highcharts-legend highcharts-no-tooltip" data-z-index="7"
						visibility="hidden" aria-hidden="true">
					<rect fill="none" class="highcharts-legend-box" rx="0" ry="0" x="0"
						y="0" width="8" height="8"></rect>
					<g data-z-index="1">
					<g></g></g></g>
					<text x="790" class="highcharts-credits" text-anchor="end"
						data-z-index="8" y="595"
						style="cursor: pointer; color: rgb(153, 153, 153); font-size: 9px; fill: rgb(153, 153, 153);"
						aria-label="Chart credits: Highcharts.com" aria-hidden="false">Highcharts.com</text></svg>
				<div aria-hidden="false"
					class="highcharts-a11y-proxy-container-after"
					style="top: 0px; left: 0px; white-space: nowrap; position: absolute;">
					<div
						class="highcharts-a11y-proxy-group highcharts-a11y-proxy-group-zoom"></div>
					<div
						class="highcharts-a11y-proxy-group highcharts-a11y-proxy-group-chartMenu">
						<button class="highcharts-a11y-proxy-button highcharts-no-tooltip"
							aria-label="View chart menu, Highcharts Org Chart"
							aria-expanded="false" title="Chart context menu"
							style="border-width: 0px; background-color: transparent; cursor: pointer; outline: none; opacity: 0.001; z-index: 999; overflow: hidden; padding: 0px; margin: 0px; display: block; position: absolute; width: 24px; height: 22px; left: 767px; top: 11px;"></button>
					</div>
				</div>
				<div
					class="highcharts-data-labels highcharts-series-0 highcharts-organization-series highcharts-tracker"
					aria-hidden="true"
					style="position: absolute; left: 10px; top: 53px; opacity: 1; visibility: inherit;">
					<div
						class="highcharts-label highcharts-data-label highcharts-data-label-color-undefined highcharts-tracker"
						style="position: absolute; left: 302px; top: 6px; opacity: 1; width: 176px; height: 54px; visibility: inherit;">
						<span data-z-index="1"
							style="position: absolute; font-family: &amp; quot; Lucida Grande&amp;quot; , &amp; quot; Lucida Sans Unicode&amp;quot; , Arial , Helvetica, sans-serif; font-size: 13px; white-space: nowrap; color: black; font-weight: normal; margin-left: 0px; margin-top: 0px; left: 0px; top: 0px; width: 100%; height: 100%; overflow: hidden;"><div
								style="width: 100%; height: 100%; display: flex; flex-direction: row; align-items: center; justify-content: center;">
								<div
									style="width: 100%; padding: 0px; text-align: center; white-space: normal;">
									<h4 style="margin: 0px;">쌍용강북교육센터</h4>
								</div>
							</div></span>
					</div>
					<div
						class="highcharts-label highcharts-data-label highcharts-data-label-color-undefined highcharts-tracker"
						style="position: absolute; left: 302px; top: 99px; opacity: 1; width: 176px; height: 54px; visibility: inherit;">
						<span data-z-index="1"
							style="position: absolute; font-family: &amp; quot; Lucida Grande&amp;quot; , &amp; quot; Lucida Sans Unicode&amp;quot; , Arial , Helvetica, sans-serif; font-size: 13px; white-space: nowrap; color: black; font-weight: normal; margin-left: 0px; margin-top: 0px; left: 0px; top: 0px; width: 100%; height: 100%; overflow: hidden;"><div
								style="width: 100%; height: 100%; display: flex; flex-direction: row; align-items: center; justify-content: center;">
								<div
									style="width: 100%; padding: 0px; text-align: center; white-space: normal;">
									<h4 style="margin: 0px;">G클래스</h4>
								</div>
							</div></span>
					</div>
					<div
						class="highcharts-label highcharts-data-label highcharts-data-label-color-undefined highcharts-tracker"
						style="position: absolute; left: 302px; top: 192px; opacity: 1; width: 176px; height: 54px; visibility: inherit;">
						<span data-z-index="1"
							style="position: absolute; font-family: &amp; quot; Lucida Grande&amp;quot; , &amp; quot; Lucida Sans Unicode&amp;quot; , Arial , Helvetica, sans-serif; font-size: 13px; white-space: nowrap; color: white; font-weight: normal; margin-left: 0px; margin-top: 0px; left: 0px; top: 0px; width: 100%; height: 100%; overflow: hidden;"><div
								style="width: 100%; height: 100%; display: flex; flex-direction: row; align-items: center; justify-content: center;">
								<img
									src="https://wp-assets.highcharts.com/www-highcharts-com/blog/wp-content/uploads/2022/06/30081411/portrett-sorthvitt.jpg"
									style="max-height: 100%; border-radius: 50%; max-width: 30%;">
								<div
									style="width: 70%; padding: 0px; text-align: center; white-space: normal;">
									<h4 style="margin: 0px;">서영학</h4>
									<p style="margin: 0px;"></p>
								</div>
							</div></span>
					</div>
					<div
						class="highcharts-label highcharts-data-label highcharts-data-label-color-undefined highcharts-tracker"
						style="position: absolute; left: 6px; top: 286px; opacity: 1; width: 176px; height: 54px; visibility: inherit;">
						<span data-z-index="1"
							style="position: absolute; font-family: &amp; quot; Lucida Grande&amp;quot; , &amp; quot; Lucida Sans Unicode&amp;quot; , Arial , Helvetica, sans-serif; font-size: 13px; white-space: nowrap; color: white; font-weight: normal; margin-left: 0px; margin-top: 0px; left: 0px; top: 0px; width: 100%; height: 100%; overflow: hidden;"><div
								style="width: 100%; height: 100%; display: flex; flex-direction: row; align-items: center; justify-content: center;">
								<img
									src="https://wp-assets.highcharts.com/www-highcharts-com/blog/wp-content/uploads/2020/03/17131120/Highsoft_04074_.jpg"
									style="max-height: 100%; border-radius: 50%; max-width: 30%;">
								<div
									style="width: 70%; padding: 0px; text-align: center; white-space: normal;">
									<h4 style="margin: 0px;">이동훈</h4>
									<p style="margin: 0px;">CTO</p>
								</div>
							</div></span>
					</div>
					<div
						class="highcharts-label highcharts-data-label highcharts-data-label-color-undefined highcharts-tracker"
						style="position: absolute; left: 203px; top: 286px; opacity: 1; width: 176px; height: 54px; visibility: inherit;">
						<span data-z-index="1"
							style="position: absolute; font-family: &amp; quot; Lucida Grande&amp;quot; , &amp; quot; Lucida Sans Unicode&amp;quot; , Arial , Helvetica, sans-serif; font-size: 13px; white-space: nowrap; color: white; font-weight: normal; margin-left: 0px; margin-top: 0px; left: 0px; top: 0px; width: 100%; height: 100%; overflow: hidden;"><div
								style="width: 100%; height: 100%; display: flex; flex-direction: row; align-items: center; justify-content: center;">
								<img
									src="https://wp-assets.highcharts.com/www-highcharts-com/blog/wp-content/uploads/2020/03/17131213/Highsoft_03998_.jpg"
									style="max-height: 100%; border-radius: 50%; max-width: 30%;">
								<div
									style="width: 70%; padding: 0px; text-align: center; white-space: normal;">
									<h4 style="margin: 0px;">강이훈</h4>
									<p style="margin: 0px;">CPO</p>
								</div>
							</div></span>
					</div>
					<div
						class="highcharts-label highcharts-data-label highcharts-data-label-color-undefined highcharts-tracker"
						style="position: absolute; left: 401px; top: 286px; opacity: 1; width: 176px; height: 54px; visibility: inherit;">
						<span data-z-index="1"
							style="position: absolute; font-family: &amp; quot; Lucida Grande&amp;quot; , &amp; quot; Lucida Sans Unicode&amp;quot; , Arial , Helvetica, sans-serif; font-size: 13px; white-space: nowrap; color: white; font-weight: normal; margin-left: 0px; margin-top: 0px; left: 0px; top: 0px; width: 100%; height: 100%; overflow: hidden;"><div
								style="width: 100%; height: 100%; display: flex; flex-direction: row; align-items: center; justify-content: center;">
								<img
									src="https://wp-assets.highcharts.com/www-highcharts-com/blog/wp-content/uploads/2020/03/17131156/Highsoft_03834_.jpg"
									style="max-height: 100%; border-radius: 50%; max-width: 30%;">
								<div
									style="width: 70%; padding: 0px; text-align: center; white-space: normal;">
									<h4 style="margin: 0px;">김성훈</h4>
									<p style="margin: 0px;">CSO</p>
								</div>
							</div></span>
					</div>
					<div
						class="highcharts-label highcharts-data-label highcharts-data-label-color-undefined highcharts-tracker"
						style="position: absolute; left: 598px; top: 286px; opacity: 1; width: 176px; height: 54px; visibility: inherit;">
						<span data-z-index="1"
							style="position: absolute; font-family: &amp; quot; Lucida Grande&amp;quot; , &amp; quot; Lucida Sans Unicode&amp;quot; , Arial , Helvetica, sans-serif; font-size: 13px; white-space: nowrap; color: white; font-weight: normal; margin-left: 0px; margin-top: 0px; left: 0px; top: 0px; width: 100%; height: 100%; overflow: hidden;"><div
								style="width: 100%; height: 100%; display: flex; flex-direction: row; align-items: center; justify-content: center;">
								<img
									src="https://wp-assets.highcharts.com/www-highcharts-com/blog/wp-content/uploads/2020/03/17131210/Highsoft_04045_.jpg"
									style="max-height: 100%; border-radius: 50%; max-width: 30%;">
								<div
									style="width: 70%; padding: 0px; text-align: center; white-space: normal;">
									<h4 style="margin: 0px;">이상우</h4>
									<p style="margin: 0px;">CFO</p>
								</div>
							</div></span>
					</div>
					<div
						class="highcharts-label highcharts-data-label highcharts-data-label-color-undefined highcharts-tracker"
						style="position: absolute; left: 105px; top: 379px; opacity: 1; width: 176px; height: 54px; visibility: inherit;">
						<span data-z-index="1"
							style="position: absolute; font-family: &amp; quot; Lucida Grande&amp;quot; , &amp; quot; Lucida Sans Unicode&amp;quot; , Arial , Helvetica, sans-serif; font-size: 13px; white-space: nowrap; color: white; font-weight: normal; margin-left: 0px; margin-top: 0px; left: 0px; top: 0px; width: 100%; height: 100%; overflow: hidden;"><div
								style="width: 100%; height: 100%; display: flex; flex-direction: row; align-items: center; justify-content: center;">
								<div
									style="width: 100%; padding: 0px; text-align: center; white-space: normal;">
									<h4 style="margin: 0px;">조선화로구이</h4>
								</div>
							</div></span>
					</div>
					<div
						class="highcharts-label highcharts-data-label highcharts-data-label-color-undefined highcharts-tracker"
						style="position: absolute; left: 302px; top: 379px; opacity: 1; width: 176px; height: 54px; visibility: inherit;">
						<span data-z-index="1"
							style="position: absolute; font-family: &amp; quot; Lucida Grande&amp;quot; , &amp; quot; Lucida Sans Unicode&amp;quot; , Arial , Helvetica, sans-serif; font-size: 13px; white-space: nowrap; color: white; font-weight: normal; margin-left: 0px; margin-top: 0px; left: 0px; top: 0px; width: 100%; height: 100%; overflow: hidden;"><div
								style="width: 100%; height: 100%; display: flex; flex-direction: row; align-items: center; justify-content: center;">
								<div
									style="width: 100%; padding: 0px; text-align: center; white-space: normal;">
									<h4 style="margin: 0px;">대서리</h4>
								</div>
							</div></span>
					</div>
					<div
						class="highcharts-label highcharts-data-label highcharts-data-label-color-undefined highcharts-tracker"
						style="position: absolute; left: 499px; top: 379px; opacity: 1; width: 176px; height: 54px; visibility: inherit;">
						<span data-z-index="1"
							style="position: absolute; font-family: &amp; quot; Lucida Grande&amp;quot; , &amp; quot; Lucida Sans Unicode&amp;quot; , Arial , Helvetica, sans-serif; font-size: 13px; white-space: nowrap; color: white; font-weight: normal; margin-left: 0px; margin-top: 0px; left: 0px; top: 0px; width: 100%; height: 100%; overflow: hidden;"><div
								style="width: 100%; height: 100%; display: flex; flex-direction: row; align-items: center; justify-content: center;">
								<div
									style="width: 100%; padding: 0px; text-align: center; white-space: normal;">
									<h4 style="margin: 0px;">향미각</h4>
								</div>
							</div></span>
					</div>
					<div
						class="highcharts-label highcharts-data-label highcharts-data-label-color-undefined highcharts-tracker"
						style="position: absolute; left: 302px; top: 472px; opacity: 1; width: 176px; height: 54px; visibility: inherit;">
						<span data-z-index="1"
							style="position: absolute; font-family: &amp; quot; Lucida Grande&amp;quot; , &amp; quot; Lucida Sans Unicode&amp;quot; , Arial , Helvetica, sans-serif; font-size: 13px; white-space: nowrap; color: white; font-weight: normal; margin-left: 0px; margin-top: 0px; left: 0px; top: 0px; width: 100%; height: 100%; overflow: hidden;"><div
								style="width: 100%; height: 100%; display: flex; flex-direction: row; align-items: center; justify-content: center;">
								<div
									style="width: 100%; padding: 0px; text-align: center; white-space: normal;">
									<h4 style="margin: 0px;">일미집</h4>
								</div>
							</div></span>
					</div>
				</div>
			</div>
			<div id="highcharts-screen-reader-region-after-0" aria-hidden="false"
				style="position: relative;">
				<div aria-hidden="false"
					style="position: absolute; width: 1px; height: 1px; overflow: hidden; white-space: nowrap; clip: rect(1px, 1px, 1px, 1px); margin-top: -3px; opacity: 0.01;">
					<div id="highcharts-end-of-chart-marker-0"
						class="highcharts-exit-anchor" tabindex="0" aria-hidden="false">End
						of interactive chart.</div>
				</div>
			</div>
		</div>
		<p class="highcharts-description highcharts-linked-description"
			aria-hidden="true">Organization charts are a common case of
			hierarchical network charts, where the parent/child relationships
			between nodes are visualized. Highcharts includes a dedicated
			organization chart type that streamlines the process of creating
			these types of visualizations.</p>
	</figure>

	<script type="text/javascript">
		Highcharts
				.chart(
						'container',
						{
							chart : {
								height : 600,
								inverted : true
							},

							title : {
								text : 'Highcharts Org Chart'
							},

							accessibility : {
								point : {
									descriptionFormatter : function(point) {
										var nodeName = point.toNode.name, nodeId = point.toNode.id, nodeDesc = nodeName === nodeId ? nodeName
												: nodeName + ', ' + nodeId, parentDesc = point.fromNode.id;
										return point.index + '. ' + nodeDesc
												+ ', reports to ' + parentDesc
												+ '.';
									}
								}
							},

							series : [ {
								type : 'organization',
								name : 'Highsoft',
								keys : [ 'from', 'to' ],
								data : [ ['Shareholders', 'Board'],
										[ 'Board', 'CEO' ], [ 'CEO', 'CTO' ],
										[ 'CEO', 'CPO' ], [ 'CEO', 'CSO' ],
										[ 'CEO', 'HR' ], [ 'CTO', 'Product' ],
										[ 'CTO', 'Web' ], [ 'CSO', 'Sales' ],
										[ 'HR', 'Market' ],
										[ 'CSO', 'Market' ],
										[ 'HR', 'Market' ], [ 'CTO', 'Market' ] ],
								levels : [ {
									level : 0,
									color : 'silver',
									dataLabels : {
										color : 'black'
									},
									height : 25
								}, {
									level : 1,
									color : 'silver',
									dataLabels : {
										color : 'black'
									},
									height : 25
								}, {
									level : 2,
									color : '#980104'
								}, {
									level : 4,
									color : '#359154'
								} ],
								nodes : [
										{
											id : 'Shareholders'
										},
										{
											id : 'Board'
										},
										{
											id : 'CEO',
											title : 'CEO',
											name : '서영학',
											image : 'https://wp-assets.highcharts.com/www-highcharts-com/blog/wp-content/uploads/2022/06/30081411/portrett-sorthvitt.jpg'
										},
										{
											id : 'HR',
											title : 'CFO',
											name : 'Anne Jorunn Fjærestad',
											color : '#007ad0',
											image : 'https://wp-assets.highcharts.com/www-highcharts-com/blog/wp-content/uploads/2020/03/17131210/Highsoft_04045_.jpg'
										},
										{
											id : 'CTO',
											title : 'CTO',
											name : 'Christer Vasseng',
											image : 'https://wp-assets.highcharts.com/www-highcharts-com/blog/wp-content/uploads/2020/03/17131120/Highsoft_04074_.jpg'
										},
										{
											id : 'CPO',
											title : 'CPO',
											name : 'Torstein Hønsi',
											image : 'https://wp-assets.highcharts.com/www-highcharts-com/blog/wp-content/uploads/2020/03/17131213/Highsoft_03998_.jpg'
										},
										{
											id : 'CSO',
											title : 'CSO',
											name : 'Anita Nesse',
											image : 'https://wp-assets.highcharts.com/www-highcharts-com/blog/wp-content/uploads/2020/03/17131156/Highsoft_03834_.jpg'
										}, {
											id : 'Product',
											name : 'Product developers'
										}, {
											id : 'Web',
											name : 'Web devs, sys admin'
										}, {
											id : 'Sales',
											name : 'Sales team'
										}, {
											id : 'Market',
											name : 'Marketing team',
											column : 5
										} ],
								colorByPoint : false,
								color : '#007ad0',
								dataLabels : {
									color : 'white'
								},
								borderColor : 'white',
								nodeWidth : 65
							} ],
							tooltip : {
								outside : true
							},
							exporting : {
								allowHTML : true,
								sourceWidth : 800,
								sourceHeight : 600
							}

						});
	</script>
</body>