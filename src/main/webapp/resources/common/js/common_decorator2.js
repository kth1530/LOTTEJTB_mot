jQuery(function(){
	/*****호텔 결과 상세 롤링이미지*****/
	var gallery = new Swiper('.re_ht_slider', {
		pagination: '.swiper-pagination',
		spaceBetween: 0,
		loop:true,
		autoplay: 2500,
		nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',
		followFinger: false,
		paginationType: 'fraction'
	});	
	/*****/
	/*****메인 상단 롤링이미지*****/
	var gallery = new Swiper('.m_tm_slider', {
		pagination: '.swiper-pagination',
		spaceBetween: 0,
		loop:true,
		autoplay: 25000000
	});	

	var swiper = new Swiper('.m_tm_listing', {
		loop:true,
		loopedSlides: 3,
		height:66,
		autoplay: 2500,
		direction: 'vertical'
	});
	/*****/
	/*****행사리스트 (마스터) 달력*****/
	var swiper = new Swiper('.sd_cld_list', {
        pagination: '.swiper-pagination',
        paginationClickable: true,
        slidesPerView: 7
    });
});