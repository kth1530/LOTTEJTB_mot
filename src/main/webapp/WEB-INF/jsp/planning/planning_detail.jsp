<%@page import="com.lottejtb.planning.service.PlanningVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
<script type="text/javascript">
	
<%
	int planSeq = Integer.parseInt(request.getParameter("plan_seq"));
	//String planNm = request.getParameter("plan_nm");
	//String planS = request.getParameter("plan_s");
	//String planE = request.getParameter("plan_e");
	//String imgUrl = request.getParameter("img_url");
	//String templeteCd = request.getParameter("templeteCd");

	System.out.println("planSeq=" + planSeq);
	//System.out.println("templeteCd=" + templeteCd);

	
%>
	var strTag = "";
	var goodCdList = null;
	var hostUrl = "";
	var ctg = '6445';		//[JEH] 기획전 ctg 추가 20180118
	var eventCd = 'KIB7551190527NA1';	//[JEH] 기획전 eventCd 추가 20180118
	var stdDate = '2019-05-22 12:00:00';	//[JEH] 기획전 시작일시 추가 20180118
	var goodsCd = 'KIB7551';
	//var chkInwon = fn_chkInwon(ctg,eventCd,'');
	
	if(devType == 0){
		hostUrl = "http://www.lottejtb.com";
	}else{
		hostUrl = "http://www.lottejtb.com";
	}
	
	$(document).ready(function() {
		//조회수
		fn_planCnt();
	});
	
	var fn_swiper = function(){
		var plsize = jQuery(".plannswp li").size();
		if(plsize == 1) jQuery(".plannswp").addClass("planli1");
		if(plsize == 2) jQuery(".plannswp").addClass("planli2");
		if(plsize == 3) jQuery(".plannswp").addClass("planli3");
		
		$(".plannswp li").off("click");
		$(".plannswp li").on("click", function(){
			var plindex = jQuery(this).index();
			jQuery(".planlist .swiper-slide").hide();
			jQuery(".planlist").find(".swiper-slide").eq(plindex).show();
		});
		
		var swiper = new Swiper('.plan-thumbs', {
			slidesPerView: 'auto',
			simulateTouch: false,
			spaceBetween: 0,
			freeMode: true,
			/*resistanceRatio: 0,*/
			wrapperClass: 'swiper-wrapper',
			slideClass: 'swiper-slide',
			onInit: function () {
				jQuery('.plan-thumbs').addClass('nextShadow');
			},
			onProgress: function (data, progress) {
				if (progress <= 0) {
					jQuery('.plan-thumbs').removeClass('prevShadow').addClass('nextShadow');
				} else if (progress >= 1) {
					jQuery('.plan-thumbs').removeClass('nextShadow').addClass('prevShadow');
				} else {
					jQuery('.plan-thumbs').addClass('nextShadow prevShadow');
				}
			}
		});

		$('.plan-thumbs').on('click', '> ul > li', function (e) {
			var target = $(e.currentTarget);
			var idxp = target.index();
			jQuery('.plan-thumbs').changeActp(idxp);
		});
		
		if (jQuery.fn.changeActp === undefined) {
			jQuery.fn.changeActp = function (idxp) {
				if (this.is('.plan-thumbs')) {
					this.find('> ul > li').removeClass('on').eq(idxp).addClass('on');
					if (this.hasClass('swiper-container')) {
						var swiper = this[0].swiper;
						swiper.slideTo(Math.max(idxp - 1, 0));
					}
				}
			};
		};
	}


	//[JEH] 서버시간 20180117
	function srvTime(){
		var xmlHttp;
	
		if (window.XMLHttpRequest) {//분기하지 않으면 IE에서만 작동된다.
			xmlHttp = new XMLHttpRequest(); // IE 7.0 이상, 크롬, 파이어폭스 등
			xmlHttp.open('HEAD',window.location.href.toString(),false);
			xmlHttp.setRequestHeader("Content-Type", "text/html");
			xmlHttp.send('');
			return xmlHttp.getResponseHeader("Date");
		}else if (window.ActiveXObject) {
			xmlHttp = new ActiveXObject('Msxml2.XMLHTTP');
			xmlHttp.open('HEAD',window.location.href.toString(),false);
			xmlHttp.setRequestHeader("Content-Type", "text/html");
			xmlHttp.send('');
			return xmlHttp.getResponseHeader("Date");
	
		}

	};

	//[JEH] 자릿수 맞춰주기 20180117
	function addZeros(num, digit) { 
		  var zero = '';
		  num = num.toString();
		  if (num.length < digit) {
		    for (i = 0; i < digit - num.length; i++) {
		      zero += '0';
		    }
		  }
		  return zero + num;
	};

	//[JEH] 현재시간과 기준시간의 차이를 계산 - 20180117
	function calTimeGap(repType){

		var srv = srvTime();
		var now =  new Date(srv);

		var yyyy = now.getFullYear();
		var mm = addZeros(now.getMonth()+1,2);
		var dd = addZeros(now.getDate(),2);
		var h = addZeros(now.getHours(),2);
		var m = addZeros(now.getMinutes(),2);
		var s = addZeros(now.getSeconds(),2);
		
		var nowTime = yyyy + "-" + mm + "-" + dd + " " + h + ":" + m + ":" + s;
		
		if(nowTime <= stdDate){
			isApply = 'W';
		}else{
			//기획전 신청 가능 여부 체크(common2.js)
			var chkInwon = fn_chkInwon(ctg,goodsCd,eventCd);

			if(chkInwon){
				isApply = 'Y';
			}else{
				isApply = 'N';
			}
		}

		return isApply;
	};
	
	//기획전 detail 데이터
	var fn_setDetailPlanList = function(cnt) {

		var startRow = 1;
		var endRow = 10;
		
		var formData = new FormData();
		formData.append('planSeq',<%=planSeq%>);
		formData.append('startRow', startRow);
		formData.append('endRow', endRow);
	
//		$('.more').hide();

		cfn_ajax({
			type : "POST",
			async : false,
			url: "/planning/setDetailPlanListAjax.do" ,
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "yes",
			timeOut : 5 * 60 * 1000,
			success: function(data) {
				list = data.list;
								
				if(nullToBlank(list) != '') {
					strTag = '';
					
					//imgurl = "http://www.lottejtb.com/upload/common/plan/" + list[0]['goodsTypeCd'] + "/" + list[0]['bigImgPh'];
					imgurl = "/m_file/upload/common/plan/" + list[0]['goodsTypeCd'] + "/" + list[0]['bigImgPh'];
					
					strTag += "<li class='header'><h3>" + list[0]['planNm'] + "</h3><em style='margin-top:0px;'>" + list[0]['planFrday'] + " ~ " + list[0]['planToday'] + "</em><i id= 'planCnt'>조회수:" + cnt + "</i></li>"; 
					strTag += "<li class='content'>";
					strTag += "		<div class='img'>";
					if(nullToBlank(list[0]['displayTypeCd']) == "ALL" || nullToBlank(list[0]['displayTypeCd']) == "MBL"){
						var planUrl = list[0]['mblPlanUrl'];
						planUrl = planUrl.replace('http://www.lottejtb.com','');
						
// 						console.log(list[0]['mblPlanUrl']);
// 						console.log(list[0].templeteCd);

						if(list[0].templeteCd == 'T'){	//[JEH] templeteCd로 구분 - 20180119
// 							stdDate = list[0].planToday + " 10:00:00";
							
							//[JEH] 현재시간과 기준시간의 차이를 계산 - 20180117
							var isApply = calTimeGap();
							console.log("---------------");
							console.log(isApply);
							//[JEH] 기획전 이미지 url분기 - 20180117
							var strArray = planUrl.split('_m');						
							if(isApply == 'W'){	//오픈전
								planUrl = strArray[0] + '_m_01.html';
							}else if(isApply == 'Y'){	//오픈
								planUrl = strArray[0] + '_m_02.html';
							}else{	//마감
								planUrl = strArray[0] + '_m_03.html';
							}
							
						}
						
						//strTag += "		<iframe id='planHtml' frameborder='0' marginheight='0' marginwidth='0'  src='"+ "http://www.lottejtb.com"+ planUrl + "' onload='javascript:resizeEvent(this);'" +  " width='100%' style='height:60vh;'>";
						strTag += "		<iframe id='planHtml' frameborder='0' marginheight='0' marginwidth='0'  src='"+ "http://www.lottejtb.com"+ planUrl + "' onload='javascript:resizeEvent(this);'" +  " width='100%' style='height:60vh;'>";
					}else if(nullToBlank(list[0]['bigImgPh']) != ""){
						strTag += "		<img src='" + imgurl + "' alt='' onerror='javascript:noimg_setting(this, 1);'/>";
					}
					
					strTag += "		</div>";
					strTag += "</li>";
					
					$('#topList').html(strTag);
										
				}
				
				fn_planDetailList();
				
			},
			error : function(err) {
				alert("조회된 결과가 없습니다.");
			},
			complete : function(e) {
			}
			
		});
		
	};	
	
	function resizeEvent(iframe) {
		/*
		var innerBody = iframe.contentWindow.document.body;
		var innerHeight = innerBody.scrollHeight + (innerBody.offsetHeight - innerBody.clientHeight);
		document.getElementById("planHtml").height = innerHeight;
		*/
	}
	
	
	//기획전 상세 목록	
	var fn_planDetailList = function() {
		
		var formData = new FormData();
		formData.append('planSeq', <%=planSeq%>);
		formData.append('planType', '');
		formData.append('templeteCd', '');
		formData.append('startRow', 1);
		formData.append('endRow', 10);
		
		//fn_dataClear();
		
		cfn_ajax({
			type : "POST",
			async : false,
			url: "/planning/planningDetailAjax.do",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "yes",
			timeOut : 5 * 60 * 1000,
			success: function(data) {
				goodCdList = data.list;
				tabList = data.tabList;
				tabTag = '';
				tabBody = '';
				
				/*
				if(goodCdList.length == 0) {
					alert("기획전 상품이 없습니다.")
					return;
				}
				*/
				
				if(goodCdList.length > 0){					
					$('#tabDiv').show();
					for(var j = 0; j < tabList.length; j++){
						if(j == 0){
							tabTag += '<li class="swiper-slide on swiper-slide-active"><a href="#">'+ tabList[j].planTabTitle +'</a></li>'
							tabBody += '<div class="swiper-slide" style="display:block;">';
						}else{
							tabTag += '<li class="swiper-slide"><a href="#">'+ tabList[j].planTabTitle +'</a></li>'
							tabBody += '<div class="swiper-slide" style="display:none;">';
						}
						tabBody += '	<ul data-role="listView" class="img swiper-list" id="bodyList_'+ tabList[j].planTabSeq +'">';
						tabBody += '	</ul>';
						tabBody += '</div>';
					}
	
					
					$('#tabList').html(tabTag);
					$('#tabBody').html(tabBody);
					
									
					for(var i=0; i < goodCdList.length; i++) {
						strTag = '';
						
						strTag += "<li>"+ 
			 							"<a href='javascript:fn_gotoPage(" + goodCdList[i]["ctgSeq"] + ",\"" + goodCdList[i]["goodCd"] + "\")'>" +
				 							"<span class='img' style='background-image:url(" + goodCdList[i]["save_file_nm"] + ")'></span>" +  
				 							"<h3 class='ellipsis ellipsis2 bold'>" + goodCdList[i]["goodsNm"] + "</h3>" +
											//"<span class='holedate'>" +"여행기간:" + goodCdList[i]["goodsNightDay"] + "</span>" + 
											"<span class='startday'>" +"출발요일:" + goodCdList[i]["etDays"] + "</span>" + 
											"<span class='money'><i>" + comma(goodCdList[i]["adultPrice"]) + "</i>원~</span>" +
										"</a>" +
					  			  "</li>"; 
				
					  	$('#bodyList_'+ goodCdList[i].planTabSeq).append(strTag);
					}
					//$('#bodyList').listview().listview("refresh").trigger("create");
				}
			},
			error : function(err) {
				alert("조회된 결과가 없습니다.");
			},
			complete : function(e) {
				fn_swiper();
			}
			
		});
		
	};
	
	//기획전 조회수 증가
	var fn_planCnt = function() {
		
	    var formData = new FormData();
	    formData.append('planSeq', <%=planSeq%>);
		
		cfn_ajax({
			type : "POST",
			async : false,
			url: "/planning/planningCntAjax.do",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "yes",
			timeOut : 5 * 60 * 1000,
			success: function(data) {
				var cnt = data.list;
				
				fn_setDetailPlanList(cnt);
			},
			error : function(err) {
				alert("조회된 결과가 없습니다.");
			},
			complete : function(e) {
			}
			
		});
		
	};
	
	function fn_dataClear() {
//		$('#topList').empty();
//		$('#bodyList').empty();
//		$('.more').show();
		
//		goodCdList = null;
	
	};
	
	//상품상세 정보페이지
	function fn_gotoPage(ctg, goodCd) {
		if(nullToBlank(ctg) == ""){
			document.location.href="/goods/master.do?ctg=0&goodsCd="+ goodCd;
		}else{
			document.location.href="/goods/master.do?ctg="+ ctg +"&goodsCd="+ goodCd;	
		}
	}
	
	//목록으로 이동
	function fn_goList() {
		document.location.href="/planning/planning.do";
	}
	
	//[JEH] iframe 링크 클릭시 호출되는함수 - 20180117
	window.addEventListener("message", fn_ifrClickEvt, false);
	function fn_ifrClickEvt(event){
		var data = event.data;
		var org = event.origin
		
		if(org == 'http://www.lottejtb.com' && data == 'Y'){
			
			var isApply = calTimeGap();
			
			if(isApply == 'W'){
				alert('오픈예정입니다.');
				window.location.reload();
				return;
			}else if(isApply == 'Y'){
// 				var openWindow = window.open("about:blank");
// 				location.href = "/goods/master.do?ctg=" + ctg + "&goodsCd=" + goodsCd;
				
				location.href = "https://m.lottejtb.com/goods/detail_goods.do?ctg=" + ctg + "&eventCd=" + eventCd;
			}else{
				alert('예약 마감되었습니다.');
				window.location.reload();
				return;
			}
		}else{
			console.log('postMessage 보안 에러');
			return;
		}
	};
	
</script>
</head>
<body>	
	<div class="planning planning2">
		<div role="main" class="ui-content contentWrap">
			<div class="nav navstitle">기획전</div>
		  
			<div class="listContent mgT10 planDtail">
				<ul data-role="listView" class="detail" id="topList">
				</ul>
				<div>
					<div class="swiper-container plan-thumbs"><!--제목 스와이프-->
						<ul class="swiper-wrapper plannswp" id="tabList">
						</ul><!--//swiper Wrapper-->
					</div><!--//swiper container-->
					<div class="planlist">
						<div id="tabBody">
						</div>
					</div>
				</div>
			</div>
			<div class="more" onclick="javascript:fn_goList();"><i class="fa fa-bars mgr5 list"></i>목록보기</div>
			<!--bottom-->
			<script src="/resources/common/bottom.js"></script>
		<!--bottom-->		 
		</div><!--//contentWrap End-->
	<!--//content-->
	</div>
</body>
