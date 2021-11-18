package com.lottejtb.account.service.impl;

import net.sf.json.JSONObject;

import com.inicis.inipay.INIpay;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;




import com.lottejtb.account.service.FreeLPointService;
import com.lottejtb.account.service.HtlPaymtService;
import com.lottejtb.account.service.HtlRefundMgtVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("HtlPaymtService")
public class HtlPaymtServiceImpl extends EgovAbstractServiceImpl implements HtlPaymtService{

private static final Logger logger = Logger.getLogger(AirPaymtServiceImpl.class);
		
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name="HtlPaymtDAO")
	private HtlPaymtDAO htlPaymtDao;
	
	@Resource(name="FreeLPointService")
	private FreeLPointService freeLpointService;

	@Override
	public void updateCancelYnHtlRsvMst(HtlRefundMgtVO reqVO) throws Exception {
		htlPaymtDao.updateCancelYnHtlRsvMst(reqVO);
	}
	
	/**
	 * 결제를 취소한다
	 *
     * @param paymentVoParam 결제 취소 정보
     * @return 결제 취소 결과
	 * @throws Exception 결제 취소 시 발생하는 예외
	 */
	@Override
	public JSONObject cancelPayment(JSONObject reqParam) throws Exception {
		JSONObject paymentVo = new JSONObject();

		try {
			String inipayHome = "";
			String mId = "";
			
			inipayHome 	= propertiesService.getString("payment.inipayHomeCancel");
			mId			= propertiesService.getString("payment.Card.mId");

			/***************************************
			 * 1. INIpay 클래스의 인스턴스 생성
			 ***************************************/
			INIpay inipay = new INIpay();

			/*********************
			 * 2. 취소 정보 설정
			 *********************/
			System.out.println("============ [JEH] HtlPaymtServiceImpl - cancelPayment - 취소정보설정 start! ==");
			HtlRefundMgtVO reqVo = new HtlRefundMgtVO();
			String fitRsvNo = reqParam.getString("fitRsvNo");
			reqVo.setFitRsvNo(fitRsvNo);
			
			HtlRefundMgtVO resultVo = htlPaymtDao.selectPaymentInfo(reqVo);
			
			inipay.SetField("inipayhome", inipayHome);  					// 이니페이 홈디렉터리(상점수정 필요)
			inipay.SetField("type", "cancel");                   			// 고정 (절대 수정 불가)
			inipay.SetField("debug", "true");                   			// 로그모드("true"로 설정하면 상세로그가 생성됨.)
			inipay.SetField("mid", mId);									// 상점아이디
			inipay.SetField("admin", "1111");                          		// 상점 키패스워드 (비대칭키)
			inipay.SetField("cancelreason", reqParam.get("cancelReason"));  // 현금영수증 취소코드

			//***********************************************************************************************************
			//* admin 은 키패스워드 변수명입니다. 수정하시면 안됩니다. 1111의 부분만 수정해서 사용하시기 바랍니다.      *
			//* 키패스워드는 상점관리자 페이지(https://iniweb.inicis.com)의 비밀번호가 아닙니다. 주의해 주시기 바랍니다.*
			//* 키패스워드는 숫자 4자리로만 구성됩니다. 이 값은 키파일 발급시 결정됩니다.                               *
			//* 키패스워드 값을 확인하시려면 상점측에 발급된 키파일 안의 readme.txt 파일을 참조해 주십시오.             *
			//***********************************************************************************************************
			inipay.SetField("tid", resultVo.getTidNo()); 		// 취소할 거래의 거래아이디
			inipay.SetField("cancelmsg", reqParam.get("msg"));  // 취소사유
			inipay.SetField("crypto", "execure");					// Extrus 암호화모듈 사용(고정)
			System.out.println("============ [JEH] HtlPaymtServiceImpl - cancelPayment - 취소정보설정 end! ==");

			/****************
			 * 3. 취소 요청
			 ****************/
			System.out.println("============ [JEH] HtlPaymtServiceImpl - cancelPayment - 취소요청 start! ==");
			inipay.startAction();
			System.out.println("============ [JEH] HtlPaymtServiceImpl - cancelPayment - 취소요청 end! ==");
			
			if("00".equals(inipay.GetResult("ResultCode"))){
				HtlRefundMgtVO pcVo = new HtlRefundMgtVO();
				pcVo.setFitRsvNo(fitRsvNo);
				pcVo.setHtlPaymtstateGb("XX");
				htlPaymtDao.updateCancelHtlPay(pcVo);
			}
			
			System.out.println("============ [JEH] HtlPaymtServiceImpl - cancelPayment - 가상계좌 취소 start! ==");
			/* 가상계좌 최소 */
			if(resultVo.getActNo() != null && !"".equals(resultVo.getActNo())){
				System.out.println("============ [JEH] HtlPaymtServiceImpl - cancelPayment - 가상계좌 취소 로직 in ==");
				INIpay inipayB = new INIpay();

				String inipayHomeB = "";
				String mIdB = "";
				
				inipayHomeB 	= propertiesService.getString("payment.inipayHomeCancel");
				mIdB			= propertiesService.getString("payment.Vbank.mId");

				if("00".equals(inipayB.GetResult("ResultCode"))){
					HtlRefundMgtVO pcVo = new HtlRefundMgtVO();
					pcVo.setFitRsvNo(fitRsvNo);
					pcVo.setHtlPaymtstateGb("XX");
					htlPaymtDao.updateCancelHtlPay(pcVo);
				}
				
				inipayB.SetField("inipayhome", inipayHomeB);  						// 이니페이 홈디렉터리(상점수정 필요)
				inipayB.SetField("type", "cancel");                   				// 고정 (절대 수정 불가)
				inipayB.SetField("debug", "true");                   				// 로그모드("true"로 설정하면 상세로그가 생성됨.)
				inipayB.SetField("mid", mIdB);										// 상점아이디
				inipayB.SetField("admin", "1111");                          		// 상점 키패스워드 (비대칭키)
				inipayB.SetField("cancelreason", reqParam.get("cancelReason"));  	// 현금영수증 취소코드

				//***********************************************************************************************************
				//* admin 은 키패스워드 변수명입니다. 수정하시면 안됩니다. 1111의 부분만 수정해서 사용하시기 바랍니다.      *
				//* 키패스워드는 상점관리자 페이지(https://iniweb.inicis.com)의 비밀번호가 아닙니다. 주의해 주시기 바랍니다.*
				//* 키패스워드는 숫자 4자리로만 구성됩니다. 이 값은 키파일 발급시 결정됩니다.                               *
				//* 키패스워드 값을 확인하시려면 상점측에 발급된 키파일 안의 readme.txt 파일을 참조해 주십시오.             *
				//***********************************************************************************************************
				inipayB.SetField("tid", resultVo.getActNo()); 		// 취소할 거래의 거래아이디
				inipayB.SetField("cancelmsg", reqParam.get("msg"));  // 취소사유
				inipayB.SetField("crypto", "execure");					// Extrus 암호화모듈 사용(고정)

				/****************
				 * 3. 취소 요청
				 ****************/
				System.out.println("============ [JEH] HtlPaymtServiceImpl - cancelPayment - 가상계좌 취소 요청 start ==");
				inipayB.startAction();
				System.out.println("============ [JEH] HtlPaymtServiceImpl - cancelPayment - 가상계좌 취소 요청 end ==");
			}
			System.out.println("============ [JEH] HtlPaymtServiceImpl - cancelPayment - 가상계좌 취소 end ==");


			/****************************************************************
			 * 4. 취소 결과
			 ****************************************************************/
			paymentVo.put("resultCode", inipay.GetResult("ResultCode")); // 결과코드
			paymentVo.put("resultMsg", inipay.GetResult("ResultMsg")); // 결과내용
			paymentVo.put("tId", inipay.GetResult("tid")); // 거래번호
			paymentVo.put("cancelDate", inipay.GetResult("CancelDate")); // 취소날짜
			paymentVo.put("cancelTime", inipay.GetResult("CancelTime")); // 취소시각
			paymentVo.put("cshrCancelNum", inipay.GetResult("CSHR_CancelNum")); // 현금영수증 취소승인번호

			
			//LPOINT 취소 처리 로직
			System.out.println("============ [JEH] HtlPaymtServiceImpl - cancelPayment - LPOINT 취소 처리 로직 start! ==");
			freeLpointService.cancelLpointUse(fitRsvNo);
			System.out.println("============ [JEH] HtlPaymtServiceImpl - cancelPayment - LPOINT 취소 처리 로직 end! ==");
			
		} catch (Exception e) {

			System.out.println("============ [JEH] HtlPaymtServiceImpl - cancelPayment - catch!!! ==");
			System.out.println(e);
			logger.error("cancelPayment Exception: {}", e);

		}

		return paymentVo;
	}
}
