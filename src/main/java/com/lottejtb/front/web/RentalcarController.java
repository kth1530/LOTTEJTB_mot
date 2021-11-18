package com.lottejtb.front.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.ehcache.Ehcache;
import net.sf.ehcache.Element;

import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.lottejtb.api.service.FURTI0001ResultVO;
import com.lottejtb.front.rentcar.service.RsvRentcarVO;
import com.lottejtb.front.service.RentalcarService;
import com.lottejtb.front.service.RentalcarVO;
import com.lottejtb.front.service.ReqRentcarVO;
import com.lottejtb.front.service.SearchRentCityVO;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
@RequestMapping(value = "/fit/rnt")
public class RentalcarController {
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	private final Logger logger = Logger.getLogger(this.getClass());
	private final String _rootPath = "/fit/rnt/";
	
	@Resource(name = "RentalcarService")
	private RentalcarService rntService;
	
	@Resource(name = "ehcache")
    Ehcache ehcache;
	
	/**
	 * 렌터카 검색 리스트 페이지 호출
	 * @return
	 */
	@RequestMapping(value = "/searchMain.do")
	public String HotelSearchMain(HttpServletRequest request, Model model) {
		String selAir = request.getParameter("selAir");
		String selHotel = request.getParameter("selHotel");
		String selRentcar = request.getParameter("selRentcar");
		
		model.addAttribute("selAir", selAir);
		model.addAttribute("selHotel", selHotel);
		model.addAttribute("selRentcar", selRentcar);
		
		return _rootPath + "rentSearchMain";
	}
	
	/**
	 * 렌터카 리스트 조회/검색
	 * @return
	 */
	@RequestMapping(value = "/listSearch.do", method = RequestMethod.POST )
	public String searchHotelList(@ModelAttribute RentalcarVO rntVO, HttpServletRequest request, Model model) {
		
		ArrayList<RentalcarVO> rentalcarList = new ArrayList<RentalcarVO>();
		
		try {
			rentalcarList = rntService.selectListRentalcar(rntVO);
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.println("Select Rentalcar Error!");
		}
		
		model.addAttribute("rentalcarList", rentalcarList);
				
		return "jsonview";
	}
	
	/**
	 * 렌터카 상세보기 조회
	 * @return
	 */
	@RequestMapping(value = "/viewInfo.do", method = RequestMethod.POST )
	public String viewHotelinfo(@ModelAttribute RentalcarVO rntVO, HttpServletRequest request, Model model) {
		
		ArrayList<RentalcarVO> rentalcarInfo = new ArrayList<RentalcarVO>();
		
		try {
			rentalcarInfo = rntService.selectRentalcarInfo(rntVO);
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.println("Select Rentalcar Error!");
		}
		
		model.addAttribute("rentalcarInfo", rentalcarInfo);
				
		return "jsonview";
	}
	
	/**
	 * 인수/반납장소 검색
	 * @return
	 */
	@RequestMapping(value = "/listCityL.do", method = RequestMethod.POST )
	public String searchCityList(@RequestBody SearchRentCityVO rntCityVO, HttpServletRequest request, Model model) {
		HashMap<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("sVal", rntCityVO.getSearchVal());
		
		List placeInfo = new ArrayList();
		
		try {
			placeInfo = rntService.selectListPlace(parameter);
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.println("Select Rentalcar Error!");
		}
		
		model.addAttribute("cityList", placeInfo);
				
		return "jsonview";
	}
	
	/**
	 * 렌터카 영업소 검색
	 * @return
	 */
	
	@RequestMapping(value = "/selectRentOffice.do", method = RequestMethod.POST )
	public String selectRentOffice(HttpServletRequest request, Model model) {
		HashMap<String, Object> parameter = new HashMap<String, Object>();
		List placeInfo = new ArrayList();
		
		
		try {
			parameter.put("country", request.getParameter("country"));
			parameter.put("city", request.getParameter("city"));
			parameter.put("searchType", request.getParameter("searchType"));
			parameter.put("takeNumday", request.getParameter("takeNumday"));
			parameter.put("takeTime", request.getParameter("takeTime"));
			parameter.put("returnNumday", request.getParameter("returnNumday"));
			parameter.put("returnTime", request.getParameter("returnTime"));
			parameter.put("type", request.getParameter("type"));
			placeInfo = rntService.selectRentOffice(parameter);
		} catch (Exception e) {
			///e.printStackTrace();
			System.err.println("Select Rentalcar Office Error!");
		}
		
		model.addAttribute("officeList", placeInfo);
				
		return "jsonview";
	}
	
	/**
	 * 렌터카 차량 검색
	 * @return
	 */
	
	@RequestMapping(value = "/selectRentcarList.do", method = RequestMethod.POST )
	public String selectRentcarList(@ModelAttribute ReqRentcarVO vo, HttpServletRequest request, Model model) {
		FURTI0001ResultVO carList = new FURTI0001ResultVO();

		try {
			Ehcache cache = ehcache.getCacheManager().getCache("chcache-properties");
			
			ObjectMapper jsonMapper = new ObjectMapper();
			Element listCache = cache.get("carList"+jsonMapper.writeValueAsString(vo));
			
            carList = rntService.selectRentCarList(vo);
			cache.put(new Element("carList"+jsonMapper.writeValueAsString(vo), carList));
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.println("Select Rentalcar Error!");
		}
		
		model.addAttribute("carList", carList.getData());
		
		return "jsonview";
	}
	
	/**
	 * 렌터카 차량 검색
	 * @return
	 */
	@RequestMapping(value = "/selectRentcarRsvList.do", method = RequestMethod.POST )
	public String selectRentcarRsvList(@ModelAttribute RsvRentcarVO vo, HttpServletRequest request, Model model) {
		List list = null;
		
		try {
			list = rntService.selectRentcarRsvList(vo);
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.println("Select Rentalcar Reserve Error!");
		}
		
		model.addAttribute("list", list);
		
		return "jsonview";
	}
}
