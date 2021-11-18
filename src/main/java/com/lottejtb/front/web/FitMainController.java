package com.lottejtb.front.web;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lottejtb.front.air.service.ReqAirAvailVO;
import com.lottejtb.front.air.service.ReqAirListVO;
import com.lottejtb.front.service.LinkFitVO;

@Controller
@RequestMapping(value = "/fit/main")
public class FitMainController {
	@SuppressWarnings("unused")
	private final Logger logger = Logger.getLogger(this.getClass());
	private final String _rootPath = "/fit/main/";
	
	/**
	 * 자유여행 메인 페이지 호출
	 * @return
	 */
	@RequestMapping(value = "/main.do")
	public String freeTravelMain() {
		
		return _rootPath + "main";
	}

	/**
	 * 자유여행 링크 (JTB홈페이지, SNS)
	 * @return
	 */
	@RequestMapping(value = "/link.do")
	public String freeTravelLink(HttpServletRequest request, Model model) {
		String selAir		= request.getParameter("selAir");
		String selHotel 	= request.getParameter("selHotel");
		String selRentcar 	= request.getParameter("selRentcar");
		
		LinkFitVO linkFitVo = new LinkFitVO();
		
		if(selAir != null && "Y".equals(selAir)){
			// 항공 파라메터
			String 	cabinClas	= request.getParameter("airCabinClas");
			String 	availTy		= request.getParameter("airAvailTy");
			int 	adtCnt		= Integer.parseInt(request.getParameter("airAdtCnt"));
			int 	chdCnt		= Integer.parseInt(request.getParameter("airAhdCnt"));
			int 	infCnt		= Integer.parseInt(request.getParameter("airInfCnt"));
			String 	carrierCd	= request.getParameter("airCarrierCd");

			ArrayList<ReqAirAvailVO> airAvailList = new ArrayList<ReqAirAvailVO>();
			String airCd 		= request.getParameter("airCdArr");		//ex) ICN,NRT,OKA
			String airDt 		= request.getParameter("airDtArr");

			String[] airCdArr;  
			if(airCd != null && !"".equals(airCd)){
				airCdArr = airCd.split(",");
			} else {
				airCdArr = new String[0];
			}

			String[] airDtArr;  
			if(airDt != null && !"".equals(airDt)){
				airDtArr = airDt.split(",");
			} else {
				airDtArr = new String[0];
			}
			
			if("MT".equals(availTy)){	//다구간
				int nNo = 1;
				for(int i=0; i<airCdArr.length; i++){
					ReqAirAvailVO availData = new ReqAirAvailVO();
					availData.setDepCd(airCdArr[i]);	//출발지
					availData.setDepDt(airDtArr[i]);	//출발일
					availData.setAvailNo(nNo);			//여정번호
					availData.setArrCd(airCdArr[nNo]);	//도착지

					if(airCdArr.length-1 == i){
						nNo = 0;
					} else {
						nNo++;
					}
					
					airAvailList.add(availData);
				}
				
			} else {	//왕복, 편도
				ReqAirAvailVO availData = new ReqAirAvailVO();
				availData.setDepCd(airCdArr[0]);	//출발지
				availData.setDepDt(airDtArr[0]);	//출발일
				availData.setAvailNo(1);			//여정번호
				availData.setArrCd(airCdArr[1]);	//도착지

				if("RT".equals(availTy)){
					availData.setArrDt(airDtArr[1]);	//귀국일
				}
				airAvailList.add(availData);
			}
			
			
			ReqAirListVO ralv = new ReqAirListVO();
			ralv.setCabinClas(cabinClas);
			ralv.setAvailTy(availTy);
			ralv.setAdtCnt(adtCnt);
			ralv.setChdCnt(chdCnt);
			ralv.setInfCnt(infCnt);
			ralv.setCarrierCd(carrierCd);
			ralv.setAvailGroup(airAvailList);
		}

		if(selHotel != null || "Y".equals(selHotel)){
			// 호텔 파라메터
			/*private String 	ageOfChildren;
			private String 	checkInDate;
			private String 	checkOutDate;
			private String 	cityCode;
			private String 	countryCode;
			private String 	numberOfAdults;
			private String 	numberOfChildren;
			private int 	roomCnt;
		    private String 	customerSessionId;
		    private String 	city;
		    private int    	numberOfResults;*/
		}

		if(selRentcar != null || "Y".equals(selRentcar)){
			// 렌터카 파라메터
			
		}
		
		model.addAttribute("linkFitVo", linkFitVo);
		
		return _rootPath + "link";
	}
}
