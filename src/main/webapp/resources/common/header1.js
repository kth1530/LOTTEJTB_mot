/*header.js*/

(function () {

	var scriptPaths = document.getElementsByTagName("script"),
		 rootPath = "./", // header.js 에서 root 폴더까지의 위치 개발자가 수정해줘야 하는 부분...
		headerPath = "";

	for (var i = 0; i < scriptPaths.length; i++) {
		if (scriptPaths[i].getAttribute("src").indexOf('header.js') !== -1) {

			headerPath = scriptPaths[i].getAttribute("src").split('header.js')[0];
			var path = headerPath + rootPath;

		   document.write('<meta http-equiv="cache-control" content="no-cache" />');
		   document.write('<meta http-equiv="pragma" content="no-cache" />');
		   document.write('<meta http-equiv="expires" content="-1" />');
		   document.write('<meta name="robots" content="all" />');
		   document.write('<meta name="keywords" content="" />');
		   document.write('<script src="' + path + 'js/UserAgent.js"></script>"></script>');           
			document.write('<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">');
			  //,target-densitydpi=medium-dpi
			document.write('<title>롯데Holyday 모바일</title>');
			document.write('<link rel="stylesheet" href="' + path + 'css/jquery.mobile-1.4.5.min.css">'); 
			document.write('<link rel="stylesheet" href="' + path + 'css/swiper.min.css">');
			document.write('<link rel="stylesheet" href="' + path + 'css/common.css">');
			document.write('<link rel="shortcut icon" type="image/x-icon" href="' + path + 'css/lottejtb.ico">');
			//document.write('<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,700">');
			//document.write('<script src="' + path + '../common/js/jquery.js"></script>');  
			document.write('<script  src="' + path + 'js/jquery.mobile-1.4.5.min.js"></script>');
			document.write('<script  src="' + path + 'js/jquery.js"></script>');
			document.write('<script src="' + path + 'js/common.js"></script>');
			document.write('<script src="' + path + 'js/library/jquery.anchor.js"></script>');



			// document.write('<script src="' + path + 'common/js/swiper.js"></script>');
		   // document.write('<script src="' + path + 'common/js/uisearch.js"></script>');
			document.write('<script src="' + path + 'js/library/jquery.easing.1.3.js"></script>');
			document.write('<script src="' + path + 'js/library/jquery.fancybox-1.3.4.pack.js"></script>');
			document.write('<script src="' + path + 'js/library/jquery.word-break-keep-all.min.js"></script>');
			document.write('<script src="' + path + 'js/library/ui.checkbox.js"></script>');
			document.write('<script src="' + path + 'js/library/ui.core.js"></script>');



	/*<link rel="stylesheet" href="../_assets/css/jqm-demos.css">
  <link rel="shortcut icon" href="../favicon.ico">
	<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,700">
  <script src="../js/jquery.js"></script>
	<script src="../_assets/js/index.js"></script>
	<script src="../js/jquery.mobile-1.4.5.min.js"></script-->*/

  /*  <link rel="stylesheet" href="../css/themes/default/jquery.mobile-1.4.5.min.css">
	<link rel="stylesheet" href="../_assets/css/jqm-demos.css">
  <link rel="shortcut icon" href="../favicon.ico">
	<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,700">
  <script src="../js/jquery.js"></script>
	<script src="../_assets/js/index.js"></script>
	<script src="../js/jquery.mobile-1.4.5.min.js"></script-->*/

			//삼성 UI프레임워크 플랫폼(순서 지킬것)
			// document.write('<link rel="stylesheet" href="' + path + 'library/jquery.mobile-1.2.css" />');
			 //document.write('<script src="' + path + 'js/MDHAdapter.js"></script>');
			 //document.write('<script src="' + path + 'library/jquery.js"></script>');
			 //document.write('<link rel="stylesheet" href="' + path + 'library/sui.fixedtoolbar-1.2.css" />');
			 //document.write('<script src="' + path + 'library/sui.fixedtoolbar.config.js"></script>');
			 //document.write('<script src="' + path + 'library/jquery.mobile-1.2.js"></script>');
			 //document.write('<script src="' + path + 'library/sui.fixedtoolbar.js"></script>');
			 //document.write('<link rel="stylesheet" href="' + path + 'library/sds.css" />');
			// document.write('<script src="' + path + 'library/jdate.js"></script>');

			//에스프레소 라이브러리
			//document.write('<script src="' + path + 'library/espresso/espresso.emulator.js"></script>'); //PC브라우저
			// document.write('<script src="' + path + 'library/espresso/espresso.common-2.2.js"></script>');
			// document.write('<script src="' + path + 'library/espresso/espresso.page.js"></script>');

			//에러메세지
			// document.write('<script src="' + path + 'js/messages.js"></script>');

			//공통 라이브러리
			// document.write('<script src="' + path + 'js/common_account.js"></script>');
			//  document.write('<script src="' + path + 'js/common_control.js"></script>');
			//  document.write('<script src="' + path + 'js/common_customer.js"></script>');
			//  document.write('<script src="' + path + 'js/common_device.js"></script>');
			//   document.write('<script src="' + path + 'js/common_function.js"></script>');
			//   document.write('<script src="' + path + 'js/import_env.js"></script>');

			//AR
			//   document.write('<link rel="stylesheet" href="' + path + 'library/ar.css" />');
			//  document.write('<script src="' + path + 'biz_home/js/home_SEMP.js"></script>');
			//  document.write('<script src="' + path + 'biz_work/js/work_SEMP.js"></script>');
			//  document.write('<script src="' + path + 'biz_home/library/zabuto_calendar/zabuto_calendar.js"></script>');
			//   document.write('<link rel="stylesheet" href="' + path + 'biz_home/library/zabuto_calendar/zabuto_calendar2.css" />');
			 //document.write('<script src="' + path + 'js/list.js"></script>'); //http://www.listjs.com/
		 }
	 }
 }());

/*hearder*/
