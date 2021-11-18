var pagingjs = pagingjs || new Object();
var pageOption = {	//페이징 정보(기본값)
	viewCnt : 10,
	pagingCnt : 10,
	totCnt : 0,
	nowpage : 1,
	maxpage : 10,
	funcname : '',
	div : ''
};

var pageInfo = {	// 리스트 노출 항목 
	start : 1,
	end : 10
};

var e_cnt = 10;	//출력개수

//페이징
pagingjs = {
	/**
	 * 최초 선언
	 */	
	init : function(_div, _totCnt, _func, _viewCnt, _pagingCnt) {
		pageOption = {	//페이징 정보(기본값)
			viewCnt : 10,
			pagingCnt : 10,
			totCnt : 0,
			nowpage : 1,
			maxpage : 10,
			funcname : '',
			div : ''
		};

		pageInfo = {	// 리스트 노출 항목 
			start : 1,
			end : 10
		};
		
		pageOption.totCnt = _totCnt;
		
		//_div = $('div.pagination'), _totCnt=전체숫자, _viewCnt=페이지당 보여줄숫자
		if(_viewCnt != undefined) {
			pageOption.viewCnt = _viewCnt;
		}
		
		if(pageOption.viewCnt > _totCnt) {
			pageOption.viewCnt = _totCnt;
		}
		
		if(_pagingCnt != undefined) {
			pageOption.pagingCnt = _pagingCnt;
		}
		
		if(_func != undefined) {
			pageOption.funcname = _func;
		}
		
		if(_div != undefined) {
			pageOption.div = _div;
		}
		
		var tot_page_cnt = Math.ceil(_totCnt / pageOption.viewCnt);	//전체 페이지 수
		pageOption.maxpage = tot_page_cnt;
		
		if(pageOption.pagingCnt > tot_page_cnt) {
			pageOption.pagingCnt = tot_page_cnt;
		}
		console.log(">>>>>>>>>>>>>>>>>>> pagingjs.init() ");
		
		// pageOption.div.html('');
		/**
		var drawStr = 	'<a class="s_prev" ft-att="vec" ft-data="1" title="처음페이지로" href="javascript:void(0);">첫페이지</a>	'
					+	'<a class="prev" ft-att="vec" ft-data="prev" title="이전" href="javascript:void(0);">이전</a>  			'
					+	'<div class="numbers">                             							'
					+	'</div>                                            							'
					+	'<a class="next" ft-att="vec" ft-data="next" title="다음" href="javascript:void(0);">다음</a>  			'
					+	'<a class="s_next" ft-att="vec" ft-data="' + tot_page_cnt + '" title="끝페이지로" href="javascript:void(0);">마지막페이지</a>	';
		pageOption.div.append(drawStr);
		
		$('div.pagination').find('a').on('click', eval(pageOption.funcname));
		**/
		return this.draw();
	},
	/**
	 * 숫자 생성 
	 */
	draw : function() {
		/*var pageOption = {	//페이징 정보(기본값)
				viewCnt : 10,
				pagingCnt : 10,
				totCnt : 0,
				nowpage : 1,
				maxpage : 10,
				funcname : ''
			};*/
		var pagingGr = Math.ceil(pageOption.nowpage/pageOption.pagingCnt);
		var stPage = ((pagingGr-1)*pageOption.pagingCnt)+1;
		var enPage = pagingGr*pageOption.pagingCnt;
		
		if(enPage > pageOption.maxpage) {
			enPage = pageOption.maxpage;
		}
		/**
		var number_div = $('div.pagination').find('div.numbers');
		number_div.html('');
		for(var p_idx=stPage; p_idx<=enPage; p_idx++) {
			number_div.append('<a href="javascript:void(0);" value="' + p_idx + '">' + p_idx + '</a>');
		}
		
		number_div.find('a[value="' + pageOption.nowpage + '"]').addClass('current');

		number_div.find('a').on('click', eval(pageOption.funcname));
		**/
		//버튼 제어
		//this.control_btn;
		
		//노출 항목
		pageInfo = {
			start : ((pageOption.nowpage-1)*pageOption.viewCnt)+1,
			end : pageOption.nowpage*pageOption.viewCnt
		};
		
		return pageInfo;
	},
	/**
	 * 페이지 이동
	 */
	mvpage : function(_selNo) {
		_selNo = _selNo-0;
		if(pageOption.nowpage==_selNo){
			return pageInfo;
		} else if(_selNo > 0 && _selNo <= pageOption.maxpage) {
			
			// var selpage = $('div.pagination').find('div.numbers > a[value="' + _selNo + '"]');			//이동할 페이지
			
			// if(selpage.length > 0) {
				// var nowpage = $('div.pagination').find('div.numbers > a[value="' + pageOption.nowpage + '"]'); //현재 페이지
				
				// nowpage.removeClass('current');
				// selpage.addClass('current');
				
				pageOption.nowpage = _selNo;
				
				//마지막 항목 숫자
				var endpage = pageOption.viewCnt * _selNo;
				if(endpage > pageOption.totCnt) {
					endpage = pageOption.totCnt;
				}
				
				pageInfo = {
					start : ((_selNo-1) * pageOption.viewCnt) + 1,
					end : endpage
				};
				
				return pageInfo;
			/** 
			} else {
				pageOption.nowpage = _selNo;
				return this.draw();
			}
			**/
		} else {
			return pageInfo;
		}
		
		
	},
	/**
	 * 이전, 다음버튼 노출 제어 - 사용 안함
	 */
	control_btn : function () {		
		//이전버튼 제어
		if(pageOption.nowpage == 1){
			pageOption.div.find('a.prev').hide();
			pageOption.div.find('a.s_prev').hide();
		} else {
			pageOption.div.find('a.prev').show();
			pageOption.div.find('a.s_prev').show();
		}
		
		//다음버튼 제어
		if(pageOption.nowpage == Math.ceil(pageOption.totCnt / pageOption.viewCnt)){
			pageOption.div.find('a.next').hide();
			pageOption.div.find('a.s_next').hide();
		} else {
			pageOption.div.find('a.next').show();
			pageOption.div.find('a.s_next').show();
		}
	}
};
