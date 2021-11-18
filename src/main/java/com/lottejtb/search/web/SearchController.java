package com.lottejtb.search.web;

import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.lottejtb.comm.service.CommCtgVO;
import com.lottejtb.goods.service.EventListDTO;
import com.lottejtb.search.service.SearchGoodsVO;
import com.lottejtb.search.service.SearchService;
import com.lottejtb.search.service.TourMentoVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import net.sf.ehcache.Ehcache;
import net.sf.json.JSONArray;

@Controller
public class SearchController {
	private final Logger logger = Logger.getLogger(this.getClass());
	private final String _rootPath = "/";
	private final int PAGESIZE = 10;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
    @Resource(name = "ehcache")
    Ehcache ehcache;
	
	@Resource(name = "SearchService")
	private SearchService searchService;
	
	
	// <!-- 상품 리스트 -->
	@RequestMapping(value = "/search/search.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String search(@RequestParam("searchKeyword") String searchKeyword, HttpServletRequest request, ModelMap model)throws Exception {
	
		int startRow = 1;
		int endRow = PAGESIZE;
		String orderby = "01";
		String rtnUrl = "search/searchList";
		
		String srchType = request.getParameter("sechType");
		if("TM".equals(srchType)){

			rtnUrl = "search/searchTourMento";
			
			String decodeKeyword = URLDecoder.decode(searchKeyword, "UTF-8");			
			
			//지역 대분류
			CommCtgVO cvo = new CommCtgVO();
			cvo.setCtg_upr_seq("5741");
			List<CommCtgVO> area =  searchService.selectAreaList(cvo);	

			//일정조회
			TourMentoVO param = new TourMentoVO();
			
			
			String[] ctg_seq = decodeKeyword.split(",");
			String[] ctglist = new String[ctg_seq.length];
			
			for(int i = 0; i < ctg_seq.length; i++){
				
				ctglist[i] = ctg_seq[i];
			}			
			
			List<String> sechCate = Arrays.asList(ctglist);
			param.setSechMento(sechCate);			
			
			List<TourMentoVO> resultList =  searchService.selectTourMentoList(param);	
			int resultCnt = searchService.selectTourMentoListCnt(param);			
			
			JSONArray jsonArray = JSONArray.fromObject(resultList);

			model.addAttribute("area", area);
			model.addAttribute("resultList", jsonArray);
			model.addAttribute("resultCnt", resultCnt);
			model.addAttribute("srchType", decodeKeyword);
		}
		
		model.addAttribute("pageSize", PAGESIZE);	
		model.addAttribute("orderby", orderby);
		model.addAttribute("searchKeyword", searchKeyword);
		
		
		return _rootPath + rtnUrl;
	}

	// <!-- 투어멘토링 지역 소분류 조회  -->
	@RequestMapping(value = "/search/selectSubAreaAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String selectSubAreaAjax(@ModelAttribute("CommCtgVO") CommCtgVO cvo,  ModelMap model) throws Exception{

		List<CommCtgVO> area =  searchService.selectAreaList(cvo);	

		model.addAttribute("area", area);
		return "jsonView";
	}
	
	// <!-- 상품명 검색 리스트 조회  -->
	@RequestMapping(value = "/search/srchGoodsListAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String srchGoodsListAjax(@RequestParam("searchKeyword") String searchKeyword,@RequestParam("orderby") String orderby, @RequestParam("ctg") String ctg, @ModelAttribute("SearchGoodsVO") SearchGoodsVO vo,  ModelMap model) throws Exception{
		
		int startRow = 1;
		int endRow = PAGESIZE;
		
		// <!-- 상품명 검색 리스트 조회-->
		vo.setSearchKeyword(searchKeyword);
		vo.setOrderby(orderby);
		vo.setEndRow(endRow);
		vo.setStartRow(startRow);
		if(ctg != null && !ctg.equals("")) {
			vo.setCtg_seq(Integer.parseInt(ctg));
		}		
		
		// 서버 날짜 받아오기 
		Date systemDate = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
		String startDay = sdf.format(systemDate);
		vo.setStart_day(startDay);
		
		System.out.println("searchKeyword : " + searchKeyword);		
		System.out.println("orderby : " + orderby);
		System.out.println("endRow : " + endRow);
		System.out.println("startRow : " + startRow);
		System.out.println("ctg : " + ctg);

		List list =  searchService.srchGoodsList(vo);		
		
		model.addAttribute("list", list);
		
		return "jsonView";
	}
	
	// <!-- 상품명 검색 리스트 카운트 조회-->
	@RequestMapping(value = "/search/srchGoodsListCountAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String srchGoodsListCountAjax(@RequestParam("searchKeyword") String searchKeyword, @RequestParam("ctg") String ctg, @ModelAttribute("SearchGoodsVO") SearchGoodsVO vo,  ModelMap model) throws Exception{
		
		System.out.println("searchKeyword : " + searchKeyword);		
		System.out.println("ctg : " + ctg);
		
		// <!-- 상품명 검색 리스트 조회-->
		vo.setSearchKeyword(searchKeyword);
		if(ctg != null && !ctg.equals("")) {
			vo.setCtg_seq(Integer.parseInt(ctg));
		}
		
		Integer totalSize =  searchService.srchGoodsListCount(vo);		
		
				
		model.addAttribute("totalSize", totalSize);
		if(ctg != null && !ctg.equals("")) {
			vo.setCtg_seq(Integer.parseInt(ctg));
		}		
		
		return "jsonView";
	}
	
	
	// <!-- (더보기) 상품명 검색 리스트 조회-->
	@RequestMapping(value = "/search/moreGoodsListAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String moreGoodsListAjax(@RequestParam("searchKeyword") String searchKeyword,@RequestParam("orderby") String orderby, @RequestParam("ctg") String ctg,  @RequestParam("startRow") String startRow, @RequestParam("endRow") String endRow, @ModelAttribute("SearchGoodsVO") SearchGoodsVO vo, ModelMap model) throws Exception{

		System.out.println("searchKeyword : " + searchKeyword);		
		System.out.println("orderby : " + orderby);
		System.out.println("endRow : " + endRow);
		System.out.println("startRow : " + startRow);
		System.out.println("ctg : " + ctg);

		// <!-- (더보기) 상품명 검색 리스트 조회-->
		vo.setSearchKeyword(searchKeyword);
		vo.setOrderby(orderby);
		vo.setEndRow(Integer.parseInt(endRow));	
		vo.setStartRow(Integer.parseInt(startRow));
		if(ctg != null && !ctg.equals("")) {
			vo.setCtg_seq(Integer.parseInt(ctg));
		}
		
		List list =  searchService.srchGoodsList(vo);		
		
		model.addAttribute("list", list);
		
		return "jsonView";
	}	
	
	
}
