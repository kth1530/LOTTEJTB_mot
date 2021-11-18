<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 파일명 : inc_layer_goods_ctg.jsp
// 설명 : 상품 카테고리 레이어 팝업 
%>
<script>
<!--
		// <!-- 상품 카테고리 리스트 조회 -->
		function fn_goodsCtg(ctg_upr_seq) {
			// alert(ctg);
			
			var nCtg = parseInt(ctg_upr_seq);
			var selectedCtg = 0;
			var selectedTag = "선택";
			/******* [AS-IS] 하드코딩으로 박음 ********/
			if(nCtg >= 5786 && nCtg <= 5794) { 
				selectedCtg = 5746; 
				selectedTag = "선택";
			} else if(nCtg >= 5807 && nCtg <= 5811) { 
				selectedCtg = 5740; 
				selectedTag = "선택";
			}  else if(nCtg >= 6129 && nCtg <= 6130) { 
				selectedCtg = 5808; 
				selectedTag = "선택";
			}  else if(nCtg >= 5749 && nCtg <= 5759) { 
				selectedCtg = 5741; 
				selectedTag = "선택";
			}  else { 
				selectedCtg = nCtg; 
				selectedTag = "선택";
			}  

			/******* [AS-IS] 하드코딩으로 박음 ********/

			console.log("fn_goodsCtg() >>>>>>>>>>>>>>>>>>>>> fn_goodsCtg() >>>>>>>>>>>>>>>>>>>>>> selectedCtg >>> " + selectedCtg);

			var formData = new FormData();
			formData.append('ctg', selectedCtg);
			
			
			cfn_ajax({
				type: "POST",
				async: false,
				url: "<c:url value='/goods/goodsCtgListAjax.do'  />",
				data: formData,
				dataType: "json",
				cache: false,
				noloading:"no",
				timeOut: (5*60*1000),
				success: function(res) {
					var list = res.list;
					if(list != null && list.length > 0) {
						
						var tag = "";

						tag = tag + "	<div class='layerPopup2'>";
						
						tag = tag + "	<div class='layerPop2' id='popGoodsCategory1'>";
						tag = tag + "			<div class='popCon'>";
						tag = tag + "				<div class='popHead'>";
						tag = tag + "					<div class='popTpart'>";
						tag = tag + "						<strong class='popTitle'>"+selectedTag+"</strong>";
						tag = tag + "						<button type='button' class='etclayerClose'><img src='/resources/images/btn/btn_exit.png' alt='레이어 닫기'></button>";
						tag = tag + "					</div>";
						tag = tag + "				</div>";
						tag = tag + "				<div class='cntain'>";
						tag = tag + "					<ul class='selectpop_radio'>";


						
						for(var i=0; i < list.length; i++) {

							// console.log("fn_goodsCtg() >>>>>>>>>>>>>>>>>> ctg_upr_seq >>> " + ctg_upr_seq + " : list[i]['ctg_seq'] >>> " + list[i]["ctg_seq"]);
							if(exceptionCategory(list[i]["ctg_seq"])) {
								if(ctg_upr_seq == list[i]["ctg_seq"]) {
									selectedArea = list[i]["ctg_nm"];

									tag = tag + "				<li><a href='#' onClick='fn_searchGoodsCtg(\""+list[i]["ctg_seq"]+"\",\""+list[i]["ctg_nm"]+"\");' class=''><span class='radiobox ctgRadio1 on'><input type='radio' name='ctg' class='ctg1' id='ctg_"+list[i]["ctg_seq"]+"' checked='checked' value='"+list[i]["ctg_seq"]+"' onClick='fn_searchGoodsCtg(\""+list[i]["ctg_seq"]+"\",\""+list[i]["ctg_nm"]+"\")'></span><label for='"+list[i]["ctg_seq"]+"'>"+ selectedArea + "</label></a></li>";
									
									$("#ctg_depth2").html(selectedArea);		

								} else {
									selectedArea = list[i]["ctg_nm"];
									tag = tag + "				<li><a href='#' onClick='fn_searchGoodsCtg(\""+list[i]["ctg_seq"]+"\",\""+list[i]["ctg_nm"]+"\");' class=''><span class='radiobox ctgRadio1'><input type='radio'  name='ctg' class='ctg1' id='ctg_"+list[i]["ctg_seq"]+"' value='"+list[i]["ctg_seq"]+"' onClick='fn_searchGoodsCtg(\""+list[i]["ctg_seq"]+"\",\""+list[i]["ctg_nm"]+"\")'></span><label for='radio"+i+"'>"+ selectedArea + "</label></a></li>";
									
								}
							}
							
						}

						tag = tag + "					</ul>";
						tag = tag + "				</div>";
										
						tag = tag + "			</div>";
						tag = tag + "	</div>";
						tag = tag + " </div>";
						
						// console.log(tag);
						$("#popupGoodsCtg").html(tag);
						// console.log(tag);
					} else {
						// alert("상품 카테고리 정보가 검색되지 않습니다.");
					}
				},
				error:function(err){
					console.log(err);
				},
				complete:function(){
					$(".layerPopup2").trigger('create');
					// fn_goodsCtg2('${ctg}');
				}
			});
		}
		
		function fn_searchGoodsCtg(ctg_val, ctg_nm) {
			curr_ctg = ctg_val;
			
			$(".ctgRadio1").removeClass('on');
			$(".ctg1").removeAttr("checked").checkboxradio("refresh");
			$("#ctg_"+ ctg_val).parent().parent().addClass('on');
			$("#ctg_"+ ctg_val).prop("checked", true).checkboxradio("refresh");
			
			setTimeout(function(){
				jQuery("html, body").css({"overflow":"auto"});
				jQuery(".layerPopup2").hide();
				
				fn_goodsCtg3(ctg_val);
			
				// -------------------------------------------
				// 화면 카테고리 2 DEPTH 표시 
				// -------------------------------------------						
				$("#ctg_depth2").html(ctg_nm);
				
				fn_search();
			}, 10);
		}
		
		// <!-- 상품 카테고리 리스트 조회 -->
		function fn_goodsCtg2() {
			var ctg = ${ctg};
			var ctg_upr_seq = 0;
			
			var formData = new FormData();
			formData.append('ctg', ctg);
			formData.append("orderby", "01");
			// console.log(">>>>>>>>>>>>>>>>>>>>> fn_goodsCtg2() >>>>>>>>>>>>>>>>>>>>>> ctg >>> " + ctg);

			cfn_ajax({
				type: "POST",
				async: false,
				url: "<c:url value='/goods/goodsCtgListDepthAjax.do' />",
				data: formData,
				dataType: "json",
				cache: false,
				noloading:"no",
				timeOut: (5*60*1000),
				success: function(res) {
					var list = res.list;
					if(list != null && list.length > 0) {						
						var tag = "";

						var tag_ctg_depth3 = "";

						tag = tag + "	<div class='layerPopup2'>";
						tag = tag + "	<div class='layerPop2' id='popGoodsCategory2'>";
						tag = tag + "			<div class='popCon'>";
						tag = tag + "				<div class='popHead'>";
						tag = tag + "					<div class='popTpart'>";
						tag = tag + "						<strong class='popTitle'>선택</strong>";
						tag = tag + "						<button type='button' class='etclayerClose'><img src='/resources/images/btn/btn_exit.png' alt='레이어 닫기'></button>";
						tag = tag + "					</div>";
						tag = tag + "				</div>";
						tag = tag + "				<div class='cntain'>";
						tag = tag + "					<ul class='selectpop_radio'>";

						
						for(var i=0 ; i < list.length; i++) {
							if(exceptionCategory(list[i]["ctg_seq"])) {
								if(ctg == list[i]["ctg_seq"]) {

									selectedArea = list[i]["ctg_nm"];
									tag = tag + "				<li><a href='#' onClick='fn_searchGoodsCtg2(\""+list[i]["ctg_seq"]+"\",\""+list[i]["ctg_nm"]+"\");' class=''><span class='radiobox ctgRadio2 on'><input type='radio' name='ctg2' class='ctg2' id='ctg_"+ list[i]["ctg_seq"] +"' checked='checked' value='"+list[i]["ctg_seq"]+"' onClick='fn_searchGoodsCtg2(\""+list[i]["ctg_seq"]+"\",\""+list[i]["ctg_nm"]+"\")'></span><label for='"+list[i]["ctg_seq"]+"'>"+ selectedArea + "</label></a></li>";

								
									tag_ctg_depth3 = list[i]["ctg_nm"];
											
									
									// -------------------------------------------
									// 화면 카테고리 2 DEPTH 표시 
									// -------------------------------------------
									// $("input:radio[name='ctg']:radio[value='"+ list[i]["ctg_upr_seq"] +"']").attr("checked",true).checkboxradio("refresh");	
									// var selectedArea = $('label[for=' + list[i]["ctg_upr_seq"]+ ']').text();
									// $("#ctg_depth2").html(selectedArea);								
									// console.log(text);
									
									// console.log(text);

									ctg_upr_seq = list[i]["ctg_upr_seq"];
								} else {
									selectedArea = list[i]["ctg_nm"];
									tag = tag + "				<li><a href='#' onClick='fn_searchGoodsCtg2(\""+list[i]["ctg_seq"]+"\",\""+list[i]["ctg_nm"]+"\");'  class=''><span class='radiobox ctgRadio2'><input type='radio' name='ctg2' class='ctg2' id='ctg_"+ list[i]["ctg_seq"] +"' value='"+list[i]["ctg_seq"]+"' onClick='fn_searchGoodsCtg2(\""+list[i]["ctg_seq"]+"\",\""+list[i]["ctg_nm"]+"\")'></span><label for='"+list[i]["ctg_seq"]+"' >"+ selectedArea + "</label></a></li>";

									// $("#ctg_depth3").html(list[0]["ctg_nm"]);
									ctg_upr_seq = list[i]["ctg_upr_seq"];
								}
							}
						}

						if(tag_ctg_depth3 == '') {
							tag_ctg_depth3 = list[0]["ctg_nm"];
						}
						
						console.log(">>>>>>>>>>>>>>>>>>>>>> fn_goodsCtg2() >>>>>>>>>>>>>>>>>>>> ctg_upr_seq : " + ctg_upr_seq);
						/**
						if(ctg_upr_seq == 0) {
							ctg_upr_seq = list[0]["ctg_upr_seq"];
						}
						**/
						

						tag = tag + "					</ul>";
						tag = tag + "				</div>";										
						tag = tag + "			</div>";
						tag = tag + "	</div>";
						tag = tag + " </div>";
						// console.log(tag);

						// -------------------------------------------
						// 화면 카테고리 3 DEPTH 표시 
						// -------------------------------------------	
						$("#ctg_depth3").html(tag_ctg_depth3);

						$("#popupGoodsCtg2").html(tag);
					} else {
						// alert("상품 카테고리 정보가 검색되지 않습니다.");
					}
				},
				error:function(err){
					console.log(err);
				},
				complete:function(){
					$(".layerPopup2").trigger('create');
					// $("#ctg2").checkboxradio("refresh");
					fn_goodsCtg(ctg_upr_seq);

				}
			});
		}

		// <!-- 상품 카테고리 리스트 조회 -->
		function fn_goodsCtg3(ctg) {
			var firCtgCode;
			var firCtgName;
			var formData = new FormData();
			formData.append('ctg', ctg);
			formData.append("orderby", "02");
			// console.log(">>>>>>>>>>>>>>>>>>>>> fn_goodsCtg2() >>>>>>>>>>>>>>>>>>>>>> ctg >>> " + ctg);

			cfn_ajax({
				type: "POST",
				async: false,
				url: "<c:url value='/goods/goodsCtgListDepthAjax2.do' />",
				data: formData,
				dataType: "json",
				cache: false,
				noloading:"no",
				timeOut: (5*60*1000),
				success: function(res) {
					var list = res.list;
					if(list != null && list.length > 0) {						
						var tag = "";

						var tag_ctg_depth3 = "";

						tag = tag + "	<div class='layerPopup2'>";
						tag = tag + "	<div class='layerPop2' id='popGoodsCategory2'>";
						tag = tag + "			<div class='popCon'>";
						tag = tag + "				<div class='popHead'>";
						tag = tag + "					<div class='popTpart'>";
						tag = tag + "						<strong class='popTitle'>선택</strong>";
						tag = tag + "						<button type='button' class='etclayerClose'><img src='/resources/images/btn/btn_exit.png' alt='레이어 닫기'></button>";
						tag = tag + "					</div>";
						tag = tag + "				</div>";
						tag = tag + "				<div class='cntain'>";
						tag = tag + "					<ul class='selectpop_radio'>";
						
						for(var i=0 ; i < list.length; i++) {
							if(exceptionCategory(list[i]["ctg_seq"])) {
								//if(ctg == list[i]["ctg_seq"]) {
								if(i == 0) {
									selectedArea = list[i]["ctg_nm"];
									tag = tag + "				<li><a href='#' onClick='fn_searchGoodsCtg2(\""+list[i]["ctg_seq"]+"\",\""+list[i]["ctg_nm"]+"\");'  class=''><span class='radiobox ctgRadio2 on'><input type='radio' name='ctg2' class='ctg3' id='ctg_"+ list[i]["ctg_seq"] +"' checked='checked' value='"+list[i]["ctg_seq"]+"' onClick='fn_searchGoodsCtg2(\""+list[i]["ctg_seq"]+"\",\""+list[i]["ctg_nm"]+"\")'></span><label for='"+list[i]["ctg_seq"]+"'>"+ selectedArea + "</label></a></li>";
								
									tag_ctg_depth3 = list[i]["ctg_nm"];
									
									firCtgCode = list[i]["ctg_seq"];
									firCtgName = list[i]["ctg_nm"];
								
									// -------------------------------------------
									// 화면 카테고리 2 DEPTH 표시 
									// -------------------------------------------
									/**
									$("input:radio[name='ctg']:radio[value='"+ list[i]["ctg_upr_seq"] +"']").attr("checked",true).checkboxradio("refresh");	
									var selectedArea = $('label[for=' + list[i]["ctg_upr_seq"]+ ']').text();
									$("#ctg_depth2").html(selectedArea);								
									**/
									// console.log(text);

								} else {
									selectedArea = list[i]["ctg_nm"];
									tag = tag + "				<li><a href='#' onClick='fn_searchGoodsCtg2(\""+list[i]["ctg_seq"]+"\",\""+list[i]["ctg_nm"]+"\");'  class='' ><span class='radiobox ctgRadio2'><input type='radio' name='ctg2' class='ctg3' id='ctg_"+ list[i]["ctg_seq"] +"' value='"+list[i]["ctg_seq"]+"' onClick='fn_searchGoodsCtg2(\""+list[i]["ctg_seq"]+"\",\""+list[i]["ctg_nm"]+"\")'></span><label for='"+list[i]["ctg_seq"]+"'>"+ selectedArea + "</label></a></li>";
		
									// $("#ctg_depth3").html(list[0]["ctg_nm"]);
									if(ctg < 5748 && ctg >  5760) {
										tag_ctg_depth3 = "선택";
									}
								}
							}
						}

						if(tag_ctg_depth3 == '') {
							tag_ctg_depth3 = list[0]["ctg_nm"];
						}

						tag = tag + "					</ul>";
						tag = tag + "				</div>";										
						tag = tag + "			</div>";
						tag = tag + "	</div>";
						tag = tag + " </div>";
						// console.log(tag);

						// -------------------------------------------
						// 화면 카테고리 3 DEPTH 표시 
						// -------------------------------------------	
						$("#ctg_depth3").html(tag_ctg_depth3);

						$("#popupGoodsCtg2").html(tag);
					} else {
						// alert("상품 카테고리 정보가 검색되지 않습니다.");
					}
				},
				error:function(err){
					console.log(err);
				},
				complete:function(){
					$(".layerPopup2").trigger('create');
					//$("#ctg2").checkboxradio("refresh");
					
					fn_searchGoodsCtg2(firCtgCode, firCtgName);
				}
			});
		}

		// <!-- 상품 카테고리 리스트 조회 -->
		function fn_searchGoodsCtg2(ctg_val, ctg_nm) {			
			curr_ctg = ctg_val;
			ctg = ctg_val;
			
			console.log("ctg_val : "+ctg_val);
			console.log("ctg_nm : "+ctg_nm);
			
			$(".ctgRadio2").removeClass('on');
			$(".ctg2").removeAttr("checked").checkboxradio("refresh");
			$("#ctg_"+ ctg_val).parent().parent().addClass('on');
			$("#ctg_"+ ctg_val).prop("checked", true).checkboxradio("refresh");

			// -------------------------------------------
			// 화면 카테고리 3 DEPTH 표시 
			// -------------------------------------------
			setTimeout(function(){
				jQuery("html, body").css({"overflow":"auto"});
				jQuery(".layerPopup2").hide();
				
				//ctg_upr_seq : 5747 ctg_val : 6548
				
				$("#ctg_depth3").html(ctg_nm);		
				 console.log("request.getRequestURI() : " + "<%=request.getRequestURI()%>");
	
				<%
						if(request.getRequestURI().endsWith("/goods/list.jsp")) {
				%>
							if(ctg==6548){
								document.location.href = "/goods/list.do?ctg=" + ctg + "&orderby=01";
							}else{
								fn_search();
							}
							

				<%
						} else if(request.getRequestURI().endsWith("/goods/list_golf.jsp")) {
				%>							
							fn_golf_search();
				<%
						} else {
				%>
							fn_goList();
				<%
						}
				%>
			}, 10);
		}	
		
		// 상품 리스트 화면으로 이동 
		function fn_go_golf_List() {
			console.log(">>>>>>>>>>>>>>>>>> 1111go list >>>>>>>>>>>>>>>>>>>>>>>>>>");
			
			document.location.href = "/goods/list.do?ctg=" + ctg + "&orderby=01";
		}
		// 상품 리스트 화면으로 이동 
		function fn_golf_search() {
			console.log(">>>>>>>>>>>>>>>>>> 2222go list >>>>>>>>>>>>>>>>>>>>>>>>>>");
			
			document.location.href = "/goods/list.do?ctg=" + ctg + "&orderby=01";
		}
		
		

		// <!-- 국내여행 및 골프 및 허니문 카테고리 조회 관련 예외사항 -->
		
		function exceptionCategory(ctg) {
			/**
			var ctgArray = [5809,6119,6121,6122,6123,6124,6125,6126,6294,5767,6296,6264,6282];
			var idx = 0;
			for (idx = 0; idx < ctgArray.length; idx++) {
				if(ctg == ctgArray[idx]) {
					return false;
				}
			}
			**/
			return true;
		}	
			
//-->
</script>

<!-- 상품 카테고리 DEPTH2 레이어 영역 -->
<div id="popupGoodsCtg"></div>

<!-- 상품 카테고리 DEPTH3 레이어 영역 -->
<div id="popupGoodsCtg2"></div>		  