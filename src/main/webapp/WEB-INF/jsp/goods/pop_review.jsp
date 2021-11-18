<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : pop_review.jsp
	// 설명 : 상품평 작성

	String ctg = (String) request.getAttribute("ctg");
	String goodsCd = (String) request.getAttribute("goodsCd");
	String eventCd = (String) request.getAttribute("eventCd");
	String goodsNm = (String) request.getAttribute("goodsNm");

%>

<script src="/resources/common/js/utils.js"></script>
<script>
<!--
	var myReviewCnt = 0; // 내가 남긴 상품평 갯수 
	var eval_avg = 0; // 평점 
	var knm = "${knm}";
	var cust_cd = "${cust_cd}";
	var email = "${email}";

	// 초기화
	var fn_init = function() {
		$('#eval_title').focus();
		// srchMyReviewCount();
	};
	

	var fn_search = function(){
		
	};
	
			
	// 버튼 초기화
	var fn_initButton = function() {
	
	};

	function check_param() {

		var eval_title = $('#eval_title').val();
		var eval_cnts = $('#eval_cnts').val();

		var score1 = $('#score1').hasClass("on");
		var score2 = $('#score2').hasClass("on");
		var score3 = $('#score3').hasClass("on");
		var score4 = $('#score4').hasClass("on");
		var score5 = $('#score5').hasClass("on");

		console.log("score1 >>>> " + score1);
		console.log("score2 >>>> " + score2);
		console.log("score3 >>>> " + score3);
		console.log("score4 >>>> " + score4);
		console.log("score5 >>>> " + score5);
		
		if(eval_title == null || eval_title == "") {
			alert("제목을 입력해 주세요.");
			$('#eval_title').focus();
			
			return false;
		}

		if(eval_cnts == null || eval_cnts == "") {
			alert("상품평 내용을 입력해 주세요.");
			$('#eval_cnts').focus();
			
			return false;
		}


		if(score1 == false && score2 == false && score3 == false && score4 == false && score5 == false) {
			alert("점수를 선택해 주세요.");

			return false;
		}

		if(srchMyReviewCount() > 0) {
				alert("상품평은 동일 상품에 대하여 기간에 상관없이 1회만 작성 가능합니다.");
				return false;
		}

		return true;
	}
	

	// 내가 등록한 상품평 갯수 조회 
	function srchMyReviewCount()  {
		myReviewCnt = 0;
		
		var goods_cd = "<%=goodsCd%>";
		var formData = new FormData();

		formData.append("cust_cd", cust_cd);
		formData.append("goods_cd", goods_cd);

		cfn_ajax({
			url: "/goods/srchMyReviewCountAjax.do",
			type: "POST",
			data: formData,
			async: false,
			dataType: "json",
			cache: false,
			noloading:"no",
			timeOut: (5*60*1000),
			success: function(res) {		
				myReviewCnt = res.saveCnt;
				console.log(" >>>>>>>>>>>>>>>>>>>>>>>>> myReviewCnt : " + myReviewCnt);

			},
			error:function(err){
				console.log(err);
			},
			complete:function(){
			}
		});
		
		return myReviewCnt;
		
	};

	// 상품평 등록 
	var saveReview = function() {
		// 미 로그인 시 
		/**
		if(fn_chkLogin() == 1) {
			var cust_id = fn_getCookieLogin();
		**/	

			var ctg = "<%=ctg%>";
			var event_cd = "<%=eventCd%>";
			var goods_cd = "<%=goodsCd%>";
			var goods_nm = "<%=goodsNm%>";
			var cust_nm = knm;
			


			var eval_title = $('#eval_title').val(); 
			var eval_cnts = $('#eval_cnts').val(); 
			var eval_avg = 0;

			var score1 = $('#score1').hasClass("on");
			var score2 = $('#score2').hasClass("on");
			var score3 = $('#score3').hasClass("on");
			var score4 = $('#score4').hasClass("on");
			var score5 = $('#score5').hasClass("on");

			console.log("score1 >>>> " + score1);
			console.log("score2 >>>> " + score2);
			console.log("score3 >>>> " + score3);
			console.log("score4 >>>> " + score4);
			console.log("score5 >>>> " + score5);
			
			if(score1 == true) {
				eval_avg = eval_avg + 20;
			}

			if(score2 == true) {
				eval_avg = eval_avg + 20;
			}

			if(score3 == true) {
				eval_avg = eval_avg + 20;
			}

			if(score4 == true) {
				eval_avg = eval_avg + 20;
			}

			if(score5 == true) {
				eval_avg = eval_avg + 20;
			}

			


			// 파라미터 값이 유효할 때 
			if(check_param()) {

				var formData = new FormData();

				formData.append("cust_cd", cust_cd);
				formData.append("cust_nm", cust_nm);

				formData.append("ctg", ctg);
				formData.append("event_cd", event_cd);
				formData.append("goods_cd", goods_cd);
				formData.append("goods_nm", goods_nm);

				formData.append("eval_title", eval_title);
				formData.append("eval_cnts", eval_cnts);
				formData.append("eval_avg", eval_avg);

				cfn_ajax({
					url: "/goods/saveGoodsReviewAjax.do",
					type: "POST",
					data: formData,
					async: false,
					dataType: "json",
					cache: false,
					noloading:"no",
					timeOut: (5*60*1000),
					success: function(res) {		

						alert("상품평이 등록되었습니다.");
					
					},
					error:function(err){
						console.log(err);
					},
					complete:function(){
						// window.close();
						// history.back(1);
						fn_ReviewList();
						closePopup();
					}
				});
			}
			
		/**	
		} else {
			history.back(-1);
		}
		**/
	};


	function closePopup() {
		jQuery("html, body").css({"overflow":"auto"});
		if(jQuery(".layerPopup").size()){
			jQuery(".layerPopup").remove();                 
		};              
		opener.focus();		
	}
	
	function fn_close() {
		window.close();
        window.opener.location.reload();
	}
	// [COMMON] 공통사항 
	$(document).ready(function(){
		fn_init();
		fn_initButton();

		/*document.addEventListener("deviceready", function(){
		fn_init();
		fn_initButton();					
		}, false);*/
	});


//-->
</script>

<div class="layerPopup">
    <div class="layerPop" id="commentPop">
			<!-- 내용시작 -->
	        <div class="popCon">
				<div class="popHead">
					<div class="popTpart">
						<strong class="popTitle">상품평 작성하기</strong>
						<button type="button" class="layerClose" onClick="fn_close()"><img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기" onClick="fn_close()"></button>
					</div>
				</div>
				<div class="cntain">
					<div class="review" >	
						<table>
							<tr>
								<td><input type="text" name="eval_title" id="eval_title" value=""  placeholder="제목을 입력하세요" data-theme="a"></td>
							</tr>
							<tr>
								<td><span class="rating2"><em id="score1" name="score1">★</em><em id="score2" name="score2">★</em><em id="score3" name="score3">★</em><em id="score4" name="score4">★</em><em id="score5" name="score5">★</em></span></td>
							</tr>				
							<tr>					
								<td><textarea name="eval_cnts" id="eval_cnts" placeholder="상품평 취지에 어긋난 상품명,업체와 일방적인 업체 비방글,음란/욕설 등 부적절한 내용의 글, 타여행사와 비교등의 상품평은 통보없이 임의 비전시처리 될 수 있습니다." data-theme="a"></textarea></td>
							</tr>
						</table>
						<p>상품평은 동일 상품에 대하여 기간에 상관없이 1회만 작성 가능합니다.</p>
					</div>
				</div>
			</div>
			<!-- 내용끝 -->
			<div class="popFoot">
				<div class="layerBtns"><button type="button" onClick="saveReview()"  class="layerClose1">상품평 저장</button></div>
			</div>
    </div>
</div>
