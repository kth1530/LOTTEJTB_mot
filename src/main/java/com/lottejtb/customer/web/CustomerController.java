package com.lottejtb.customer.web;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.ehcache.Ehcache;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.lottejtb.comm.util.CommInfo;
import com.lottejtb.customer.service.FaqService;
import com.lottejtb.customer.service.FaqVO;
import com.lottejtb.customer.service.NoticeService;
import com.lottejtb.customer.service.NoticeVO;
import com.lottejtb.customer.service.QnaService;
import com.lottejtb.customer.service.QnaVO;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class CustomerController {
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
    @Resource(name = "ehcache")
    Ehcache ehcache;
	
	@Resource(name = "FaqService")
	private FaqService faqService;
	
	@Resource(name = "NoticeService")
	private NoticeService noticeService;
	
	@Resource(name = "QnaService")
	private QnaService qnaService;	

	private final Logger logger = Logger.getLogger(this.getClass());
	private final String _rootPath = "/";
	private final int PAGESIZE = 10;
	
	/** 이용약관 **/
	@RequestMapping(value = "/customer/clause.do",method={RequestMethod.GET, RequestMethod.POST})
	public String clause(HttpServletRequest request, Model model)throws Exception{
		return _rootPath+"customer/clause";
	}
	
	/** 공지사항 **/
	@RequestMapping(value = "/customer/noticeList.do",method={RequestMethod.GET, RequestMethod.POST})
	public String noticeList(HttpServletRequest request,  ModelMap model)throws Exception{
		
		model.addAttribute("pageSize", PAGESIZE);
		
		return  _rootPath + "customer/customer_noticeList";
	}
	
	/** 공지사항 목록 총수 Ajax **/	
	@RequestMapping(value = "/customer/noticeListCountAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String noticeListCntAjax(@ModelAttribute("NoticeVO") NoticeVO vo, HttpServletRequest request,ModelMap mode) throws Exception{
		
		vo.setNoticeClsCd("10");
		vo.setNoticeDetClsCd("10");
		
		int totalCount = noticeService.selectNoticeListCount(vo);
		
		mode.addAttribute("totalCount", totalCount);
		
		return "jsonView";
	}
	
	/** 공지사항 목록 더보기 Ajax **/		
	@RequestMapping(value = "/customer/noticeListAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String noticeListAjax(@ModelAttribute("NoticeVO") NoticeVO vo, HttpServletRequest request,ModelMap model) throws Exception{
		
		vo.setNoticeClsCd("10");
		vo.setNoticeDetClsCd("10");
		
		List list = noticeService.selectNoticeList(vo);
		
		model.addAttribute("list", list);
		
		return "jsonView";
	}
	
	/** 공지사항 상세 Ajax **/				
	@RequestMapping(value = "/customer/noticeDetailAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String noticeDetailAjax(@ModelAttribute("NoticeVO") NoticeVO vo, HttpServletRequest request,ModelMap model) throws Exception{
		
		Object detail = noticeService.selectNoticeDetail(vo);
		
		model.addAttribute("detail", detail);
		
		noticeService.updateNoticeCount(vo);
		
		return "jsonView";
	}
	
	/** 자주 찾는 질문 **/
	@RequestMapping(value = "/customer/faq.do",method = RequestMethod.GET )
	public String faq(HttpServletRequest request,  ModelMap model)throws Exception{
		
		// A.CLS_CD  : 지역구분코드
		// 10 : 여행상품, 20 : 항공권, 해외호텔 : 30, 예약/결제 : 40, 사이트 이용 : 50, 회원제 : 60
		String cls_cd = "0";
		int startRow = 1;
		int endRow = PAGESIZE;
		
		model.addAttribute("faqType", cls_cd);
		model.addAttribute("pageSize", PAGESIZE);
		
		return _rootPath+ "customer/customer_faq";
	}
	
	/** 검색어를 포함한 항목별 카운트조회 Ajax **/				
	@RequestMapping(value = "/customer/faqListAllCountAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String faqListAllCountAjax(@ModelAttribute("FaqVO") FaqVO vo, HttpServletRequest request,ModelMap model) throws Exception{
		
		FaqVO returnFaqVO = faqService.selectFaqListAllCount(vo);		
		model.addAttribute("list", returnFaqVO);
	    return "jsonView";
	}
	
	/** 자주찾는 질문 첫페이지 데이터 Ajax **/				
	@RequestMapping(value = "/customer/faqFirstListAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String faqFirstListAjax(@ModelAttribute("FaqVO") FaqVO vo, HttpServletRequest request,ModelMap model) throws Exception{
		
		int startRow = 1;
		int endRow = PAGESIZE;
		
		vo.setStartRow(startRow);
		vo.setEndRow(endRow);
		
		List list = faqService.selectFaqFirstList(vo);	
		model.addAttribute("list", list);
		model.addAttribute("searchTxt", vo.getSearchKeyword());
		
		return "jsonView";
	}

	/** 자주찾는 질문 목록 더보기 기능 Ajax **/				
	@RequestMapping(value = "/customer/moreFaqListAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String moreFaqListAjax(@ModelAttribute("FaqVO") FaqVO vo, HttpServletRequest request,ModelMap model) throws Exception{
		
		Object list = faqService.selectFaqList(vo);
		model.addAttribute("list", list);
		
		return "jsonView";
	}
	

	/** 묻고답하기 **/
	@RequestMapping(value = "/customer/qnaList.do",method={RequestMethod.GET, RequestMethod.POST})
	public String qnaList(HttpServletRequest request,  ModelMap model)throws Exception{
		
		model.addAttribute("pageSize", PAGESIZE);
		model.addAttribute("param_consultCd", request.getParameter("consultCd"));
		
		return  _rootPath + "customer/customer_qnaList";
	}
	
	/** 묻고답하기 목록 총수 Ajax **/	
	@RequestMapping(value = "/customer/qnaListCountAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String qnaListCntAjax(@ModelAttribute("QnaVO") QnaVO vo, HttpServletRequest request,ModelMap mode) throws Exception{
		
		vo.setConsultMstCd("01");
		vo.setChannelCd("AA");
		
		int totalCount = qnaService.selectQnaListCount(vo);
		
		mode.addAttribute("totalCount", totalCount);
		
		return "jsonView";
	}
	
	/** 묻고답하기 목록 더보기 Ajax **/		
	@RequestMapping(value = "/customer/qnaListAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String qnaListAjax(@ModelAttribute("QnaVO") QnaVO vo, HttpServletRequest request,ModelMap model) throws Exception{
		
		vo.setConsultMstCd("01");
		vo.setChannelCd("AA");
		
		List list = qnaService.selectQnaList(vo);
		
		model.addAttribute("list", list);
		
		return "jsonView";
	}
	
	/** 묻고답하기 상세 Ajax **/				
	@RequestMapping(value = "/customer/qnaDetailAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String qnaDetailAjax(@ModelAttribute("QnaVO") QnaVO vo, HttpServletRequest request,ModelMap model) throws Exception{
		
		QnaVO detail = (QnaVO)qnaService.selectQnaDetail(vo);
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		String custCd = null;
		
		if(sessionParam != null){
			custCd = sessionParam.get("cust_cd").toString();
		}
		
		//로그인인증체크 상세데이터 공개/비공개 체크하여 비공개 이고 등록자가 아닐경우 디비에서 받아온 정보를 replace한다.
		//titleYn이 N일경우 비공개
		//비공개
		if("N".equals(detail.getTitleYn())){
			//질문자 본인이 아닐경우
			if(custCd == null){
				detail.setRemark("이글은 작성자에게만 공개된 글입니다");
				detail.setConsultDesc("이글은 작성자에게만 공개된 글입니다");
			}else if(!custCd.equals(detail.getCustCd())){
				detail.setRemark("이글은 작성자에게만 공개된 글입니다");
				
				if(!StringUtils.hasText(detail.getConsultDesc())){
					detail.setConsultDesc("상담 내용을 준비 중에 있습니다.");
				}else{
					detail.setConsultDesc("이글은 작성자에게만 공개된 글입니다");
				}
			}else{
				if(!StringUtils.hasText(detail.getConsultDesc())){
					detail.setConsultDesc("상담 내용을 준비 중에 있습니다.");
				}
			}
		}else{
			if(!StringUtils.hasText(detail.getConsultDesc())){
				detail.setConsultDesc("상담 내용을 준비 중에 있습니다.");
			}
		}
		
		model.addAttribute("detail", detail);
		
		return "jsonView";
	}
	
	/** 묻고답하기 작성하기 **/
	@RequestMapping(value = "/customer/qnaWrite.do",method={RequestMethod.GET, RequestMethod.POST})
	public String qnaWrite(HttpServletRequest request, Model model)throws Exception{
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		String custCd = null;
		String knm = null;
		String age = null;
		String sex = null;
		
		if(sessionParam != null){
			custCd = sessionParam.get("cust_cd").toString();
			knm = sessionParam.get("knm").toString();
			age = sessionParam.get("age").toString();
			sex = sessionParam.get("sex").toString();
			
		}
		
		model.addAttribute("custCd", custCd);
		model.addAttribute("knm", knm);
		model.addAttribute("age", age);
		model.addAttribute("sex", sex);
		
		return _rootPath+"customer/customer_qnaWrite";
	}
	
	/** 묻고답하기 등록하기 **/
	@RequestMapping(value = "/customer/insertConsultQna.do",method={RequestMethod.GET, RequestMethod.POST})
	public String insertConsultQna(@ModelAttribute("QnaVO") QnaVO vo, HttpServletRequest request,ModelMap model) throws Exception{
		qnaService.insertConsultQna(vo);
		
		return "jsonView";
	}
	
	/** 코드 가져오기**/
	@RequestMapping(value = "/customer/selectQnaCode.do",method={RequestMethod.GET, RequestMethod.POST})
	public String selectQnaCode(@ModelAttribute("QnaVO") QnaVO vo, HttpServletRequest request,ModelMap model) throws Exception{
		HashMap<String, Object> parameter = new HashMap<String, Object>();
		
		parameter.put("grpCd", "CONDET");
		model.addAttribute("conetCode", qnaService.selectQnaCode(parameter));
		parameter.put("grpCd", "MAILGB");
		model.addAttribute("mailCode", qnaService.selectQnaCode(parameter));
		parameter.put("grpCd", "HPTYPE");
		model.addAttribute("hpCode", qnaService.selectQnaCode(parameter));
		
		return "jsonView";
	}
	
	/** 쿠폰 **/
	@RequestMapping(value = "/customer/coupon.do",method={RequestMethod.GET, RequestMethod.POST})
	public String coupon(HttpServletRequest request, Model model)throws Exception{
		return _rootPath+"customer/customer_coupon";
	}
	
	/** 쿠폰Pop **/
	@RequestMapping(value = "/customer/couponPop.do",method={RequestMethod.GET, RequestMethod.POST})
	public String couponPop(HttpServletRequest request, Model model)throws Exception{
		return _rootPath+"customer/customer_couponPop";
	}
	
	/** 개인정보보호약관 **/
	@RequestMapping(value = "/customer/policy.do",method={RequestMethod.GET, RequestMethod.POST})
	public String policy(HttpServletRequest request, Model model)throws Exception{
		return _rootPath+"customer/policy";
	}
	
	/** 여행약관 **/
	@RequestMapping(value = "/customer/travel_clause.do",method={RequestMethod.GET, RequestMethod.POST})
	public String travel_clause(HttpServletRequest request, Model model)throws Exception{
		return _rootPath+"customer/travel_clause";
	}

	/** 개인정보보호약관 가져오기**/
	@RequestMapping(value = "/customer/selectPolicy.do",method={RequestMethod.GET, RequestMethod.POST})
	public String selectPolicy(HttpServletRequest request, Model model)throws Exception{
		String version = request.getParameter("version");
		System.out.println("====================>>>version : " + version);
		return _rootPath+"customer/policy_"+version;
	}
	
	
}