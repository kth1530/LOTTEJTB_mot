<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>
<head>
<script type="text/javascript">
	
	var tabIdx = 0;
	var scrollTopHeight = 0;
	var listTop = 0;
	var startday;
	var endday;
	
	var ingSize = 0;
	var endSize = 0;
	var winnerSize = 0;
	
	var list = null;
	var list1 = null;
	var list2 = null;
	
	var param_seq = "${param_seq}";
	var param_nm = "${param_nm}";
	var param_s = "${param_s}";
	var param_e = "${param_e}";
	var param_tabNo = "${param_tabNo}";
	var param_backYn = "${param_backYn}";
	
	var pageSize = 10;
		
	$(document).ready(function () {
		//목록 이전값 저장위한 scroll event
		$(window).scroll(function(event) {
			scrollTopHeight = $(window).scrollTop();
		});
		
		fn_srchEventList();
		fn_winnerList();
		
		if(nullToBlank(param_seq) != ""){
			fn_goDetailUrl(param_tabNo, param_seq, param_nm, param_s, param_e);			
		}
	});

	$(function() {
		
		//더보기
		$(document).on("click", "#moreBtn", function(){
		 	if(tabIdx == 0) {
		 		fn_moreEventList(tabIdx);
		 	} else if(tabIdx == 1) {
		 		fn_moreEventList(tabIdx);
		 	} else {
		 		fn_moreWinnerList(tabIdx);
		 	}
			
		});	
		
		//목록으로
		$(document).on("click", "#goListBtn", function() {
			if(nullToBlank(param_backYn) == "Y"){
				pageBack();
			}else{
				$('#detailTab1').empty();
				$('#detailTab2').empty();
				$('#detailTab3').empty();
				
				$('.tabContent1').hide();
				$('.tabContent2').hide();
				$('.tabContent3').hide();
				$("#goListBtn").hide();
				
				if(tabIdx == 0){
					$('.tabList1').show();
				}else if(tabIdx == 1){
					$('.tabList2').show();
				}else if(tabIdx == 2){
					$('.tabList3').show();
				}
				
				$("#moreBtn").show();
				
				cfn_scrollTop(listTop);
			}
		});
		
	});
	
	//이벤트 목록조회
	var fn_srchEventList = function() {
		
		var startRow = 1;
		var endRow = 10;
		
		var formData = new FormData();
		formData.append('startRow', startRow);
		formData.append('endRow', endRow);
		formData.append("dispYn", 'Y');
		
		cfn_ajax({
			type : "POST",
			async : false,
			url: "/event/event_listAjax.do",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "no",
			timeOut : 5 * 60 * 1000,
			success: function(data) {
				list1 = data.list1;
				list2 = data.list2;
				
				ingSize = data.totalCnt1;
				endSize = data.totalCnt2;
								
				//fn_dataClear();
				
				fn_listDraw();
				
			},
			error : function(err) {
				console.log(err);
				alert("조회 결과가 없습니다.");
				
			},
			complete : function() {
			}
			
		});
		
	};	
	
	//이벤트 목록 그리기
	function fn_listDraw() {
		
		if(list1.length == 0){
 			$('#event_tab1').html("진행중인 이벤트가 없습니다.");
		}else{
			for(var i=0; i < list1.length;  i++) {
				$('#event_tab1').append("<li>" +
										//"<a href='javaScript:fn_goDetailUrl(0, " + list1[i]["eventSeq"]  + ",\"" + list1[i]["eventNm"] + "\",\"" + list1[i]["eventFrday"] + "\",\"" + list1[i]["eventToday"] + "\")'><span class='img'><img src='http://www.lottejtb.com/upload/common/event/main/" + list1[i]["eventBigImgurl"] + "' + alt='' onerror='javascript:noimg_setting(this, 1);'/></span>" +
										"<a href='javaScript:fn_goDetailUrl(0, " + list1[i]["eventSeq"]  + ",\"" + list1[i]["eventNm"] + "\",\"" + list1[i]["eventFrday"] + "\",\"" + list1[i]["eventToday"] + "\")'><span class='img'><img src='/m_file/upload/common/event/main/" + list1[i]["eventBigImgurl"] + "' + alt='' onerror='javascript:noimg_setting(this, 1);'/></span>" +
										"<h3>" + list1[i]["eventNm"] + "</h3>" +
										"<em>" + list1[i]["eventFrday"] + "~" + list1[i]["eventToday"] + "</em>" +
										"</a>" +
										"</li>"
									   );
			}
		}
		
		if(list2.length == 0){
			$('#event_tab2').html("종료중인 이벤트가 없습니다.");
		}else{
			for(var j = 0; j < list2.length; j++) {
				$('#event_tab2').append("<li>" +
										"<a href='javaScript:fn_goDetailUrl(1, " + list2[j]["eventSeq"]  + ",\"" + list2[j]["eventNm"] + "\",\"" + list2[j]["eventFrday"] + "\",\"" + list2[j]["eventToday"] + "\")'>" +
										"<h3>" + list2[j]["eventNm"] + "</h3>" +
										"<em>" + list2[j]["eventFrday"] + "~" + list2[j]["eventToday"] + "</em>" +
										"<i>조회수 " + list2[j].cnt +
										"</a>" +
										"</li>"
										);
			}
		}
	}
	
	function fn_listDrawMore(type) {	
		if(type == 0){
			if(list.length == 0){
	 			$('#event_tab1').html("진행중인 이벤트가 없습니다.")
	 			return false;
			}
	
			for(var i = 0; i < list.length;  i++) {
				$('#event_tab1').append("<li>" +
										//"<a href='javaScript:fn_goDetailUrl(0, " + list[i]["eventSeq"]  + ",\"" + list[i]["eventNm"] + "\",\"" + list[i]["eventFrday"] + "\",\"" + list[i]["eventToday"] + "\")'><span class='img'><img src='http://www.lottejtb.com/upload/common/event/main/" + list1[i]["eventBigImgurl"] + "' + alt='' onerror='javascript:noimg_setting(this, 1);'/></span>" +
										"<a href='javaScript:fn_goDetailUrl(0, " + list[i]["eventSeq"]  + ",\"" + list[i]["eventNm"] + "\",\"" + list[i]["eventFrday"] + "\",\"" + list[i]["eventToday"] + "\")'><span class='img'><img src='/m_file/upload/common/event/main/" + list1[i]["eventBigImgurl"] + "' + alt='' onerror='javascript:noimg_setting(this, 1);'/></span>" +
										"<h3>" + list[i]["eventNm"] + "</h3>" +
										"<em>" + list[i]["eventFrday"] + "~" + list[i]["eventToday"] + "</em>" +
										"</a>" +
										"</li>"
									   );
			}
		}else if(type == 1){
			if(list.length == 0){
				$('#event_tab2').html("종료중인 이벤트가 없습니다.");
				return false;
			}
			
			for(var j = 0; j < list.length; j++){
				$('#event_tab2').append("<li>" +
										"<a href='javaScript:fn_goDetailUrl(1, " + list[j]["eventSeq"]  + ",\"" + list[j]["eventNm"] + "\",\"" + list[j]["eventFrday"] + "\",\"" + list[j]["eventToday"] + "\")'>" +
										"<h3>" + list[j]["eventNm"] + "</h3>" +
										"<em>" + list[j]["eventFrday"] + "~" + list[j]["eventToday"] + "</em>" +
										"<i>조회수 " + list[j].cnt +
										"</a>" +
										"</li>"
										);
		   	}
		}
	}
	
	//이벤트 목록 더보기 
	var fn_moreEventList = function(type) {
		var thisSize;
		
		if(type == 0) {
			var curRow = $('#event_tab1').find("li").size();
			startRow = curRow + 1;
			endRow = curRow + Number(pageSize);
			thisSize = ingSize; 
		} else {
			var curRow = $('#event_tab2').find("li").size();
			startRow = curRow + 1;
			endRow = curRow + Number(pageSize);
			thisSize = endSize;
		}
		
		var formData = new FormData();
			formData.append('startRow', startRow);
			formData.append('endRow', endRow);
			formData.append('dispType', type);
		
		if(startRow > thisSize) {
			alert("더이상 등록된 이벤트가 없습니다");
			return false;
		}
		
		cfn_ajax({
			type : "POST",
			async : false,
			url: "/event/event_moreListAjax.do",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "yes",
			timeOut : 60 * 5 * 1000,
			success: function(data) {
				list = data.list;
				
				//fn_dataClear();
				if(list.length == 0) {
					alert("더이상 등록된 이벤트가 없습니다");
					$('#moreBtn').show();
					return false;
				}
								
				fn_listDrawMore(type);
			
				$('#moreBtn').show();
				
			},
			error : function(err) {
				console.log(err);
				alert("조회 결과가 없습니다.");
				
			},
			complete : function(e) {
			}
			
		});
		
	};
	
	//이벤트 상세보기
	var fn_srchDetailtList = function(seq,event_nm, event_s, event_e) {
		
		var formData = new FormData();
		formData.append('eventSeq', seq);
		
		cfn_ajax({
			type : "POST",
			async : false,
			url: "/event/event_detailAjax.do",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "yes",
			timeOut : 60 * 5 * 1000,
			success: function(data) {
				var detailCnt = data.cnt;
				var detail = data.list
				var vHTML = "";
				
				for(var i = 0; i < detail.length; i++){
					if(tabIdx == 0) {
						$('.tabcontent1').show();
						
						var event_img = detail[i].mblEeventUrl;
						
						event_img = event_img.replace('http://www.lottejtb.com', '');
												
						vHTML += "<li class='header'>"
						vHTML += "	<h3>" + detail[i].eventNm + "</h3>" + detail[i].eventFrday + "~" + detail[i].eventToday + "<i id='eventCnt'>" + "조회수:" + detailCnt + "</i>";
						vHTML += "</li>";
						vHTML += "<li class='content'>";
						vHTML += "	<div class='img'>";
						
						/* if(nullToBlank(detail[i].imgTopPh) != ""){
							vHTML += "		<img src='http://www.lottejtb.com/upload/common/event/template/"+ detail[i].imgTopPh +"' alt='' onerror='javascript:noimg_setting(this, 1);'/>";
						}
						if(nullToBlank(detail[i].imgLeftBackPh) != ""){
							vHTML += "		<img src='http://www.lottejtb.com/upload/common/event/template/"+ detail[i].imgLeftBackPh +"' alt='' onerror='javascript:noimg_setting(this, 1);'/>";
						}
						if(nullToBlank(detail[i].imgBottomPh) != ""){
							vHTML += "		<img src='http://www.lottejtb.com/upload/common/event/template/"+ detail[i].imgBottomPh +"' alt='' onerror='javascript:noimg_setting(this, 1);'/>";
						} */
						
						if(nullToBlank(event_img) != "") {
							//vHTML += "			<p><iframe  id='eventHtml' name='eventHtml' frameborder='0' marginheight='0' marginwidth='0'  src='http://www.lottejtb.com" + event_img + "' onload='javascript:resizeEvent1(this);'" +  " width='100%' height='height:60vh;' /></p>";
							vHTML += "			<p><iframe  id='eventHtml' name='eventHtml' frameborder='0' marginheight='0' marginwidth='0'  src='/m_file" + event_img + "' onload='javascript:resizeEvent1(this);'" +  " width='100%' height='height:60vh;' /></p>";
						}
						vHTML += "	</div>";
						vHTML += "</li>";
						
						$('#detailTab1').html(vHTML);
					} else if(tabIdx == 1) {
						$('.tabcontent2').show();
						
						vHTML += "<li class='header'>"
						vHTML += "	<h3>" + detail[i].eventNm + "</h3>" + detail[i].eventFrday + "~" + detail[i].eventToday + "<i id='eventCnt'>" + "조회수:" + detailCnt + "</i>";
						vHTML += "</li>";
						vHTML += "<li class='content'>";
						vHTML += "	<div class='img'>";
						if(nullToBlank(detail[i].imgTopPh) != ""){
							//vHTML += "		<img src='http://www.lottejtb.com/upload/common/event/template/"+ detail[i].imgTopPh +"' alt='' onerror='javascript:noimg_setting(this, 1);'/>";
							vHTML += "		<img src='/m_file/upload/common/event/template/"+ detail[i].imgTopPh +"' alt='' onerror='javascript:noimg_setting(this, 1);'/>";
						}
						if(nullToBlank(detail[i].imgLeftBackPh) != ""){
							//vHTML += "		<img src='http://www.lottejtb.com/upload/common/event/template/"+ detail[i].imgLeftBackPh +"' alt='' onerror='javascript:noimg_setting(this, 1);'/>";
							vHTML += "		<img src='/m_file/upload/common/event/template/"+ detail[i].imgLeftBackPh +"' alt='' onerror='javascript:noimg_setting(this, 1);'/>";
						}
						if(nullToBlank(detail[i].imgBottomPh) != ""){
							//vHTML += "		<img src='http://www.lottejtb.com/upload/common/event/template/"+ detail[i].imgBottomPh +"' alt='' onerror='javascript:noimg_setting(this, 1);'/>";
							vHTML += "		<img src='/m_file/upload/common/event/template/"+ detail[i].imgBottomPh +"' alt='' onerror='javascript:noimg_setting(this, 1);'/>";
						}
						vHTML += "	</div>";
						vHTML += "</li>";
							
						$('#detailTab2').html(vHTML);						
					}
				}
				
				$('#moreBtn').hide();
				$('#goListBtn').show();
				
			},
			error : function(err) {
				console.log(err);
				alert("조회 결과가 없습니다.");
				
			},
			complete : function(e) {
			}
			
		});
		
	};	
	
	
	//당첨자 더보기
	var fn_moreWinnerList = function() {
		
		var curRow = $('#event_tab3').find("li").size();
		startRow = curRow + 1;
		endRow = curRow + Number(pageSize);
			
		var formData = new FormData();
		formData.append('startRow', startRow);
		formData.append('endRow', endRow);
		
		if(startRow > winnerSize){
			alert("더이상 등록된 이벤트가 없습니다");
			return false;
		}
		
		cfn_ajax({
			type : "POST",
			async : false,
			url: "/event/event_WinnerListAjax.do",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "no",
			timeOut : 60 * 5 * 1000,
			success: function(data) {
				var list = data.list;
				
				//fn_dataClear();
				
				if(list.length == 0) {
					alert("더이상 등록된 이벤트가 없습니다");
					$('#moreBtn').show();
					return false;
				}
				
				for(var i=0; i < list.length;  i++) {	
					
					$('#event_tab3').append("<li data-icon= 'false'>" +
											"<a href=\"javaScript:fn_goDetailUrl(" + tabIdx + "," + list[i]["eventSeq"]  + ",\'" + list[i]["eventNm"] + "\',\'" + list[i]["eventFrday"] + "\',\'" + list[i]["eventToday"] +"\',\'"+ list[i]["eventDesc"] + "\',\'"+ list[i]['spotWinYn'] +"\')\"><h3><span class='gray'>" + "당첨자발표"  + "</span>" +
											list[i]["eventNm"] + "</h3><em> " + list[i]["eventFrday"] + "~" + list[i]["eventToday"] + 
											"</em></a></li>"
											);
				}
				$('#moreBtn').show();
			},
			error : function(err) {
				console.log(err);
				alert("조회 결과가 없습니다.");
				
			},
			done : function(e) {
			}
		});
	};
	
	//당첨자 목록 조회
	var fn_winnerList = function() {
		var startRow = 1;
		var endRow = 10;

		var formData = new FormData();
		formData.append('startRow', startRow);
		formData.append('endRow', endRow);
			
		cfn_ajax({
				type : "POST",
				async : false,
				url: "/event/event_winnerAjax.do",
				data: formData,
				dataType: "json",
				cache : false,
				noloading : "no",
				timeOut : 60 * 5 * 1000,
				success: function(data) {
					var list = data.list;
					winnerSize = data.totalCnt;
							
//					fn_dataClear();
//					$('.tabList3').show();
					
					//일단 임시적으로 이렇게 처리되었으나, 당첨자 발표부분 리스트들이 최신것으로 업데이트 되면
					//다시 화면그리는 루틴으로 변경해야함.
//					$('#event_tab3').html("검색된 결과가 없습니다.");
					 for(var i=0; i < list.length;  i++) {	
						
						$('#event_tab3').append("<li data-icon= 'false'>" +
												"<a href='javaScript:fn_goDetailUrl(2," + list[i]["eventSeq"]  + ",\"" + list[i]["eventNm"] + "\",\"" + list[i]["eventFrday"] + "\",\"" + list[i]["eventToday"] + "\",\""+ list[i]["eventDesc"] + "\",\""+ list[i]["spotWinYn"] +"\")'><h3><span class='gray'>" + "당첨자발표"  + "</span>" +
												list[i]["eventNm"] + "</h3><em> " + list[i]["eventFrday"] + "~" + list[i]["eventToday"] + 
												"</em></a></li>"
												);
						
					} 
					
					$('#moreBtn').show();
					//$('#event_tab3').listview().listview("refresh").trigger("create");
				},
				error : function(err) {
					console.log(err);
					alert("조회 결과가 없습니다.");
					
				},
				complete : function(e) {
				}
				
			});
	};
	
	
	//당첨자 상세보기
	var fn_winnerDetailtList = function(seq,event_nm, event_s, event_e, event_desc, spotWinYn) {
		
		var formData = new FormData();
		formData.append('eventSeq', seq);
		
		cfn_ajax({
			type : "POST",
			async : false,
			url: "/event/event_detailAjax.do",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "yes",
			timeOut : 60 * 5 * 1000,
			success: function(data) {
				var detailCnt = data.cnt;
				list = data.list;
				var vHTML = "";
				
				$('.tabcontent3').show();
				event_desc = event_desc.replace('http://www.lottejtb.com', '');
				
				vHTML += "<li class='header'>";
				vHTML += "	<h3><span class='gray'>" + "당첨자발표" +"</span>" + event_nm + "</h3>";
				vHTML += "	<em>" + event_s + "-" + event_e + "</em><i>" + "조회수:" + detailCnt + "</i>";
				vHTML += "</li>";
				vHTML += "<li class='content'>";
				vHTML += "	<div class='txt'>";
				vHTML += "		<p>" + event_nm + "</p>";
				vHTML += "		<div class='plan_cont_img'>";
				if(spotWinYn == 'Y'){
					//vHTML += "			<p><iframe  id='winnerHtml' name='winnerHtml' frameborder='0' marginheight='0' marginwidth='0'  src='http://www.lottejtb.com" + event_desc + "' onload='javascript:resizeEvent(this);'" +  " width='100%' height='1000' /></p>";
					vHTML += "			<p><iframe  id='winnerHtml' name='winnerHtml' frameborder='0' marginheight='0' marginwidth='0'  src='/m_file" + event_desc + "' onload='javascript:resizeEvent(this);'" +  " width='100%' height='1000' /></p>";
				}else{
					vHTML += "			<p>"+ event_desc +"</p>";
				}
				vHTML += "		</div>";
				vHTML += "	</div>";
				vHTML += "</li>";

				$('#detailTab3').html(vHTML);
				$('#moreBtn').hide();
				$('#goListBtn').show();
			},
			error : function(err) {
				console.log(err);
				alert("조회 결과가 없습니다.");
				
			},
			done : function(e) {

			}
			
		});
		
	};	
	
	function resizeEvent(iframe) {
		var innerBody = iframe.contentWindow.document.body;
		var innerHeight = innerBody.scrollHeight + (innerBody.offsetHeight - innerBody.clientHeight);
		document.getElementById("winnerHtml").height = innerHeight;
	}
	
	function resizeEvent1(iframe) {
		var innerBody = iframe.contentWindow.document.body;
		var innerHeight = innerBody.scrollHeight + (innerBody.offsetHeight - innerBody.clientHeight);
		document.getElementById("eventHtml").height = innerHeight;
	}
	
	//set
	function fn_selTab(tab) {
		$('#tab1').css('background', '#fff');
		$('#tab2').css('background', '#fff');
		$('#tab3').css('background', '#fff');
		$('#tab1').css('color', '#000');
		$('#tab2').css('color', '#000');
		$('#tab3').css('color', '#000');
		
		$('#detailTab1').empty();
		$('#detailTab2').empty();
		$('#detailTab3').empty();
		$('.tabContent1').hide();
		$('.tabContent2').hide();
		$('.tabContent3').hide();
		
		$("#goListBtn").hide();
		//$("#moreBtn").show();
		
		if(tab == 0) {
			tabIdx = 0;
			$('#tab1').css('background', '#705399');
			$('#tab1').css('color', '#fff');
			$('#tabList1').show();
			//fn_srchEventList();
			$("#moreBtn").show();
		} else if(tab == 1) {
			//종료이벤트
			tabIdx = 1;
			$('#tab2').css('background', '#705399');
			$('#tab2').css('color', '#fff');
			$('#tabList2').show();
			//fn_srchEventList();
			$("#moreBtn").show();
		} else if(tab == 2) {
			tabIdx = 2;
			$('#tab3').css('background', '#705399');
			$('#tab3').css('color', '#fff');
			$('#tabList3').show();
			$("#moreBtn").show();
			//fn_winnerList();
		}
	};
	
	function fn_dataClear() {
		$('#event_tab1').empty();
		$('#event_tab2').empty();
		$('#event_tab3').empty();
		
		$('#detailTab1').empty();
		$('#detailTab2').empty();
		$('#detailTab3').empty();
		$('#moreBtn').show();
	
		$('.tabList1').hide();
		$('.tabList2').hide();
		$('.tabList3').hide();
		$('.tabContent1').hide();
		$('.tabContent2').hide();
		$('.tabContent3').hide();
		
		$('#goListBtn').hide();
	};
	
	//이벤트 상세페이지
	//function fn_goDetailUrl(event_seq, event_nm, event_s, event_e) {
	//	document.location.href="/event/event_detail.do?event_seq=" + event_seq + "&event_nm=" + event_nm + "&event_s=" + event_s + "&event_e=" + event_e;
	//}
	
	// 이벤트 상세
	function fn_goDetailUrl(tabidx, seq, event_nm, event_s, event_e, event_desc, spotWinYn) {
		console.log(tabidx);
		//종료된 이벤트
		if(tabidx == 1) { 
			alert("종료된 이벤트 행사입니다.");
			return;
		}else{
			location.href = "/event/event_detail.do?eventSeq="+ seq;
		}
		/*
		$('.tabsnav').css("height", "");
		
	    //진행중 이벤트
		if(tabidx == 0) {
			$('.tabList1').hide();
			$('#tab1').css("")
			$(".tabContent1").show();
		} else if(tabidx == 1) {  //종료된 이벤트
			$('.tabList2').hide();
			$('.tabContent2').show();
		} else {  //당청자발표
			$('.tabList3').hide();
			$('.tabContent3').show();
		}
	    $('#moreBtn').show();
		$('#goListBtn').hide();
	
	    listTop = scrollTopHeight;   		 
		
		cfn_scrollTop(0);
		 
		if(tabidx == 2) {  //당첨자발표
			fn_winnerDetailtList(seq,event_nm, event_s, event_e, event_desc, spotWinYn);
		} else {
			//상세페이지 이동
			fn_srchDetailtList(seq,event_nm, event_s, event_e);	
		}
		*/
	}
	
</script>
</head>
<body>
<!--content-->    
	<div role="main" class="ui-content contentWrap">
		<div class="nav navstitle">이벤트</div>
	   <div data-role="tabs"  id="wrap" class="event">
		 <div data-role="navbar" class="tabsnav mgT10">
			<ul>
			  <li><a href="#tabList1" onclick="javascript:fn_selTab(0);" data-theme="a" data-ajax="false" id = "tab1" class="ui-btn-active"><span class="evt"></span>진행중 이벤트</a></li>
			   <li><a href="#tabList2" onclick="javascript:fn_selTab(1);" data-theme="a" data-ajax="false" id = "tab2"><span class="evt"></span>종료된이벤트</a></li>
			  <li><a href="#tabList3" onclick="javascript:fn_selTab(2);" data-theme="a" data-ajax="false" id = "tab3"><span class="evt"></span>당첨자발표</a></li>
			</ul>
		 </div>
		 
		 <!-- 진행중 이벤트목록 -->
		 <div id="tabList1" class="tabList1 tabContent evinglist">
		   <ul data-role="listView" class="img" id="event_tab1">
			</ul>
		  </div>
		  
		  <!-- 진행중 이벤트상세 -->
		  <div id="tabcontent1" class="tabcontent1 mgT10" style="display:none">
		   	<ul data-role="listView" class="detail"  id="detailTab1">
			 <!--
			 <li class='header'><h3></h3><i id="eventCnt"></i></li>
			 <li class="content"><div class="img"><img src="/resources/images/img/@img01.png" alt="" /></div></li>
			  <ul data-role="listView" class="detail">
		 	  </ul>
			  -->
		   </ul>
		  </div>
		  <!-- 종료된 이벤트목록 -->
		  <div id="tabList2" class="tabList2 tabContent evinglist"  >
		   <ul data-role="listView" class="list" id ="event_tab2">
		   </ul>
		  </div>
		  <!-- 종료된 이벤트 상세 -->
		  <div id="tabContent2" class="tabContent2 mgT10" style="display:none">
		   <ul data-role="listView" class="detail"  id ="detailTab2">
			<!-- 		    
		     <li class='header'><h3></h3><em>2016-08-02~2016-08-15</em><i></i></li>
		     <li class="content">				 
				<div class="txt">시사영어 제휴이벤트 당첨자발표<br/>					
				롯데홀리데이<br/>페이스북  EVENT!!<br/>2016-08-02~2016-08-15</br>축하드립니다
				</div>
			</li>
			-->
		   </ul>
		  </div>
		  <!-- 당첨자발표 목록 -->
		 <div id="tabList3" class="tabList3 tabContent evinglist">
		   <ul data-role="listView" class="list" id="event_tab3" >
		    </ul>
		  </div>
		  <!-- 당첨바발표 상세 -->
		  <div id="tabContent3" class="tabContent3 mgT10" style="display:none">
		   <ul data-role="listView" class="detail"  id = "detailTab3">
		    <!-- 
		    <li class='header'></li>
		    <li class="content">
				<div class="txt">
					<p>시사영어 제휴이벤트 당첨자발표</p>
					<table>
						<tr><td>김**</td><td>7731</td></tr>
						<tr><td>제**</td><td>0087</td></tr>
						<tr><td>표**</td><td>3632</td></tr>
						<tr><td>사**</td><td>5853</td></tr>
					</table>
					
				</div>
			</li>
			 -->
		   </ul>
		  </div>
		  
		  
		<div class="more" id="moreBtn">
			<a href="#"><i class="fa fa-angle-down fa-2x"></i>더보기</a>
		</div>
		<div class="more" id="goListBtn" style="display:none"><i class="fa fa-bars mgr5 list"></i>목록으로</div>
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
		 </div><!--tabs End-->
	  </div><!--//contentWrap End-->
	<!--//content-->
		
	</body>
