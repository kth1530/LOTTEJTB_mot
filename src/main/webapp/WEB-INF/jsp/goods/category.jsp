<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>
<head>
<script type="text/javascript">
<!--
	// require(["jquery","jquery.blockUI","jquery.mobile"], function($){
	// require(["jquery","jquery.blockUI"], function($){
	var ctg = '${ctg}';		

	// 초기화
	var fn_init = function() {
	};

	var fn_search = function() {

	};

	// 버튼 초기화
	var fn_initButton = function() {

	};

	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	var subCtgCodes2 = "";
	//var subCtgCodes = "5749,5750,5751,5752,5753,5754,5755,5756,5759";
	var subCtgCodes = "5749,5750,5751,5752,5753,5754,5755,5756,5923,5924,5925,5926";

	var subCategoryList = function() {
		
		var formData = new FormData();		
		formData.append('ctgCode', subCtgCodes);
		
		cfn_ajax({
			url: "/goods/categoryListAjax.do",
			type: "POST",
			data: formData,
			async: false,
			cache: false,
			dataType: "json",
			noloading:true,
			success: function(res) {

				console.log("subCtgCodes >>>>>>> " + subCtgCodes);

				var subCtgCode = subCtgCodes.split(",");
				console.log("subCtgCode.length >>>>>>> " + subCtgCode.length);

				for(var i = 0; i < subCtgCode.length; i++){
					try{
						vHTML = "";
						
						for(var j = 0; j < res[subCtgCode[i]].length; j++) {
							
							// console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + res[subCtgCode[i]][j]['ctgSeq'] + " >>>>>>> " + ctg);

							if(res[subCtgCode[i]][j]['ctgCnt'] > 0) {
								vHTML += "<li><a href='#' data-theme='a' data-ajax='false'>"+ res[subCtgCode[i]][j]['ctgNm'] +"</a>";
							} else {
								vHTML += "<li><a href='#' data-theme='a' data-ajax='false' onclick='moveCategoryMenu("+ res[subCtgCode[i]][j]['ctgSeq'] +", 2)'>"+ res[subCtgCode[i]][j]['ctgNm'] +"</a>";							
							}
							// 하부 카테고리가 있는 경우 
							if(res[subCtgCode[i]][j]['ctgCnt'] > 0) {
								vHTML += "<ul id='ctg_" + res[subCtgCode[i]][j]['ctgSeq'] + "'></ul>";
							}
							vHTML += "</li>";
							subCtgCodes2 += res[subCtgCode[i]][j]['ctgSeq'] + ","; 
						}
						
						$("#ctg_"+subCtgCode[i]).html(vHTML);
						// console.log("subCtgCodes2 >>>>>>> " + subCtgCodes2);
						// console.log("vHTML >>>>>>> " + vHTML);

					}catch(e){
						
					}
				}
				
			},
			error:function(err){
				console.log(err);
			},
			complete:function(){
			}
		});
	};

	var subCategoryList2 = function() {
		var formData = new FormData();
		formData.append('ctgCode', subCtgCodes2);
		
		cfn_ajax({
			url: "/goods/categoryListAjax.do",
			type: "POST",
			data: formData,
			async: false,
			cache: false,
			dataType: "json",
			noloading:false,
			success: function(res) {
				console.log("subCtgCodes2 >>>>>>> " + subCtgCodes2);
				var subCtgCode2 = subCtgCodes2.split(",");
				console.log("subCtgCode2.length >>>>>>> " + subCtgCode2.length);

				for(var i = 0; i < subCtgCode2.length; i++){
					try{
						vHTML = "";
						
						for(var j = 0; j < res[subCtgCode2[i]].length; j++){
							vHTML += "<li><a href='#' onclick='moveCategoryMenu("+ res[subCtgCode2[i]][j]['ctgSeq'] +", 2)'>"+ res[subCtgCode2[i]][j]['ctgNm'] +"</a></li>";
						}
						
						$("#ctg_"+subCtgCode2[i]).html(vHTML);
					}catch(e){
						
					}
				}
				
			},
			error:function(err){
				console.log(err);
			},
			complete:function(){
			}
		});
	};
	

	var moveCategoryMenu = function(val, type){
		/**
		if(type == 1){
			document.location.href = "/goods/list.do?ctg=" + val + "&orderby=01";
		}else if(type == 2){
		**/
			document.location.href = "/goods/list.do?ctg=" + val + "&orderby=01";
		// }
		
	};

	// 검색하기 
	var fn_GoSearch = function() {
		/*
		var frmSearch = document.frmSearch;
		frmSearch.action = "/search/search.do";
		frmSearch.orderby.value = "01";
		frmSearch.ctg.value = ctg;
		*/
		
		searchKeyword = document.all.searchKeyword.value;
		if(check_param()) {
			document.location.href="/search/search.do?ctg=" + $("#hiddenCtg").val() + "&orderby=01&searchKeyword="+$("#searchKeyword").val();
		}
	};
	
	function check_param() {
		//var frmSearch = document.frmSearch;
		var flag = false;
	
		if(nullToBlank($("#searchKeyword").val()) == "") {
			$("#searchKeyword").focus();
			alert("검색어를 입력해 주세요.");
			flag = false;
		} else {
			flag = true;
		}
		
		return flag;
	}
	
	// [COMMON] 공통사항 
	$(document).ready(function() {
		fn_init();
		fn_initButton();
		// 상품 전시 페이지 CSS 스타일을 맞춰줌 
		$(".bodyWrap").addClass("goods");

		// 카테고리 정보 조회 
		subCategoryList();
		// 서브 카테고리 정보 조회 
		subCategoryList2();
		
		// 강제로 실행하자 마자 클릭 이벤트 준다. 
		var selectedTag = "#div_ctg_" + ctg;
		console.log("selectedTag >>>>>>>>>>>>>>>>>>> " + selectedTag);
		$(selectedTag).collapsible( "option", "collapsed", false );
		if(ctg != null && ctg != '' && ctg != 'undefined') {
			scrollLink(selectedTag);
		}

		// >>>>>>>>>>>>>>>>>>>>>> 자바스크립트 동적 로딩 >> 서브 카테고리 표시가 안되는 부분 때문에 추후 로딩하도록 바꿈 >>>>>>>>>>>>>>>>>>>>>>>>>>>	
		var s = document.createElement('script');
		s.setAttribute('src', '/resources/common/js/common.js');
		s.setAttribute('type', 'text/javascript');
		document.getElementsByTagName('head')[0].appendChild(s);
		// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		
		$(".mg0").trigger("create");
		$(".ctgMenu").trigger("create");
		$("#hiddenCtg").val(ctg);
		
		/*document.addEventListener("deviceready", function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
	});

	// 해당 위치로 이동함. 
	function scrollLink(obj){
	
		var position = $(obj).offset();
		
		if(nullToBlank(position) != ""){
			setTimeout(function(){
				$('html, body').animate({scrollTop : (position.top  - 55)}, 100);
			}, 100);
		}
	}

	// });
//-->
</script>
</head>
<body>

	<!--content-->
	<div role="main" class="ui-content contentWrap categoryBox">
		<div style="height:39px"></div>
		<div data-role="navbar" data-iconpos="right" class="nav mg0 navstitle">해외패키지</div>
		<!--div data-role="navbar" data-iconpos="right" class="nav mg0">
			<ul>
				<li><a href="javascript:void(0);"  data-rel="popup" data-icon="carat-d" class="ui-btn-active ui-nodisc-icon ui-alt-icon"></a></li>
			</ul> 
			<ul class="ctgTopbtn">
				<li><a href="javascript:void(0);"  data-rel="popup" data-icon="carat-d" class="ui-btn-active ui-nodisc-icon ui-alt-icon">인천/김포</a></li>
				<li><a href="javascript:void(0);" data-icon="plus" class="ui-nodisc-icon ui-alt-icon">최근검색</a></li>
			</ul> 
		</div -->
		<!-- ul class="ctgTopdiv">
			<li><a href="#">
				<dl>
					<dt>국가/도시 : </dt>
					<dd>유럽/아프라카/인도 > 서유럽 장기</dd>
				</dl>
				<p>출발지역 : 인천/김포</p>
			</a></li>
			<li><a href="#">
				<dl>
					<dt>국가/도시 : </dt>
					<dd>유럽/아프라카/인도 > 서유럽 장기 > 서유럽 장기 > 서유럽 장기</dd>
				</dl>
				<p>출발지역 : 인천/김포</p>
			</a></li>
		</ul -->
<!-- 		<div class="search">
			<fieldset> -->
				<!-- <form name="frmSearch" method="get">  -->
<!-- 					<input type="hidden" name="orderby" value="01"/>
					<input type="hidden" name="ctg" id="hiddenCtg" value=""/>
					<legend>검색</legend>
					<label for="input_search">검색어 입력</label>
					<input type="text" title="검색어를 입력하세요." class="input_m"  placeholder="검색어를 입력하세요." id="searchKeyword"  name="searchKeyword" value="" onkeypress="if( event.keyCode==13 ){fn_GoSearch();}">
					<input type="image" class="btn_search" src="/resources/images/btn/btn_search.gif" alt="검색" title="검색" onclick="fn_GoSearch();">  -->
				<!-- </form>  -->
<!-- 			</fieldset>
		</div>
 -->			
		<div  class="category">
			<div class="tabContent category ctgMenu" id="tab1">
				<div data-role="collapsible" data-iconpos="right" id="div_ctg_5749">
					<h1 class="ui-nodisc-icon ui-alt-icon"><em class="one"></em>유럽/아프리카/인도</h1>
					<ul id="ctg_5749">
					</ul>
				</div>
				<div data-role="collapsible" data-iconpos="right" id="div_ctg_5750">
					<h1 class="ui-nodisc-icon ui-alt-icon"><em class="two"></em>동남아</h1>
					<ul id="ctg_5750">
					</ul>
				</div>
				<div data-role="collapsible" data-iconpos="right" id="div_ctg_5751">
					<h1 class="ui-nodisc-icon ui-alt-icon"><em class="three"></em>중국</h1>
					<ul id="ctg_5751">
					</ul>
				</div>
				<div data-role="collapsible" data-iconpos="right" id="div_ctg_5752">
					<h1 class="ui-nodisc-icon ui-alt-icon"><em class="four"></em>홍콩/대만</h1>
					<ul id="ctg_5752">
					</ul>
				</div>
				<div data-role="collapsible" data-iconpos="right" id="div_ctg_5753">
					<h1 class="ui-nodisc-icon ui-alt-icon"><em class="five"></em>일본</h1>
					<ul id="ctg_5753">
					</ul>
				</div>
				<div data-role="collapsible" data-iconpos="right" id="div_ctg_5754">
					<h1 class="ui-nodisc-icon ui-alt-icon"><em class="six"></em>괌/사이판/팔라우</h1>
					<ul id="ctg_5754">
					</ul>
				</div>
				<div data-role="collapsible" data-iconpos="right" id="div_ctg_5755">
					<h1 class="ui-nodisc-icon ui-alt-icon"><em class="seven"></em>호주/뉴질랜드/피지</h1>
					<ul id="ctg_5755">
					</ul>
				</div>
				<div data-role="collapsible" data-iconpos="right" id="div_ctg_5756">
					<h1 class="ui-nodisc-icon ui-alt-icon"><em class="eight"></em>미주/하와이/중남미</h1>
					<ul id="ctg_5756">
					</ul>
				</div>
				<!-- 
				<div data-role="collapsible" data-iconpos="right" id="div_ctg_5759">
					<h1 class="ui-nodisc-icon ui-alt-icon"><em class="nine"></em>지방출발</h1>
					<ul id="ctg_5759">
					</ul>
				</div>
				 -->
				 <div data-role="collapsible" data-iconpos="right" id="div_ctg_5923">
					<h1 class="ui-nodisc-icon ui-alt-icon"><em class="nine"></em>부산출발</h1>
					<ul id="ctg_5923">
					</ul>
				</div>
				<div data-role="collapsible" data-iconpos="right" id="div_ctg_5924">
					<h1 class="ui-nodisc-icon ui-alt-icon"><em class="nine"></em>광주(무안) 출발</h1>
					<ul id="ctg_5924">
					</ul>
				</div>
				<div data-role="collapsible" data-iconpos="right" id="div_ctg_5925">
					<h1 class="ui-nodisc-icon ui-alt-icon"><em class="nine"></em>대전(청주) 출발</h1>
					<ul id="ctg_5925">
					</ul>
				</div>
				<div data-role="collapsible" data-iconpos="right" id="div_ctg_5926">
					<h1 class="ui-nodisc-icon ui-alt-icon"><em class="nine"></em>대구출발</h1>
					<ul id="ctg_5926">
					</ul>
				</div>
			</div>
			<!--bottom-->
			<script src="/resources/common/bottom.js"></script>
			<!--bottom-->
		</div><!--category End-->
	</div><!--//contentWrap End-->
	<!--//content-->