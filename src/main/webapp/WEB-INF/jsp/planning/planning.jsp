<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
<script type="text/javascript">
	var list = null;
	var pageSize = 10;
	var totalSize = 0;
	
	$(document).ready(function() {
		fn_srchPlanList();
	});

	$(function() {
		$('.more').on("click", function(){
			fn_morePlanList();
		});

	});

	//기획전 선택 조회
	var fn_srchPlanList = function() {

		var startRow = 1;
		var endRow = 10;
		
		var formData = new FormData();
		formData.append('startRow', startRow);
		formData.append('endRow', endRow);
		formData.append("dispYn", "Y");
		formData.append("optionYn" ,"Y")

		$('.more').hide();

		cfn_ajax({
			type : "POST",
			async : false,
			url: "/planning/selListPlanAjax.do" ,
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "yes",
			timeOut : 5 * 60 * 1000,
			success: function(data) {
				list = data.list;
				
				totalSize = data.totalcnt;
				
				fn_dataClear();
				var cdnm;
				var plliindex;
				for(var i=0; i < list.length; i++) {
					
					if(list[i]["bigImgPh"] == null) list[i]["bigImgPh"] = "";
					cdnm = list[i]["cdNm"];
					deli = i+1;
					
					//var detailImgUrl = "http://www.lottejtb.com/upload/common/plan/" + list[i]["goodsTypeCd"] + "/" + list[i]["bigImgPh"];
					var detailImgUrl = "/m_file/upload/common/plan/" + list[i]["goodsTypeCd"] + "/" + list[i]["bigImgPh"];
					
					$('#planning').append("<li>" +
										 "<a href='javascript:gotoDetailPlan("+ list[i]["planSeq"] +")'> " +
										"<span class='img' style=\"background-image:url('" + list[i]["thnPath"] + "')\" /></span>" +  
										"<span class='purple'>" + cdnm + "</span>" + 
										"<h3>" + list[i]["planNm"] + "</h3>" + 
										"<em>" + list[i]["planFrday"] + "~" + list[i]["planToday"] + "</em>" +
										"</a></li>");
					
					if(cdnm == null || cdnm =='') $('#planning li:nth-child('+deli+') .purple').hide();  
				 };
				 //$('#planning').listview().listview('refresh').trigger('create');
				 console.log(list);
			},
			error : function(err) {
				alert("조회된 결과가 없습니다.");
				console.log(err);
			},
			complete : function(e) {
				console.log(e);
			}
			
		});
		
	};	
	
	//기획전 더보기		
	var fn_morePlanList = function() {
		var thisSize;
		
		var curRow = $('#planning').find("li").size();
		startRow = curRow + 1;
		endRow = curRow + Number(pageSize);
		thisSize = totalSize;
				
		var formData = new FormData();
		formData.append("startRow", startRow);
		formData.append("endRow", endRow);
		
		if(startRow > thisSize) {
			alert("더이상 등록된 기획전이 없습니다.");
			return false;
		}
		
		cfn_ajax({
			type : "POST",
			async : false,
			url: "/planning/morePlanListAjax.do",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "no",
			timeOut : 5 * 60 * 1000,
			success: function(data) {
				list = data.list;
				
				//fn_dataClear();
				
				for(var i = 0; i < list.length; i++) {
					
					$('#planning').append("<li>" +
											 "<a href='javascript:gotoDetailPlan("+ list[i]["planSeq"] + ")'> " +
													"<span class='img'><img src= '" + list[i]["thnPath"] + "' + alt='' /></span>" +  
													"<span class='purple'>" + list[i]["cdNm"] + "</span>" + 
													"<h3>" + list[i]["planNm"] + "</h3>" + 
													"<em>" + list[i]["planFrday"] + "~" + list[i]["planToday"] + "</em>" +
											  "</a>" +
										   "</li>"
										   );
			  	 };
			  	 //$('#planning').listview().listview('refresh').trigger('create');
			},
			error : function(err) {
				alert("조회된 결과가 없습니다.");
				console.log(err);
			},
			done : function(e) {
				console.log(e);
			}
			
		});
		
	};	
	
	function fn_dataClear() {
		$('#planning').empty();
		$('.more').show();
	}
	
	function gotoDetailPlan(planSeq,planNm,planS,planE,planImgUrl,templeteCd) {
		//document.location.href = "/planning/planning_detail.do?plan_seq=" + planSeq + "&plan_nm=" + planNm + "&plan_s=" + planS + "&plan_e=" + planE + "&img_url=" + planImgUrl + "&templeteCd=" + templeteCd;
		document.location.href = "/planning/planning_detail.do?plan_seq=" + planSeq;
	};	
</script>
</head>
<body>
<body>

	<!--content-->    
	<div role="main" class="ui-content contentWrap planning2">
	 <div class="nav navstitle">기획전</div>
	  
	   		<div class="listContent mgT10">
		 <ul data-role="listView" class="img" id="planning">
		  </ul>
		</div>
		 <div class="more"><i class="fa fa-angle-down fa-2x"></i>더보기</a></div>
			
			<!--bottom-->
			<script src="/resources/common/bottom.js"></script>
			<!--bottom-->		 
	  </div><!--//contentWrap End-->
	<!--//content-->
</body>
