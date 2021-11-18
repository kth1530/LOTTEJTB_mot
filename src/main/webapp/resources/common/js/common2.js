
jQuery(function(){
	/*********************************************
	모바일 2차
	**********************************************/
	/* 중복체크 텝 */
	//jQuery(".free_topchk #aircheck").attr("checked",true);
	jQuery(".free_topchk #aircheck").parent().addClass("chked");
	jQuery(".free_topchk input").change(function(){
		jQuery(".freesearch .chkpart").hide();
		jQuery(".free_topchk input").each(function(){
			if(jQuery(this).is(":checked")==true){
				var showid = jQuery(this).attr("id");
				if(showid == "aircheck") jQuery(".freesearch .airpart").show();
				if(showid == "hotelcheck") jQuery(".freesearch .hotelpart").show();
				if(showid == "carcheck") jQuery(".freesearch .carpart").show();
			};
		});
		/*인원 초기화*/
		jQuery(".tabctn_com").find(".ps_cunt span").text("0");
		jQuery(".personnel").find("li:first-child").find(".ps_cunt span").text("1");
		/* Select Center*/
		jQuery(".centerSelect").each(function(){
			centerSelect(jQuery(this));
		});
		/* 다중화면 노출 */
		var chkedchk = function(){
			var showids = "";
			jQuery(".free_topchk input:checked").each(function(){
				var showid_index = jQuery(this).attr("id");
				if(showids) showids = showids + showid_index;
				else showids = showid_index;
			});
			var hidid = showids;
			jQuery(".freesearch .selectchk").removeClass("mb0");
			if(hidid == "aircheckhotelcheck"){
			//항공 + 호텔
				jQuery(".chkv_hid,.chkv_show,.ah_show,.hc_show,.chkv_show2,.ah_show2,.hc_show2").hide(); 
				jQuery(".ttsch,.chkv_show,.ah_show").show();
				// jQuery(".free_airtab li").css("width","50%");
				jQuery(".free_airtab li").css("width","25%");
				jQuery(".freesearch .personnel").css("border-bottom","0");
				//텝초기화
				tabliset();
				/*인원 초기화*/
				jQuery(".personnel").find(".ps_cunt span").text("0");
				jQuery(".personnel").find("li:first-child").find(".ps_cunt span").text("1");
				/* Select Center*/
				jQuery(".centerSelect").each(function(){
					centerSelect(jQuery(this));
				});
			}else if(hidid == "aircheckcarcheck"){
			//항공 + 렌터카
				jQuery(".chkv_hid,.chkv_show,.ah_show,.hc_show,.chkv_show2,.ah_show2,.hc_show2").hide(); 
				jQuery(".ttsch,.chkv_show,.hc_show").show();
				// jQuery(".free_airtab li").css("width","50%");
				jQuery(".free_airtab li").css("width","25%");
				jQuery(".freesearch .personnel").css("border-bottom","0");
				//텝초기화
				tabliset();
				/*인원 초기화*/
				jQuery(".personnel").find(".ps_cunt span").text("0");
				jQuery(".personnel").find("li:first-child").find(".ps_cunt span").text("1");
				/* Select Center*/
				jQuery(".centerSelect").each(function(){
					centerSelect(jQuery(this));
				});
			}else if(hidid == "hotelcheckcarcheck"){
			//호텔 + 렌터카
				jQuery(".chkv_hid,.chkv_show,.ah_show,.hc_show,.chkv_show2,.ah_show2,.hc_show2").hide(); 
				jQuery(".ttsch,.chkv_show2,.hc_show2").show();
				jQuery(".freesearch .selectchk").addClass("mb0");
			}else if(hidid == "aircheckhotelcheckcarcheck"){
			//항공 + 호텔 + 렌터카
				jQuery(".chkv_hid,.chkv_show,.ah_show,.hc_show,.chkv_show2,.ah_show2,.hc_show2").hide(); 
				jQuery(".ttsch,.chkv_show,.ah_show,.hc_show").show();
				// jQuery(".free_airtab li").css("width","50%");
				jQuery(".free_airtab li").css("width","25%");
				jQuery(".freesearch .personnel").css("border-bottom","0");
				//텝초기화
				tabliset();
				/*인원 초기화*/
				jQuery(".personnel").find(".ps_cunt span").text("0");
				jQuery(".personnel").find("li:first-child").find(".ps_cunt span").text("1");
				/* Select Center*/
				jQuery(".centerSelect").each(function(){
					centerSelect(jQuery(this));
				});
			}else{
				jQuery(".chkv_hid,.chkv_show,.ah_show,.hc_show,.chkv_show2,.ah_show2,.hc_show2").hide(); 
				jQuery(".chkv_hid").show();  
				jQuery(".ttsch,.chkv_show,.ah_show,.hc_show").hide();
				jQuery(".free_airtab li").css("width","25%");
				jQuery(".freesearch .personnel").css("border-bottom","1px solid #eee");
				/*인원 초기화*/
				jQuery(".personnel").find(".ps_cunt span").text("0");
				jQuery(".personnel").find("li:first-child").find(".ps_cunt span").text("1");
			};
			if(hidid == "hotelcheck"){
				for(var hch=6; hch<10; hch++){
					jQuery(".freesearch .hotal_clone"+hch).hide();
					jQuery(".freesearch .hotal_clone"+hch).removeClass("htshow");
				};
			}
		};
		if(jQuery(this).is(":checked")==true){
			jQuery(this).parent().addClass("chked");
			chkedchk();	
		}else{
			jQuery(this).parent().removeClass("chked");
			chkedchk();
		};
	});
	var personnelfc = function(){
		/* 인원수 조건 */
		var tatalCount = function(fcs){
			var fcss = jQuery(fcs).parent().parent().parent();
			var htfoss = jQuery(fcs).parent().parent().parent().parent().parent().parent();
			var tcount1 = Number(fcss.find("li:nth-child(1) .ps_cunt span").text());
			var tcount2 = Number(fcss.find("li:nth-child(2) .ps_cunt span").text());
			var tcount3 = Number(fcss.find("li:nth-child(3) .ps_cunt span").text());
			var allcount = tcount1 + tcount2 + tcount3;
			var fcstext = jQuery(fcs).find("button").text();
			if(allcount > 9){
				var msg1 = fcss.attr("data-msg");
				alert(msg1); 
				var ps_count2 = Number(jQuery(fcs).prev().find("span").text());
				var ps_count2 = ps_count2-1;
				jQuery(fcs).prev().find("span").text(ps_count2);
				delete ps_count2;
				return false
			};
			if(Number(tcount1) < Number(tcount3)){
				alert("성인 1명이 유아1명만을 예약 할 수 있으며, \n나머지 유아는 소아로 예약하셔야 합니다.");
				if(fcstext == "올림"){
					var ps_count2 = Number(jQuery(fcs).prev().find("span").text());
					var ps_count2 = ps_count2-1;
					jQuery(fcs).prev().find("span").text(ps_count2);
				}else{
					var ps_count2 = Number(jQuery(fcs).next().find("span").text());
					var ps_count2 = ps_count2+1;
					jQuery(fcs).next().find("span").text(ps_count2);
				}
				delete ps_count2;
				return false
			};
			if(htfoss.is(".hotelpart")==true){
				var psallc2 = 0;
				htfoss.find(".ps_cunt").each(function(){
					var psallc = jQuery(this).text();
					if(jQuery(this).parent().parent().parent().parent().hasClass("htshow")==true)	psallc2 = Number(psallc2) + Number(psallc);
				});
				if(psallc2 <= 9){ 
					htfoss.find(".addbtn2").removeClass("noBtn_Action");
					if(Number(tcount2) > 3){
						alert("아동은 3명까지 입실이 가능하십니다."); 
						if(fcstext == "올림"){
							var ps_count2 = Number(jQuery(fcs).prev().find("span").text());
							var ps_count2 = ps_count2-1;
							jQuery(fcs).prev().find("span").text(ps_count2);
						}else{
							var ps_count2 = Number(jQuery(fcs).next().find("span").text());
							var ps_count2 = ps_count2+1;
							jQuery(fcs).next().find("span").text(ps_count2);
						};
						delete ps_count2;
						return false
					}else{
						fcss.next().removeClass("agenum1").removeClass("agenum2").removeClass("agenum3");
						fcss.next().addClass("agenum"+Number(tcount2));				
					};
				}else{
					alert("총 9명까지만 예약이 가능합니다..");
					htfoss.find(".addbtn2").addClass("noBtn_Action");
					var ps_counta = Number(jQuery(fcs).prev().find("span").text());
					var ps_counta = ps_counta-1;
					jQuery(fcs).prev().find("span").text(ps_counta);
				}
			};
		};
		/* 인원 카운트 */
		jQuery(".personnel .ps_c1").on("click", function(){
			/* 기본카운트 */
			var ps_count = Number(jQuery(this).next().find("span").text());
			if(ps_count > 0){
				var ps_count = ps_count-1;
				jQuery(this).next().find("span").text(ps_count);
				tatalCount(this);
			};
			delete ps_count;
			return false
		});
		jQuery(".personnel .ps_c2").on("click", function(){
			/* 기본카운트 */
			var ps_count = Number(jQuery(this).prev().find("span").text());
			if(ps_count < 9){
				var ps_count = ps_count+1;
				jQuery(this).prev().find("span").text(ps_count);
				tatalCount(this);
			}else{
				alert("최대인원입니다.");
			};
			delete ps_count;
			return false
		});
	};
	/* 텝공통 */
	jQuery(".tablist_com li").on("click", function(){
		var tabli = (jQuery(this).index())+1;
		var ctnBox = jQuery(this).parent().attr("data-ctn");
		jQuery(this).parent().find("li").removeClass("active");
		jQuery("."+ctnBox).hide();
		jQuery(this).addClass("active");
		jQuery(".tabctn_com").removeClass("ps_view");
		jQuery(".tabctn_com."+ctnBox+tabli).show();
		jQuery(".tabctn_com."+ctnBox+tabli).addClass("ps_view");
		/*인원 초기화*/
		jQuery(".personnel").find(".ps_cunt span").text("0");
		jQuery(".personnel").find("li:first-child").find(".ps_cunt span").text("1");
		/* Select Center*/
		jQuery('.centerSelect').each(function(){
			centerSelect(jQuery(this));
		});
		
		//[JEH] 일정표 탭 클릭시 일정표 모두펼침
		if($(this).hasClass('schd')){
			$(".sd_inbox2_abtn .sd_all_btn").toggleClass("off");
			$(".sd_inbox2_abtn .sd_all_btn").text("모두닫힘");
			$(".sd_inbox2_abtn .sd_all_btn").parent().next().addClass("all_on");
			$(".sd_inbox2_abtn .sd_all_btn").parent().next().find(" > dt").addClass("on");
		}
		
		return false
	});
	/* 메인텝 */
	jQuery(".mtablist_com li").on("click", function(){
		var mtab_pos = jQuery(".mtablist_com").offset().top;
		jQuery(document).scrollTop(mtab_pos-165);
		if(jQuery(this).is(".active")==false){
			var tabli = (jQuery(this).index())+1;
			var ctnBox = jQuery(this).parent().attr("data-ctn");
			jQuery(this).parent().find("li").removeClass("active");
			jQuery("."+ctnBox).hide();
			jQuery(this).addClass("active");
			jQuery(".mtabctn_com").removeClass("ps_view");
			jQuery(".mtabctn_com."+ctnBox+tabli).show();
			jQuery(".mtabctn_com."+ctnBox+tabli).addClass("ps_view");
			/*인원 초기화*/
			jQuery(".personnel").find(".ps_cunt span").text("0");
			jQuery(".personnel").find("li:first-child").find(".ps_cunt span").text("1");
			/* Select Center*/
			jQuery('.centerSelect').each(function(){
				centerSelect(jQuery(this));
			});
		}else{
			jQuery(this).removeClass("active");
			jQuery(".mtabctn_com").removeClass("ps_view").hide();
		}
		return false
	});
	personnelfc();
	/* 객실추가 */
	var htcount = 1;
	jQuery(".freesearch .hotal_clone1,.main .hotal_clone1").addClass("htshow");
	jQuery(".freesearch .hotelpart .addbtn2,.main .hotelpart .addbtn2").on("click", function(){
		if(jQuery(this).is(".noBtn_Action")==false){
			var showids = "";
			var htindez = jQuery(".freesearch .hotal_clone.htshow,.main .hotal_clone.htshow").size();
			var htindezadd = htindez+1;
			jQuery(".free_topchk input:checked").each(function(){
				var showid_index = jQuery(this).attr("id");
				if(showids) showids = showids + showid_index;
				else showids = showid_index;
			});
			if(jQuery(".main div").is(".mainWrap")==false){
				if(showids == "hotelcheck"){
					if(htindez >= 5){
						alert("호텔만 예약하신다면 5개까지만 가능하십니다."); 
						return false
					}
				}else{
					if(htindez >= 9){
						alert("호텔만 예약하신다면 9개까지만 가능하십니다."); 
						return false
					}
				};
			}else{
				if(htindez >= 5){
					alert("호텔만 예약하신다면 5개까지만 가능하십니다."); 
					return false
				}
			}
			jQuery(".freesearch .hotal_clone"+htindezadd+",.main .hotal_clone"+htindezadd).show();
			jQuery(".freesearch .hotal_clone"+htindezadd+",.main .hotal_clone"+htindezadd).addClass("htshow");
			jQuery(".centerSelect").each(function(){
				centerSelect(jQuery(this));
			});
		}else{
			alert("총 9명까지만 예약이 가능합니다.");
		}
	});
	jQuery(".hotal_clone .setroom_remove").on("click", function(){
		if(jQuery(this).parent().parent().hasClass("hotal_clone1")==false){
			jQuery(this).parent().parent().hide();
			jQuery(this).parent().parent().removeClass("htshow");
			//호텔인원 연산결과 초기화
			jQuery(this).parent().parent().parent().next().removeClass("noBtn_Action");
			jQuery(this).parent().parent().find(".ps_cunt").each(function(){
				jQuery(this).find("span").text("0");
				jQuery(this).parent().parent().parent().find("li:first-child").find(".ps_cunt span").text("1");
			});
		}else{
			alert("객실1은 삭제가 안됩니다.");
		}
	});
	
	/* Select Center*/
	function getTextWidth(txt) {
		var elm = jQuery('<span class="tempforSize">'+txt+'</span>').prependTo("body");
		var elmWidth = elm.width();
		elm.remove();
		return elmWidth;
	};
	function centerSelect(elm) {
		var optionWidth = getTextWidth(elm.children(":selected").html())
		var emptySpace = elm.width()- optionWidth;
		elm.css("text-indent", (emptySpace/2) + (optionWidth/20) );
	};
	setTimeout(function(){ 
		jQuery('.centerSelect').each(function(){
			centerSelect(jQuery(this));
		});
	},100);
	jQuery('.centerSelect').on('change', function(){
		centerSelect(jQuery(this));
	});
	/* 검색결과 레이어 */
	var frctnHft = function(){
		var frctnH = jQuery(".bodyWrap").height();
		jQuery(".re_schview").css({"height":(frctnH-110)+"px"});
	};
	/* 결과레이어 블라인드 높이 */
	frctnHft();
	/* 검색결과 재검색 버튼 */
	jQuery(".re_search").on("click", function(){
		var re_doh = (jQuery(document).height()-210);
		jQuery(".re_schview").show().css({"height":re_doh+"px"});
		/* 다구간 텝 선택시 높이 조정 */
		jQuery(".re_schview .free_airtab li").on("click", function(){
			var res_result_index = jQuery(this).index();
			var many_travelbox_index = jQuery(".re_schview .airbox.airbox3").find(".many_travelbox").size();
			if(res_result_index == "2"){
				var re_very_sbox_height = 240*many_travelbox_index;
				jQuery(".re_very_sarchbox").css({"min-height":re_very_sbox_height+"px"});
				frctnHft();
			}else{
				jQuery(".re_very_sarchbox").css({"min-height":"auto"});
				frctnHft();
			};
		});
		
		jQuery('.centerSelect').each(function(){
			centerSelect(jQuery(this));
		});
	});
	jQuery(".re_search_close").on("click", function(){
		jQuery(".re_schview").hide();
		jQuery(".re_very_sarchbox").css({"min-height":"auto"});
	});
	/* 라디오+체크 */
	jQuery(document.body).on("click",".radioboxs input",function(){
		var r_name = jQuery(this).attr("name");
		var parentBox = jQuery("input[name="+r_name+"]").parent();      
		parentBox.removeClass("on");
		jQuery(this).parent().addClass("on");
		
		/* 렌터카 결과 페이지 전용 */
		if(jQuery("div").is(".re_sch_lentcar")==true){
			var fec_index = jQuery(this).parent().parent().parent().index(".fr_carlist");
			lt_car_tinfo(fec_index);
		};
	});
	jQuery(document.body).on("click",".checkboxs input",function(){
		jQuery(this).parent().toggleClass("on");        
	});
	/* 렌터카 결과 간략내용 */
	jQuery(".car_infobtn button:first-child").on("click", function(){
		jQuery(this).toggleClass("on");
		if(jQuery(this).hasClass("on")==true){
			jQuery(this).parent().parent().parent().parent().find(".car_infotable3").show();
		}else{
			jQuery(this).parent().parent().parent().parent().find(".car_infotable3").hide();
		}
	});
	/* 렌터카 라디오박스 이미지 및 타이틀 */
	jQuery(".frc_infobox > p").on("click", function(){
		jQuery(this).parent().parent().parent().parent().find(".radioboxs2").removeClass("on");
		jQuery(this).parent().prev().addClass("on");	
		jQuery(this).parent().prev().find("input").prop("checked", true);	
		var fec_index = jQuery(this).parent().parent().parent().index(".fr_carlist");
		lt_car_tinfo(fec_index);
	});
	jQuery(".frc_infobox .car_infot2").on("click", function(){
		jQuery(this).parent().parent().parent().parent().parent().find(".radioboxs2").removeClass("on");
		jQuery(this).parent().parent().prev().addClass("on");	
		jQuery(this).parent().parent().prev().find("input").prop("checked", true);	
		var fec_index = jQuery(this).parent().parent().parent().parent().index(".fr_carlist");
		lt_car_tinfo(fec_index);
	});
	/* 렌터카 라디오박스 체크 시 정보 노출 */
	var lt_car_tinfo = function(idx){
		jQuery(".car_infotable1").hide();
		jQuery(".car_infobtn button:first-child").removeClass("on");
		if(jQuery(".fr_carlist"+idx+" .radioboxs2 input").is(":checked")==true){
			jQuery(".fr_carlist"+idx+" .car_infotable2").show();
		};
	};
	/* 아코디언 (렌터카 상세조건 새창 전용) *
	jQuery(".ft_acdon dt").on("click", function(){
		if(jQuery(this).hasClass("on")==false){
			jQuery(".ft_acdon dt").removeClass("on");
			jQuery(".ft_acdon dd").hide();
			jQuery(this).addClass("on");
			jQuery(this).next().show();
		}else{
			jQuery(".ft_acdon dt").removeClass("on");
			jQuery(".ft_acdon dd").hide();
		}
	});
	/* 아코디언 (렌터카 선택확인 전용) */
	lcacinfo();
	/* 아코디언 */
	acdon();
	/* 마이투어 (자유여행) */
	jQuery(".free_myt_part .free_myt_title1").on("click", function(){
		jQuery(this).parent().toggleClass("on");
	});
	/* 결제 선택 */
	jQuery(".paylist_chkbox2 button").on("click", function(){
		jQuery(".paylist_chkbox2 button").removeClass("active");
		jQuery(this).addClass("active");
		var pay_indoex = jQuery(this).parent().index();
		jQuery(".caronline_bankinfo,.card_bankinfo,.online_bankinfo,.lpay_bankinfo,.lpay_bank_sel").hide();
		if(pay_indoex == 0) jQuery(".card_bankinfo").show();
		if(pay_indoex == 1) jQuery(".online_bankinfo").show();
		if(pay_indoex == 2) jQuery(".caronline_bankinfo,.card_bankinfo,.online_bankinfo").show();
		if(pay_indoex == 3) jQuery(".lpay_bank_sel,.lpay_bankinfo").show();
	});
	/* 결제하기 LPOINT 및 상품권 */
	jQuery(".freesearch .payinfo_ctnbox li > div:first-child button.payc_view").on("click", function(){
		jQuery(this).parent().find(".payc_use").show();
		jQuery(this).parent().find(".payc_view").hide();
		jQuery(this).parent().next().show();		
		//jQuery(this).parent().next().find(".lpoint_text,.pro_price").val(); 데이터 비우기
		jQuery(this).parent().find(".f_red").html("&nbsp;");
	});
	jQuery(".freesearch .payinfo_ctnbox li > div:first-child button.payc_use").on("click", function(){
		jQuery(this).parent().find(".payc_use").hide();
		jQuery(this).parent().find(".payc_view").show();
		jQuery(this).parent().next().hide();
		var l_price = jQuery(this).parent().next().find(".lpoint_text,.pro_price").val();
		jQuery(this).parent().find(".f_red").text(l_price);
	});
	/* Toggle 아코디언 */
	tgacdon();
	/* 디바이스 크로스 */
	//alert(navigator.userAgent.indexOf('Chrome'))
	if (navigator.userAgent.indexOf('Safari')<141 && navigator.userAgent.indexOf('Safari') > 139) {
		//아이폰 저브랴우져
		jQuery("body").addClass("iphon1");
	}	
	if (navigator.userAgent.indexOf('Safari') != -1 && navigator.userAgent.indexOf('Chrome') == -1){
		//아이폰 기본
		jQuery("body").addClass("iphon2");
	}else if(navigator.userAgent.indexOf('iPhone') != -1){
		//아이폰 기본
		jQuery("body").addClass("iphon2");
	}
	
	if (navigator.userAgent.indexOf('Chrome')== 97) {

		//안드로이드 크롬 브라우져
		jQuery("body").addClass("adrcrm");
	};
	//
	jQuery(".iphon2 input[type=text],.iphon2 input[type=password],.iphon2 input[type=number],.iphon2 textarea").on("focus",function(){
		jQuery("#foot").removeClass("ui-footer-fixed");
	});
	jQuery(".iphon2 input[type=text],.iphon2 input[type=password],.iphon2 input[type=number],.iphon2 textarea").on("blur",function(){
		jQuery("#foot").addClass("ui-footer-fixed");
	});

	//메인 팝업
	var mainpop = function(){
		jQuery("body").bind('touchmove', function(e){e.preventDefault()}); //터치방지
		var winh = jQuery(window).height();
		var poph = jQuery(".main_pop").height();
		var wpcenter = winh/2 - poph/2;
		jQuery(".mian_popbox").css({"padding-top":wpcenter+"px"});
		jQuery(".main_pop .mpop_close").off("click");
		jQuery(".main_pop .mpop_close").on("click", function(){
			jQuery(".mian_popbox").hide();
			jQuery("body").unbind('touchmove'); //터치방지해지
		});
		return false;
	};
	//mainpop();
	//상품 상세 공통텝
	jQuery(".sd_tahaco dt").on("click", function(){
		jQuery(this).parent().removeClass("all_on");
		jQuery(this).toggleClass("on");
	});
	jQuery(".sd_all_btn").on("click", function(){
		jQuery(this).toggleClass("off");
		if(jQuery(this).hasClass("off")==true){
			jQuery(this).text("모두닫힘");
			jQuery(this).parent().next().addClass("all_on");
			jQuery(this).parent().next().find(" > dt").addClass("on");
		}else{
			jQuery(this).text("모두펼침");
			jQuery(this).parent().next().removeClass("all_on");
			jQuery(this).parent().next().find(" > dt").removeClass("on");
		};

	});
	
	// 상단 고정탭 스크롤액션
	setTimeout(function(){ 
		var posfixed1 = jQuery(".posfixed1").height()-10;
		var posfixed2 = jQuery(".posfixed2").height();

		if( jQuery("div").hasClass("posfixed1")==true){
			if( jQuery("div").hasClass("posfixed1")==true) var scrpos1pos = jQuery(".posfixed1").offset().top;
			if( jQuery("div").hasClass("posfixed2")==true) var scrpos2pos = jQuery(".posfixed2").offset().top-posfixed1-10;
			jQuery(window).on("scroll",function(){
				var nowposs =  jQuery(document).scrollTop();
				if(nowposs > scrpos1pos){
					jQuery(".posfixed1 > p").css({"z-index":"10","position":"fixed","top":"0","width":"100%","border-bottom":"1px solid #ccc"});
				}else{
					jQuery(".posfixed1 > p").css({"z-index":"0","position":"relative","top":"none","border-bottom":"0"});
				}
					
				if(nowposs > scrpos2pos){
					jQuery(".posfixed2 > ul").css({"z-index":"10","position":"fixed","top":posfixed1+"px","width":"100%"});
				}else{
					jQuery(".posfixed2 > ul").css({"z-index":"0","position":"relative","top":"0px"});
				}
			});
		};
		/* 상품상세 텝클릭시 이동 */
		jQuery(".shopdetailbox .sd_info_tab li").on("click", function(){
			var tabpos = jQuery(".posfixed2").offset().top;
			jQuery(document).scrollTop(tabpos+posfixed1-117);
		});
	 }, 1000);
	/* 자유여행 약관동의 */
	jQuery(".allcheckDiv span").on("click", function(){
		if(jQuery(this).find("input").is(":checked")==true){
			jQuery(this).parent().parent().parent().find(".step1Agree").prop("checked", true);
		}else{
			jQuery(this).parent().parent().parent().find(".step1Agree").prop("checked", false);
		};
	});
	/* 자동완성 */
	jQuery(".tt_searchbtn").on("click", function(){
		jQuery(".total_searchbox").toggleClass("on");
	});
	jQuery(".total_searchbox .ts_close").on("click", function(){
		jQuery(".total_searchbox").removeClass("on");
	});
	autokey();
	/* 상품상세 체크뷰 */
	jQuery(".sd_chk_view .chkbox").on("click", function(){
		var sd_cvc = jQuery(this).parent().index();
		
		if(jQuery(this).find("input").is(":checked")==true){
			if(sd_cvc == 0)	jQuery(this).parent().parent().parent().find(".sd_chk_v3").show();
			if(sd_cvc == 1)	jQuery(this).parent().parent().parent().find(".sd_chk_v1").show();
			if(sd_cvc == 2)	jQuery(this).parent().parent().parent().find(".sd_chk_v2").show();
		}else{
			if(sd_cvc == 0)	jQuery(this).parent().parent().parent().find(".sd_chk_v3").hide();
			if(sd_cvc == 1)	jQuery(this).parent().parent().parent().find(".sd_chk_v1").hide();
			if(sd_cvc == 2)	jQuery(this).parent().parent().parent().find(".sd_chk_v2").hide();
		};
		
	});
	/* 항공결제 */
	/* 일괄 / 탑승객 */
	jQuery(".pop_airp_title0 input").on("change",function(){
		if(jQuery(this).prop("checked")==true){
			var pap_chk = jQuery(this).attr("data-chk");
			jQuery(".part_chk").hide();
			jQuery("."+pap_chk).show();
		}
	});
	/* 증빙서류 */
	jQuery(".pop_ppchk input").on("change",function(){
		if(jQuery(this).prop("checked")==true){
			var pbp_chk = jQuery(this).attr("data-chk");
			jQuery(".pop_pp").hide();
			jQuery("."+pbp_chk).show();
		}
	});
	
	/* 상품권 
	jQuery(".coup_btnbox button").on("click",function(){
		var coup_clone = jQuery(this).parent().next().clone();
		coup_clone.find("input").val("");
		coup_clone.find("select").attr("seleced",false);
		jQuery(".coup_clone").append(coup_clone);
	});
	*/
	/* 항공 결제 선택 */
	jQuery(".pop_plist_chk button").on("click", function(){
		//초기화
		jQuery(".part_chk,.pop_pp").show();
		jQuery(".obj_none").hide();
		jQuery(".pop_at_chk .radioboxs,td .radioboxs").removeClass("on").find("input").attr("checked",false);
		jQuery(".pop_at_chk .radioboxs:first-child,td .radioboxs:first-child").addClass("on").find("input").attr("checked",true);
		jQuery(".pop_at_chk .radioboxs:first-child,td .radioboxs:first-child").addClass("on").find("input").prop("checked", true);
		jQuery(".card_part,.bank_part,.card_cash_part,.card_cash_coup_part,.coup_part").find("input[type=text],input[type=number],select").val("").attr("selected",false);
		jQuery(".coup_clone").empty();
		//작동
		jQuery(".pop_plist_chk button").removeClass("active");
		jQuery(this).addClass("active");
		var pay_indoex = jQuery(this).parent().index();
		jQuery(".card_part,.bank_part,.card_cash_part,.card_cash_coup_part,.coup_part").hide();
		if(pay_indoex == 0) jQuery(".card_part").show();
		if(pay_indoex == 1) jQuery(".bank_part").show();
		if(pay_indoex == 2) jQuery(".card_cash_part").show();
		if(pay_indoex == 3) jQuery(".card_cash_coup_part").show();
		if(pay_indoex == 4) jQuery(".coup_part").show();
	});
	/* 카테고리 */
	jQuery(".ctgr_list > li").each(function(){
		if(!jQuery(this).find("ul").text()) jQuery(this).addClass("none_active");
	})
	jQuery(".ctgr_list > li > ul > li > ul").each(function(){
		var deps_index = jQuery(this).find("li").size();
		if (deps_index % 2 == 0){}else{jQuery(this).append("<li></li>");};
	})
	jQuery(".ctgr_list > li > a").on("click",function(){
		if(jQuery(this).parent().hasClass("active")==true){
			jQuery(this).parent().toggleClass("active");
			jQuery(".ctgr_list > li > a p").removeClass("addon");
		}else{
			jQuery(".ctgr_list > li").removeClass("active");
			jQuery(".ctgr_list > li > a p").removeClass("addon");
			jQuery(this).parent().addClass("active");
			jQuery(this).find("p").addClass("addon");
		}
	});
	jQuery(".ctgr_list > li > ul > li > a").on("click",function(){
		if(jQuery(this).parent().hasClass("on")==true){
			jQuery(this).parent().toggleClass("on");
			jQuery(".ctgr_list > li > ul > li").removeClass("clear");
			
		}else{
			jQuery(".ctgr_list > li > ul > li").removeClass("on");
			jQuery(this).parent().addClass("on");
		}
	});
});


/********* 팝업 포함 함수 ***********/
	/* 아코디언 */
	var acdon = function(){
		jQuery(".ft_acdon dt").on("click", function(){
			if(jQuery(this).hasClass("on")==false){
				jQuery(".ft_acdon dt").removeClass("on");
				jQuery(".ft_acdon dd").hide();
				jQuery(this).addClass("on");
				jQuery(this).next().show();
			}else{
				jQuery(".ft_acdon dt").removeClass("on");
				jQuery(".ft_acdon dd").hide();
			}
		});
		jQuery(".ft2_acdon dt").on("click", function(){
			jQuery(this).toggleClass("on");
		});
	};
	/* 자유 텝공통 */
	var tablist_com = function(){
		jQuery(".tablist_com li").on("click", function(){
			var tabli = (jQuery(this).index())+1;
			var ctnBox = jQuery(this).parent().attr("data-ctn");
			jQuery(this).parent().find("li").removeClass("active");
			jQuery("."+ctnBox).hide();
			jQuery(this).addClass("active");
			jQuery(".tabctn_com").removeClass("ps_view");
			jQuery(".tabctn_com."+ctnBox+tabli).show();
			jQuery(".tabctn_com."+ctnBox+tabli).addClass("ps_view");
		});
	};
	/* 아코디언 (렌터카 선택확인 전용) */
	var lcacinfo = function(){
		jQuery(".pop_info_list .lc_acodion_info > li").on("click", function(){
			jQuery(this).toggleClass("on");
		});
	}
	
	/* 자동완성 */
	var autokey = function(){
		jQuery(".fs_search .csbox input").bind("change keyup", function(){
			//jQuery(".fs_search .search_nowkey").show();
			var intext = jQuery(this).val();
			jQuery(".fs_search .search_nowkey li").each(function(){
				var text = jQuery(this).text();
				jQuery(this).attr("data-text",text);
				jQuery(this).html(text.replace(intext, "<span class='f_red'>"+intext+"</span>")); 
			});
		});
		jQuery(".fs_search .search_nowkey li").on("click", function(){
			var text2 = jQuery(this).attr("data-text");
			jQuery(".fs_search .csbox input").val(text2);
		});	
		jQuery(".fs_search .search_nowkey p.snkclose").on("click", function(){
			jQuery(".fs_search .search_nowkey").hide();
		});
	}
	/* Toggle 아코디언 */
	var tgacdon = function(){
		jQuery(".toggle_acdon dt").on("click", function(){
			jQuery(this).toggleClass("on");
		});
	};
	/* 자유여행 검색 텝 초기화 */
	var tabliset = function(){
		jQuery(".airpart .tablist_com.free_airtab[data-ctn=airbox] li").removeClass("active");		
		jQuery(".airpart .tablist_com.free_airtab[data-ctn=airbox] li:first-child").addClass("active");
		jQuery(".airpart .tabctn_com.airbox").hide();
		jQuery(".airpart .tabctn_com.airbox").removeClass("ps_view");
		jQuery(".airpart .tabctn_com.airbox.airbox1").show();
		jQuery(".airpart .tabctn_com.airbox.airbox1").addClass("ps_view");
	}
	
	/**
		parameter 
			 - nowTime  : 현재시간 (월 일 년 시:분:초) - ex) 01 24 2017 18:00:00
			 - entTime  : 행사종료시간 (월 일 년 시:분:초) - ex) 01 24 2017 18:00:00
			 - divIndex : DIV INDEX
	**/
	var getTime = function(nowTime, endTime, divIndex, slideVal) { 
		if(nowTime == "" || nowTime == "undefined"){
			now = new Date(); 
		}else{
			var nowTimeArr = nowTime.split(/[- :]/);
			now = new Date(nowTimeArr[0], parseInt(nowTimeArr[1])-1, nowTimeArr[2], nowTimeArr[3], nowTimeArr[4], nowTimeArr[5]); 
		}
		
		var endTimeArr = endTime.split(/[- :]/);
		end = new Date(endTimeArr[0], parseInt(endTimeArr[1])-1, endTimeArr[2], endTimeArr[3], endTimeArr[4]);
		
		var nt = now.getTime();
		var et = end.getTime();
		
		sec = parseInt(et - nt) / 1000;
		day  = parseInt(sec/60/60/24);
		if(day.toString().length > 1){
			var day2_1 = day.toString().substr(day.toString().length-2,1);
			var day2_2 = day.toString().substr(day.toString().length-1,1);
		}else{
			var day2_1 = "0";
			var day2_2 = day.toString().substr(day.toString().length-1,1);
		}

		sec = (sec - (day * 60 * 60 * 24));
		hour = parseInt(sec/60/60);
		if(hour.toString().length > 1){
			var hour2_1 = hour.toString().substr(hour.toString().length-2,1);
			var hour2_2 = hour.toString().substr(hour.toString().length-1,1);
		}else{
			var hour2_1 = "0";
			var hour2_2 = hour.toString().substr(hour.toString().length-1,1);
		}

		sec = (sec - (hour*60*60));
		min = parseInt(sec/60);
		if(min.toString().length > 1){
			var min2_1 = min.toString().substr(min.toString().length-2,1);
			var min2_2 = min.toString().substr(min.toString().length-1,1);
		}else{
			var min2_1 = "0";
			var min2_2 = min.toString().substr(min.toString().length-1,1);
		}

		sec = parseInt(sec-(min*60));
		if(sec.toString().length > 1){
			var sec2_1 = sec.toString().substr(sec.toString().length-2,1);
			var sec2_2 = sec.toString().substr(sec.toString().length-1,1);
		}else{
			var sec2_1 = "0";
			var sec2_2 = sec.toString().substr(sec.toString().length-1,1);
		}
		jQuery("#mainTime"+divIndex+ " table tr:first-child td:nth-child(1) p:first-child").text(day2_1);
		jQuery("#mainTime"+divIndex+ " table tr:first-child td:nth-child(1) p:nth-child(2)").text(day2_2);

		jQuery("#mainTime"+divIndex+ " table tr:first-child td:nth-child(2) p:first-child").text(hour2_1);
		jQuery("#mainTime"+divIndex+ " table tr:first-child td:nth-child(2) p:nth-child(2)").text(hour2_2);

		jQuery("#mainTime"+divIndex+ " table tr:first-child td:nth-child(3) p:first-child").text(min2_1);
		jQuery("#mainTime"+divIndex+ " table tr:first-child td:nth-child(3) p:nth-child(2)").text(min2_2);

		jQuery("#mainTime"+divIndex+ " table tr:first-child td:nth-child(4) p:first-child").text(sec2_1);
		jQuery("#mainTime"+divIndex+ " table tr:first-child td:nth-child(4) p:nth-child(2)").text(sec2_2);
		//jQuery(".m_tm_title1 span").text(day+"일"+hour+"시간"+min+"분"+sec2+"초");
		newtime = window.setTimeout(function(){
			if(nowTime < endTime){
				if(nowTime == "" || nowTime == "undefined"){
					tempNow = new Date(); 
				}else{
					var tempTimeArr = nowTime.split(/[- :]/);
					tempNow = new Date(nowTimeArr[0], parseInt(nowTimeArr[1])-1, nowTimeArr[2], nowTimeArr[3], nowTimeArr[4], nowTimeArr[5]);
					tempNow.setSeconds(tempNow.getSeconds()+1);
				}
				
				getTime(tempNow.format('yyyy-MM-dd HH:mm:ss'), endTime, divIndex, slideVal);
			}else{				
				slideVal.removeSlide($("#timeSpecialSub"+ divIndex).data("swiper-slide-index"));
				
				if((slideVal.slides.length - 2) < 1){
					$("#timeSpecialPrice").hide();
				}
			}
		}, 1000); 
	};

	//[JEH] 기획전 신청 가능 여부 체크 - 20180117
	function fn_chkInwon(ctg,goodsCd,eventCd){
		
		var rtnValue = false;
		
//		var eventCd = '';
		var startRow = 1;	
		var endRow = 10;	
		var flagReserve = '';
		var startDay = '';
				
	    var formData = new FormData();
		formData.append('ctg', ctg);
		formData.append('goodsCd', goodsCd);
		formData.append("startDay", startDay);
		formData.append('eventCd', eventCd);
		formData.append("startRow", startRow);
		formData.append("endRow", endRow);
		formData.append("flagReserve", flagReserve);
		
		var url = '';
		if(devType == 0){
			url = "/goods/srchSiteGoodsEvntDetailAjax.do";
		}else{
			url = "https://m.lottejtb.com/goods/srchSiteGoodsEvntDetailAjax.do";
		}

		cfn_ajax({
			type : "POST",
			url: url,
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "yes",
			async: false,
			timeOut : 5 * 60 * 1000,
			success: function(data) {
//				var list = data.list;
				console.log(data.rnEtMst);
				
				if(data != null) {
					var rvCnt = data.rnEtMst.rv_cnt;
					var evInwon = data.rnEtMst.ev_inwon;
//					var rvCnt = list[0]["rv_cnt"];		//예약인원
//					var evInwon = list[0]["ev_inwon"];	//행사인원
	
					console.log(rvCnt);
					console.log(evInwon);
					if(rvCnt >= evInwon || evInwon == 0){
						rtnValue = false;
					}else{
						rtnValue = true;
					}
				}
			},
			error : function(err) {
				console.log(err);
				rtnValue = false;
			}
			
		});
		
		return rtnValue;
	};
	
	//[JEH] 천단위 콤마찍기 - 20190604
	function addComma(num) {
	  var regexp = /\B(?=(\d{3})+(?!\d))/g;
	  return num.toString().replace(regexp, ',');
	}