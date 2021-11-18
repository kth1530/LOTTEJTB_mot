$(document).ready(function () {


/**************** Lotte JTB 20161116 ************/
jQuery("li.sns .snsLink").on("click", function(){
	jQuery(".sns nav").show();
	jQuery("li.sns .blinds").show();
	jQuery("body,.ui-mobile").css({"overflow":"hidden"})
});
jQuery("li.sns .blinds, .containerT a:last-child").on("click", function(){
	jQuery(".sns nav").hide();
	jQuery("li.sns .blinds").hide();
	jQuery("body,.ui-mobile").css({"overflow":"auto"})
});

jQuery(".allopenbtn1,.allopenbtn2,.allopenbtn3").on("click", function(){
	if(jQuery(this).hasClass("allopenbtn1")==true){
		var parentnum1 = jQuery(this).parent().next();
		if(jQuery(this).text()=="모두펼침"){
			jQuery(this).text("모두닫힘");
			parentnum1.find(".ui-collapsible").removeClass("ui-collapsible-collapsed");
			parentnum1.find("h1.ui-nodisc-icon").removeClass("ui-collapsible-heading-collapsed");
			parentnum1.find("a.ui-collapsible-heading-toggle").addClass("ui-icon-minus");
			parentnum1.find("a.ui-collapsible-heading-toggle").removeClass("ui-icon-plus");
			parentnum1.find(".ui-collapsible-content").removeClass("ui-collapsible-content-collapsed");
			parentnum1.find(".ui-collapsible-content").attr("aria-hidden","false");
		}else{
			jQuery(this).text("모두펼침");		
			parentnum1.find(".ui-collapsible").addClass("ui-collapsible-collapsed");
			parentnum1.find("h1.ui-nodisc-icon").addClass("ui-collapsible-heading-collapsed");
			parentnum1.find("a.ui-collapsible-heading-toggle").removeClass("ui-icon-minus");
			parentnum1.find("a.ui-collapsible-heading-toggle").addClass("ui-icon-plus");
			parentnum1.find(".ui-collapsible-content").addClass("ui-collapsible-content-collapsed");
			parentnum1.find(".ui-collapsible-content").attr("aria-hidden","true");
		}
	}
	if(jQuery(this).hasClass("allopenbtn2")==true){
		var parentnum2 = jQuery(this).parent().parent();
		if(jQuery(this).text()=="모두펼침"){
			jQuery(this).text("모두닫힘");
			parentnum2.find(".ui-collapsible").removeClass("ui-collapsible-collapsed");
			parentnum2.find("h1.ui-nodisc-icon").removeClass("ui-collapsible-heading-collapsed");
			parentnum2.find("a.ui-collapsible-heading-toggle").addClass("ui-icon-minus");
			parentnum2.find("a.ui-collapsible-heading-toggle").removeClass("ui-icon-plus");
			parentnum2.find(".ui-collapsible-content").removeClass("ui-collapsible-content-collapsed");
			parentnum2.find(".ui-collapsible-content").attr("aria-hidden","false");
		}else{
			jQuery(this).text("모두펼침");		
			parentnum2.find(".ui-collapsible").addClass("ui-collapsible-collapsed");
			parentnum2.find("h1.ui-nodisc-icon").addClass("ui-collapsible-heading-collapsed");
			parentnum2.find("a.ui-collapsible-heading-toggle").removeClass("ui-icon-minus");
			parentnum2.find("a.ui-collapsible-heading-toggle").addClass("ui-icon-plus");
			parentnum2.find(".ui-collapsible-content").addClass("ui-collapsible-content-collapsed");
			parentnum2.find(".ui-collapsible-content").attr("aria-hidden","true");
		}
	}
	if(jQuery(this).hasClass("allopenbtn3")==true){
		var parentnum2 = jQuery(this).parent().parent().parent();
		if(jQuery(this).text()=="모두펼침"){
			jQuery(this).text("모두닫힘");
			parentnum2.find(".ui-collapsible").removeClass("ui-collapsible-collapsed");
			parentnum2.find("h1.ui-nodisc-icon").removeClass("ui-collapsible-heading-collapsed");
			parentnum2.find("a.ui-collapsible-heading-toggle").addClass("ui-icon-minus");
			parentnum2.find("a.ui-collapsible-heading-toggle").removeClass("ui-icon-plus");
			parentnum2.find(".ui-collapsible-content").removeClass("ui-collapsible-content-collapsed");
			parentnum2.find(".ui-collapsible-content").attr("aria-hidden","false");
		}else{
			jQuery(this).text("모두펼침");		
			parentnum2.find(".ui-collapsible").addClass("ui-collapsible-collapsed");
			parentnum2.find("h1.ui-nodisc-icon").addClass("ui-collapsible-heading-collapsed");
			parentnum2.find("a.ui-collapsible-heading-toggle").removeClass("ui-icon-minus");
			parentnum2.find("a.ui-collapsible-heading-toggle").addClass("ui-icon-plus");
			parentnum2.find(".ui-collapsible-content").addClass("ui-collapsible-content-collapsed");
			parentnum2.find(".ui-collapsible-content").attr("aria-hidden","true");
		}
	}
});
jQuery(".allopenbtn10").on("click", function(){
	var parentnum10 = jQuery(this).parent().parent().parent();
	if(jQuery(this).text()=="모두닫힘"){
		jQuery(this).text("모두펼침");
		parentnum10.find(".ui-collapsible").addClass("ui-collapsible-collapsed");
		parentnum10.find("h1.ui-nodisc-icon").addClass("ui-collapsible-heading-collapsed");
		parentnum10.find("a.ui-collapsible-heading-toggle").removeClass("ui-icon-minus");
		parentnum10.find("a.ui-collapsible-heading-toggle").addClass("ui-icon-plus");
		parentnum10.find(".ui-collapsible-content").addClass("ui-collapsible-content-collapsed");
		parentnum10.find(".ui-collapsible-content").attr("aria-hidden","true");
	}else{
		jQuery(this).text("모두닫힘");		
		parentnum10.find(".ui-collapsible").removeClass("ui-collapsible-collapsed");
		parentnum10.find("h1.ui-nodisc-icon").removeClass("ui-collapsible-heading-collapsed");
		parentnum10.find("a.ui-collapsible-heading-toggle").addClass("ui-icon-minus");
		parentnum10.find("a.ui-collapsible-heading-toggle").removeClass("ui-icon-plus");
		parentnum10.find(".ui-collapsible-content").removeClass("ui-collapsible-content-collapsed");
		parentnum10.find(".ui-collapsible-content").attr("aria-hidden","false");
	};
});
// 상단 고정탭 스크롤액션
setTimeout(function(){ 
	var scrpos1h = jQuery(".scrpos1").height();
	var scrpos2h = jQuery(".scrpos2").height();
	var scrpos3h = jQuery(".scrpos3").height();

	if( jQuery("ul, div").hasClass("scrpos1")==true){
		if( jQuery("ul, div").hasClass("scrpos1")==true) var scrpos1pos = jQuery(".scrpos1").offset().top-60;
		if( jQuery("ul, div").hasClass("scrpos2")==true) var scrpos2pos = jQuery(".scrpos2").offset().top-60;
		if( jQuery("ul, div").hasClass("scrpos3")==true) var scrpos3pos = jQuery(".scrpos3").offset().top-60-scrpos2h;
		jQuery(window).on("scroll",function(){
			var nowpos =  jQuery(document).scrollTop();
			if(nowpos > scrpos1pos){
				jQuery(".scrpos1").css({"z-index":"10","position":"fixed","top":"99px","width":"100%"});
				jQuery(".scrpos1").parent().css({"padding-top":scrpos1h+"px"})
			}else{
				jQuery(".scrpos1").css({"z-index":"0","position":"relative","top":"0px"});
				jQuery(".scrpos1").parent().css({"padding-top":"0"})
			}
				
			if(nowpos > scrpos1pos){
				jQuery(".scrpos2").css({"z-index":"10","position":"fixed","top":(scrpos1h+99)+"px","width":"100%"});
				jQuery(".scrpos2").parent().css({"padding-top":scrpos2h+"px"})
			}else{
				jQuery(".scrpos2").css({"z-index":"0","position":"relative","top":"0px"});
				jQuery(".scrpos2").parent().css({"padding-top":"0"})
			}
			if(nowpos > scrpos3pos){
				jQuery(".scrpos3").css({"z-index":"10","position":"fixed","top":(scrpos2h+scrpos1h+99)+"px","border-bottom":"1px solid #666"});
				jQuery(".scrpos3").parent().css({"padding-top":scrpos3h+"px"})
			}else{
				 jQuery(".scrpos3").css({"z-index":"0","position":"relative","top":"0px","border-bottom":"0"});
				 jQuery(".scrpos3").parent().css({"padding-top":"0"})
			}
		});
	};
 }, 1000);
/* 상품상세 텝클릭시 이동 */
jQuery(".gsdetail .tab_navbar li a").on("click", function(){
	var tabpos = jQuery("[data-role=tabs]").offset().top;
	jQuery(document).scrollTop(tabpos-220);
});

	
/* Left Menu */
jQuery("div[style='height:39px'],iv[style='height:40px']").css({"height":"47px"})
jQuery(".lnb_tab").each(function(){
	jQuery(this).find("li a").on("click", function(){
		var ltClass = jQuery(this).parent().parent().attr("class");
		var ltlink_index = (jQuery(this).parent().index())+1;
		var number_ltClass = (ltClass.match(/[0-9]/gi))-1;
		var li_check = 3*number_ltClass+ltlink_index;
		jQuery(".lnb_tab,.lnb_tab > li").removeClass("on");
		if(jQuery(".lnb_tab_c").hasClass("lnb_tab_c"+li_check)==true){
			jQuery(this).parent().addClass("on");
			jQuery(this).parent().parent().addClass("on");
		}
		jQuery(".lnb_tab_c").hide();
		jQuery(".lnb_tab_c"+li_check).show();
		jQuery(".lnb_tab_c"+li_check).css({"border-bottom": "1px solid #d1d1d6"});
	});
});
/* categry menu */
jQuery(".ctgTopbtn li:nth-child(2) a").on("click",function(){
	if(jQuery(".categoryBox .nav").hasClass("ctgtopon")==false){
		jQuery(".categoryBox .nav").addClass("ctgtopon");
		jQuery(this).css({"background":"#fff"});
		jQuery(this).removeClass("ui-icon-plus");
		jQuery(this).addClass("ui-icon-minus");
	}else{
		jQuery(".categoryBox .nav").removeClass("ctgtopon");
		jQuery(this).css({"background":"transparent"});
		jQuery(this).addClass("ui-icon-plus");
		jQuery(this).removeClass("ui-icon-minus");
	}
});
jQuery(".ctgMenu div").each(function(){
	if(jQuery(this).hasClass("nodepth")==true){
		jQuery(this).find("h1").removeClass("ui-alt-icon");
	}
})
jQuery(".ctgMenu ul > li > a").on("click",function(){
	jQuery(".ctgMenu ul > li").removeClass("clear");
	var dep3z = (jQuery(this).parent().index())+1;
	if (dep3z % 2 == 0){
		jQuery(this).parent().next().addClass("clear");
	}else{
		jQuery(this).parent().next().next().addClass("clear");
	}
	jQuery(".ctgMenu ul > li").removeClass("on");
	jQuery(this).parent().addClass("on");
})
/* Main Tab */
jQuery(".faqh").on("tap",function(){
	var mindex2 = jQuery(this).find(".swiper-slide-active").attr("data-bh");
	jQuery(".faqhlist .swiper-slide").hide();
	jQuery(".faqhlist .swiper-slide:nth-child("+mindex2+")").show();
});
jQuery(".faqh div").on("click", function(){
	var mindex = jQuery(this).attr("data-bh");
	jQuery(".faqhlist .swiper-slide").hide();
	jQuery(".faqhlist .swiper-slide:nth-child("+mindex+")").show();
})
/* 약관동의 */
jQuery("#chkAll").on("change", function(){
	if(jQuery(this).prop("checked")== true){
		jQuery("input[type=checkbox]").prop("checked",true).checkboxradio("refresh");
	}else{
		jQuery("input[type=checkbox]").prop("checked",false).checkboxradio("refresh");
	}
});
/* 이전페이지 전용 */
jQuery(".bkmenu").on("click", function(){
	jQuery(this).parent().attr("href","javascript:history.back()");
});
/* fraem 높이 */
var webviewH = jQuery(window).height();
var headerH = jQuery("div[data-role=header]").height();
var depth1H = jQuery(".depth1").height();
var depth2H = jQuery(".domestic .scrpos1").height();
var footerH = jQuery("#foot").height();

var ifh = webviewH - 150;
jQuery("#ifname").css({"height":ifh+"px"});
/* 기획전 상세 */
var plsize = jQuery(".plannswp li").size();
if(plsize == 1) jQuery(".plannswp").addClass("planli1");
if(plsize == 2) jQuery(".plannswp").addClass("planli2");
if(plsize == 3) jQuery(".plannswp").addClass("planli3");
jQuery(".plannswp li a").on("click", function(){
	var plindex = jQuery(this).parent().index();
	
	jQuery(".planlist .swiper-slide").hide();
	jQuery(".planlist").find(".swiper-slide").eq(plindex).show();
});
/* 자주하는 질문 */
jQuery(".faqli li a").on("click", function(){
	var flindex = jQuery(this).parent().index();
	jQuery(".faqhlist .swiper-slide").hide();
	jQuery(".faqhlist").find(".swiper-slide").eq(flindex).show();
});
/* 레이어 팝업 */
var opener; 
function layerOpen(url,op,w,h,ok,ps,pa){
    $.ajax({
        type    : 'GET',
        url     : url,
		data    : pa,
        success    : function(html){
            //op.after(html);
            //opener = op;
			jQuery("body").append(html);
            var obj = jQuery(".layerPop"),                
                  wt = w,
                  ht = h;
            obj.parent().show();
			jQuery("html, body").css({"overflow":"hidden"});
			//jQuery("body").bind('touchmove', function(e){e.preventDefault()}); 아이폰 터치
			if(ps) obj.find(".cntain").addClass("cntain3");
			if(wt){
				if(ok){
					obj.find(".popTpart").width(wt);
					obj.find(".cntain").addClass("cntain2");
					obj.find(".popCon").height(ht-51).css({"overflow":"scroll","min-height":"auto","overflow-x":"hidden"})
					obj.width(wt).height(ht).css({"margin-top": (obj.height()/2)*-1+"px","margin-left": (obj.width()/2)*-1+"px"});
					if(ps) obj.find(".cntain").addClass("cntain4");
					obj.find(".alert_text").height(ht-105);
				}else{
					obj.find(".popFoot").hide();
					obj.find(".cntain").addClass("cntain2");
					obj.find(".popTpart").width(wt);
					obj.width(wt).height(ht).css({"margin-top": (obj.height()/2)*-1+"px","margin-left": (obj.width()/2)*-1+"px"});
					obj.find(".alert_text").height();
				};
			}else{
				if(ok){
					obj.find(".popFoot").addClass("posfd");
					obj.css({"width":"100%","left":"0","top":"0","margin":"0","height":"100%","position":"relative"});
					if(ps) obj.find(".cntain").addClass("cntain4");
				}else{
					obj.find(".popFoot").hide();
					obj.find(".cntain").addClass("cntain2");
					obj.css({"width":"100%","left":"0","top":"0","margin":"0","height":"100%","position":"relative"});
				};
			};
			
			/*
			common2.js 함수
			*/
			/* 상품평 */
			ratings();
			/* 아코디언 */
			acdon();
			/* 자유 텝공통 */
			tablist_com();
			/* 아코디언 (렌터카 선택확인) */
			lcacinfo();
			/* 자동완성 */
			autokey();
        }
    });
};
jQuery(document.body).on("click",".layerOpener",function(){
	var durl = jQuery(this).attr("data-url");
	var w = jQuery(this).attr("data-width");
	var h = jQuery(this).attr("data-height");
	var ok = jQuery(this).attr("data-ok");
	var ps = jQuery(this).attr("data-ctn");
	var para = durl.split('?');
	
	if(jQuery(this).hasClass('event_off')) {
		alert("이미 응모하셨습니다.");
		return false;
	}
		
	layerOpen(para[0],jQuery(this),w,h,ok,ps,para[1]);
	return false;
}).on("click",".layerClose",function(){
	layerClose();
	return false;
});
function layerClose(){
	//jQuery("body").unbind('touchmove'); 아이폰 터치
	jQuery("html, body").css({"overflow":"visible"});
	if(jQuery(".layerPopup").size()){
		jQuery(".layerPopup").remove();                 
	};              
	//opener.focus();
};

/* 레이어팝업 라디오 */
jQuery(document.body).on("click",".layerPopup .radiobox input",function(){
    var r_name = jQuery(this).attr("name");
    var parentBox = jQuery("input[name="+r_name+"]").parent();      
    parentBox.removeClass("on");
    jQuery(this).parent().addClass("on");
});
jQuery(document.body).on("click",".layerPopup .checkbox input",function(){
    jQuery(this).parent().toggleClass("on");        
});
/* 일반 라디오 */
jQuery(document.body).on("click",".event .radiobox input",function(){
    var r_name = jQuery(this).attr("name");
    var parentBox = jQuery("input[name="+r_name+"]").parent();      
    parentBox.removeClass("on");
    jQuery(this).parent().addClass("on");
});
jQuery(document.body).on("click",".event .checkbox input",function(){
    jQuery(this).parent().toggleClass("on");        
});

/*Add class when scroll down*/
jQuery(document).scroll(function(){
  	var scroll = jQuery(window).scrollTop();
    if (scroll >= 20) {
        jQuery(".go-top").addClass("show");
    } else {
        jQuery(".go-top").removeClass("show");
    }
     
});
jQuery(".go-top").click(function(){
    jQuery('body,html').animate({
      scrollTop: 0
    }, 250);
});


/*Animation anchor*/
$(".footop").click(function(){
    $('body,html').animate({
      scrollTop: 0
    }, 500);
});
/* 상품평 */
var ratings = function(){
	jQuery(".rating em").on("click", function(){
		jQuery(".rating em").removeClass("on");
		var stindex = jQuery(this).index();
		for(i=0; i<=stindex; i++){
			jQuery(".rating em").eq(i).addClass("on");
		}
	});
	jQuery(".rating2 em").on("click", function(){
		jQuery(".rating2 em").removeClass("on");
		var stindex = jQuery(this).index();
		for(i=0; i<=stindex; i++){
			jQuery(".rating2 em").eq(i).addClass("on");
		}
	});
};
$('[data-rel="popup"]').on('click', function(){
	$('.ui-mobile').css('overflow', 'hidden');	
});

$('[data-rel="back"]').on('click', function(){
	$('.ui-mobile').css('overflow', 'auto');	
});

/* 상품리스트 */
	window.master_init = function(){

		$(".nav").css("position","relative");
		$("#content").css("margin-top","50");
		
		
		$(".selWrap").on("click",function(){
			var val=$(this).children("span.txt").text();
			var obj = $(this).attr("id");
			//selLayerOpen2(obj,val);
		});
		

		$(".sortWrap > ul > li").on("click",function(){
			$(".sortWrap > ul > li").removeClass("on");
			$(this).addClass("on");
		});


	}

/* 상세일정표 */
	window.detail_init = function(){
		var fixTop = 0; var rv_top = 0;
		
		$("header").css("position","relative");
		$("#content").css("margin-top","0");
		
		$(".selWrap span").on("click", function(){
			var target = $(this).attr("class");
			
			if(!(target == "backBtn")){
				var val=$(this).text();			
				var obj = $(this).parents("div").attr("id");
				//selLayerOpen2(obj,val);
			}
		});
		

		// 상단 고정탭 초기화//
		
		$(".scTab").each(function(){
			var idx = $(this).index(".scTab");
			$(this).attr("cTop", $(this).offset().top);
			if (idx > 0)
			{ 
				fixTop +=  $(".scTab:eq("+(idx-1)+")").outerHeight();
			}
			$(this).attr("fixTop",fixTop);
		});

		var dtl_top = $(".scTab:eq(2)").attr("cTop") - $(".scTab:eq(1)").outerHeight() -  $(".scTab:eq(2)").height()+60;

		// 상세정보탭 클릭이벤트 //
		$("#dtlTab > ul > li").on("click", function(){
			var tab_id = $(this).index()+1;
			var vObj = ".dtl0"+tab_id;
			$("#dtlTab > ul > li").removeClass("on");
			$(this).addClass("on");

			$(".dtl").css("display","none");
			$(vObj).css("display","block");
			$("body").animate({scrollTop:dtl_top},300);
			
			if (tab_id == 2){
				
				var sl_w = [];
				var sl_w_id = [];
				$(".weatherCont > .wslider").each(function (idx){
					var tmp = $(".weatherCont > .wslider").eq(idx);
					sl_w_id[idx] = tmp.attr("id");
				});
				
				$.each(sl_w_id,function(idx){
					sl_w[idx] = $("#"+sl_w_id[idx]).bxSlider({
						auto: false
						});
				});
				
				$(".prev").on("click", function(){
					var index = $("#realArea option").index($("#realArea option:selected"));
					sl_w[index].goToPrevSlide();
				});
				
				$(".next").on("click", function(){
					var index = $("#realArea option").index($("#realArea option:selected"));
					sl_w[index].goToNextSlide();
				});
				
				rv_top = $("#reviewWrap").offset().top - $("#dtlTab").height() - 50; 
				
				$(".tmZone.target , .weather").each(function(){
			 		$(this).css("display", "none");
				});

				var cityCd = $("#realArea").val();
				$("#c"+cityCd).css("display", "block");
				$("#w"+cityCd).css("display", "block");
				
			} // 날씨 슬라이더 초기화

		});
		
}

//Safari 전용호출 
//alert(navigator.userAgent.indexOf());
//alert(navigator.userAgent.indexOf('Chrome'));
	if (navigator.userAgent.indexOf('Safari')<141 && navigator.userAgent.indexOf('Safari') > 139) {
		//아이폰 저브랴우져
			jQuery(".ui-content div.tabsnav.ui-navbar ul li a.mstaLink").css({"padding":"15px 0 0"});
			jQuery(".mytrctn .listContent .btnbox .mtm8").css({"margin-bottom":"-5px"});
			jQuery(".gsdetail .pd li i.mtm8").css({"margin-top":"2px"});
			jQuery(".popTpart").on("click",function(){
				layerClose();
				return false;
			});
	}	
	if (navigator.userAgent.indexOf('Safari') != -1 && navigator.userAgent.indexOf('Chrome') == -1){
		//아이폰 기본
			jQuery(".ui-content div.tabsnav.ui-navbar ul li a.mstaLink").css({"padding":"15px 0 0"});
			jQuery(".mytrctn .listContent .btnbox .mtm8").css({"margin-bottom":"-5px"});
			jQuery(".gsdetail .pd li i.mtm8").css({"margin-top":"2px"});
			jQuery(".popTpart").on("click",function(){
				layerClose();
				return false;
			});
	}
	if (navigator.userAgent.indexOf('Chrome')== 97) {
		//안드로이드 크롬 브라우져
			jQuery(".ui-content div.tabsnav.ui-navbar ul li a.mstaLink").css({"padding":"18px 0 0"});
	}
	

	//[JEH] 숫자만 입력하도록 check - 20191121
	$(document).off("keyup", ".in-num");
	$(document).on("keyup", ".in-num", function(){
		$(this).val( $(this).val().replace(/[^0-9]/gi,"") );
	});

	//[JEH] 숫자만 입력하도록 check - 20191121
	//한글입력시 탭이동하면 한글자씩 남아있기 때문에 focusout 시 clear
	$(document).off("focusout", ".in-num");
	$(document).on("focusout", ".in-num", function(){
		$(".in-num").trigger("keyup");

	});

});


