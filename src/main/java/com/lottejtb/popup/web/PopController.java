package com.lottejtb.popup.web;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.ehcache.Ehcache;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.lottejtb.comm.util.CommInfo;
import com.lottejtb.front.air.service.AirService;
import com.lottejtb.front.air.service.RsvAirService;
import com.lottejtb.front.air.service.RsvAirVO;
import com.lottejtb.main.service.MainService;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class PopController {

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
    @Resource(name = "ehcache")
    Ehcache ehcache;
	
	@Resource(name = "MainService")
	private MainService mainService;
	

	@Resource(name = "RsvAirService")
	private RsvAirService rsvAirService;
	
	@Resource(name = "AirService")
	private AirService airService;
	
	private final Logger logger = Logger.getLogger(this.getClass());
	private final String _rootPath = "/pop";
	
	
	
	@RequestMapping(value = "/pop/pop_city_select1.do", method = RequestMethod.GET )
	public String pop_city_select1(HttpServletRequest request, @RequestParam("availTy") String availTy, Model model) throws Exception {
	    
		String travelMtCnt = "1";
		String type = "D";
		if(availTy.equals("MT")) {
			travelMtCnt = (String) request.getParameter("travelMtCnt");
			type = (String) request.getParameter("type");
			
			model.addAttribute("travelMtCnt", travelMtCnt);
			model.addAttribute("type", type);

		}
		
		model.addAttribute("availTy", availTy);

		return "/pop/pop_city_select1";
	}
	
	@RequestMapping(value = "/pop/pop_city_select2.do", method = RequestMethod.GET )
	public String pop_city_select2(HttpServletRequest request, @RequestParam("availTy") String availTy, Model model) throws Exception {

		String travelMtCnt = "1";
		String type = "A";
		
		if(availTy.equals("MT")) {
			travelMtCnt = (String) request.getParameter("travelMtCnt");
			type = (String) request.getParameter("type");
			
			model.addAttribute("travelMtCnt", travelMtCnt);
			model.addAttribute("type", type);			
		}else if(availTy.equals("OO")){
			type = request.getParameter("type");
			
			model.addAttribute("type", type);
		}
		model.addAttribute("availTy", availTy);
		return "/pop/pop_city_select2";
	}
	
	@RequestMapping(value = "/pop/pop_hotel_city_select.do", method = RequestMethod.GET )
	public String pop_hotel_city_select(HttpServletRequest request, @RequestParam("availTy") String availTy, Model model) throws Exception {

		model.addAttribute("availTy", availTy);
		return "/pop/pop_hotel_city_select";
	}

	@RequestMapping(value = "/pop/pop_pay_city_select.do", method = RequestMethod.GET )
	public String pop_pay_city_select(HttpServletRequest request, @RequestParam("availTy") String availTy, @RequestParam("type") String type, Model model) throws Exception {
		String travelMtCnt = (String) request.getParameter("travelMtCnt");
		
		model.addAttribute("availTy", availTy);
		model.addAttribute("type", type);
		model.addAttribute("travelMtCnt", travelMtCnt);
		
		return "/pop/pop_pay_city_select";
	}
	
	@RequestMapping(value = "/pop/pop_city_select3.do", method = RequestMethod.GET )
	public String pop_city_select3(HttpServletRequest request, @RequestParam("availTy") String availTy, Model model) throws Exception {
		model.addAttribute("type", request.getParameter("type"));
		model.addAttribute("availTy", availTy);
		
		return "/pop/pop_city_select3";
	}


	@RequestMapping(value = "/pop/pop_age_text.do", method = RequestMethod.GET )
	public String pop_age_text(HttpServletRequest request, Model model) throws Exception {
	    
		
		return "/pop/pop_age_text";
	}
	
	@RequestMapping(value = "/pop/pop_air_ifdetail.do", method = RequestMethod.GET )
	public String pop_air_ifdetail(HttpServletRequest request, Model model) throws Exception {
		return "/pop/pop_air_ifdetail";
	}
	
	@RequestMapping(value = "/pop/pop_air_viewdetail.do", method = RequestMethod.GET )
	public String pop_air_viewdetail(HttpServletRequest request, Model model) throws Exception {
	    
	    String ar_cnt = (String) request.getParameter("ar_cnt");
	    
	    model.addAttribute("ar_cnt", ar_cnt);		
		return "/pop/pop_air_viewdetail";
	}
	
	@RequestMapping(value = "/pop/pop_alert.do", method = RequestMethod.GET )
	public String pop_alert(HttpServletRequest request, Model model) throws Exception {
	    
		
		return "/pop/pop_alert";
	}	
	
	@RequestMapping(value = "/pop/pop_calendar.do", method = RequestMethod.GET )
	public String pop_calendar(HttpServletRequest request, @RequestParam("type") String type, @RequestParam("availTy") String availTy, Model model) throws Exception {
	    

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
			System.err.println("Air Sell Date Error!");
		}
		
		model.addAttribute("type", type);
		model.addAttribute("availTy", availTy);
		model.addAttribute("sellDate", sellDate);
		
		String travelMtCnt = "1";
		if(availTy.equals("MT")) {
			travelMtCnt = (String) request.getParameter("travelMtCnt");
			model.addAttribute("travelMtCnt", travelMtCnt);

		}		
		return "/pop/pop_calendar";
	}	
	
	//호텔 달력
	@RequestMapping(value = "/pop/pop_ht_calendar", method = RequestMethod.GET )
	public String pop_ht_calendar(HttpServletRequest request, @RequestParam("type") String type,@RequestParam("availTy") String availTy, Model model) throws Exception {
	    	
		model.addAttribute("type", type);
		model.addAttribute("availTy", availTy);
		
		String travelMtCnt = "1";
		if(availTy.equals("MT")) {
			travelMtCnt = (String) request.getParameter("travelMtCnt");
			model.addAttribute("travelMtCnt", travelMtCnt);

		}
		return "/pop/pop_ht_calendar";
	}	
	
	//렌트카 차량인수 반납일
	@RequestMapping(value = "/pop/pop_rc_calendar", method = RequestMethod.GET )
	public String pop_rc_calendar(HttpServletRequest request, @RequestParam("type") String type,@RequestParam("availTy") String availTy, Model model) throws Exception {
	    	
		model.addAttribute("type", type);
		model.addAttribute("availTy", availTy);
		
		String travelMtCnt = "1";
		if(availTy.equals("MT")) {
			travelMtCnt = (String) request.getParameter("travelMtCnt");
			model.addAttribute("travelMtCnt", travelMtCnt);

		}
		return "/pop/pop_rc_calendar";
	}

	
	@RequestMapping(value = "/pop/pop_cancel1.do", method = RequestMethod.GET )
	public String pop_cancel1(HttpServletRequest request, Model model) throws Exception {
	    
		model.addAttribute("cancelPolicy", request.getParameter("cancelPolicy"));
		model.addAttribute("selIdx", Integer.parseInt(request.getParameter("selIdx")));
		return "/pop/pop_cancel1";
	}	

	@RequestMapping(value = "/pop/pop_cancel2.do", method = RequestMethod.GET )
	public String pop_cancel2(HttpServletRequest request, Model model) throws Exception {
	    
		
		return "/pop/pop_cancel2";
	}	
	
	@RequestMapping(value = "/pop/pop_car_list.do", method = RequestMethod.GET )
	public String pop_car_list(HttpServletRequest request, Model model) throws Exception {
	    
		
		return "/pop/pop_car_list";
	}	
	
	@RequestMapping(value = "/pop/pop_commair.do", method = RequestMethod.GET )
	public String pop_commair(HttpServletRequest request, Model model) throws Exception {
	    
		
		return "/pop/pop_comair";
	}	
	
	@RequestMapping(value = "/pop/pop_hotel_ifdetail.do", method = RequestMethod.GET )
	public String pop_hotel_ifdetail(HttpServletRequest request, Model model) throws Exception {
		return "/pop/pop_hotel_ifdetail";
	}	
	
	@RequestMapping(value = "/pop/pop_mappos.do", method = RequestMethod.GET )
	public String pop_mappos(HttpServletRequest request, Model model) throws Exception {
		
		model.addAttribute("lat", request.getParameter("lat"));
		model.addAttribute("longi", request.getParameter("longi"));
		model.addAttribute("hname", request.getParameter("hname"));
		
		System.out.println("lat=" + request.getParameter("lat"));
		System.out.println("longi=" + request.getParameter("longi"));
		System.out.println("hname=" + request.getParameter("hname"));
		
		return "/pop/pop_mappos";
	}	
	
	@RequestMapping(value = "/pop/pop_pay_guide.do", method = RequestMethod.GET )
	public String pop_pay_guide(HttpServletRequest request, Model model) throws Exception {
	    String ar_cnt = (String) request.getParameter("ar_cnt");
	    System.out.println("ar_cnt : " + ar_cnt);
	    
	    model.addAttribute("ar_cnt", ar_cnt);
		
		return "/pop/pop_pay_guide";
	}	
	
	@RequestMapping(value = "/pop/pop_quest.do", method = RequestMethod.GET )
	public String pop_quest(HttpServletRequest request, Model model) throws Exception {
	    
		return "/pop/pop_quest";
	}		
	
	@RequestMapping(value = "/pop/pop_rentcar_ifdetail.do", method = RequestMethod.GET )
	public String pop_rentcar_ifdetail(HttpServletRequest request, Model model) throws Exception {
	    
		
		return "/pop/pop_rentcar_ifdetail";
	}	
	
	@RequestMapping(value = "/pop/pop_rentcar_map.do", method = RequestMethod.GET )
	public String pop_rentcar_map(HttpServletRequest request, Model model) throws Exception {
	    model.addAttribute("lat", request.getParameter("lat"));
	    model.addAttribute("lng", request.getParameter("lng"));
		
		return "/pop/pop_rentcar_map";
	}	
	
	@RequestMapping(value = "/pop/pop_rentcar_viewdetail.do", method = RequestMethod.GET )
	public String pop_rentcar_viewdetail(HttpServletRequest request, Model model) throws Exception {		
		model.addAttribute("rcIdx", request.getParameter("rcIdx"));
		
		return "/pop/pop_rentcar_viewdetail";
	}	
	
	@RequestMapping(value = "/pop/pop_select_air.do", method = RequestMethod.GET )
	public String pop_select_air(HttpServletRequest request, Model model) throws Exception {
	    
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		String custCd = "";
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
		}
		
		String ar_cnt = (String) request.getParameter("ar_cnt");
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
	    model.addAttribute("ar_cnt", ar_cnt);
	    model.addAttribute("mode", request.getParameter("mode"));
	    model.addAttribute("custCd", custCd);
		return "/pop/pop_select_air";
	}	
	
	@RequestMapping(value = "/pop/pop_select_hotel.do", method = RequestMethod.GET )
	public String pop_select_hotel(HttpServletRequest request, Model model) throws Exception {
	    
		
		return "/pop/pop_select_hotel";
	}	
	
	@RequestMapping(value = "/pop/pop_select_rentcar.do", method = RequestMethod.GET )
	public String pop_select_rentcar(HttpServletRequest request, Model model) throws Exception {
	    
		
		return "/pop/pop_select_rentcar";
	}	
	
	@RequestMapping(value = "/pop/pop_selectok_no.do", method = RequestMethod.GET )
	public String pop_selectok_no(HttpServletRequest request, Model model) throws Exception {
	    
		
		return "/pop/pop_selectok_no";
	}	
	
	@RequestMapping(value = "/pop/pop_street.do", method = RequestMethod.GET )
	public String pop_street(HttpServletRequest request, Model model) throws Exception {
	    
		
		return "/pop/pop_street";
	}	

	@RequestMapping(value = "/pop/pop_visa.do", method = RequestMethod.GET )
	public String pop_visa(HttpServletRequest request, Model model) throws Exception {
	    
		
		return "/pop/pop_visa";
	}	
	
	@RequestMapping(value = "/pop/pop_email.do", method = { RequestMethod.GET, RequestMethod.POST } )
	public String pop_email(HttpServletRequest request, Model model) throws Exception {
		
	    String rsvSeqno = (String) request.getParameter("rsvSeqno");
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		String custCd = "";
		String knm = "";
		String age = "";
		String sex = "";
		String id = "";
		String email = "";
		String custGradeCd = "";
		String birthday = "";
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
			if(sessionParam.get("knm") != null)
				knm = sessionParam.get("knm").toString();
			if(sessionParam.get("age") != null)
				age = sessionParam.get("age").toString();
			if(sessionParam.get("sex") != null)
				sex = sessionParam.get("sex").toString();
			if(sessionParam.get("id") != null)
				id = sessionParam.get("id").toString();
			if(sessionParam.get("email") != null)
				email = sessionParam.get("email").toString();
			if(sessionParam.get("custGradeCd") != null)
				custGradeCd = sessionParam.get("custGradeCd").toString();
			if(sessionParam.get("birthday") != null)
				birthday = sessionParam.get("birthday").toString();
		}
	    
	    System.out.println("rsvSeqno : " + rsvSeqno);
	    
		model.addAttribute("cust_cd", custCd);
		model.addAttribute("knm", knm);
		model.addAttribute("email", email);
		model.addAttribute("age", age);
		model.addAttribute("id", id);		
		model.addAttribute("sex", sex);
		model.addAttribute("birthday", birthday);
		model.addAttribute("custGradeCd", custGradeCd);	    
		model.addAttribute("rsvSeqno", rsvSeqno);
		
		return "/pop/pop_email";
	}	
	
	@RequestMapping(value = "/pop/pop_mileage.do", method = RequestMethod.GET )
	public String pop_mileage(@RequestParam("seqNo") String seqNo, HttpServletRequest request, Model model) throws Exception {

		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		String custCd = "";
		String knm = "";
		String age = "";
		String sex = "";
		String id = "";
		String email = "";
		String custGradeCd = "";
		String birthday = "";
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
			if(sessionParam.get("knm") != null)
				knm = sessionParam.get("knm").toString();
			if(sessionParam.get("age") != null)
				age = sessionParam.get("age").toString();
			if(sessionParam.get("sex") != null)
				sex = sessionParam.get("sex").toString();
			if(sessionParam.get("id") != null)
				id = sessionParam.get("id").toString();
			if(sessionParam.get("email") != null)
				email = sessionParam.get("email").toString();
			if(sessionParam.get("custGradeCd") != null)
				custGradeCd = sessionParam.get("custGradeCd").toString();
			if(sessionParam.get("birthday") != null)
				birthday = sessionParam.get("birthday").toString();
		}
		
		if(seqNo == null || seqNo.equals("")) seqNo = "0";
		
		RsvAirVO rsvAirParam = new RsvAirVO();		
		rsvAirParam.setAirRsvSeqno(Integer.parseInt(seqNo));
		RsvAirVO rsvAirResult =  null;
		
		if(!seqNo.equals("0")) {
			rsvAirResult = (RsvAirVO) rsvAirService.selectRsvAir(rsvAirParam);
		}
		
		model.addAttribute("cust_cd", custCd);
		model.addAttribute("knm", knm);
		model.addAttribute("email", email);
		model.addAttribute("age", age);
		model.addAttribute("id", id);		
		model.addAttribute("sex", sex);
		model.addAttribute("birthday", birthday);
		model.addAttribute("custGradeCd", custGradeCd);
		
		model.addAttribute("rsvAirResult", rsvAirResult);
		
		return "/pop/pop_mileage";
	}	
	
	@RequestMapping(value = "/pop/pop_lpoint.do", method = RequestMethod.GET )
	public String pop_lpoint(HttpServletRequest request, Model model) throws Exception {
	    
		
		return "/pop/pop_lpoint";
	}	
	
	@RequestMapping(value = "/pop/pop_nightdays.do", method = RequestMethod.GET )
	public String pop_nightdays(HttpServletRequest request, Model model) throws Exception {
	    		
		return "/pop/pop_nightdays";
	}
	
	@RequestMapping(value = "/pop/pop_air_sorting.do", method = RequestMethod.GET )
	public String pop_air_sorting(HttpServletRequest request, Model model) throws Exception {
	    
		
		return "/pop/pop_air_sorting";
	}
	
	@RequestMapping(value = "/pop/pop_hotel_sorting.do", method = RequestMethod.GET )
	public String pop_hotel_sorting(HttpServletRequest request, Model model) throws Exception {
	    
		return "/pop/pop_hotel_sorting";
	}
	
	@RequestMapping(value = "/pop/pop_rentcar_sorting.do", method = RequestMethod.GET )
	public String pop_rentcar_sorting(HttpServletRequest request, Model model) throws Exception {
	    
		
		return "/pop/pop_rentcar_sorting";
	}
	
	@RequestMapping(value = "/pop/insurance_policy_pop.do", method = RequestMethod.GET )
	public String insurance_policy_pop(HttpServletRequest request, Model model) throws Exception {
		
		
		return "/pop/insurance_policy_pop";
	}
}
