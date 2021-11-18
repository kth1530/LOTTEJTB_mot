<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>

<%
	String tabsNo = "03";

	String custCd = (String) request.getAttribute("cust_cd");

%>
<link rel="stylesheet" type="text/css" href="/resources/common/css/common_tour.css" />
<script type="text/javascript">	
	var flag = false;
	var list = [];
	var listSize = '${listSize}';	
	var totalSize = 0;
	var _s_cnt = 1;
	var _e_cnt = 0;
	var pageSize = 10;
	var orderby = '${orderby}';
	var searchKeyword = '${searchKeyword}';
	var goodsTypeCd;
	var lightDay = [];
	var subTotnum = 0;
	var all_data, fix_list, cateList;
	
	// 버튼 초기화
	var fn_initButton = function() {
		
		// 상품 목록 더보기 
		if(parseInt(_e_cnt) == fix_list.length) {
				document.all.btn_more.style.display="none";
		}	else {
				document.all.btn_more.style.display="";
		}			
	};
	
	function addComma(num) {
		var regexp = /\B(?=(\d{3})+(?!\d))/g;
		return num.toString().replace(regexp, ',');
	}
	
	// 상품 리스트 조회 
	var fnSetList = function () {
		var txt = new Array();
		
		$("#sub_total_num").text(fix_list.length);
		
		if(fix_list == null || fix_list.length == 0){
			$("#sechTourMentoModel").html('<tr><td colspan="6"><div class="no_data">검색된 내용이 없습니다.</div></td></tr>');
			return;	
		}
		
		var rowData = fix_list;
		
		for(var i=_s_cnt; i <= _e_cnt; i++){
			var event = rowData[i-1];
			var data = "";

		    var ctgSeq = event.ctg_seq;
		    var eventCd = event.event_cd;
		    var days = event.et_days.split("/");
		    var startDay = event.start_day;
		    var startTime = event.start_time;
		    var endDay = event.end_day;
		    var endTime = event.end_time;
		    var evDayCnt = event.ev_day_cnt;
		    var adultPrice = event.adult_price;
		    var trffKnm = event.trff_knm;
		    var trffCdShort = event.trff_cd_short;
		    var dispNm = event.disp_nm.replaceAll('>','&gt;').replaceAll('<','&lt;');
		    var rvCnt = parseInt(event.rv_cnt);
		    var evInwon = parseInt(event.ev_inwon);
		    var procCd = event.proc_cd;
		    var lockUnit = event.lock_unit;
		    var rvTxt = "";
		    var cls = "point_i";
		    var goodsNightCnt = event.goods_night_cnt;        
		    var goodsDayCnt = event.goods_day_cnt;
		    var ctgNm = event.ctg_nm;        
		    var ctgUprNm = event.ctg_upr_nm;
		    var minInwon = event.min_inwon;
		     
		    //일자 HeightLight
		    lightDay.push(startDay);
		      
		    startDay = startDay.substring(2,4)+"/"+startDay.substring(4,6)+"/"+startDay.substring(6,8);
		      
		    if(startTime){
		    	startTime = startTime.substring(0,2)+":"+startTime.substring(2,4);
		    }else{
		    	startTime = "";
		    }
		
		    endDay = endDay.substring(2,4)+"/"+endDay.substring(4,6)+"/"+endDay.substring(6,8);
		      
		    if(endTime){
		    	endTime = endTime.substring(0,2)+":"+endTime.substring(2,4);
		    }else{
		    	endTime ="";
		    }
		
		
		    if (dispNm.length > 54) {
		    	dispNm = dispNm.substring(0,54) + "...";
		    }
		
		     

		    if (rvCnt >= evInwon) {
		    	rvTxt = "예약마감";
		    	cls = "cld_black";
		    } else {
		        if (evInwon == 0) {
		          rvTxt = "예약마감";
		          cls = "cld_black";
		        } else {
		          if (procCd == "RE") {
		            rvTxt = "예약마감";
		            cls = "cld_black";
		          } else {
		            if (lockUnit == "Y") {
		              rvTxt = "예약마감";
		              cls = "cld_black";
		            } else {
		              if (procCd == "SE") {
		                rvTxt = "출발가능";
		                cls = "cld_purple";
		              }else if (procCd == "09") {
		                rvTxt = "긴급모객";
		                cls = "cld_red";
		              } else {
		                rvTxt = "예약가능";
		                cls = "cld_blue";
		              }
		            }
		          }
		        }
		      }
		    
		    data += '<li onClick="goGoodsDetail(\'' + eventCd + '\',\'' + ctgSeq + '\')"> ';
		    data += " <p class='sm_sub_textbox3'>" + ctgUprNm + ">" + ctgNm + "</p>";
		    data += " <p class='sm_sub_textbox1'>";							
		    data += "	 <span class='startday'>출발일" + startDay + "(" + days[0] + ")" + startTime + "</span>";
		    data += "	 <span class='endday'>도착일" + endDay + "(" + days[1] + ")" + endTime + "</span>";
		    data += "	 <em class='conday'>" + goodsNightCnt + "박 " + goodsDayCnt + "일</em>";
		    data += " </p>";
		    data += "<p class='sm_sub_textbox2 " + cls +" '>" + rvTxt + "</p>";
		    data += "<input type='hidden' name='status' value='" + rvTxt + "'>";
		    data += " <input type='hidden' name='date' value='14'>";
		    data += " <p class='sm_sub_title'>" + dispNm + "</p>";
		    data += " <div class='sm_sub_text1'>";
		    data += "    <p class='sm_sub_airbox'>";
		    data += "		<img src='/resources/images/air/" + trffCdShort + ".png' class='img mgL5'>" + trffKnm;
		    data += "	</p>";
		    data += " </div>";
		    data += " <div class='sm_sub_text1'>";
		    data += "    남은 좌석 : <em>" + ( parseInt(evInwon) - parseInt(rvCnt)) + "석</em>, 최소출발 : <em>" + minInwon + "명</em>";
		    data += "    <p class='sm_sub_pirce'><em>" + addComma(adultPrice) + "</em>원</p>";
		    data += " </div>";
		    data += "</li>";
		    
		      
			$("#eventList").append(data);
		}
		
		fn_initButton();
		exeCriteoScript();
	};		
	
	// 페이지 계산 
	var fn_calcPage = function(status) {

		if(status == 'new'){
			_s_cnt = 1;
			_e_cnt = (parseInt(pageSize) > fix_list.length) ? fix_list.length : parseInt(pageSize);
		}else{
			_s_cnt = parseInt(_s_cnt) + parseInt(pageSize);
			_e_cnt = (parseInt(_e_cnt) + parseInt(pageSize)) > fix_list.length ? fix_list.length : parseInt(_e_cnt) + parseInt(pageSize);		
		}
		

		fn_initButton();
		fnSetList();
		
	};		
	
	// [COMMON] 공통사항 
	$(document).ready(function(){
		
		//조회결과 배열에 push start
		var result = ${resultList};
		var resultCnt = "${resultCnt}";
		
		$.each(result, function(i, e){
			var row = new Array();
			$.each(e, function(k, v){
				row[k] = v;
			});
			list.push(row);
		});			

		//조회결과 배열에 push end
		
		totalSize = resultCnt;
		all_data = list;
		fix_list = list;			
			
		fn_calcPage('new');
		
		master_init();
		
		fn_initButton();
	
		//초기날짜set		
		var nowDate = new Date();		
		
		var frYesterDate = nowDate.getTime() + (3*24*60*60*1000);
		nowDate.setTime(frYesterDate);
		
		var yesterY = nowDate.getFullYear();
		var yesterM = nowDate.getMonth() + 1;
		var yesterD = nowDate.getDate();
		
		if(yesterM < 10){ yesterM = "0" + yesterM; }
		if(yesterD < 10){ yesterD = "0" + yesterD; }
		
		var frYesterDay = yesterY + "." + yesterM + "." + yesterD;
		$("#dep_dt").text(frYesterDay);
		
		var toYesterDate = nowDate.getTime() + (4*24*60*60*1000);
		nowDate.setTime(toYesterDate);
		
		var yesterY = nowDate.getFullYear();
		var yesterM = nowDate.getMonth() + 1;
		var yesterD = nowDate.getDate();
		
		if(yesterM < 10){ yesterM = "0" + yesterM; }
		if(yesterD < 10){ yesterD = "0" + yesterD; }
		
		var toYesterDay = yesterY + "." + yesterM + "." + yesterD;
		$("#arr_dt").text(toYesterDay);
		
		
		// 상품 전시 페이지 CSS 스타일을 맞춰줌 
		$(".bodyWrap").addClass("goods");
		
		//카테고리 코디-네임 변경
		var param = "${srchType}";
		var arrNm = param.split(",");
		var cateNm = new Array();
		
		for(var i = 0; i < arrNm.length; i++){
			switch(arrNm[i]){
				case '6571' :	cateNm[i] = '부모님'; break;
				case '6580' :	cateNm[i] = '엄마'; break; 
				case '6572' :	cateNm[i] = '자녀'; break;
				case '6573' :	cateNm[i] = '연인'; break;
				case '6574' :	cateNm[i] = '부부'; break;
				case '6576' :	cateNm[i] = '친구'; break;
				case '6581' :	cateNm[i] = '형제'; break;
				case '6593' :	cateNm[i] = '가족'; break;
				case '6582' :	cateNm[i] = '친목회'; break;
			}
		}
		$("#sp_tagList").text(cateNm);
		
	});

	//전체일정 check event
	$(document).off("click", ".chk_allday");
	$(document).on("click", ".chk_allday", function(){
		
		if($(this).find("input").is(":checked")==true){
			$(".btnDate").attr("disabled", true);
			$(".btnDate").removeClass("tm_date");
			sortList();
		}else{
			$(".btnDate").attr("disabled", false);
			$(".btnDate").addClass("tm_date");
		}
		
	});
	
	//대분류 change event
	$(document).off("change", "#area_cd");
	$(document).on("change", "#area_cd", function(){
		var seq = $(this).val();
		var html = "<option value='0'>- 소분류 -</option>";

		if(seq > 0){

			var formData = new FormData();
			formData.append('ctg_upr_seq', seq);
			
			cfn_ajax({
				type: "POST",
				url: "<c:url value='/search/selectSubAreaAjax.do' />",
				data: formData,
				dataType: "json",
				cache: false,
				noloading:"no",
				success: function(res) {
					var result = res.area;
					if(result.length > 0){
						$("sub_area_cd").html('');
						for(var i = 0; i < result.length; i++){
							html += "<option value='" + result[i].ctg_seq + "'>" + result[i].ctg_nm + "</oprion>";
						}						
					}
					$("#sub_area_cd").html(html);
				},
				error:function(err){
					//console.log(err);
				}
			});
		}else{
			$("sub_area_cd").html('');
			$("#sub_area_cd").html(html);
		}
		
		sortList();
		
	});

	
	// 상품 상세 화면으로 이동 
	function goGoodsDetail(eventCd, ctg) {
		document.location.href="/goods/detail_goods.do?ctg="+ctg+"&eventCd=" + eventCd;

	}		
	

	//소분류 change event
	$(document).off("change", "#sub_area_cd");
	$(document).on("change", "#sub_area_cd", function(){
		sortList();		
	});
	
	//정렬방식 change event
	$(document).off("change", "#sort_amt");
	$(document).on("change", "#sort_amt", function(){
		sortList();		
	});
	
	function sortList(){

		var sort = $("#sort_amt option:selected").val();
		
		//정렬		
		if(sort > 0){
			switch(sort-0)	{		
				case 1:	// 금액이 낮은순 
					sortByCol(all_data, 'adult_price', 'A', 'Y');
			  	break;
				case 2:	// 금액이 높은순 
					sortByCol(all_data, 'adult_price', 'D', 'Y');
			  	break;
				default: // IBE 순서
			}	
		}
		sechMentoFilter();	
	}
	
	//컬럼순번으로  정렬하는 함수
	//arr:정렬대상, colNm:정렬기준컬럼명 ord:정렬방법(A:오름차순, D:내림차순), parseYN : string->int 변환여부
	function sortByCol(arr, colNm, ord, parseYN){
	    arr.sort(sortFunction)

	    function sortFunction(a, b) {
	    	if(parseYN == "Y"){
		        //a = parseInt(eval("a." + colNm))
		        //b = parseInt(eval("b." + colNm))
		        //속도문제로 일단 컬럼명 하드코딩으로 함 
		        a = parseInt(a.adult_price)
		        b = parseInt(b.adult_price)
	    	}else{
		        //a = eval("a." + colNm)
		        //b = eval("b." + colNm)
		        a = eval(a.adult_price)
		        b = eval(b.adult_price)
	    	}
	        if(ord == "A"){
	        	return (a === b) ? 0 : (a < b) ? -1 : 1
	        }else if(ord == "D"){
	        	return (a === b) ? 0 : (a > b) ? -1 : 1
	        }
	    }
	};

	function sechMentoFilter(){
	
		if(totalSize > 0){		
			$(".main_title").prop("style", "display:none");
			$(".search_text").prop("style", "display:block");
			
			fix_list = [];

			$("#eventList").html("");
			
			var s_date = $("#dep_dt").text();			
			var e_date = $("#arr_dt").text();
			var chkStatus = $(".btnDate").hasClass("tm_date");
			
			var dep1 = $("#area_cd option:selected").val();			
			var dep2 = $("#sub_area_cd option:selected").val();
			
			for(var idx=0; idx < all_data.length; idx++){
				var sort_data = all_data[idx];
				var f_addData = false;

				//날짜
				if(chkStatus == true){
					s_date = s_date.replaceAll(/\./, "");
					e_date = e_date.replaceAll(/\./, "");
					var sort_s_date = sort_data.start_day;
					var sort_e_date = sort_data.end_day;					
					
					if(s_date <= sort_s_date && e_date >= sort_e_date){
						f_addData = true;
					}else{
						f_addData = false;
					}
				}else{
						f_addData = true;
				}
				
				//지역
				if(f_addData){
					if(dep1 > 0){
						var area = sort_data.ctg_upr_seq;
						var sub_area = sort_data.ctg_seq;
						
						if(dep1 == area){
							if(dep2 > 0){
								if(dep2 == sub_area){
									f_addData = true;
								}else{
									f_addData = false;
								}
							}else{
								f_addData = true;
							}
						}else{
							f_addData = false;
						}
						
					}else{
						f_addData = true;
					}	
				}
				
				if(f_addData){
					fix_list.push(sort_data);
				}	
				
			}
				
			//페이징 처리
			fn_calcPage('new');
		}
	
	}		
	
</script>
</head>
<!--content-->
<div role="main" class="ui-content contentWrap searchBox searchResultDiv" id="top">
	<div  class="list">
		<div class="tm_title">
			<div class="main_title">
				<h2><span id="sp_tagList" name="sp_tagList"></span>와(과) 함께 할 수 있는 적합한 여행상품이 <span id="sp_tagListSize" name="sp_tagListSize">${resultCnt }</span>건 검색되었습니다.</h2>
				<p>날짜와 여행지를 선택하시면 더욱 적합한 상품을 찾아 드립니다.</p>
			</div>
		</div>
		<!-- 2018-12-04 수정 -->
		<div class="Mentoring_tit">
			<div class="box">
				<div class="step step1">
					<h3>멘토링 1단계</h3>
					<div class="text">
						<p class="text_tit">언제 떠나고 싶으세요?</p>
						<div class="after">
							<div class="day freesearch" ft-att='RCGroup'>
							
								<!-- 날짜 -->
								<ul class="tra_day tra_day2">
									<li>
										<button type="button" class="layerOpener btnDate" data-url="/pop/pop_ht_calendar.do?type=HOTEL&availTy=HT"  data-ctn="full" data-role="none" style="cursor='hand';" data-ok='yes' disabled="true">
											<span class="noSelect" name="depDt" id="dep_dt">미지정</span>
										</button>
									</li>
									<li>
										<button type="button" class="layerOpener btnDate" data-url="/pop/pop_ht_calendar.do?type=HOTEL&availTy=HT"  data-ctn="full" data-role="none" style="cursor='hand';" data-ok='yes' disabled="true">
											<span class="noSelect" name="arrDt" id="arr_dt">미지정</span>
										</button>
									</li>
								</ul>
								
							</div>
							<div class="chk_allday">
								<p class="chkbox" style="margin-left:0px;margin-top: 10px;">
									<span class="chk_allDay"><input id="allDay" type="checkbox" data-role="none" checked=""></span>
									<label for="chk_ck10_1">전체 일정 보기</label>
								</p>
							</div>
						</div>
					</div>
				</div>
				<div class="step step2">
					<h3>멘토링 2단계</h3>
					<div class="text">
						<p class="text_tit">어디로 떠나고 싶으세요?</p>
						<div class="after">
							<div class="day">
								<dl class="dl_set main">
									<dt>지역선택</dt>
									<div class="selectbox" id="areaSelect">
										<select title="대분류" id ="area_cd" name="area_cd" class="select" data-role="none" >											
												<option value="0">- 대분류 -</option>
												<c:choose>
													<c:when test="${fn:length(area) > 0 }">
														<c:forEach items="${area }" var="aList">		
															<c:if test="${aList.ctg_type_cd == '000' }">				
																<option value="${aList.ctg_seq }">${aList.ctg_nm }</option>
															</c:if>
														</c:forEach>
													</c:when>
												</c:choose>			
										</select>
									</div>
									<div class="selectbox" id="subAreaSelect">
										<select title="소분류" id="sub_area_cd" name="sub_area_cd" class="select" data-role="none" >											
												<option value="0">- 소분류 -</option>												
										</select>
									</div>
							</div>
						</div>
					</div>
				</div>
				<div class="step step3">
					<h3>멘토링 3단계</h3>
					<div class="text">
						<p class="text_tit">보시기 편한 순으로 골라주세요!</p>
						<div class="after">
							<div class="day">
								<dl class="dl_set">
									<dt>정렬방식</dt>
									<div class="selectbox" id="sortSelect">
										<select title="정렬" id="sort_amt" name="sort_amt" class="select w100" data-role="none">											
												<option value="0">- 선택하기 -</option>												
												<option value="1">금액이 낮은 순</option>												
												<option value="2">금액이 높은 순</option>		
										</select>
									</div>
								</dl>
							</div>
						</div>
					</div>
				</div>
				<div class="step_right_search">
					<a href="javascript:sortList();">검색</a>
				</div>
			</div>
		</div>

		<!-- 리스트 형태 -->
		<div class="search_text" style="display:none;">고객님에게 적합한 여행상품이 <span class="point_b" id="sub_total_num" style="color:#cd1d1f;"></span>건 검색되었습니다.</div>
		
		<div class="shopmasterbox" id="tab1" style="margin-top:2px;">	
			<div class="tabctn_com sm_mst_box sm_mst_box1 ps_view" style="display:block;">
				   <ul class="sm_sub_listbox" id="eventList">
				      
				     
				   </ul>
			</div>
		</div>
		

		<div class="last">상기 모든 상품 가격은 항공운임(항공권)이 포함된 금액이며,<br/>유류할증료는 유가와 환율에 따라 변동될 수 있습니다.</div>
		<div class="more" id="btn_more"><a href="javascript:fn_calcPage()"><i class="fa fa-angle-down fa-2x"></i>더보기</a></div>
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div><!--tabs End-->
<!-- 정렬 방식  -->       
</div><!--//contentWrap End-->
<!-- 		criteo script -->
		<script type="text/javascript" src="//static.criteo.net/js/ld/ld.js" async="true"></script>
		<script type="text/javascript">
			exeCriteoScript();
			function exeCriteoScript(){
				window.criteo_q = window.criteo_q || [];
				window.criteo_q.push(
				        { event: "setAccount", account: 7995 },
				        { event: "setCustomerId", id: '<%=custCd%>'},
				        { event: "setSiteType", type: "m" },
				        { event: "viewList", item: [], keywords:$('#searchKeyword').val()}
				);
			}
		</script>
<!--//content-->