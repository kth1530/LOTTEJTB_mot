<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : pop_rentcar_viewdetail.jsp
	// 설명 : 렌터카 상세보기 (새창)
%>

<script type="text/javascript">
	var carResultList = JSON.parse(sessionStorage.rentCarResultList);
	var rcIdx = "${rcIdx}";
	
	var rentInfo = rentalCarList[rcIdx];
	

	// 초기화
	var fn_init = function() {
		var countryCode = searchData.rentTakePlaceCountryCd;
		var vHTML = "";
		
		/*
		if("US" == countryCode){
			//vHTML += '<li>LDW (차량손실 면책프로그램=자차보험)</li>';
			//vHTML += '<li>LIS (대인/대물 추가 책임보험)</li>';
			//vHTML += '<li>TAX (세금)</li>';
			//vHTML += '<li>Surcharges (부가세)</li>';
			//vHTML += '<li>UM (무제한 마일리지)</li>';
			
			vHTML += '<dl class="ft_acdon ft_acdon1 pop_acdon1" style="padding-bottom:0px;">';
			vHTML += '	<dt class="on">LDW (차량손실 면책프로그램=자차보험)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">Hertz 차량의 파손 및 도난에 대한 책임이 면제됩니다.</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '	<dt>LIS (대인/대물 추가 책임보험)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">제 3자로 부터의 손해배상 청구에 대해 기본 포함되는 대인/대물 보상한도(USD 20,000-USD 100,000 : 지역에 따라 다름)를 최대 USD 1,000,000까지 상향시켜줍니다.</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '	<dt>TAX (세금)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">지역별 세금(State Tax)</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '	<dt>Surcharges (부가세)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">공항세 (Airport Concession Fee Recovery)</li>';
			vHTML += '			<li style="line-height:1.5;">영업소 서비스 비용 (Location Service Charge)</li>';
			vHTML += '			<li style="line-height:1.5;">차량 등록세 (Vehicle Licensing Fee)</li>';
			vHTML += '			<li style="line-height:1.5;">에어 컨디셔너 부가세 (Air Conditioner Surcharge Recovery)</li>';
			vHTML += '			<li style="line-height:1.5;">환경세 (Energy Surcharge) 등</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '	<dt>UM (무제한 마일리지)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">UM (무제한 마일리지)</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '</dl>';
		}else if("CA" == countryCode || "NZ" == countryCode){							// 캐나다
			//vHTML += '<li>LDW (차량손실 면책프로그램=자차보험)</li>';
			//vHTML += '<li>Liability (대인/대물 책임보험)</li>';
			//vHTML += '<li>UM (무제한 마일리지)</li>';
			//vHTML += '<li>TAX (세금)</li>';
			//vHTML += '<li>Surcharges (부가세)</li>';
			
			if("CA" == countryCode){
				vHTML += '<dl class="ft_acdon ft_acdon1 pop_acdon1" style="padding-bottom:0px;">';
				vHTML += '	<dt class="on">LDW (차량손실 면책프로그램=자차보험)</dt>';
				vHTML += '	<dd style="background-color:#FFFFFF">';
				vHTML += '		<ul class="pop_liacdon1">';
				vHTML += '			<li style="line-height:1.5;">Hertz 차량의 파손 및 도난에 대한 책임이 경감되며, 일정 금액(CAD 500)의 본인 책임액이 적용됩니다.</li>';
				vHTML += '		</ul>';
				vHTML += '	</dd>';
				vHTML += '	<dt>LIS (대인/대물 추가 책임보험)</dt>';
				vHTML += '	<dd style="background-color:#FFFFFF">';
				vHTML += '		<ul class="pop_liacdon1">';
				vHTML += '			<li style="line-height:1.5;">제 3자로 부터의 손해배상 청구에 대해 최대 CAD 1,000,000의 보상이 적용됩니다.</li>';
				vHTML += '		</ul>';
				vHTML += '	</dd>';
				vHTML += '	<dt>TAX (세금)</dt>';
				vHTML += '	<dd style="background-color:#FFFFFF">';
				vHTML += '		<ul class="pop_liacdon1">';
				vHTML += '			<li style="line-height:1.5;">지역별 세금(State Tax)</li>';
				vHTML += '		</ul>';
				vHTML += '	</dd>';
				vHTML += '	<dt>Surcharges (부가세)</dt>';
				vHTML += '	<dd style="background-color:#FFFFFF">';
				vHTML += '		<ul class="pop_liacdon1">';
				vHTML += '			<li style="line-height:1.5;">공항세 (Airport Concession Fee Recovery)</li>';
				vHTML += '			<li style="line-height:1.5;">영업소 서비스 비용 (Location Service Charge)</li>';
				vHTML += '			<li style="line-height:1.5;">차량 등록세 (Vehicle Licensing Fee)</li>';
				vHTML += '			<li style="line-height:1.5;">에어 컨디셔너 부가세 (Air Conditioner Surcharge Recovery)</li>';
				vHTML += '			<li style="line-height:1.5;">환경세 (Energy Surcharge) 등</li>';
				vHTML += '		</ul>';
				vHTML += '	</dd>';
				vHTML += '	<dt>UM (무제한 마일리지)</dt>';
				vHTML += '	<dd style="background-color:#FFFFFF">';
				vHTML += '		<ul class="pop_liacdon1">';
				vHTML += '			<li style="line-height:1.5;">UM (무제한 마일리지)</li>';
				vHTML += '		</ul>';
				vHTML += '	</dd>';
				vHTML += '</dl>';
			}else if("NZ" == countryCode){
				vHTML += '<dl class="ft_acdon ft_acdon1 pop_acdon1" style="padding-bottom:0px;">';
				vHTML += '	<dt class="on">LDW (차량손실 면책프로그램=자차보험)</dt>';
				vHTML += '	<dd style="background-color:#FFFFFF">';
				vHTML += '		<ul class="pop_liacdon1">';
				vHTML += '			<li style="line-height:1.5;">Hertz 차량의 파손 및 도난에 대한 책임이 경감되며, 일정 금액(최대 NZD 4,025)의 본인 책임액이 적용됩니다.</li>';
				vHTML += '		</ul>';
				vHTML += '	</dd>';
				vHTML += '	<dt>LIS (대인/대물 추가 책임보험)</dt>';
				vHTML += '	<dd style="background-color:#FFFFFF">';
				vHTML += '		<ul class="pop_liacdon1">';
				vHTML += '			<li style="line-height:1.5;">제 3자로 부터의 손해배상 청구에 대해 최대 NZD 10,000,000의 보상이 적용됩니다.</li>';
				vHTML += '		</ul>';
				vHTML += '	</dd>';
				vHTML += '	<dt>TAX (세금)</dt>';
				vHTML += '	<dd style="background-color:#FFFFFF">';
				vHTML += '		<ul class="pop_liacdon1">';
				vHTML += '			<li style="line-height:1.5;">지역별 세금</li>';
				vHTML += '		</ul>';
				vHTML += '	</dd>';
				vHTML += '	<dt>Surcharges (부가세)</dt>';
				vHTML += '	<dd style="background-color:#FFFFFF">';
				vHTML += '		<ul class="pop_liacdon1">';
				vHTML += '			<li style="line-height:1.5;">공항세 (Airport Concession Fee Recovery)</li>';
				vHTML += '			<li style="line-height:1.5;">영업소 서비스 비용 (Location Service Charge)</li>';
				vHTML += '			<li style="line-height:1.5;">차량 등록세 (Vehicle Licensing Fee)</li>';
				vHTML += '			<li style="line-height:1.5;">에어 컨디셔너 부가세 (Air Conditioner Surcharge Recovery)</li>';
				vHTML += '			<li style="line-height:1.5;">환경세 (Energy Surcharge) 등</li>';
				vHTML += '		</ul>';
				vHTML += '	</dd>';
				vHTML += '	<dt>UM (무제한 마일리지)</dt>';
				vHTML += '	<dd style="background-color:#FFFFFF">';
				vHTML += '		<ul class="pop_liacdon1">';
				vHTML += '			<li style="line-height:1.5;">UM (무제한 마일리지)</li>';
				vHTML += '		</ul>';
				vHTML += '	</dd>';
				vHTML += '</dl>';
			}
		} else if("DK" == countryCode || "GL" == countryCode || "IS" == countryCode ||  "PL" == countryCode ||
                "RS" == countryCode || "AT" == countryCode || "BY" == countryCode ||  "CZ" == countryCode ||
                "DE" == countryCode || "GE" == countryCode || "GR" == countryCode ||  "LT" == countryCode ||
                "LU" == countryCode || "SE" == countryCode || "SI" == countryCode ||  "TR" == countryCode ||
                "VA" == countryCode || "AM" == countryCode || "EE" == countryCode ||  "HU" == countryCode ||
                "NL" == countryCode || "RU" == countryCode || "VI" == countryCode ||  "AZ" == countryCode ||
                "BE" == countryCode || "ES" == countryCode || "FI" == countryCode ||  "GI" == countryCode ||
                "IT" == countryCode || "KG" == countryCode || "MD" == countryCode ||  "NO" == countryCode ||
                "SK" == countryCode || "BG" == countryCode || "CS" == countryCode ||  "FO" == countryCode ||
                "GB" == countryCode || "LV" == countryCode || "MC" == countryCode ||  "TM" == countryCode ||
                "YU" == countryCode || "AL" == countryCode || "CY" == countryCode ||  "HR" == countryCode ||
                "IE" == countryCode || "MT" == countryCode || "SM" == countryCode ||  "UA" == countryCode ||
                "VG" == countryCode || "BA" == countryCode || "CH" == countryCode ||  "PT" == countryCode ||
                "RO" == countryCode || "TJ" == countryCode || "FR" == countryCode) { 	// 유럽
			//vHTML += '<li>CDW (차량손실 면책프로그램=자차보험)</li>';
			//vHTML += '<li>TP (도난보험)</li>';
			//vHTML += '<li>Liability (대인/대물 책임보험)</li>';
			//vHTML += '<li>Super Cover (완전면책 프로그램)</li>';
			//vHTML += '<li>PI (임차인 상해 및 휴대품 분실보험)</li>';
			//vHTML += '<li>UM (무제한 마일리지)</li>';
			//vHTML += '<li>TAX (세금)</li>';
			//vHTML += '<li>Surcharges (부가세)</li>';
			
			vHTML += '<dl class="ft_acdon ft_acdon1 pop_acdon1" style="padding-bottom:0px;">';
			vHTML += '	<dt class="on">CDW (차량손실 면책프로그램=자차보험)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">Hertz 차량의 파손 및 도난에 대한 책임이 경감되며, 일정 금액의 본인 책임액이 적용됩니다.</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '	<dt>TP (도난보험)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">Hertz 차량의 도난에 대한 책임이 경감되며, 일정 금액의 본인 책임액이 적용됩니다.</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '	<dt>Liability (대인/대물 책임보험)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">제 3자로 부터 손해배상 청구에 대해 보상이 적용됩니다.<br/> 국가별 보상한도가 다르며 일정 금액의 본인 책임액이 적용됩니다.</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '	<dt>PI (임차인 상해 및 휴대품 분실보험)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">임차인 및 동승자의 상해 및 수하물 분실에 대한 보상이 적용됩니다.</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '	<dt>UM (무제한 마일리지)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">UM (무제한 마일리지)</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '	<dt>TAX (세금)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">지역별 세금</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '	<dt>Surcharges (부가세)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">공항세 (Airport Concession Fee Recovery)</li>';
			vHTML += '			<li style="line-height:1.5;">영업소 서비스 비용 (Location Service Charge)</li>';
			vHTML += '			<li style="line-height:1.5;">차량 등록세 (Vehicle Licensing Fee)</li>';
			vHTML += '			<li style="line-height:1.5;">에어 컨디셔너 부가세 (Air Conditioner Surcharge Recovery)</li>';
			vHTML += '			<li style="line-height:1.5;">환경세 (Energy Surcharge) 등</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '</dl>';
		} else if("AU" == countryCode){							// 호주
			//vHTML += '<li>LDW (차량손실 면책프로그램=자차보험)</li>';
			//vHTML += '<li>UM (무제한 마일리지)</li>';
			//vHTML += '<li>TAX (세금)</li>';
			//vHTML += '<li>Surcharges (부가세)</li>';
			
			vHTML += '<dl class="ft_acdon ft_acdon1 pop_acdon1" style="padding-bottom:0px;">';
			vHTML += '	<dt class="on">LDW (차량손실 면책프로그램=자차보험)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">Hertz 차량의 파손 및 도난에 대한 책임이 경감되며, 일정 금액(최대 AUD 8,250)의 본인 책임액이 적용됩니다.</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '	<dt>UM (무제한 마일리지)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">UM (무제한 마일리지)</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '	<dt>TAX (세금)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">지역별 세금</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '	<dt>Surcharges (부가세)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">공항세 (Airport Concession Fee Recovery)</li>';
			vHTML += '			<li style="line-height:1.5;">영업소 서비스 비용 (Location Service Charge)</li>';
			vHTML += '			<li style="line-height:1.5;">차량 등록세 (Vehicle Licensing Fee)</li>';
			vHTML += '			<li style="line-height:1.5;">에어 컨디셔너 부가세 (Air Conditioner Surcharge Recovery)</li>';
			vHTML += '			<li style="line-height:1.5;">환경세 (Energy Surcharge) 등</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '</dl>';
		} else if("GU" == countryCode){							// 괌
			//vHTML += '<li>LDW (차량손실 면책프로그램=자차보험)</li>';
			//vHTML += '<li>UM (무제한 마일리지)</li>';
			//vHTML += '<li>TAX (세금)</li>';
			//vHTML += '<li>Surcharges (부가세)</li>';
			
			vHTML += '<dl class="ft_acdon ft_acdon1 pop_acdon1" style="padding-bottom:0px;">';
			vHTML += '	<dt class="on">LDW (차량손실 면책프로그램=자차보험)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">Hertz 차량의 파손 및 도난에 대한 책임이 면제됩니다.</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '	<dt>UM (무제한 마일리지)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">UM (무제한 마일리지)</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '	<dt>TAX (세금)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">지역별 세금</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '	<dt>Surcharges (부가세)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">공항세 (Airport Concession Fee Recovery)</li>';
			vHTML += '			<li style="line-height:1.5;">영업소 서비스 비용 (Location Service Charge)</li>';
			vHTML += '			<li style="line-height:1.5;">차량 등록세 (Vehicle Licensing Fee)</li>';
			vHTML += '			<li style="line-height:1.5;">에어 컨디셔너 부가세 (Air Conditioner Surcharge Recovery)</li>';
			vHTML += '			<li style="line-height:1.5;">환경세 (Energy Surcharge) 등</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '</dl>';
		} else if("MP" == countryCode){							// 사이판
			//vHTML += '<li>LDW (차량손실 면책프로그램=자차보험)</li>';
			//vHTML += '<li>UM (무제한 마일리지)</li>';
			//vHTML += '<li>TAX (세금)</li>';
			//vHTML += '<li>Surcharges (부가세)</li>';
			
			vHTML += '<dl class="ft_acdon ft_acdon1 pop_acdon1" style="padding-bottom:0px;">';
			vHTML += '	<dt class="on">LDW (차량손실 면책프로그램=자차보험)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">Hertz 차량의 파손 및 도난에 대한 책임이 면제됩니다.</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '	<dt>UM (무제한 마일리지)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">UM (무제한 마일리지)</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '	<dt>TAX (세금)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">지역별 세금</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '	<dt>Surcharges (부가세)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">공항세 (Airport Concession Fee Recovery)</li>';
			vHTML += '			<li style="line-height:1.5;">영업소 서비스 비용 (Location Service Charge)</li>';
			vHTML += '			<li style="line-height:1.5;">차량 등록세 (Vehicle Licensing Fee)</li>';
			vHTML += '			<li style="line-height:1.5;">에어 컨디셔너 부가세 (Air Conditioner Surcharge Recovery)</li>';
			vHTML += '			<li style="line-height:1.5;">환경세 (Energy Surcharge) 등</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '</dl>';
		} else if("UZ" == countryCode || "YE" == countryCode || "BN" == countryCode ||  "KP" == countryCode ||
                "LA" == countryCode || "PK" == countryCode || "TH" == countryCode ||  "TW" == countryCode ||
                "IN" == countryCode || "JP" == countryCode || "MN" == countryCode ||  "AF" == countryCode ||
                "CC" == countryCode || "HK" == countryCode || "ID" == countryCode ||  "MO" == countryCode ||
                "MV" == countryCode || "YT" == countryCode || "IQ" == countryCode ||  "KR" == countryCode ||
                "KW" == countryCode || "KZ" == countryCode || "MM" == countryCode ||  "MY" == countryCode ||
                "BH" == countryCode || "KH" == countryCode || "LK" == countryCode ||  "NP" == countryCode ||
                "SG" == countryCode || "VN" == countryCode || "WF" == countryCode ||  "BD" == countryCode ||
                "BT" == countryCode || "CN" == countryCode || "PH" == countryCode ||  "UM" == countryCode) { // 아시아
			//vHTML += '<li>LDW (차량손실 면책프로그램=자차보험)</li>';
			//vHTML += '<li>UM (무제한 마일리지)</li>';
			//vHTML += '<li>TAX (세금) </li>';
			//vHTML += '<li>Surcharges (부가세)</li>';
			
			vHTML += '<dl class="ft_acdon ft_acdon1 pop_acdon1" style="padding-bottom:0px;">';
			vHTML += '	<dt class="on">LDW (차량손실 면책프로그램=자차보험)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">Hertz 차량의 파손 및 도난에 대한 책임이 면제됩니다.</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '	<dt>UM (무제한 마일리지)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">UM (무제한 마일리지)</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '	<dt>TAX (세금)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">지역별 세금</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '	<dt>Surcharges (부가세)</dt>';
			vHTML += '	<dd style="background-color:#FFFFFF">';
			vHTML += '		<ul class="pop_liacdon1">';
			vHTML += '			<li style="line-height:1.5;">공항세 (Airport Concession Fee Recovery)</li>';
			vHTML += '			<li style="line-height:1.5;">영업소 서비스 비용 (Location Service Charge)</li>';
			vHTML += '			<li style="line-height:1.5;">차량 등록세 (Vehicle Licensing Fee)</li>';
			vHTML += '			<li style="line-height:1.5;">에어 컨디셔너 부가세 (Air Conditioner Surcharge Recovery)</li>';
			vHTML += '			<li style="line-height:1.5;">환경세 (Energy Surcharge) 등</li>';
			vHTML += '		</ul>';
			vHTML += '	</dd>';
			vHTML += '</dl>';
		}
		*/
		
		if("US" == countryCode){
			vHTML += '<li>LDW (차량손실 면책프로그램=자차보험)</li>';
			vHTML += '<li>LIS (대인/대물 추가 책임보험)</li>';
			vHTML += '<li>TAX (세금)</li>';
			vHTML += '<li>Surcharges (부가세)</li>';
			vHTML += '<li>UM (무제한 마일리지)</li>';
		}else if("CA" == countryCode || "NZ" == countryCode){							// 캐나다
			vHTML += '<li>LDW (차량손실 면책프로그램=자차보험)</li>';
			vHTML += '<li>LIS (대인/대물 추가 책임보험)</li>';
			vHTML += '<li>TAX (세금)</li>';
			vHTML += '<li>Surcharges (부가세)</li>';
			vHTML += '<li>UM (무제한 마일리지)</li>';
		}else if("AD" == countryCode || "AT" == countryCode || "BE" == countryCode || "HR" == countryCode ||
				"CZ" == countryCode || "DK" == countryCode || "EE" == countryCode || "FJ" == countryCode ||
				"FI" == countryCode || "FR" == countryCode || "DE" == countryCode || "HU" == countryCode ||
				"IT" == countryCode || "LU" == countryCode || "MC" == countryCode || "NL" == countryCode ||
				"NO" == countryCode || "PT" == countryCode || "RS" == countryCode || "SK" == countryCode || 
				"SI" == countryCode || "ES" == countryCode || "CH" == countryCode || "GB" == countryCode) { 	// 유럽
			vHTML += '<li>CDW (차량손실 면책프로그램=자차보험)</li>';
			vHTML += '<li>TP (도난보험)</li>';
			vHTML += '<li>Liability (대인/대물 책임보험)</li>';
			vHTML += '<li>Super Cover (완전면책 프로그램)</li>';
			vHTML += '<li>PI (임차인 상해 및 휴대품 분실보험)</li>';
			vHTML += '<li>UM (무제한 마일리지)</li>';
			vHTML += '<li>TAX (세금)</li>';
			vHTML += '<li>Surcharges (부가세)</li>';
		}else if("AU" == countryCode){						// 호주
			vHTML += '<li>LDW (차량손실 면책프로그램=자차보험)</li>';
			vHTML += '<li>UM (무제한 마일리지)</li>';
			vHTML += '<li>TAX (세금)</li>';
			vHTML += '<li>Surcharges (부가세)</li>';
		}else if("MY" == countryCode || "PH" == countryCode || "SG" == countryCode || "ZA" == countryCode ||
				"AE" == countryCode){
			vHTML += '<li>LDW (차량손실 면책프로그램=자차보험)</li>';
			vHTML += '<li>UM (무제한 마일리지)</li>';
			vHTML += '<li>TAX (세금) </li>';
			vHTML += '<li>Surcharges (부가세)</li>';
		}else{
			if(nullToBlank(rentInfo.coverType1) != ""){
				vHTML += '<li>'+ corverageType[rentInfo.coverType1] +'</li>';				
			}
			
			if(nullToBlank(rentInfo.coverType2) != ""){
				vHTML += '<li>'+ corverageType[rentInfo.coverType2] +'</li>';
			}
			
			if(nullToBlank(rentInfo.coverType3) != ""){
				vHTML += '<li>'+ corverageType[rentInfo.coverType3] +'</li>';
			}
			
			if(nullToBlank(rentInfo.coverType4) != ""){
				vHTML += '<li>'+ corverageType[rentInfo.coverType4] +'</li>';
			}
			
			if(nullToBlank(rentInfo.coverType5) != ""){
				vHTML += '<li>'+ corverageType[rentInfo.coverType5] +'</li>';
			}
		}
		
		$("#containOpt").html(vHTML);
	};

	var fn_search = function() {

	};

	// 버튼 초기화
	var fn_initButton = function() {

	};

	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		fn_init();
		fn_initButton();
	});
</script>

<div class="layerPopup">
    <div class="layerPop" style="background-color:#FFFFFF;">
		<!-- 내용시작 -->
        <div class="popCon">
			<div class="popHead">
				<div class="popTpart">
					<strong class="popTitle">상세조건</strong>
					<button type="button" class="layerClose"><img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기"></button>
				</div>
			</div>
			<div class="cntain cntain3 pop_lc_box white2">
				<ul class="tablist_com pop_ht_dttab" data-ctn="lc_dt_pop">
					<li class="active"><button type="button" data-role="none">포함사항</button></li>
					<li><button type="button" data-role="none">임차자격 및 이용규정</button></li>
				</ul>
				<div class="tabctn_com lc_dt_pop lc_dt_pop1 ps_view">
					<ul class="pop_lilist1" id="containOpt">
					</ul>
				</div>
				<div class="tabctn_com lc_dt_pop lc_dt_pop2">
					<div class="pay_text">
					※ 규정에 대한 정보는 영어로만 안내되며 한국어로 안내 되지 않음을 양해 바랍니다.
					</div>
					<dl class="ft_acdon ft_acdon1 pop_acdon1">
						<!-- dt class="on">RESERVATION TERMS AND CONDITIONS. CHECKLIST - WHAT YOU NEED TO BRING</dt -->
						<dt class="on">예약 규정 및 조건 (확인사항 / 지참목록)</dt>
						<dd>
							<ul class="pop_liacdon1">
								<li>When you collect your vehicle you will need the credit card you used to make your booking (if you used a debit card, you will need that card plus a valid credit card in your name) and a full and current driving licence for each driver.</li>
								<li>Also, the name and details of the renter must be the same as the person that made the reservation.</li>
							</ul>
						</dd>
						<!-- dt>PAYMENT, PRICING & CHARGES</dt -->
						<dt>지불방법</dt>
						<dd>
							<ul class="pop_liacdon1">
								<li>Please note: we will block an amount on your credit/debit card equal to the anticipated cost of your rental over and above the amount paid at the time of reservation.</li>
								<li>Most locations accept the majority of debit cards. If you have questions about the acceptability of your form of payment, please check Rental Qualifications & Requirements.</li>
								<li>Although we try to ensure that all prices quoted on our websites are accurate, errors may sometimes occur. We will inform you as soon as possible if we discover an error in the price of your reservation and give you the opportunity to confirm your booking at the correct price or cancel your usual cancellation charges will not apply if you choose to cancel. If you cancel and you have already paid for your rental, you will receive a full refund. If we are unable to contact you we will treat your reservation as cancelled.</li>
								<li>An additional daily charge may apply for renters under 25 (see Rental Qualifications & Requirements).</li>
								<li>Estimated amount to be paid at the counter is based on available information at the time of reservation for renters age 25 and older. This does not include any additional items you may choose at the location, such as refuelling, LDW, etc.</li>
								<li>Where the booking is a prepaid booking and additional product have been selected, the total charge is estimated based on local currency conversion, where applicable, at time of booking, and is subject to exchange rate fluctuation at time of pick up for any additional products selected.</li>
							</ul>
						</dd>
						<!-- dt>CHANGES TO YOUR RESERVATION</dt -->
						<dt>예약의 변경</dt>
						<dd>
							<ul class="pop_liacdon1">
								<li>You can amend your reservation free of charge online through the View/Modify/Cancel button on our website or you can Contact Us, although we reserve the right to charge an administration fee.</li>
								<li>If you make a change we will recalculate your rental charges based on current prices, which may be more or less than the price originally booked. Please note that you must use the same credit card you used to make the original booking or you will need to cancel (see Cancellations below) and make a new reservation.</li>
								<li>We are unable to accept changes to the renter or the pick up location. If you want to change these, you will need to cancel (see Cancellations below) and make a new reservation.</li>
							</ul>
						</dd>
						<!-- dt>CHANGES AT TIME OF PICK UP</dt -->
						<dt>차량 인수 시간 변경</dt>
						<dd>
							<ul class="pop_liacdon1">
								<li>If you wish to rent a larger car or rent for a longer period, you can make these changes on pick up, subject to availability, on payment of additional charges, which will be quoted in the currency of the renting country.</li>
								<li>Please note that prepaid vouchers can only be used for rentals on the actual date quoted on the reservation. If you wish to change the pick-up date you must cancel (see Cancellations below) and re-book.</li>
							</ul>
						</dd>
						<!-- dt>CANCELLATIONS</dt -->
						<dt>취소 수수료</dt>
						<dd>
							<ul class="pop_liacdon1">
								<li>You can cancel your reservation online through the View/Modify/Cancel button or you can Contact Us.</li>
								<li>If you made a pre-paid reservation and cancel within 7 days of the original booking time we will refund your reservation in full. An administration charge of GBP 30, AED 200, AUD 70, BHD 25, CHF 65, DKK 300, EUR 45, KWD 20, NOK 300, OMR 25, PLN 200, QAR 200, RUB 1800, SAR 200, SEK 300, USD 60, ZAR 450 will apply if the cancellation is made after this time and will be taken from the credit card you used to make your booking.</li>
							</ul>
						</dd>
						<!-- dt>NO SHOWS / LOST RENTALS</dt -->
						<dt>노-쇼 / 예약 후 이용 불가 시</dt>
						<dd>
							<ul class="pop_liacdon1">
								<li>If you pre-paid, fail to cancel your reservation and do not collect the vehicle on the pick up date, we reserve the right to make a No Show / Lost Rental Charge of GBP 70, AED 450, AUD 150, BHD 50, CHF 140, DKK 700, EUR 95, KWD 50, NOK 750, OMR 50, PLN 400, QAR 400, RUB 3500, SAR 450, SEK 750, USD 130, ZAR 1050, which recovers our administration costs and compensates the Hertz company providing your rental for their inability to rent the vehicle when it was reserved for your use.</li>
								<li>In this case we will refund your prepayment, less the No Show/Lost Rental Charge, if you write to us within 90 days of the pick up date at Hertz Prepaid Accounting Department, Hertz Europe Service Centre, Swords Business Park, Swords, Co. Dublin, Ireland requesting repayment and enclosing a copy of your Reservation Confirmation.</li>
								<li>If you pay at location, fail to cancel your reservation and do not collect the vehicle on the pick up date, we reserve the right to make a No Show / Lost Rental Charge of EUR 40.00 (or local equivalent) which recovers our administration costs. This will be taken from the credit card you used to make your booking.</li>
							</ul>
						</dd>
						<!-- dt>EARLY RETURN / LATE RETURN CHARGE </dt -->
						<dt>조기 반납 / 늦은 반납시 수수료</dt>
						<dd>
							<ul class="pop_liacdon1">
								<li>If you pay at location, we reserve the right to make an Early Return Charge of EUR 8.00, GBP 7.00, CHF 10.00, SEK 72.00, NOK 65.00, DKK 61.00, RUB 349.00, AED 39.00, SAR 39.00, QAR 39.00, KWD 3.00, OMR 4.00, BHD 4.00, USD 11.00, PLN 35.00, ZAR 106.00, depending on your destination country, to compensate us in part for our inability to rent your vehicle during the time reserved for your use. Currently applicable only to rentals with a destination in Europe.</li>
								<li>If you prepaid or you pay at location, we reserve the right to make a Late Return Charge of EUR 11.5, GBP 10, CHF 14, SEK 102, NOK 92, DKK 87, RUB 499, AED 56, SAR 56, QAR 55, KWD 4, OMR 5.80, BHD 5.70, USD 15, PLN 50, ZAR 151, depending on your destination country, to compensate us in part for the costs we incur in finding an alternative vehicle to satisfy our next booking for your vehicle and for our administration costs in contacting you to return the vehicle. Currently applicable only to rentals with a destination in Europe.</li>
							</ul>
						</dd>
						<!-- dt>NATURE OF THIS AGREEMENT</dt -->
						<dt>계약의 성격</dt>
						<dd>
							<ul class="pop_liacdon1">
								<li>These reservation terms cover your booking with us (Hertz Europe Service Centre Limited, a company registered in Ireland) and are governed by Irish law. Your rental terms will be given to you by the Hertz company that provides your rental vehicle and will be governed by local law. </li>
								<li>Acceptance of your reservation and completion of this contract for provision of a rental vehicle will occur when the vehicle is made available for your use on the agreed pick up date by the Hertz company providing your rental.</li>
							</ul>
						</dd>
					</dl>
				</div>
			</div>				
		</div>
    </div>
</div>
