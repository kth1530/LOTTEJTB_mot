package com.lottejtb.main.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.ehcache.Ehcache;
import net.sf.ehcache.Element;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.lottejtb.comm.service.CommFileService;
import com.lottejtb.comm.service.CommFileVO;
import com.lottejtb.comm.util.CommInfo;
import com.lottejtb.front.air.service.AirService;
import com.lottejtb.main.service.CodeDetailVO;
import com.lottejtb.main.service.MainService;
import com.lottejtb.main.service.MainVO;
import com.lottejtb.main.service.MenuVO;
import com.lottejtb.main.service.PromoVO;
import com.lottejtb.main.service.RankVO;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class MainController {
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
    @Resource(name = "ehcache")
    Ehcache ehcache;
	
	@Resource(name = "MainService")
	private MainService mainService;
	
    @Resource(name = "CommFileService")
    private CommFileService fileService;

	@Resource(name = "AirService")
	private AirService airService;
	
	private final Logger logger = Logger.getLogger(this.getClass());
	private final String _rootPath = "/";
	private final int PAGESIZE = 10;
	
	@RequestMapping(value = "/default.do",method = RequestMethod.GET )
	public String defaultMain(@ModelAttribute MainVO vo,HttpServletRequest request, Model model) throws Exception {
	    
	    Ehcache cache = ehcache.getCacheManager().getCache("chcache-properties");
	    List<MainVO> resultList = null;
	    List<CommFileVO> fileList = null;
	    
	    CommFileVO fileVo = new CommFileVO();
	    fileVo.setTbl("imsi");
	    fileVo.setParentNum("1");
	    
	    try {
	        Element cacheInfo1 = cache.get("cacheInfo1");
	        Element cacheInfo2 = cache.get("cacheInfo2");
	        fileList   = fileService.selectFileList(fileVo); // 업로드 후 리스트를 불러와야 하므로 캐시에 넣지 않는다.
	        if( cacheInfo1 == null ){
	            System.out.println("//NO Cache");
	            resultList = mainService.selectList(vo);
	            cache.put(new Element( "cacheInfo1", resultList  ));
	            cache.put(new Element( "cacheInfo2", fileList  ));
	        }else{
	            System.out.println("//IN Cache");
	            resultList = (List<MainVO>)     cacheInfo1.getObjectValue();
	        }
        } catch (Exception e) {
            //e.printStackTrace();
        	System.err.println("Cache Error!");
        }
	    
        model.addAttribute("resultList" , resultList );
        model.addAttribute("fileList" , fileList );
	    
		return _rootPath+"default";
	}
	
	@RequestMapping(value = "/main.do",method = RequestMethod.GET )
	public String main(@ModelAttribute MainVO vo,HttpServletRequest request, Model model) throws Exception {
		model.addAttribute("pageSize", PAGESIZE);
		
		return _rootPath+"main";
	}
	
	@RequestMapping(value = "/et.do",method = RequestMethod.GET )
	public String et(HttpServletRequest request, Model model) throws Exception {
		String eventCd = (String) request.getParameter("eventCd");
		
		model.addAttribute("eventCd", eventCd);
		
		return _rootPath+"et";
	}
	
	/** 디바이스 정보 저장 **/
	@RequestMapping(value = "/insertDeviceInfo.do",method={RequestMethod.GET, RequestMethod.POST})
	public String bannerList(@ModelAttribute("MainVO") MainVO vo, HttpServletRequest request,ModelMap model) throws Exception{
		int existYn = mainService.selectDeviceInfoCnt(vo);
		
		if(existYn == 0){
			mainService.insertDeviceInfo(vo);
		}else{
			mainService.updateDeviceInfo(vo);
		}
		
	    return "jsonView";
	}
	
	/** 배너리스트 조회 **/
	@RequestMapping(value = "/bannerList.do",method={RequestMethod.GET, RequestMethod.POST})
	public String bannerList(@ModelAttribute("PromoVO") PromoVO vo, HttpServletRequest request,ModelMap model) throws Exception{
	    List<PromoVO> list = new ArrayList<PromoVO>();
	    ArrayList<PromoVO> tempList = new ArrayList<PromoVO>();
	    long keySeq = 0;

	    list = mainService.bannerList(vo);
	    
	    for(PromoVO datas : list){
	    	keySeq = datas.getKeySeq();
	    	
	    	if(keySeq == 0){
	    		model.addAttribute(datas.getDivision(), tempList.clone());
	    		
	    		tempList.clear();
	    	}else{
	    		tempList.add(datas);
	    	}
	    }
	    
	    model.addAttribute("list", list);
		
	    return "jsonView";
	}
	
	/** 메뉴리스트 조회 **/
	@RequestMapping(value = "/menuList.do",method={RequestMethod.GET, RequestMethod.POST})
	public String menuList(@ModelAttribute("MenuVO") MenuVO vo, HttpServletRequest request,ModelMap model) throws Exception{
		/*
		HashMap<String, Object> parameter = new HashMap<String, Object>();
		String ctgCodes = vo.getCtgCode();
		String[] ctgCode = ctgCodes.split(",");
		
		for(int i = 0; i < ctgCode.length ; i++){
			parameter.put("ctgCode", ctgCode[i]);
			
			model.addAttribute(ctgCode[i], mainService.menuList(parameter));
		}
		*/
		
		ArrayList<MenuVO> tempList = new ArrayList<MenuVO>();
		HashMap<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("ctgCode", vo.getCtgCode());
		
		List<MenuVO> list = mainService.menuList(parameter);
		
		try{
			for(MenuVO data : list){
				int thisCtgSeq = data.getCtgSeq();
				
				if(thisCtgSeq == 0){
					model.addAttribute(data.getCtgUprSeq()+"", tempList.clone());

					tempList.clear();
				}else{
					tempList.add(data);
					model.addAttribute(data.getCtgUprSeq()+"", tempList.clone());
				}
			}
		}catch(Exception e){
			//e.printStackTrace();
			System.err.print("model Set || ArrayList Error!");
		}
		
	    return "jsonView";
	}
	
	/** 코드리스트 조회 **/
	@RequestMapping(value = "/codeDetailList.do",method={RequestMethod.GET, RequestMethod.POST})
	public String codeDetailList(@ModelAttribute("CodeDetailVO") CodeDetailVO vo, HttpServletRequest request,ModelMap model) throws Exception{
		List<CodeDetailVO> list = mainService.codeDetailList(vo);
		
		/*
		List<PromoVO> detailList = new ArrayList<PromoVO>();
		ArrayList<PromoVO> tempList = new ArrayList<PromoVO>();
		PromoVO promoVO = new PromoVO();
		int i = 0;
		long keySeq = 0;
		
		String tabCodes = "";
		
		for(CodeDetailVO codeVo : list){
			tabCodes += codeVo.getCd() + ",";
		}
		
		promoVO.setDivision(vo.getGrpCd());
		promoVO.setTabCode(tabCodes);
		
		detailList = mainService.bestDetailList(promoVO);
		
		
		for(PromoVO detailVO : detailList){
			keySeq = detailVO.getKeySeq();
			if(keySeq == 0){
				model.addAttribute(detailVO.getTabCode(), tempList.clone());
				
				tempList.clear();
			}else{
				tempList.add(detailVO);
			}
		}
		*/
		model.addAttribute("list", list);
		
	    return "jsonView";
	}
	
	/** 코드리스트 조회 **/
	@RequestMapping(value = "/bestDetailList.do",method={RequestMethod.GET, RequestMethod.POST})
	public String bestDetailList(@ModelAttribute("PromoVO") PromoVO vo, HttpServletRequest request,ModelMap model) throws Exception{
		List list = mainService.bestDetailList(vo);
		
		model.addAttribute("list", list);
		
	    return "jsonView";
	}
	
	/** 메뉴맵 조회 **/
	@RequestMapping(value = "/menuMapList.do",method={RequestMethod.GET, RequestMethod.POST})
	public String menuMapList(@ModelAttribute("MenuVO") MenuVO vo, HttpServletRequest request,ModelMap model) throws Exception{
		List list = mainService.menuMapList(vo);
		
		model.addAttribute("list", list);
		
	    return "jsonView";
	}
	
	/** 실시간 RANK **/
	@RequestMapping(value = "/realRanking.do",method={RequestMethod.GET, RequestMethod.POST})
	public String realRanking(@ModelAttribute("RankVO") RankVO vo, HttpServletRequest request,ModelMap model) throws Exception{
		List list = mainService.realRanking(vo);
		
		model.addAttribute("list", list);
		
		return "jsonView";
	}
	
	/** 핫한 여행가기 **/
	@RequestMapping(value = "/selectHotGoods.do",method={RequestMethod.GET, RequestMethod.POST})
	public String selectHotGoods(HttpServletRequest request, ModelMap model) throws Exception{
		HashMap<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("startRow", request.getParameter("startRow"));
		parameter.put("endRow", request.getParameter("endRow"));
		
		List list = mainService.selectHotGoods(parameter);
		
		model.addAttribute("list", list);
		
		return "jsonView";
	}
	
	/** 광고팝업 **/
	@RequestMapping(value = "/selectAdPop.do", method={RequestMethod.GET, RequestMethod.POST})
	public String selectAdPop(HttpServletRequest request, ModelMap model) throws Exception{
		HashMap<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("division", request.getParameter("division"));
		
		Object result = mainService.selectAdPop(parameter);
		
		model.addAttribute("result", result);
		
		return "jsonView";
	}
	
	/** 타입특가 **/
	@RequestMapping(value = "/selectTimeGoods.do", method={RequestMethod.GET, RequestMethod.POST})
	public String selectTimeGoods(HttpServletRequest request, ModelMap model) throws Exception{
		HashMap<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("division", request.getParameter("division"));
		
		List list = mainService.selectTimeGoods(parameter);
		
		model.addAttribute("list", list);
		
		return "jsonView";
	}
	
	/** 타입특가 **/
	@RequestMapping(value = "/updateHitCount.do", method={RequestMethod.GET, RequestMethod.POST})
	public String updateHitCount(HttpServletRequest request, ModelMap model) throws Exception{
		HashMap<String, Object> parameter = new HashMap<String, Object>();
		
		parameter.put("division", request.getParameter("division"));
		parameter.put("tabCode", request.getParameter("tabCode"));
		parameter.put("keySeq", request.getParameter("keySeq"));
		
		mainService.updateHitCount(parameter);
		
		return "jsonView";
	}
	
	
	/******************************************* 자유여행 파트 *******************************************/ 
	@RequestMapping(value = "/free/main.do", method =  {RequestMethod.GET, RequestMethod.POST} )
	public String main(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		String custCd = "";

		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
		}
		String sellDate = "";
		try {
			JSONObject result = airService.getAirSellDate(custCd);
			sellDate = result.get("data").toString();
			System.out.println("sellDate : " + sellDate);
			
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.println("Air Sel Date Error!");
		}
		
		model.addAttribute("sellDate", sellDate);		
		model.addAttribute("tabType", request.getParameter("tabType"));
		model.addAttribute("domesticYn", request.getParameter("domesticYn"));
		model.addAttribute("remainYN", request.getParameter("remainYN"));
		
		return _rootPath+"free/main";
	}

	/* 국내호텔 모바일 추가 2019.02.28 bum */
	@RequestMapping(value = "/free/mainDome.do", method =  {RequestMethod.GET, RequestMethod.POST} )
	public String mainDome(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		String custCd = "";

		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
		}
		String sellDate = "";
		try {
			JSONObject result = airService.getAirSellDate(custCd);
			sellDate = result.get("data").toString();
			System.out.println("sellDate : " + sellDate);
			
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.println("Air Sel Date Error!");
		}
		
		model.addAttribute("sellDate", sellDate);		
		model.addAttribute("tabType", request.getParameter("tabType"));
		model.addAttribute("domesticYn", "Y");
		model.addAttribute("remainYN", request.getParameter("remainYN"));
		
		return _rootPath+"free/mainDome";
	}
	
	@RequestMapping(value = "/free/main1.do", method =  {RequestMethod.GET, RequestMethod.POST} )
	public String main1(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		String custCd = "";

		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
		}
		String sellDate = "";
		try {
			JSONObject result = airService.getAirSellDate(custCd);
			sellDate = result.get("data").toString();
			System.out.println("sellDate : " + sellDate);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("sellDate", sellDate);		
		model.addAttribute("tabType", request.getParameter("tabType"));
		model.addAttribute("domesticYn", request.getParameter("domesticYn"));
		model.addAttribute("remainYN", request.getParameter("remainYN"));
		
		return _rootPath+"free/main1";
	}
	
	
	@RequestMapping(value = "/free/search_result_air.do", method =  {RequestMethod.GET, RequestMethod.POST} )
	public String search_result_air(HttpServletRequest request, Model model) throws Exception {
	    
		String selAir = (String) request.getParameter("selAir");
		String selHotel = (String) request.getParameter("selHotel");
		String selRentcar = (String) request.getParameter("selRentcar");
		
		System.out.println("selAir : " + selAir);
		System.out.println("selHotel : " + selHotel);
		System.out.println("selRentcar : " + selRentcar);
		
		if(selAir == null || selAir.equals("")) selAir = "N";
		if(selHotel == null || selHotel.equals("")) selHotel = "N";
		if(selRentcar == null || selRentcar.equals("")) selRentcar = "N";
		
		model.addAttribute("selAir", selAir);
		model.addAttribute("selHotel", selHotel);
		model.addAttribute("selRentcar", selRentcar);
		
		return _rootPath+"free/search_result_air";
	}
	
	@RequestMapping(value = "/free/search_result_rentcar.do", method =  {RequestMethod.GET, RequestMethod.POST} )
	public String search_result_rentcar(HttpServletRequest request, Model model) throws Exception {
		String selAir = (String) request.getParameter("selAir");
		String selHotel = (String) request.getParameter("selHotel");
		String selRentcar = (String) request.getParameter("selRentcar");
		String vendorId = request.getParameter("vendorId");
		String pkOagCode = request.getParameter("pkOagCode");
		String rtOagCode = request.getParameter("rtOagCode");
		String type = request.getParameter("type");
		
		if(selAir == null || selAir.equals("")) selAir = "N";
		if(selHotel == null || selHotel.equals("")) selHotel = "N";
		if(selRentcar == null || selRentcar.equals("")) selRentcar = "N";
		
		model.addAttribute("selAir", selAir);
		model.addAttribute("selHotel", selHotel);
		model.addAttribute("selRentcar", selRentcar);
		model.addAttribute("vendorId", vendorId);
		model.addAttribute("pkOagCode", pkOagCode);
		model.addAttribute("rtOagCode", rtOagCode);
		model.addAttribute("pageSize", PAGESIZE);
		model.addAttribute("type", type);
		
		return _rootPath+"free/search_result_rentcar";
	}
	
	@RequestMapping(value = "/free/search_result_rentcar_office.do", method =  {RequestMethod.GET, RequestMethod.POST} )
	public String search_result_rentcar_office(HttpServletRequest request, Model model) throws Exception {
		String selAir = (String) request.getParameter("selAir");
		String selHotel = (String) request.getParameter("selHotel");
		String selRentcar = (String) request.getParameter("selRentcar");
		
		if(selAir == null || selAir.equals("")) selAir = "N";
		if(selHotel == null || selHotel.equals("")) selHotel = "N";
		if(selRentcar == null || selRentcar.equals("")) selRentcar = "N";
		
		model.addAttribute("selAir", selAir);
		model.addAttribute("selHotel", selHotel);
		model.addAttribute("selRentcar", selRentcar);
		
		model.addAttribute("pageSize", PAGESIZE);
		
		return _rootPath+"free/search_result_rentcar_office";
	}

	@RequestMapping(value = "/free/search_result_no.do", method =  {RequestMethod.GET, RequestMethod.POST})
	public String search_result_no(HttpServletRequest request, Model model) throws Exception {
	    
		return _rootPath+"free/search_result_no";
	}
	
	@RequestMapping(value = "/free/search_result_hotel.do", method =  {RequestMethod.GET, RequestMethod.POST})
	public String search_result_hotel(HttpServletRequest request, Model model) throws Exception {
	    
		String selAir = (String) request.getParameter("selAir");
		String selHotel = (String) request.getParameter("selHotel");
		String selRentcar = (String) request.getParameter("selRentcar");
		String type = (String) request.getParameter("type");
		
		System.out.println("selAir : " + selAir);
		System.out.println("selHotel : " + selHotel);
		System.out.println("selRentcar : " + selRentcar);
		System.out.println("type : " + type);
		
		if(selAir == null || selAir== "") selAir = "N";
		if(selHotel == null || selHotel== "") selHotel = "N";
		if(selRentcar == null || selRentcar== "") selRentcar = "N";
		
		model.addAttribute("selAir", selAir);
		model.addAttribute("selHotel", selHotel);
		model.addAttribute("selRentcar", selRentcar);
		model.addAttribute("type", type);
		return _rootPath+"free/search_result_hotel";
	}
	
	//호텔상세
	@RequestMapping(value = "/free/hotel_detail_hotel.do", method =  {RequestMethod.GET, RequestMethod.POST})
	public String hotel_detail(HttpServletRequest request, Model model) throws Exception {
	
		String selAir = (String) request.getParameter("selAir");
		String selHotel = (String) request.getParameter("selHotel");
		String selRentcar = (String) request.getParameter("selRentcar");
		
		System.out.println("selAir : " + selAir);
		System.out.println("selHotel : " + selHotel);
		System.out.println("selRentcar : " + selRentcar);
		
		if(selAir == null || selAir== "") selAir = "N";
		if(selHotel == null || selHotel== "") selHotel = "N";
		if(selRentcar == null || selRentcar== "") selRentcar = "N";
		
		model.addAttribute("selAir", selAir);
		model.addAttribute("selHotel", selHotel);
		model.addAttribute("selRentcar", selRentcar);
	    
		return _rootPath+"free/hotel_detail";
	}
	
	@RequestMapping(value = "/free/rentcar_workstore.do", method =  {RequestMethod.GET, RequestMethod.POST})
	public String rentcar_workstore(HttpServletRequest request, Model model) throws Exception {
	    
		return _rootPath+"free/rentcar_workstore";
	}
	/******************************************* 자유여행 파트 *******************************************/
}