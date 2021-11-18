<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : qna_list.jsp
	// 설명 : 자유여행 문의하기 리스트 
%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="expires" content="-1">
	<meta name="robots" content="all">
	<meta name="keywords" content="">
	<script src="/resources/common/js/UserAgent.js"></script>
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	<title>롯데홀리데이</title>
	<link rel="stylesheet" href="/resources/common/css/common.css">
	<link rel="stylesheet" href="/resources/common/css/common2.css">
	<link rel="shortcut icon" type="image/x-icon" href="/resources/common/css/lottejtb.ico">
	<script src="/resources/common/js/jquery-latest.min.js"></script>
	<script src="/resources/common/js/common.js"></script>
	<script src="/resources/common/js/common2.js"></script>
	<script src="/resources/common/js/swiper.js"></script>
	<script src="/resources/common/js/library/jquery.anchor.js"></script>
	<script src="/resources/common/js/common_decorator.js"></script>
	<script src="/resources/common/js/common_decorator2.js"></script>
	<script src="/resources/common/js/utils.js"></script>
	<script type="text/javascript">
	
	
	
	
	 function fn_childView() {
	 	jQuery(function(){
			var bodyh = jQuery(document).height();
			jQuery(".popCon").css({"height":bodyh+"px"});

			/* 자유여행 문의 */	
			jQuery(".pop_qna_list li .qna_box").on("click",function(){
				if(jQuery(this).parent().hasClass("on")==false){
					jQuery(".pop_qna_list li").removeClass("on");
				};
				jQuery(this).parent().toggleClass("on");
			});
		}); 
	 }

		var totalSize = 10;
		var counselList;
		var pageSize = 10;
		var curRow = 0;
		var type = "";

		// 초기화
		var fn_init = function() {
			fn_CounselList();
		};

		// 버튼 초기화
		var fn_initButton = function() {

		};

	

		/* *************************************************************************** */
		// [Ajax] 데이터 통신 부분 
		// 문의하기 리스트 조회  
		var fn_CounselList = function() {

			var formData = new FormData();
			formData.append("startRow", 1);
			formData.append("endRow", pageSize);
			formData.append("userID", '${cust_cd}');

			cfn_ajax({
				url: "/mytour/counselListAjax.do",
				type: "POST",
				data: formData,
				async: false,
				dataType: "json",
				cache: false,
				noloading: "no",
				timeOut: (5 * 60 * 1000),
				success: function(res) {
					counselList = res.list;
					curRow = counselList.length;
					
					var html = "";
					for(var i=0; i < counselList.length; i++) {
						
						html = html + "				<li>";
						html = html + "					<div class='qna_box'>";
						html = html + "						<p class='qna_title1'>"+counselList[i].title+"</p>";
						html = html + "						<p class='qna_date'>";
						html = html + "							"+counselList[i].reg_DTT+"";
						if(counselList[i].answ != null) {
							html = html + "							<span class='purple2'>답변완료</span>";
						} else {
							html = html + "							<span class='gray2'>미답변</span>";
						}
						html = html + "						</p>";
						html = html + "					</div>";
						if(counselList[i].answ != null) {
							html = html + "					<div class='qna_qabox'>";
							html = html + "						<div class='qna_qbox'>";
							// 문의분류1 &lt; 문의분류2 &lt; 문의분류3
							html = html + "							<p class='qna_alist'>"+counselList[i].assort_CD+"</p>";
							html = html + "							<p class='qna_atext'>"+counselList[i].answ+"</p>";
							html = html + "						</div>";
							
							html = html + "						<div class='qna_abox'>";
							html = html + "							<p class='qna_qlist'>답변안내</p>";
							html = html + "							<p class='qna_qtext'>"+counselList[i].answ+"</p>";
							html = html + "						</div>";
							
							html = html + "					</div>";
						}
						html = html + "				</li>";

						
					}
					$("#counselList").html(html);
					
					fn_childView();
					
				},
				error: function(err) {
					//console.log(err);
				},
				complete: function() {
					fn_CounselListCount();
				}
			});

		};
		

		var fn_MoreCounselList = function() {
			// 페이지 계산
			if(type == "new"){
				// $(".goodsList").empty();
				
				startRow = 1;
				endRow = pageSize;	
								
			}else{
			
			
				startRow = curRow + 1;
				endRow = curRow + Number(pageSize);
			
			}
			
			if(type != "new"){
				if(startRow > totalSize) {
					// alert("더이상 등록된 상품이 없습니다");
					return;
				}
			}


			var formData = new FormData();
			formData.append("startRow", startRow);
			formData.append("endRow", endRow);
			formData.append("userID", '${cust_cd}');

			cfn_ajax({
				url: "/mytour/counselListAjax.do",
				type: "POST",
				data: formData,
				async: false,
				dataType: "json",
				cache: false,
				noloading: "no",
				timeOut: (5 * 60 * 1000),
				success: function(res) {
					counselList = res.list;
					
					var html = "";
					curRow = curRow + counselList.length;
					for(var i=0; i < counselList.length; i++) {
						
						html = html + "				<li>";
						html = html + "					<div class='qna_box'>";
						html = html + "						<p class='qna_title1'>"+counselList[i].title+"</p>";
						html = html + "						<p class='qna_date'>";
						html = html + "							"+counselList[i].reg_DTT+"";
						if(counselList[i].answ != null) {
							html = html + "							<span class='purple2'>답변완료</span>";
						} else {
							html = html + "							<span class='gray2'>미답변</span>";
						}
						html = html + "						</p>";
						html = html + "					</div>";
						if(counselList[i].answ != null) {
							html = html + "					<div class='qna_qabox'>";
							html = html + "						<div class='qna_qbox'>";
							// 문의분류1 &lt; 문의분류2 &lt; 문의분류3
							html = html + "							<p class='qna_alist'>"+counselList[i].assort_CD+"</p>";
							html = html + "							<p class='qna_atext'>"+counselList[i].answ+"</p>";
							html = html + "						</div>";
							
							html = html + "						<div class='qna_abox'>";
							html = html + "							<p class='qna_qlist'>답변안내</p>";
							html = html + "							<p class='qna_qtext'>"+counselList[i].answ+"</p>";
							html = html + "						</div>";
							
							html = html + "					</div>";
						}
						html = html + "				</li>";

						$("#counselList").append(html);
						
						fn_childView();
					}

					
				},
				error: function(err) {
					//console.log(err);
				},
				complete: function() {
					fn_CounselListCount();
				}
			});

		};

		// 문의하기 리스트 카운트 수 조회 
		function fn_CounselListCount(){

			var formData = new FormData();
			formData.append("userID", '${cust_cd}');
			
			cfn_ajax({
				url: "/mytour/counselListCountAjax.do",
				type: "POST",
				data: formData,
				async: false,
				dataType: "json",
				cache: false,
				noloading: "no",
				timeOut: (5 * 60 * 1000),
				success: function(res) {
					
					totalSize = res.totalSize;
					
				},
				error:function(err){
					console.log(err);
				},
				complete:function(){
					fn_displayMoreBtn();
				}
			});
		};

		// 더보기 버튼 노출 관련 
		function fn_displayMoreBtn() {
			console.log("================ 목록 수 체크 ===================");
			console.log("totalSize : " +  totalSize);
			console.log("curRow : " +  curRow);
			console.log("================ 목록 수 체크 ===================");


			// 상품 목록 더보기 
			if(curRow < totalSize) {
					document.all.btn_more.style.display="";
			}	else {
					document.all.btn_more.style.display="none";
			}				
		}


		// [COMMON] 공통사항 
		$(document).ready(function() {
			fn_init();
			fn_initButton();

		});
	
	</script>
</head>
<body>
<div class="lypopview">
    <div class="layerPop10">
		<!-- 내용시작 -->
		<div class="popCon">
			<div class="popHead">
				<div class="popTpart">
					<strong class="popTitle">자유여행 문의하기</strong>
					<button type="button" class="layerClose10" onclick="history.back();">
						<img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기">
					</button>
				</div>
			</div>
			<div class='cntain cntain3 pop_qna_box'>
				
				<ul class='pop_qna_list' id='counselList' name='counselList'>
					
					<li>
						<div class='qna_box'>
							<p class='qna_atext' align="center">문의 내용이 없습니다.</p>
						</div>

					</li>

				</ul>

				<div class='btn_one qna_more_btn' id="btn_more" name="btn_more">
					<button class='white2 moreico' data-role='none' onClick="fn_MoreCounselList()">더보기</button>
				</div>
				<div class='pop_btn_one mt7'>
					<button class='purple2 layerOpener'
						data-url='/mytour/pop_qna_write.do' data-ctn='full' data-ok='yes'
						data-role='none'>작성하기</button>
				</div>
			</div>
		</div>
   </div>
</div>
</body>
</html>