var data ='';
var homeUrl = "http://m.lottejtb.com";
	
data +=' 	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />';
data +=' 	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">';
data +=' 	<meta http-equiv="cache-control" content="no-cache" />';
data +=' 	<meta http-equiv="pragma" content="no-cache" />';
data +=' 	<meta http-equiv="expires" content="-1" />';
data +=' 	<meta name="robots" content="all" />';
data +=' 	<meta name="keywords" content="" />';
data +=' 	<link rel="shortcut icon" type="image/x-icon" href="' + homeUrl + '/resources/common/images_ju/lottejtb.ico">';
data +='  	<script src="' + homeUrl + '/resources/common/js/menuList.js"></script>';
data +=' 	<script src="' + homeUrl + '/resources/common/js/utils.js"></script>';
data +=' 	<link rel="stylesheet" href="' + homeUrl + '/resources/common/css_ju/reset.css">';
data +=' 	<link rel="stylesheet" href="' + homeUrl + '/resources/common/css_ju/swiper.css">';
data +=' 	<link rel="stylesheet" href="' + homeUrl + '/resources/common/css_ju/style.css">';
data +=' 	<script src="' + homeUrl + '/resources/common/css_ju/jquery-latest.min.js"></script>';
	
data +=' 	<!-- <script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script> -->';
data +=' 	<script src="' + homeUrl + '/resources/common/css_ju/swiper.js"></script>';
data +=' 	<div class="bodyWrap">';
data +=' 		<div class="callbox">';
data +='			<span>여행상담안내</span>';
data +='  			<p><a href="tel:02-1577-6511" class="ui-link">1577-6511</a></p>';
data +='		<div>평일 <b>9:00~18:30</b> | 토요일<b>9 : 00 ~ 18 : 00</b><br>일요일 및 공휴일 휴무</div>';
data +='		</div>';
data +='  		<div class="footerWrap">';
data +='			<ul class="foot_top">';
data +=' 				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/main.do\', 1)" class="ui-link">홈</a></li>';
data +='				<li class="divider">|</li>';
data +=' 				<li><a href="#"  onclick="moveMenu(\'' + homeUrl +'/mytour/mytour.do\', 1)" class="ui-link">예약확인/결제</a></li>';
data +='				<li class="divider">|</li>';
data +='				<li><a href="http://www.lottejtb.com/xhtml/index.xhtml?ui=pc" target="_blank" class="ui-link">PC버젼</a></li>';
data +=' 				<li class="divider">|</li>';
data +='				<li><a href="#" class="footop ui-link"><i class="fa fa-angle-up"></i>TOP</a></li>';
data +='			</ul>';
data +='			<ul class="foot_box">';
data +='				<li><a href="#"  onclick="moveMenu(\'' + homeUrl +'/customer/travel_clause.do\', 1);" class="ui-link">여행약관</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/customer/clause.do\', 1);" class="ui-link">이용약관</a></li>';
data +='				<li><a href="#" onclick="fn_travelCaluse();">해외여행자 보험약관</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/customer/policy.do\', 1);" class="letterS ui-link">개인정보 처리방침</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/corperate/corperate.do?tab=3\',1)" class="ui-link">찾아오시는 길</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/shop/shopList.do\', 1)" class="ui-link">매장안내</a></li>';
data +='			</ul>';
data +='			<div class="foot_txt">';
data +='				<span>롯데제이티비(주) 대표이사 카미모리 히로아리, 안규동</span>';
data +='				<span>122-827 서울시 은평구 통일로 626 유림빌딩 롯데제이티비(주)</span>';
data +='				<span>';
data +='					<i>사업자등록번호: 201-86-02089</i>';
data +='					<i>통신판매업 신고번호 : 제 2011-서울은평-0415호</i>';
data +='					<i>관광사업자 등록번호 :일반 제2011-0002호</i>';
data +='					<i>여행상담 : 1577-6511(고객감동센터)</i>';
data +='					<i>제휴 및 사업문의 :02-3782-3094</i>';
data +='					<i>개인정보관리책임 및 청소년보호 책임자 :이문규</i>';
data +='				</span>';
data +='			</div>';
data +='		</div>';
data +='	</div>';

document.write(data);