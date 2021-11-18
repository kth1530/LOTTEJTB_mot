<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
<script src="/resources/common/js/utils.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var cust_cd = '${cust_cd}';
		console.log("cust_cd : " + cust_cd);
		
		if(cust_cd != '' && fn_chkLogin() == 1){
			var frmGoodsDetail = document.frmGoodsDetail;
			var formData = new FormData();
			formData.append("goods_cd", goodsCd);
			formData.append("event_cd", eventCd);
			formData.append("cust_cd", cust_cd);
			formData.append("start_day", start_day);
			formData.append("ctg_seq", ctg);
			
			cfn_ajax({
				url: "<c:url value='/goods/saveGoodsCart.do'  />",
				type: "POST",
				data: formData,
				async: false,
				dataType: "json",
				cache: false,
				noloading:false,
				timeOut: (5*60*1000),
				success: function(res) {					
					var saveCnt = res["saveCnt"];

					if(saveCnt > 0) {
						// alert("등록되었습니다.");
					}
				},
				error:function(err){
					console.log(err);
					alert("등록에 실패하였습니다.");
					
					$("html, body").css({"overflow":"auto"});
					if($(".layerPopup").size()){
						$(".layerPopup").remove();                 
					};
				},
				complete:function(){
				}
			});
		}else{
			$("html, body").css({"overflow":"auto"});
			if($(".layerPopup").size()){
				$(".layerPopup").remove();                 
			};
			
			fn_goLogin();
		}
	});
	
	var fn_moveMytour = function(){
		$("html, body").css({"overflow":"auto"});
		if($(".layerPopup").size()){
			$(".layerPopup").remove();                 
		};
		
		document.location.href="/mytour/mytour.do#tab2";
	}
</script>
</head>
<body>
	<div class="layerPopup">
	    <div class="layerPop">
			<!-- 내용시작 -->
	        <div class="popCon">
				<div class="popHead">
					<div class="popTpart">
						<strong class="popTitle">찜하기</strong>
						<button type="button" class="layerClose"><img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기"></button>
					</div>
				</div>
				<div class="cntain" style="text-align:center;box-sizing:border-box;">
					<p style="font-size:11pt;margin:1em 0;">선택한 여행상품을 찜하기에 담았습니다.</p>
					<span style="font-size:11pt;">찜!여행상품 목록에서 확인하시겠습니까?</span>
				</div>
			</div>
			<!-- 내용끝 -->
			<div class="popFoot pf2">
				<div class="layerBtns"><button type="button" class="layerClose1 layerClose">계속여행</button></div>
				<div class="layerBtns"><button type="button" class="layerClose2" onclick="fn_moveMytour()">목록확인</button></div>
			</div>
	    </div>
	</div>
</body>