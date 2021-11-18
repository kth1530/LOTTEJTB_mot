package com.lottejtb.llst.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.ehcache.Ehcache;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.lottejtb.goods.rn.service.RNETMstVO;
import com.lottejtb.goods.rn.service.RNGDSchdVO;
import com.lottejtb.goods.rn.service.RNGDTagsVO;
import com.lottejtb.goods.rn.service.RNGoodsService;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class St11Controller {

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
    @Resource(name = "ehcache")
    Ehcache ehcache;
	
	
	@Resource(name = "RNGoodsService")
	private RNGoodsService rnGoodsService;
	
	
	private final Logger logger = Logger.getLogger(this.getClass());
	private final String _rootPath = "/";
	private final int PAGESIZE = 10;

	// <!-- 상품 상세 -->
	@RequestMapping(value = {"/11st/schedule.do", "/ebay/schedule.do", "/wmp/schedule.do"} ,method={RequestMethod.GET, RequestMethod.POST})
	public String schedule(@RequestParam("ctg") String ctg, @RequestParam("eventCd") String eventCd, HttpServletRequest request, ModelMap model)throws Exception{
		
		String flag = (String) request.getParameter("flag");
		
		String goodsCd = "";
		if(eventCd != null && !eventCd.equals("")) 
			goodsCd = eventCd.substring(0, 7);
		
		
		if(logger.isInfoEnabled()) {
			logger.info("ctg : " + ctg);
			logger.info("goodsCd : " + goodsCd);
			logger.info("eventCd : " + eventCd);
		}
		

		System.out.println("ctg : " + ctg);
		System.out.println("goodsCd : " + goodsCd);
		System.out.println("eventCd : " + eventCd);
		
		/** 행사 상품 태그 조회 **/
		RNGDTagsVO rnGDTagsParam = new RNGDTagsVO();
		rnGDTagsParam.setEvent_cd(eventCd);
		
		RNGDTagsVO rnGDTagsResult = new RNGDTagsVO();
		rnGDTagsResult = (RNGDTagsVO) rnGoodsService.srchGDTags(rnGDTagsParam);
		
		/** 행사 상품 이벤트 조회 **/
		RNETMstVO rnEtMstParam = new RNETMstVO();
		rnEtMstParam.setEvent_cd(eventCd);
		rnEtMstParam.setComp_cd(rnGDTagsResult.getComp_cd());
		rnEtMstParam.setGoods_cd(goodsCd);
		
		RNETMstVO rnEtMstResult = new RNETMstVO();
		rnEtMstResult = (RNETMstVO) rnGoodsService.srchETMst(rnEtMstParam);
		
		/** 행사 상품 공통 코드 리스트 조회 **/
		RNGDSchdVO rnGDCommSchdParam = new RNGDSchdVO();
		rnGDCommSchdParam.setEvent_cd(eventCd);
		List rnGDCommSchdList = (List) rnGoodsService.srchGDCommSchdList(rnGDCommSchdParam);
		
		/** 행사 상품 일정표 리스트 조회 **/
		RNGDSchdVO rnGDSchdParam = new RNGDSchdVO();
		rnGDSchdParam.setEvent_cd(eventCd);
		List rnGDSchdList = (List) rnGoodsService.srchGDSchdList(rnGDSchdParam);
		

		model.addAttribute("ctg", ctg);
		model.addAttribute("goodsCd", goodsCd);		
		model.addAttribute("eventCd", eventCd);
		model.addAttribute("flag", flag);
		
		model.addAttribute("rnEtMst", rnEtMstResult);
		model.addAttribute("rnGDCommSchdList", rnGDCommSchdList);
		model.addAttribute("rnGDSchdList", rnGDSchdList);
		
		
		return _rootPath+"11st/schedule";
	}
	
	// <!-- 상품 상세 -->
	@RequestMapping(value = "/11st/11st_detail.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String detail_11st(@RequestParam("ctg") String ctg, @RequestParam("eventCd") String eventCd, HttpServletRequest request, ModelMap model)throws Exception{
		
		
		String goodsCd = "";
		if(eventCd != null && !eventCd.equals("")) 
			goodsCd = eventCd.substring(0, 7);
		
		
		if(logger.isInfoEnabled()) {
			logger.info("ctg : " + ctg);
			logger.info("goodsCd : " + goodsCd);
			logger.info("eventCd : " + eventCd);
		}
		
		
		System.out.println("ctg : " + ctg);
		System.out.println("goodsCd : " + goodsCd);
		System.out.println("eventCd : " + eventCd);
		

		/** 행사 상품 공통 코드 리스트 조회 **/
		RNGDSchdVO rnGDCommSchdParam = new RNGDSchdVO();
		rnGDCommSchdParam.setEvent_cd(eventCd);
		List rnGDCommSchdList = (List) rnGoodsService.srchGDCommSchdList(rnGDCommSchdParam);
		
		model.addAttribute("ctg", ctg);
		model.addAttribute("goodsCd", goodsCd);		
		model.addAttribute("eventCd", eventCd);
		

		model.addAttribute("rnGDCommSchdList", rnGDCommSchdList);
		

	
		return _rootPath+"11st/11st_detail";
	}
	
	// <!-- 상품 상세 -->
	@RequestMapping(value = "/11st/11st_detail2.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String detail_11st2(@RequestParam("ctg") String ctg, @RequestParam("eventCd") String eventCd, HttpServletRequest request, ModelMap model)throws Exception{
		
		
		String goodsCd = "";
		if(eventCd != null && !eventCd.equals("")) 
			goodsCd = eventCd.substring(0, 7);
		
		
		if(logger.isInfoEnabled()) {
			logger.info("ctg : " + ctg);
			logger.info("goodsCd : " + goodsCd);
			logger.info("eventCd : " + eventCd);
		}
		
		
		System.out.println("ctg : " + ctg);
		System.out.println("goodsCd : " + goodsCd);
		System.out.println("eventCd : " + eventCd);
		

		/** 행사 상품 공통 코드 리스트 조회 **/
		RNGDSchdVO rnGDCommSchdParam = new RNGDSchdVO();
		rnGDCommSchdParam.setEvent_cd(eventCd);
		List rnGDCommSchdList = (List) rnGoodsService.srchGDCommSchdList(rnGDCommSchdParam);
		
		model.addAttribute("ctg", ctg);
		model.addAttribute("goodsCd", goodsCd);		
		model.addAttribute("eventCd", eventCd);
		

		model.addAttribute("rnGDCommSchdList", rnGDCommSchdList);
		

	
		return _rootPath+"11st/11st_detail2";
	}
	
	
	// <!-- 상품 상세 -->
	@RequestMapping(value = "/11st/11st_detail3.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String detail_11st3(@RequestParam("ctg") String ctg, @RequestParam("eventCd") String eventCd, HttpServletRequest request, ModelMap model)throws Exception{
		
		
		String goodsCd = "";
		if(eventCd != null && !eventCd.equals("")) 
			goodsCd = eventCd.substring(0, 7);
		
		
		if(logger.isInfoEnabled()) {
			logger.info("ctg : " + ctg);
			logger.info("goodsCd : " + goodsCd);
			logger.info("eventCd : " + eventCd);
		}
		
		
		System.out.println("ctg : " + ctg);
		System.out.println("goodsCd : " + goodsCd);
		System.out.println("eventCd : " + eventCd);
		

		/** 행사 상품 공통 코드 리스트 조회 **/
		RNGDSchdVO rnGDCommSchdParam = new RNGDSchdVO();
		rnGDCommSchdParam.setEvent_cd(eventCd);
		List rnGDCommSchdList = (List) rnGoodsService.srchGDCommSchdList(rnGDCommSchdParam);
		
		model.addAttribute("ctg", ctg);
		model.addAttribute("goodsCd", goodsCd);		
		model.addAttribute("eventCd", eventCd);
		

		model.addAttribute("rnGDCommSchdList", rnGDCommSchdList);
		

	
		return _rootPath+"11st/11st_detail3";
	}
	
	// <!-- 상품 상세 -->
	@RequestMapping(value = "/11st/11st_detail4.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String detail_11st4(@RequestParam("ctg") String ctg, @RequestParam("eventCd") String eventCd, HttpServletRequest request, ModelMap model)throws Exception{
		
		
		String goodsCd = "";
		if(eventCd != null && !eventCd.equals("")) 
			goodsCd = eventCd.substring(0, 7);
		
		
		if(logger.isInfoEnabled()) {
			logger.info("ctg : " + ctg);
			logger.info("goodsCd : " + goodsCd);
			logger.info("eventCd : " + eventCd);
		}
		
		
		System.out.println("ctg : " + ctg);
		System.out.println("goodsCd : " + goodsCd);
		System.out.println("eventCd : " + eventCd);
		

		/** 행사 상품 공통 코드 리스트 조회 **/
		RNGDSchdVO rnGDCommSchdParam = new RNGDSchdVO();
		rnGDCommSchdParam.setEvent_cd(eventCd);
		List rnGDCommSchdList = (List) rnGoodsService.srchGDCommSchdList(rnGDCommSchdParam);
		
		model.addAttribute("ctg", ctg);
		model.addAttribute("goodsCd", goodsCd);		
		model.addAttribute("eventCd", eventCd);
		

		model.addAttribute("rnGDCommSchdList", rnGDCommSchdList);	
		
		return _rootPath+"goods/11st_detail4";
	}	
	
	
	// <!-- 표준 약관 보기  -->
	@RequestMapping(value = "/11st/11st_policy.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String pop_policy(@RequestParam("ctg") String ctg, @RequestParam("eventCd") String eventCd, ModelMap model)throws Exception {
	
		
		String goodsCd = "";
		if(eventCd != null && !eventCd.equals("")) 
			goodsCd = eventCd.substring(0, 7);
		
		
		if(logger.isInfoEnabled()) {
			logger.info("ctg : " + ctg);
			logger.info("goodsCd : " + goodsCd);
			logger.info("eventCd : " + eventCd);
		}
		
		int startRow = 1;
		int endRow = PAGESIZE;
		
		System.out.println("ctg : " + ctg);
		System.out.println("goodsCd : " + goodsCd);
		System.out.println("eventCd : " + eventCd);
		
		/** 행사 상품 태그 조회 **/
		RNGDTagsVO rnGDTagsParam = new RNGDTagsVO();
		rnGDTagsParam.setEvent_cd(eventCd);
		
		RNGDTagsVO rnGDTagsResult = new RNGDTagsVO();
		rnGDTagsResult = (RNGDTagsVO) rnGoodsService.srchGDTags(rnGDTagsParam);
		
		/** 행사 상품 이벤트 조회 **/
		RNETMstVO rnEtMstParam = new RNETMstVO();
		rnEtMstParam.setEvent_cd(eventCd);
		rnEtMstParam.setComp_cd(rnGDTagsResult.getComp_cd());
		rnEtMstParam.setGoods_cd(goodsCd);
		
		RNETMstVO rnEtMstResult = new RNETMstVO();
		rnEtMstResult = (RNETMstVO) rnGoodsService.srchETMst(rnEtMstParam);
		

		

		
		model.addAttribute("ctg", ctg);
		model.addAttribute("goodsCd", goodsCd);		
		model.addAttribute("eventCd", eventCd);
		
		model.addAttribute("rnEtMst", rnEtMstResult);
		
		return _rootPath+"11st/11st_policy";
	}
	
}
