package com.lottejtb.planning.web;

import java.lang.reflect.Array;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.ehcache.Ehcache;

import org.apache.log4j.Logger;
import org.omg.CORBA.DATA_CONVERSION;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.bean.conf.loader.annotation.handler.Length;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.lottejtb.customer.service.NoticeVO;
import com.lottejtb.planning.service.PlanDate;
import com.lottejtb.planning.service.PlanMonth;
import com.lottejtb.planning.service.PlanningService;
import com.lottejtb.planning.service.PlanningVO;
import com.lottejtb.planning.service.impl.PlanningServiceImpl;
import com.lottejtb.util.Util;

import egovframework.rte.fdl.property.EgovPropertyService;


/*
 * 기획전  controller
 * 
 */

@Controller
public class PlanningController {
	
	//private int NUM = 10;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
    @Resource(name = "ehcache")
    Ehcache ehcache;
	
	@SuppressWarnings("unused")
	private Logger logger = Logger.getLogger(this.getClass());
	private final String _rootPath = "/";
	
	@Resource(name = "PlanningService")
	private PlanningService service;
	
	private List<PlanningVO> planList = new ArrayList<PlanningVO>();
	
	@RequestMapping(value = "/planning/planning.do",method={RequestMethod.GET, RequestMethod.POST})
	public String planning(HttpServletRequest request, ModelMap model) throws Exception {
		return _rootPath + "planning/planning";
	}
	
	
	@RequestMapping(value = "/planning/planning_detail.do",method={RequestMethod.GET, RequestMethod.POST})
	public String detail(HttpServletRequest request, ModelMap model) throws Exception {
		return _rootPath + "planning/planning_detail";
	}
	

	//기획전  목록조회
	@RequestMapping(value = "/planning/planningAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String planningAjax(@ModelAttribute("PlanningVO") PlanningVO vo, HttpServletRequest request,ModelMap model) throws Exception {
	
		Object list = service.srchAllPlanList(vo);
		
		System.out.println("[kkm]list=" + list.toString());
		
		model.addAttribute("list", list);
		
		return "jsonView";
	}
	
	//기획전 선택 목록 조회
	@RequestMapping(value= "/planning/selListPlanAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String selListPlanAjax(@ModelAttribute("PlanningVO") PlanningVO vo, HttpServletRequest request,ModelMap model) throws Exception {
		
		//vo.setStartRow(1);
		//vo.setEndRow(10);
		vo.setDispYn("Y");
		vo.setOptionYn("Y");
		
		List list = service.selPlanList(vo);
		int totalcnt = service.getTotalCnt(vo);
		
		model.addAttribute("list", list);
		model.addAttribute("totalcnt", totalcnt);
		
		return "jsonView";
	}
	
	//기획전  더보기 목록조회
	@RequestMapping(value = "/planning/morePlanListAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String morePlanListAjax(@ModelAttribute("PlanningVO") PlanningVO vo, HttpServletRequest request,ModelMap model) throws Exception {
		vo.setDispYn("Y");
		vo.setOptionYn("Y");
		
		Object list = service.selPlanList(vo);
		
		model.addAttribute("list", list);
		
		return "jsonView";
	}
	
	//기획전 상세 detail 데이터
	@RequestMapping(value= "/planning/setDetailPlanListAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String setDetailPlanListAjax(@ModelAttribute("PlanningVO") PlanningVO vo, HttpServletRequest request,ModelMap model) throws Exception {
		
		vo.setStartRow(1);
		vo.setEndRow(10);
		
		System.out.println("vo.planseq=" + vo.getPlanSeq());
		List list = service.setDetailPlanList(vo);
		
		model.addAttribute("list", list);
		
		return "jsonView";
	}
	
	
	//조회수 증가
	@RequestMapping(value = "/planning/planningCntAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String planningCntAjax(@ModelAttribute("PlanningVO") PlanningVO vo, HttpServletRequest request,ModelMap model) throws Exception {
 		int cnt= 0;
		
	    service.planningCnt(vo);
	    
	    System.out.println("planSeq=" + vo.getPlanSeq());

		cnt = service.getplanCnt(vo);
		
		model.addAttribute("list", cnt);
		
		return "jsonView";
	}
	
	//기획전 상품코드 ,상품이름,행사정보를 조회
	@RequestMapping(value = "/planning/planningDetailAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String planningDetailAjax(@ModelAttribute("PlanningVO") PlanningVO vo, @RequestParam("planType")String type, HttpServletRequest request,ModelMap model) throws Exception {
		List<PlanningVO> goodsCdList = (List<PlanningVO>) service.srchDetailPlanList(vo);
		ArrayList<PlanningVO> result = new ArrayList<PlanningVO>(); 
		List<PlanningVO> subInfoList = null;
		List tabList = service.getPlanTabList(vo);
		
		//for(PlanningVO goodsCdData : goodsCdList){
		for(int x = 0; x < goodsCdList.size(); x++){
			String reCount = "N";
			String goodsCd = goodsCdList.get(x).getGoodCd();
			List<PlanMonth> planDateList = new ArrayList<PlanMonth>();
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			int minCharge = 0;			
			
			if(type != "F"){
				vo.setGoodCd(goodsCd);
				
				if(goodsCdList.get(x).getOpCd().equals("DO")){
					vo.setStartDay((Integer.parseInt(sdf.format(new Date())) + 2) + "");
				}else{
					vo.setStartDay((Integer.parseInt(sdf.format(new Date())) + 4) + "");
				}
				
				subInfoList = (List<PlanningVO>) service.getplanSubInfo(vo);
				
				if(subInfoList.size() > 0){
					if(subInfoList.get(0).getAdultPrice() > 0){
						subInfoList.get(0).setPlanSeq(goodsCdList.get(x).getPlanSeq());
						subInfoList.get(0).setGoodCd(goodsCdList.get(x).getGoodCd());
						subInfoList.get(0).setGoodsNightDay(goodsCdList.get(x).getGoodsNightDay());
						subInfoList.get(0).setPlanTabSeq(goodsCdList.get(x).getPlanTabSeq());
						subInfoList.get(0).setGoodsNm(goodsCdList.get(x).getGoodsNm());
						subInfoList.get(0).setShortGoodsNm(goodsCdList.get(x).getShortGoodsNm());
						subInfoList.get(0).setAir_remark(goodsCdList.get(x).getAir_remark());
						subInfoList.get(0).setCtgSeq(goodsCdList.get(x).getCtgSeq());
						subInfoList.get(0).setCompCd(goodsCdList.get(x).getCompCd());
						subInfoList.get(0).setSave_file_nm(goodsCdList.get(x).getSave_file_nm());
						
						result.add(subInfoList.get(0));
					}
				}
			}else{
				Integer price = (Integer)goodsCdList.get(x).getAdultPrice();
				goodsCdList.get(x).setAdultPrice(price);
			}
		}
		
		model.addAttribute("list", result);
		model.addAttribute("tabList", tabList);
		
		/*
		String templeteCd = vo.getTempleteCd();
				
		List<PlanningVO> goodsCdList = (List<PlanningVO>) service.srchDetailPlanList(vo);
			    
		
		System.out.println("vo.getPlanSeq=" + vo.getPlanSeq());
		
	    //기획전 추가 상품
	    List<PlanningVO> addinfolist = (List<PlanningVO>) service.searchRNDiPlanAddInfo(vo);
		List<PlanningVO> subInfoList = null;
		
	    String AIR_MARK = "";
	    String RETURN_AIR_MARK = "";
	    	    
		for(int i = 0; i < goodsCdList.size(); i++) {
			String reCount = "N";
			String goodcd = goodsCdList.get(i).getGoodCd();
			
			for(int j = 0; j < addinfolist.size(); j++) {
				if(goodcd.equals(addinfolist.get(j).getGoodCd())) {
					goodsCdList.get(i).setHomeShoppingYn(addinfolist.get(j).getHomeShoppingYn());
					goodsCdList.get(i).setPlanYn(addinfolist.get(j).getPlanYn());
					goodsCdList.get(i).setEventYn(addinfolist.get(j).getEventYn());
					goodsCdList.get(i).setCtg_goods(addinfolist.get(j).getCtg_goods());
					goodsCdList.get(i).setGoodsNightDay(addinfolist.get(j).getGoodsNightDay());
					goodsCdList.get(i).setShortGoodsNm(addinfolist.get(j).getShortGoodsNm());
					AIR_MARK = (String) addinfolist.get(j).getAir_remark();
					if(AIR_MARK != null && AIR_MARK.length() > 0) {
						RETURN_AIR_MARK  = AIR_MARK.substring(1, AIR_MARK.length());
					}
					goodsCdList.get(i).setAir_remark(RETURN_AIR_MARK);	
				}
					

				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				int minCharge = 0;
				if(type != "F") {
					//각 상품의 행사 가격정보를 조회한다.
									
					vo.setTempleteCd(templeteCd);
					vo.setGoodCd(goodcd);
					vo.setStartDay(sdf.format(new Date()));
					vo.setCompCd("LT");
					vo.setAreaCd(templeteCd);
					vo.setPlanSeq(vo.getPlanSeq());
					vo.setAdultPrice(vo.getPlanSeq());
					
					//기획전에 포함된 각 상품의 행사별 요금/날짜 정보를 조회한다.
					subInfoList = (List<PlanningVO>) service.getplanSubInfo(vo);
					
					List<PlanMonth> planDateList = new ArrayList<PlanMonth>();
					
					//행사 날짜를 상품별로 출력하기 위한  collection object 구성
					for(int k=0; k < subInfoList.size(); k++) {
						PlanningVO subinfo = subInfoList.get(k);
						String startday = (String)subinfo.getStartDay();
						String eventcd = (String)subinfo.getEventCd();
						
						//출발일 정보가 있을경우
						if(startday != null) {
							// 국내일 경우는 출발일이 오늘로부터 2일 이후인 것 부터
							if (goodsCdList.get(i).getOpCd().equals("DO")) {
								if (Integer.parseInt(startday) >= Integer.parseInt(sdf.format(new Date())) + 2) {
									// 행사 날짜 정보를 DataTable에 출력할 수 있도록 구성
									//planDateList = setPlanDate(startday, goodsCdList.get(i).getGoodCd(), eventcd,planDateList);
								} 
							} else { // 해외일 경우는 출발일이 오늘로부터 4일 이후인 것 부터
								if (Integer.parseInt(startday) >= Integer.parseInt(sdf.format(new Date())) + 4) {
									// 행사 날짜 정보를 DataTable에 출력할 수 있도록 구성
									//planDateList = setPlanDate(START_DAY, GOODS_CD, eventCD,planDateList);
								} 
							}
							String month = startday.substring(4, 6);
							String day = startday.substring(6, 8);
							PlanMonth planMonth = null;
							PlanDate planDate = null;
							
							// 조회된 행사의 날짜를 월별로 모은다.
							for (int e = 0; e < planDateList.size(); e++) {
								if (planDateList.get(e).getMonth() != null
										&& planDateList.get(e).getMonth().equals(month)) {
									planMonth = planDateList.get(e);
									planDate = new PlanDate(day, eventcd);
									planMonth.getPlanDateList().add(planDate);
									break;
								}
							}
							// 새로운 Month 나타났을 경우 그 Month를 생성하여 Add
							if (planMonth == null) {
								planMonth = new PlanMonth(month, goodsCdList.get(i).getGoodCd());
								planDate = new PlanDate(day, eventcd);
								planMonth.getPlanDateList().add(planDate);
								planDateList.add(planMonth);
							}
							vo.setGoodCd(goodcd);
							vo.setStartDay(startday);
							vo.setAdultPrice(vo.getPlanSeq());
							
							goodsCdList.get(i).setStartDay(startday);
							
							//최소금액 조회
							minCharge = service.minCharge(vo);
							System.out.println("mincharge=" + minCharge);
						}
					}
					goodsCdList.get(i).setPlanDateList(planDateList);
					// 최소가격 정보 setting.
					// 가격 정보가 존재하지 않을 경우에는 처리하지 않는다.
					if (subInfoList.size() > 0) {
						goodsCdList.get(i).setAdultPrice(minCharge);
						reCount = "Y";
					} 
					//type !=F
				}  else { 
					Integer price = (Integer)goodsCdList.get(i).getAdultPrice();
					goodsCdList.get(i).setAdultPrice(price);
				
				}
				
			} //addListInfo for문
			
			vo.setPlanTabSeq(vo.getPlanTabSeq()); //예제로 데이터 나오는지 확인 위해서 나중에는 planseq값 가져와서 넣어줘야한다.
			vo.setPlanSeq(vo.getPlanSeq());
			vo.setCompCd("LT");
			String img_str_new = "";
			
			List<PlanningVO> imgList = service.planImage(vo);
			
			for(int m=0; m < imgList.size(); m++) {
				if(goodsCdList.get(i).getGoodCd().equals(imgList.get(m).getGoodCd())) {
					// 상품 이미지의 DISP_GRADE가 모두 동일한 경우
					// 가장 앞의 그림이 대표 이미지가 되도록 하기 위하여
					// 이전 ROW와 Key가 같을 경우는 continue 처리한다.
					if(m > 0) {
						if(imgList.get(m).getGoodCd().equals(imgList.get(m-1).getGoodCd())) {
							continue;
						}
					}
					
					if (null != imgList.get(m).getSave_file_nm()) {
						String[] img_arr = Util.split((String)imgList.get(m).getSave_file_nm(), ".");
						
						// 대표 이미지의 경로를 새로 구성
						img_str_new = "http://www.lottejtb.com/upload/common/goods/"
							+ ((String)goodsCdList.get(i).getGoodCd()).substring(0, 2)
							+ "/" + (String)goodsCdList.get(i).getGoodCd() + "/"
							+ img_arr[0] + "_" + "440" + "." + img_arr[1];
						
						goodsCdList.get(i).setSave_file_nm(img_str_new);
						goodsCdList.get(i).setImg_title(img_str_new);
					}
					
				}
			}
			
		} //goodCdList for문
		
		model.addAttribute("list", goodsCdList);
		*/
		
		return "jsonView";
	}
	
	//기획전 추가정보 조회
	@RequestMapping(value = "/planning/planningAddInfoAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String searchRNDiPlanAddInfo(@ModelAttribute("PlanningVO") PlanningVO vo, HttpServletRequest request,ModelMap model) throws Exception {
	
		System.out.println("seq=" + vo.getPlanSeq());
		
		List list = service.searchRNDiPlanAddInfo(vo);
		
		model.addAttribute("list", list);
		return "jsonView";
	}
   
	//기획전에 포함된 각 상품별 행사별요금/날짜정보를 조회
	@RequestMapping(value = "/planning/planingSubAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String planingSubAjax(@ModelAttribute("PlanningVO") PlanningVO vo, HttpServletRequest request,ModelMap model) throws Exception {
	
		Object list = service.getplanSubInfo(vo);
		
		model.addAttribute("list", list);
		return "jsonView";
	}
	
	//기획전 전시플랜상품 최소금액조회
	@RequestMapping(value = "/planning/planingminChargeAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String planingminChargeAjax(@ModelAttribute("PlanningVO") PlanningVO vo, HttpServletRequest request,ModelMap model) throws Exception {
	
		int adultPrice = service.minCharge(vo);
					
		model.addAttribute("list", adultPrice);
		return "jsonView";
	}
	
	//상품이미지 정보얻기
	@RequestMapping(value = "/planning/planImgAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String getPlanImage(@ModelAttribute("PlanningVO") PlanningVO vo, HttpServletRequest request,ModelMap model) throws Exception {
	
		Object list= service.planImage(vo);
					
		model.addAttribute("list", list);
		return "jsonView";
	}

}
