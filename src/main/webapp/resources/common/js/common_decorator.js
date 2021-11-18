jQuery(function(){
	/*****메인 탑메뉴******/
	var swiper = new Swiper('.category-thumbs', {
		slidesPerView: 'auto',
		simulateTouch: false,
		spaceBetween: 0,
		freeMode: true,
		/*resistanceRatio: 0,*/
		wrapperClass: 'swiper-wrapper',
		slideClass: 'swiper-slide',
		onInit: function () {
			jQuery('.category-thumbs').addClass('nextShadow');
		},
		onProgress: function (data, progress) {
			if (progress <= 0) {
				jQuery('.category-thumbs').removeClass('prevShadow').addClass('nextShadow');
			} else if (progress >= 1) {
				jQuery('.category-thumbs').removeClass('nextShadow').addClass('prevShadow');
			} else {
				jQuery('.category-thumbs').addClass('nextShadow prevShadow');
			}
		}
	});
	jQuery('.category-thumbs').on('click', '> ul > li > a', function (e) {	
		var idx = jQuery(this).parent().index();
		jQuery('.category-thumbs').changeAct(idx);
	});
	jQuery(function(){
		var idx = jQuery(".category-thumbs > ul > li.on").index();
		jQuery('.category-thumbs').changeAct(idx);
	});
	
	//활성화 변경 jQuery 확장
	if (jQuery.fn.changeAct === undefined) {
		jQuery.fn.changeAct = function (idx) {
			if (this.is('.category-thumbs')) {
				this.find('> ul > li').removeClass('on').eq(idx).addClass('on');
				if (this.hasClass('swiper-container')) {
					var swiper = this[0].swiper;
					swiper.slideTo(Math.max(idx - 1, 0));
				}
			}
		};
	};
	/*****/
	/*****메인 상단 롤링이미지*****/
	var gallery = new Swiper('.imgGallery', {
		pagination: '.swiper-pagination',
		spaceBetween: 0,
		loop:true,
		autoplay: 2500,
		nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev'
	});	
	/*****/
	/*****메인 기획전 이벤트 롤링*****/
	var btn = new Swiper('.imgPlan', {
		pagination: '.swiper-pagination2',
		spaceBetween: 10,
		slidesPerView:3,
		paginationClickable: true,
		centeredSlides: true,
		speed:100,
		loop:true,
		loopedSlides: 3
	});	
	jQuery(".tabsnav li:nth-child(2) a").on("click",function(){
		var btn = new Swiper('.imgEvent', {
			pagination: '.swiper-pagination3',
			spaceBetween: 10,
			slidesPerView:3,
			paginationClickable: true,
			centeredSlides: true,
			speed:100,
			loop:true,
			loopedSlides: 3
		});		
	});
	/*****/
	/*****메인 베스트 홀리데이*****/
	var faqThumbs = new Swiper('.main-thumbs', {
		spaceBetween: 0,
		slidesPerView:4,
		touchRatio: 0.2,
		speed:100,
		loop:true,
		loopedSlides: 7,      
		paginationClickable: true,
		slideToClickedSlide: true
	});

	var faqContent = new Swiper('.main-content', {
		spaceBetween: 0,
		paginationClickable: true,
		speed:100,
		loop:true,
		loopedSlides: 7,			
		slideToClickedSlide: true
	});
	faqContent.params.control = faqThumbs;
	faqThumbs.params.control = faqContent;
	/*****/
	/*****메인 자유 홀리데이*****/
	var btn = new Swiper('.imgFree', {
		pagination: '.swiper-pagination4',
		spaceBetween: 20,
		paginationClickable: true,
		slidesPerView:2,			
		loop:true,
		speed:100,
		loopedSlides: 2
	});	
	/*****/
	/*****기획전 상세 메뉴 롤링****/
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

	jQuery('.plan-thumbs').on('click', '> ul > li > a', function (e) {
		var target = $(e.currentTarget);
		var idxp = target.parent().index();
		jQuery('.plan-thumbs').changeActp(idxp);
	});
	//활성화 변경 jQuery 확장
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
	/*****/
	/*****자주하는질문 메뉴 롤링****/
	var swiper = new Swiper('.faq-thumbs', {
		slidesPerView: 'auto',
		simulateTouch: false,
		spaceBetween: 0,
		freeMode: true,
		wrapperClass: 'swiper-wrapper',
		slideClass: 'swiper-slide',
		onInit: function () {
			jQuery('.faq-thumbs').addClass('nextShadow');
		},
		onProgress: function (data, progress) {
			if (progress <= 0) {
				jQuery('.faq-thumbs').removeClass('prevShadow').addClass('nextShadow');
			} else if (progress >= 1) {
				jQuery('.faq-thumbs').removeClass('nextShadow').addClass('prevShadow');
			} else {
				jQuery('.faq-thumbs').addClass('nextShadow prevShadow');
			}
		}
	});

	jQuery('.faq-thumbs').on('click', '> ul > li > a', function (e) {
		var target = $(e.currentTarget);
		var idxf = target.parent().index();
		jQuery('.faq-thumbs').changeActf(idxf);
	});
	//활성화 변경 jQuery 확장
	if (jQuery.fn.changeActf === undefined) {
		jQuery.fn.changeActf = function (idxf) {
			if (this.is('.faq-thumbs')) {
				this.find('> ul > li').removeClass('on').eq(idxf).addClass('on');
				if (this.hasClass('swiper-container')) {
					var swiper = this[0].swiper;
					swiper.slideTo(Math.max(idxf - 1, 0));
				}
			}
		};
	};
	
});
/*****리스트 및 겔러리 변환 아이콘*****/
var toggle_list = function(id) {
	var e = document.getElementById(id);
	if(e.style.display == 'block') {
		e.style.display = 'none';
		$("#tab1").css("display","block");
		$(".chgview").css("background-position","-15px -10px");
	} else {
		e.style.display = 'block';
		$("#tab1").css("display","none");
		$(".chgview").css("background-position","-15px -53px");
	};
}
var toggle_list2 = function(id) {
	var e = document.getElementById(id);
	if(e.style.display == 'block') {
		e.style.display = 'none';
		$("#tab1").css("display","block");
		$(".chgview").css("background-position","-15px -12px");
	} else {
		e.style.display = 'block';
		$("#tab1").css("display","none");
		$(".chgview").css("background-position","-15px -56px");
	};
}