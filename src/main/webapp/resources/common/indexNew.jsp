<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"		uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">

    <head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />		
        <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
        <meta name="author" content="">
        <meta name="description" content="">
        <meta name="keywords" content="">
        <meta name="format-detection" content="telephone=no">
        <title>롯데제이티비X묘미</title>

        <!-- CSS 58,59 /home/FREE_WEB/public_html/common/js/page/myomee-->
        <link rel="stylesheet" href="/common/js/page/myomee/assets/css/reset.css?version=1.1">
        <link rel="stylesheet" href="/common/js/page/myomee/assets/css/style.css?version=1.1">
        <link rel="stylesheet" href="/common/js/page/myomee/assets/css/custom.css?version=1.1">
	
		<!-- date picker-->
		<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">		

        <!-- jQuery 58,59 /home/FREE_WEB/public_html/common/js/page/myomee -->
		<script type="text/javascript" src="/common/js/page/myomee/jquery-3.3.1.min.js"></script>
		<script type="text/javascript" src="/common/js/page/myomee/custom.js"></script>
		<!--주소api-->
		<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
        <!-- xeicon -->
        <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
		
		<!-- Global site tag (gtag.js) - Google Analytics -->
		<script async src="https://www.googletagmanager.com/gtag/js?id=G-HHXVTCKD6K"></script>
		<script>
		  window.dataLayer = window.dataLayer || [];
		  function gtag(){dataLayer.push(arguments);}
		  gtag('js', new Date());

		  gtag('config', 'G-HHXVTCKD6K');
		</script>
	
		
    </head>

<style>

    @media screen and (min-width: 768px) {

    }
	
	.button {

	  background-color:#9999a9;

	  border: none;

	  color: white;

	  padding: 15px 50px;

	  text-align: center;

	  text-decoration: none;

	  display: inline-block;

	  font-size: 16px;

	  margin: 4px 310px 0px 10px;

	  cursor: pointer;
	  
	}	
	
	.txtBox00, .txtBox01, .txtBox02, .txtBox03, .txtBox04 {
		border-style: solid; border-width: 2px; padding: 12px; word-break: break-all; 
	} 
	.txtBox00 { border-color: LightGray; } .txtBox01 { border-color: DodgerBlue; } .txtBox02 { border-color: LightSalmon; } .txtBox03 { border-color: Tomato; } .txtBox04 { border-color: Crimson; }

	


</style>

<body>
<form name="form">
<div id="wrap">
    <!-- 메인 -->
    <div class="main">
        <!-- 섹션 01 -->
        <div class="s01">
            <div class="cont">
                <div class="sponsor">
                    <div class="sl"><img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/logo.png" alt=""></div>
                    <div class="sc"><img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/icon-x.png" alt=""></div>
                    <div class="sr"><img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/sponsor02.png" alt=""></div>
                </div>
                <div class="p1">
                    <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/icon-camera.png" alt="">
                    <div class="tit">여행을 준비하다, 일상이 여행이다!</div>
                </div>
                <div class="p2">
                    <div class="tit">
                        롯데제이티비 여행상품권으로, <br> 
                        <span class="em">묘미(MYOMEE) 인기상품 구매</span>
                    </div>
                </div>
                <div class="p3">
                    <div class="tit">
                        코로나 바이러스로 모두가 답답하고 힘든 시간<br>
                        <span class="em">여러분의 일상에 여행을 선물</span>합니다!
                    </div>
                    <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/icon-x.png" alt="">
                </div>
            </div>
            <div class="banner">
                <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/banner.png" alt="">
            </div>
        </div>

        <!-- 섹션 02 -->
        <div class="s02">
            <!-- 탭 선택 -->
            <div class="cont-btn">
                <div class="toggle_btn active" id="btn-tab01">여행을 준비하다!</div>
                <div class="toggle_btn" id="btn-tab02">일상이 여행이다!</div>
                <div class="toggle_btn" id="btn-tab03">우리집이 호텔이다!</div>
            </div>

            <!-- 탭 화면1 -->
            <div class="tab active" id="tab01">
                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2003322&optValCd=001&dpCatCd=S004129004&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/travel/A1.png" alt="">
                        </div>
                        <div class="content">
                            <div class="name">인바디</div>
                            <div class="option">인바디다이얼(W) + 인바디밴드</div>
                            <div class="ori_price">일반구매가 : 340,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">300,000원</div>
                        </div>
                    </a>
                </div>
             
                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2014554&optValCd=003&dpCatCd=S002004001&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/travel/A2.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">숀리</div>
                            <div class="option">자이로 엑스 홈 워킹패드 런닝머신 워킹머신</div>
                            <div class="ori_price">일반구매가 : 799,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">790,000원</div>
                        </div>
                    </a>
                </div>
              
                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2014551&optValCd=004&dpCatCd=S002004010&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/travel/A3.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">숀리</div>
                            <div class="option">NEW 숀리 엑스바이크 x 10 엑스텐 실내자전거</div>
                            <div class="ori_price">일반구매가 : 179,100원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">175,000원</div>
                        </div>
                    </a>
                </div>
                
                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2008727&optValCd=589&dpCatCd=S002004001&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/travel/A4.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">이화에스엠피</div>
                            <div class="option">이화에스엠피 데일리 오피스 바이크</div>
                            <div class="ori_price">일반구매가 :  299,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">260,000원</div>
                        </div>
                    </a>
                </div>
<!--               
                <div class="item" style="display:none">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2010363&optValCd=001&dpCatCd=S021003002&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/travel/A5.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">테일러메이드</div>
                            <div class="option">테일러메이드 심쿵 메탈우드 세트4 (초/중급자)</div>
                            <div class="ori_price">일반구매가 : 1,398,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,250,000원</div>
                        </div>
                    </a>
                </div>
               
                <div class="item" style="display:none">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2013614&optValCd=001&dpCatCd=S021003001&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/travel/A6.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">테일러메이드</div>
                            <div class="option">테일러메이드 심쿵7 P770세트 (중/상급자)</div>
                            <div class="ori_price">일반구매가 : 3,860,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">3,450,000원</div>
                        </div>
                    </a>
                </div>
 -->                
                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2013833&optValCd=001&dpCatCd=S021004000&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/travel/A7.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">마루망</div>
                            <div class="option">마루망SG 풀세트</div>
                            <div class="ori_price">일반구매가 : 2,850,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">2,600,000원</div>
                        </div>
                    </a>
                </div>
				
                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2014632&optValCd=001&dpCatCd=S021001002&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/travel/A8.png" alt="">
                        </div>
                        <div class="content">
                            <div class="name">마루망</div>
                            <div class="option">마루망SG 여성 풀세트</div>
                            <div class="ori_price">일반구매가 : 2,850,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">2,600,000원</div>
                        </div>
                    </a>
                </div>
                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2013825&optValCd=001&dpCatCd=S021007000&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/travel/A9.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">마제스티</div>
                            <div class="option">마제스티 퍼터 MJ 103M</div>
                            <div class="ori_price">일반구매가 : 800,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">650,000원</div>
                        </div>
                    </a>
                </div>
                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2011897&optValCd=015&dpCatCd=S004132003&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/travel/A10.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">후지필름</div>
                            <div class="option">후지필름 카메라 X100V</div>
                            <div class="ori_price">일반구매가 : 1,699,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,600,000원</div>
                        </div>
                    </a>
                </div>
                <div class="item" style="display:none">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2008397&optValCd=589&dpCatCd=S004132006&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/travel/A11.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">캐논</div>
                            <div class="option">미니 빔프로젝터 캐미빔 MP250</div>
                            <div class="ori_price">일반구매가 : 429,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">416,000원</div>
                        </div>
                    </a>
                </div>	

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2019494&optValCd=001&dpCatCd=S021003001&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/travel/A9_NEW.png" alt="">
                        </div>
                        <div class="content">
                            <div class="name">테일러메이드</div>
                            <div class="option">RBZ 풀세트 남성용</div>
                            <div class="ori_price">일반구매가 : 1,420,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,300,000원</div>
                        </div>
                    </a>
                </div>		

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2020209&optValCd=001&dpCatCd=S021004000&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/travel/A10_NEW.png" alt="">
                        </div>
                        <div class="content">
                            <div class="name">젝시오</div>
                            <div class="option">젝시오 11 드라이버</div>
                            <div class="ori_price">일반구매가 : 680,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">646,000원</div>
                        </div>
                    </a>
                </div>				

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2020214&optValCd=001&dpCatCd=S021006000&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/travel/A11_NEW.png" alt="">
                        </div>
                        <div class="content">
                            <div class="name">젝시오</div>
                            <div class="option">젝시오 11 페어웨이우드</div>
                            <div class="ori_price">일반구매가 : 440,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">420,000원</div>
                        </div>
                    </a>
                </div>	

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2020216&optValCd=001&dpCatCd=S021006000&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/travel/A12_NEW.png" alt="">
                        </div>
                        <div class="content">
                            <div class="name">젝시오</div>
                            <div class="option">젝시오 11 유틸리티우드</div>
                            <div class="ori_price">일반구매가 : 290,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">275,500원</div>
                        </div>
                    </a>
                </div>		

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2020232&optValCd=001&dpCatCd=S021005000&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/travel/A13_NEW.png" alt="">
                        </div>
                        <div class="content">
                            <div class="name">젝시오</div>
                            <div class="option">젝시오 11 남성 8 아이언세트</div>
                            <div class="ori_price">일반구매가 : 1,280,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,200,000원</div>
                        </div>
                    </a>
                </div>	

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2020210&optValCd=1228&dpCatCd=S021001002&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/travel/A14_NEW.png" alt="">
                        </div>
                        <div class="content">
                            <div class="name">젝시오</div>
                            <div class="option">젝시오 11 여성 드라이버</div>
                            <div class="ori_price">일반구매가 : 680,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">646,000원</div>
                        </div>
                    </a>
                </div>		

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2020215&optValCd=1228&dpCatCd=S021001003&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/travel/A15_NEW.png" alt="">
                        </div>
                        <div class="content">
                            <div class="name">젝시오</div>
                            <div class="option">젝시오 11 여성 페어웨이우드</div>
                            <div class="ori_price">일반구매가 : 440,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">418,000원</div>
                        </div>
                    </a>
                </div>	

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2020217&optValCd=1228&dpCatCd=S021001003&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/travel/A16_NEW.png" alt="">
                        </div>
                        <div class="content">
                            <div class="name">젝시오</div>
                            <div class="option">젝시오 11 여성 유틸리티우드</div>
                            <div class="ori_price">일반구매가 : 290,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">275,000원</div>
                        </div>
                    </a>
                </div>						
				
            </div>
			<!-- 탭 화면1 -->

			<!-- 탭 화면2 -->
            <div class="tab" id="tab02">
			
                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2020127&optValCd=589&dpCatCd=S002003003&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/everyday/B1_NEW.png" alt="">
                        </div>
                        <div class="content">
                            <div class="name">치사이클</div>
                            <div class="option">2021 치사이클 뉴트로(정품 미니펌프 증정 중)</div>
                            <div class="ori_price">일반구매가 : 1,100,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,050,000원</div>
                        </div>
                    </a>
                </div>	

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2019375&optValCd=004&dpCatCd=S002003014&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/everyday/B2_NEW.png" alt="">
                        </div>
                        <div class="content">
                            <div class="name">아이나비</div>
                            <div class="option">아이나비스포츠 로드기어CT 전동킥보드</div>
                            <div class="ori_price">일반구매가 : 329,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">275,000원</div>
                        </div>
                    </a>
                </div>	

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2020269&optValCd=004&dpCatCd=S002003014&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/everyday/B3_NEW.png" alt="">
                        </div>
                        <div class="content">
                            <div class="name">나인봇</div>
                            <div class="option">세그웨이 나인봇 맥스 전동킥보드</div>
                            <div class="ori_price">일반구매가 : 889,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">859,000원</div>
                        </div>
                    </a>
                </div>	

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2014410&optValCd=004&dpCatCd=S002003014&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/everyday/B18.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">세그웨이-나인봇</div>
                            <div class="option">세그웨이-나인봇 전동킥보드 MAX </div>
                            <div class="ori_price">일반구매가 : 858,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">800,000원</div>
                        </div>
                    </a>
                </div>					
			
			
                <div class="item" style="display:none">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2014725&optValCd=001&dpCatCd=S003016003&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/everyday/B1.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">PRADA</div>
                            <div class="option">여성 삼각로고 나일론 숄더백(20FW/블랙)</div>
                            <div class="ori_price">일반구매가 : 1,810,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,700,000원</div>
                        </div>
                    </a>
                </div>
<!--               
                <div class="item" style="display:none">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2014726&optValCd=001&dpCatCd=S003016003&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/everyday/B2.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">PRADA</div>
                            <div class="option">여성 나일론 숄더백(20FW/블랙)</div>
                            <div class="ori_price">일반구매가 : 1,394,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,300,000원</div>
                        </div>
                    </a>
                </div>
-->                
                <div class="item" style="display:none">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2014732&optValCd=001&dpCatCd=S003016003&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/everyday/B3.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">PRADA</div>
                            <div class="option">여성 다이노 크로스백(20FW/블랙)</div>
                            <div class="ori_price">일반구매가 : 1,394,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,350,000원</div>
                        </div>
                    </a>
                </div>
                
                <div class="item" style="display:none">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2014733&optValCd=001&dpCatCd=S003016003&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/everyday/B4.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">PRADA</div>
                            <div class="option">여성 더블지퍼 크로스 바디 백(20FW/블랙)</div>
                            <div class="ori_price">일반구매가 : 1,624,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,600,000원</div>
                        </div>
                    </a>
                </div>
<!--				
                <div class="item" style="display:none">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2014734&optValCd=001&dpCatCd=S003016003&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/everyday/B5.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">PRADA</div>
                            <div class="option">여성 다이아그램 숄더백(20FW/블랙)</div>
                            <div class="ori_price">일반구매가 : 1,350,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,310,000원</div>
                        </div>
                    </a>
                </div>
				
                <div class="item" style="display:none">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2014751&optValCd=001&dpCatCd=S003022013&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/everyday/B6.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">BURBERRY</div>
                            <div class="option">클래식 체크 캐시미어 머플러(20FW/화이트)</div>
                            <div class="ori_price">일반구매가 : 502,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">480,000원</div>
                        </div>
                    </a>
                </div>
-->
                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2014753&optValCd=001&dpCatCd=S003022013&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/everyday/B7.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">BURBERRY</div>
                            <div class="option">클래식 체크 캐시미어 머플러(20FW/그레이)</div>
                            <div class="ori_price">일반구매가 : 502,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">480,000원</div>
                        </div>
                    </a>
                </div>

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2014461&optValCd=001&dpCatCd=S003022001&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/everyday/B8.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">MooseKnuckles</div>
                            <div class="option">여성 GRAND METIS 롱패딩 (19FW/블랙)</div>
                            <div class="ori_price">일반구매가 : 1,610,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,580,000원</div>
                        </div>
                    </a>
                </div>

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2014464&optValCd=001&dpCatCd=S003022001&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/everyday/B9.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">MooseKnuckles</div>
                            <div class="option">여성 CAUSAPCAL 파카 롱패딩 (19FW/블랙)</div>
                            <div class="ori_price">일반구매가 : 1,658,500원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,600,000원</div>
                        </div>
                    </a>
                </div>

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2014467&optValCd=001&dpCatCd=S003022002&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/everyday/B10.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">MooseKnuckles</div>
                            <div class="option">남성 BIG RIDGE PARKA 패딩 (19FW/블랙)</div>
                            <div class="ori_price">일반구매가 : 1,621,500원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,600,000원</div>
                        </div>
                    </a>
                </div>

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2014473&optValCd=001&dpCatCd=S003022001&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/everyday/B11.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">MooseKnuckles</div>
                            <div class="option">여성 서스캐처원 롱 패딩 (19FW/블랙)</div>
                            <div class="ori_price">일반구매가 : 1,610,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,580,000원</div>
                        </div>
                    </a>
                </div>

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2014476&optValCd=001&dpCatCd=S003022001&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/everyday/B12.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">MooseKnuckles</div>
                            <div class="option">여성 아이벡스 롱패딩 (18FW/블랙)</div>
                            <div class="ori_price">일반구매가 : 1,460,500원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,450,000원</div>
                        </div>
                    </a>
                </div>

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2014478&optValCd=001&dpCatCd=S003022002&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/everyday/B13.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">MooseKnuckles</div>
                            <div class="option">남성 웨스트 고어 롱 파카 (18FW/블랙)</div>
                            <div class="ori_price">일반구매가 :1,587,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,550,000원</div>
                        </div>
                    </a>
                </div>

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2014479&optValCd=001&dpCatCd=S003022002&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/everyday/B14.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">MooseKnuckles</div>
                            <div class="option">남성 웨스트 고어 롱 파카 (18FW/네이비)</div>
                            <div class="ori_price">일반구매가 : 1,587,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,550,000원</div>
                        </div>
                    </a>
                </div>	

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2014480&optValCd=001&dpCatCd=S003022002&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/everyday/B15.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">MooseKnuckles</div>
                            <div class="option">남성 웨스트 고어 롱 패딩 (18FW/카키))</div>
                            <div class="ori_price">일반구매가 : 1,587,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,550,000원</div>
                        </div>
                    </a>
                </div>	

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2014481&optValCd=001&dpCatCd=S003022001&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/everyday/B16.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">MooseKnuckles</div>
                            <div class="option">여성 SALMON RIVER 롱 파카 (18FW/카키)</div>
                            <div class="ori_price">일반구매가 : 1,587,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,550,000원</div>
                        </div>
                    </a>
                </div>	

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2014778&optValCd=001&dpCatCd=S003022003&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/everyday/B17.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">MooseKnuckles</div>
                            <div class="option">여성 스틸링 롱 패딩 (18FW/블랙)</div>
                            <div class="ori_price">일반구매가 : 1,265,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,250,000원</div>
                        </div>
                    </a>
                </div>	

                <div class="item" style="display:none">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2013623&optValCd=002&dpCatCd=S002003003&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/everyday/B19.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">샤오미</div>
                            <div class="option">샤오미 치사이클 EF1 Plus 2021</div>
                            <div class="ori_price">일반구매가 : 1,150,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,090,000원</div>
                        </div>
                    </a>
                </div>	
<!--
                <div class="item" style="display:none">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2013227&optValCd=589&dpCatCd=S004128002&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/everyday/B20.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">소니</div>
                            <div class="option">SONY 플레이스테이션4 프로(PS4PRO) 블랙(CHU-7218BB01)</div>
                            <div class="ori_price">일반구매가 : 490,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">480,000원</div>
                        </div>
                    </a>
                </div>
-->

				
				
				
            </div>
			<!-- 탭 화면2 -->

			<!-- 탭 화면3 -->
            <div class="tab" id="tab03">
			
                <div class="item">
                    <a href="#" onclick="javascript:compingPop();" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C28.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">캠핑카 렌탈</div>
                            <div class="option">캠핑카 올인원 패키지<br /> 1박 2일(36시간)</div>
                            <div class="ori_price">일반구매가 : 690,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">610,000원</div>
                        </div>
                    </a>
                </div>		

                <div class="item">
                    <a href="#" onclick="javascript:compingPop();" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C28.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">캠핑카 렌탈</div>
                            <div class="option">캠핑카 올인원 패키지<br /> 2박 3일(60시간)</div>
                            <div class="ori_price">일반구매가 : 960,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">880,000원</div>
                        </div>
                    </a>
                </div>				
			
			
                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2010906&optValCd=001&dpCatCd=S004134002&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C1.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">삼성전자</div>
                            <div class="option">Crystal UHD TV 138 cm</div>
                            <div class="ori_price">일반구매가 : 1,151,200원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,080,000원</div>
                        </div>
                    </a>
                </div>
 <!--               
                <div class="item" style="display:none">
                    <a href="">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C2.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">LG전자</div>
                            <div class="option">LG전자 울트라 HDTV 138cm 55UT641S0NB</div>
                            <div class="ori_price">일반구매가 : 906,500원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">780,000원</div>
                        </div>
                    </a>
                </div>
-->				
                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2010404&optValCd=001&dpCatCd=S004120002&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C3.png" alt="">
                        </div>
                        <div class="content">
                            <div class="name">삼성전자</div>
                            <div class="option">삼성전자 제트 무선청소기 + 청정스테이션 패키지</div>
                            <div class="ori_price">일반구매가 : 1,421,200원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,240,000원</div>
                        </div>
                    </a>
                </div>
<!--
                <div class="item" style="display:none">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2014130&optValCd=586&dpCatCd=S004120002&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C4.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">LG전자</div>
                            <div class="option">LG전자 코드제로 A9S ThinQ 물걸레 무선청소기</div>
                            <div class="ori_price">일반구매가 : 1,360,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,250,000원</div>
                        </div>
                    </a>
                </div>
-->
                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2008263&optValCd=149&dpCatCd=S004120002&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C5.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">Miele </div>
                            <div class="option">Miele C3 파켓 청소기</div>
                            <div class="ori_price">일반구매가 : 551,600원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">520,000원</div>
                        </div>
                    </a>
                </div>

                <div class="item" style="display:none">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2014093&optValCd=001&dpCatCd=S004120002&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C6.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">다이슨</div>
                            <div class="option">다이슨 무선청소기 V11 220AW 컴플리트</div>
                            <div class="ori_price">일반구매가 : 1,082,200원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,030,000원</div>
                        </div>
                    </a>
                </div>

                <div class="item" style="display:none">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2013445&optValCd=001&dpCatCd=S004122001&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C7.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">삼성전자</div>
                            <div class="option">삼성전자 무풍 큐브 공기청정기 47+47m²</div>
                            <div class="ori_price">일반구매가 : 1,098,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,000,000원</div>
                        </div>
                    </a>
                </div>

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2001628&optValCd=002&dpCatCd=S004122001&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C8.png" alt="">
                        </div>
                        <div class="content">
                            <div class="name">IQAir </div>
                            <div class="option">IQAir 프리미엄 공기청정기 HealthPro 100</div>
                            <div class="ori_price">일반구매가 : 1,652,400원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,500,000원</div>
                        </div>
                    </a>
                </div>

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2004557&optValCd=835&dpCatCd=S004125002&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C9.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">Vifa </div>
                            <div class="option">Vifa Oslo(오슬로) 블루투스 스피커</div>
                            <div class="ori_price">일반구매가 : 780,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">700,000원</div>
                        </div>
                    </a>
                </div>

                <div class="item" style="display:none">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2012756&optValCd=398&dpCatCd=S004120001&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C10.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">LG전자</div>
                            <div class="option">LG전자 트롬 스타일러 블랙틴트미러 S5MBA</div>
                            <div class="ori_price">일반구매가 : 2,114,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,900,000원</div>
                        </div>
                    </a>
                </div>

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2002293&optValCd=001&dpCatCd=S004124001&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C11.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">삼성전자</div>
                            <div class="option">지펠 양문형냉장고 815L RS82M6000S8</div>
                            <div class="ori_price">일반구매가 : 1,036,800원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,000,000원</div>
                        </div>
                    </a>
                </div>
<!--
                <div class="item">
                    <a href="">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C12.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">LG전자</div>
                            <div class="option">LG전자 DIOS 김치톡톡 스탠드형 김치냉장고 327L K330W14</div>
                            <div class="ori_price">일반구매가 : 1,570,800원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,450,000원</div>
                        </div>
                    </a>
                </div>
-->
                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2009375&optValCd=678&dpCatCd=S004121001&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C13.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">삼성전자</div>
                            <div class="option">삼성전자 갤럭시북 Flex NT950QCG-X716(i7,16GB,512GB,39.6cm)</div>
                            <div class="ori_price">일반구매가 : 2,858,800원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">2,500,000원</div>
                        </div>
                    </a>
                </div>
<!--
                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2011875&optValCd=860&dpCatCd=S004121001&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C14.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">LG전자</div>
                            <div class="option">LG전자 그램 17 17Z90N-VA5IK (i5-1035G7,16GB,256GB,17.0")</div>
                            <div class="ori_price">일반구매가 : 2,171,600원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,980,000원</div>
                        </div>
                    </a>
                </div>
-->
                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2011208&optValCd=001&dpCatCd=S004129008&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C15.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">동영온돌침대</div>
                            <div class="option">비너스 퀸 동영돌침대</div>
                            <div class="ori_price">일반구매가 : 1,680,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,500,000원</div>
                        </div>
                    </a>
                </div>

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2011213&optValCd=001&dpCatCd=S020090002&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C16.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">동영온돌침대</div>
                            <div class="option">뉴황제 퀸 동영돌침대</div>
                            <div class="ori_price">일반구매가 : 1,090,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">970,000원</div>
                        </div>
                    </a>
                </div>

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2011217&optValCd=001&dpCatCd=S020090001&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C17.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">동영온돌침대</div>
                            <div class="option">엘레강스 소파 동영돌소파</div>
                            <div class="ori_price">일반구매가 : 1,290,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,150,000원</div>
                        </div>
                    </a>
                </div>

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2007216&optValCd=001&dpCatCd=S020040002&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C18.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">slou</div>
                            <div class="option">매트리스 토퍼 프리미엄 (SS/Q/K)(무색,Q)</div>
                            <div class="ori_price">일반구매가 : 399,900원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">390,000원</div>
                        </div>
                    </a>
                </div>

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2007216&optValCd=001&dpCatCd=S020040002&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C19.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">slou</div>
                            <div class="option">매트리스 토퍼 프리미엄 (SS/Q/K)(무색,K)</div>
                            <div class="ori_price">일반구매가 : 448,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">430,000원</div>
                        </div>
                    </a>
                </div>		

				
                <div class="item" style="display:none">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2008206&optValCd=001&dpCatCd=S020040003&ifwChnNo=" target="_blank">
                        <div class="img">
                           <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C20.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">경동나비엔</div>
                            <div class="option">경동나비엔 온수매트 EQM560-H 쿠션형(S/Q/K)(무색,퀸)</div>
                            <div class="ori_price">일반구매가 : 398,800원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">390,000원</div>
                        </div>
                    </a>
                </div>	

                <div class="item" style="display:none">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2008206&optValCd=001&dpCatCd=S020040003&ifwChnNo=" target="_blank">
                        <div class="img">
                             <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C21.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">경동나비엔</div>
                            <div class="option">경동나비엔 온수매트 EQM560-H 쿠션형(S/Q/K)(무색,킹)</div>
                            <div class="ori_price">일반구매가 : 425,200원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">410,000원</div>
                        </div>
                    </a>
                </div>	

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2010717&optValCd=001&dpCatCd=S020020001&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C22.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">시트앤모어</div>
                            <div class="option">몽베르 전동 1인용 All천연면피가죽 리클라이너 소파</div>
                            <div class="ori_price">일반구매가 : 1,380,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,150,000원</div>
                        </div>
                    </a>
                </div>	

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2007750&optValCd=29&dpCatCd=S020010001&ifwChnNo=" target="_blank">
                        <div class="img">
                             <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C23.png" alt="">
                        </div>
                        <div class="content">
                            <div class="name">Herman Miller</div>
                            <div class="option">허먼밀러_Mirra 2 black</div>
                            <div class="ori_price">일반구매가 : 1,470,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,350,000원</div>
                        </div>
                    </a>
                </div>	

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2006370&optValCd=047&dpCatCd=S020010001&ifwChnNo=" target="_blank">
                        <div class="img">
                             <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C24.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">Herman Miller</div>
                            <div class="option">허먼밀러_New Aeron Full(Graphite,B,New Headrest 추가)</div>
                            <div class="ori_price">일반구매가 : 2,131,500원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">1,950,000원</div>
                        </div>
                    </a>
                </div>	

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2009140&optValCd=606&dpCatCd=S020050002&ifwChnNo=" target="_blank">
                        <div class="img">
                             <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C25.jpg" alt="">
                        </div>
                        <div class="content">
                            <div class="name">KOAS</div>
                            <div class="option">코아스 1200 무빙데스크 OSD1201</div>
                            <div class="ori_price">일반구매가 : 1,028,800원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">950,000원</div>
                        </div>
                    </a>
                </div>	

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2005544&optValCd=001&dpCatCd=S020080002&ifwChnNo=" target="_blank">
                        <div class="img">
                             <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C26.png" alt="">
                        </div>
                        <div class="content">
                            <div class="name">넵스홈</div>
                            <div class="option">S.O.U.L 루이스 티테이블 L</div>
                            <div class="ori_price">일반구매가 : 476,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">450,000원</div>
                        </div>
                    </a>
                </div>	

                <div class="item">
                    <a href="https://www.myomee.com/pr/detail.do?itemCd=2005545&optValCd=001&dpCatCd=S020080002&ifwChnNo=" target="_blank">
                        <div class="img">
                            <img src="https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C27.png" alt="">
                        </div>
                        <div class="content">
                            <div class="name">넵스홈</div>
                            <div class="option">S.O.U.L 셀마 티테이블</div>
                            <div class="ori_price">일반구매가 : 336,000원</div>
                            <div class="desc">이벤트 구매가</div>
                            <div class="sale_price">270,000원</div>
                        </div>
                    </a>
                </div>	
								
				<!-- 탭 화면3 -->
            </div>
        </div>
		
		</br></br></br></br></br>			
		<div class="txtBox00" align="center">
			<font size="4" color="#ffffff"><b>상품을 클릭하면 상품상세정보 페이지로 이동합니다. 해당 제품을 주문하시려면 아래의 주문하기 페이지에서 주문 바랍니다</b></br></font>
		</div>		

        <!-- 섹션 03 -->
        <div class="s03">
            <div class="tit">개인정보 이용동의</div>
            <div class="private">
                <div class="content">
					[개인정보 수집 및 이용동의]
					<br><br>
					1. 개인정보의 수집 및 이용목적 전자금융거래서비스 제공에 관한 결제 정보 등 개인정보 수집 - 이용자가 구매한 재화나 용역의 대금 결제 - 결제 과정 중 본인 식별, 인증, 실명확인 및 이용자가 결제한 거래의 내역을 요청하는 경우 응대 및 확인 - 이용자가 결제한 거래의 취소 또는 환불, 상품 배송 등 전자상거래 관련 서비스 제공 - 이용자가 결제한 대금의 청구 및 수납 - 전자금융거래 및 통신과금 서비스 이용 불가능한 이용자(미성년자 등)와 불량, 불법 이용자의 부정 이용 방지 - 서비스 제공 및 관련 업무 처리에 필요한 동의 또는 철회 등 의사확인 - 회사가 제공하는 결제알림메일 발송 - 고객 불만 및 민원처리<br>
					※ 상기 개인(신용)정보 수집 및 이용은 서비스 이용에 필요한 최소한의 필수정보로서 해당정보 수집 및 이용에 동의를 해주셔야만 서비스를 이용 하실 수 있습니다. 또한 본인은 본인의사에 따라 개인(신용)정보 수집 및 이용에 대하여 거부할 권리가 있습니다. <br>
					  다만, 계약 체결 등 을 위해 필요한 최소한의 개인(신용)정보 수집에 관한 동의를 거부하는 경우에는 계약 체결·유지·이행·관리 등 불가 등의 불이익이 있을 수 있습니다.
					<br><br>
					2. 수집항목 및 수집방법<br>
					   전자금융거래서비스 이행과 관련 수집 정보 - 이용자의 신용카드 정보 또는 지불하고자 하는 금융기관 계좌 정보 - 이용자의 휴대폰 또는 유선 전화 번호 - 이용자의 접속 IP - 이용자의 상품 또는 용역 거래 정보
					<br><br>
					3. 개인정보의 보유 및 이용 기간  이용자의 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기 합니다. 단, 전자금융거래법, 전자상거래 등에서의 소비자 보호에 관한 법률 등 관련 법령에 의하여 보존할 필요가 있는 경우 관련 법령에서 정한 일정한 기간 동안 개인정보를 보존합니다. 이 경우 회사는 보관하는 정보를 그 보관의 목적으로만 이용하며 보존기간은 아래와 같습니다. - 건당 1만원 초과 전자금융거래에 관한 기록 (보존이유: 전자금융거래법, 보존기간: 5년) - 건당 1만원 이하 전자금융거래에 관한 기록 (보존이유: 전자금융거래법, 보존기간: 1년) - 계약 또는 청약 철회 등에 관한 기록 (보존이유: 전자상거래 등에서의 소비자보호에 관한 법률, 보존기간: 5년) - 대금결제 및 재화 등의 공급에 관한 기록 (보존이유: 전자상거래 등에서의 소비자보호에 관한 법률, 보존기간: 5년) - 소비자의 불만 또는 분쟁 처리에 관한 기록 (보존이유: 전자상거래 등에서의 소비자보호에 관한 법률, 보존기간: 3년) - 본인확인에 관한 기록 (보존이유: 정보통신 이용촉진 및 정보보호 등에 관한 법률, 보존기간: 6개월)<br>
                </div>
                <div class="radio">
                    <input type="radio" id="private1"
                     name="private1" value="accept">
                    <label for="private1">동의함</label>
                
                    <input type="radio" id="private2"
                     name="private1" value="reject" checked>
                    <label for="private2">동의안함</label>
                  </div><br>
            </div>
			
			<div class="tit">개인정보 제3자 제공 동의</div>
            <div class="private">
                <div class="content">
					[개인정보 제3자 제공 동의]
					<br><br>
					롯데제이티비는 고객님의 주문/배송 처리를 위하여 고객님께 수집한 개인정보를 아래와 같이 제 3자에게 제공합니다. <br>
					1. 개인정보를 제공받는 자: 상품별 전자결제 및 배송관련 해당 협력사<br>
					* ㈜인바디, ㈜이화에스엠피, (유)테일러메이드코리아, 마제스티골프코리아㈜, 후지필름일렉트로닉이미징코리아㈜, ㈜영현아이엔씨, 주식회사 로모모다, ㈜유니코,<br> 삼성에스엘 주식회사, 주식회사 차이난다, ㈜밀레코리아, 게이트비젼 주식회사, ㈜컨텍, 주식회사 디앤오, ㈜동영침대, ㈜일룸, ㈜티엔더블류트레이딩, 스테이엣,<br> ㈜인노바드, ㈜코아스, 주식회사 넵스홈<br>
					2. 개인정보를 제공받는 자의 이용목적: 고객님이 주문한 상품에 대한 결제 및 배송처리<br>
					3. 제공하는 개인정보의 항목: 이름, 연락처, 주문정보(주문일시, 주문번호, 배송지 주소, 연락처, 고객요청사항 등)<br>
					4. 개인정보를 제공받는 자의 개인정보 보유 및 이용기간 : 이용목적 달성 후 지체 없이 파기<br>
					   이용자는 회사의 개인정보 제3자 제공 동의를 거부할 권리가 있습니다. 다만, 개인정보의 제3자 제공을 거부할 경우 롯데렌탈 묘미(온라인몰)을 통한 주문이<br> 불가능함을 알려드립니다.
                </div>
                <div class="radio">
                    <input type="radio" id="private3"
                     name="private3" value="accept">
                    <label for="private3">동의함</label>
                
                    <input type="radio" id="private4"
                     name="private3" value="reject" checked>
                    <label for="private4">동의안함</label>
                  </div>
            </div>			
			
			 <div class="tit">이용약관</div>
            <div class="private">
                <div class="content">
					이용약관
					<br><br>
					제1조(목적) 
					이 약관은 롯데렌탈(주)(이하 "회사"라 한다)가 운영하는 사이버 몰에서 제공하는 인터넷 관련 서비스(이하 "서비스"라 한다)를 이용함에 있어 "몰"과 이용자의 권리.의무 및 책임사항을 규정함을 목적으로 하는 합니다. 롯데제이티비는 이용자를 대신하여 구매하며, 기타 이용에 필요한 내용은 해당 롯데렌탈의 기본 약관에 따릅니다. 
					<br><br>
					제2조(정의)
					①"몰"이란 회사가 재화 또는 용역(이하 "재화 등"이라 함)을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 등을 거래할 수 있도록 설정한 가상의 영업장(www.myomee.com 및 모바일 앱 등)을 말하며, 아울러 사이버몰을 운영하는 사업자의 의미로도 사용합니다. 
					②"이용자"란 "몰"에 접속하여 이 약관에 따라 "몰"이 제공하는 서비스를 받는 회원 및 비회원을 말합니다.
					③‘회원’이라 함은 "몰"에 회원등록을 한 자로서, 계속적으로 "몰"이 제공하는 서비스를 이용할 수 있는 자를 말합니다. 
					④‘비회원’이라 함은 회원에 가입하지 않고 "몰"이 제공하는 서비스를 이용하는 자를 말합니다. 
					⑤ "이용계약"이란 "몰"이 제공하는 서비스에 관한 회원의 이용신청을 회사가 승낙함으로써 성립하는 계약을 말합니다. 
					⑥"ID"라 함은 회원의 식별과 서비스 이용을 위하여 회원이 설정하고 회사가 승인하여 등록된 전자우편주소를 말합니다. 
					⑦"비밀번호"라 함은 회원의 동일성 확인과 회원의 권익 및 비밀보호를 위하여 회원 스스로가 설정하여 사이트에 등록한 문자와 숫자의 조합을 말합니다. 
					<br><br>
					제3조 (약관 등의 명시와 설명 및 개정)
					① "몰"은 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호.모사전송번호.전자우편주소, 사업자등록번호, 통신판매업 신고번호, 개인정보관리책임자 등을 이용자가 쉽게 알 수 있도록 "몰"의 초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다. 
					② "몰"은 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회.배송책임.환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다. 
					③ "몰"은 「전자상거래 등에서의 소비자보호에 관한 법률」, 「약관의 규제에 관한 법률」, 「전자문서 및 전자거래기본법」, 「전자금융거래법」, 「전자서명법」, 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」, 「방문판매 등에 관한 법률」, 「소비자기본법」 등 관련 법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다. 
					④ "몰"이 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 몰의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다.이 경우 "몰"은 개정 전 내용과 개정 후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다. 
					⑤ "몰"이 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정 전의 약관조항이 그대로 적용됩니다. 다만 이미 계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제3항에 의한 개정약관의 공지기간 내에 "몰"에 송신하여 "몰"의 동의를 받은 경우에는 개정약관 조항이 적용됩니다. 
					⑥ 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제 등에 관한 법률, 공정거래위원회가 정하는 전자상거래 등에서의 소비자 보호지침 및 관계법령 또는 상관례에 따릅니다. 
					<br><br>
					제4조(서비스의 제공 및 변경)
					① "몰"은 다음과 같은 업무를 수행합니다. 
					1.재화 또는 용역에 대한 정보 제공 
					2.재화 또는 용역에 대한 렌탈계약, 할부계약, 판매계약 등(이하 "구매계약")의 체결 
					3."구매계약"이 체결된 재화 또는 용역의 배송 4.기타 "몰"이 정하는 업무 
					② "몰"은 재화 또는 용역의 품절 또는 기술적 사양의 변경 등의 경우에는 장차 체결되는 계약에 의해 제공할 재화 또는 용역의 내용을 변경할 수 있습니다. 이 경우에는 변경된 재화 또는 용역의 내용 및 제공일자를 명시하여 현재의 재화 또는 용역의 내용을 게시한 곳에 즉시 공지합니다. 
					③ "몰"이 제공하기로 이용자와 계약을 체결한 서비스의 내용을 재화 등의 품절 또는 기술적 사양의 변경 등의 사유로 변경할 경우에는 그 사유를 이용자에게 전화, 이메일 등으로 즉시 통지합니다. 
					④ 전항의 경우 "몰"은 이로 인하여 이용자가 입은 손해를 배상합니다. 다만, "몰"이 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다. 
					<br><br>
					제5조(서비스의 중단)
					① "몰"은 컴퓨터 등 정보통신설비의 보수점검.교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다. 
					② "몰"은 제1항의 사유로 서비스의 제공이 일시적으로 중단됨으로 인하여 이용자 또는 제3자가 입은 손해에 대하여 배상합니다. 단, "몰"이 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다. 
					③ 사업종목의 전환, 사업의 포기, 업체 간의 통합 등의 이유로 서비스를 제공할 수 없게 되는 경우에는 "몰"은 제8조에 정한 방법으로 이용자에게 통지하고 당초 "몰"에서 제시한 조건에 따라 소비자에게 보상합니다. 다만, "몰"이 보상기준 등을 고지하지 아니한 경우에는 이용자들의 마일리지 또는 적립금 등을 "몰"에서 통용되는 통화가치에 상응하는 현물 또는 현금으로 이용자에게 지급합니다. 
					<br><br>
					제6조(회원가입)
					① 이용자는 "몰"이 정한 가입 양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다. 
					② "몰"은 제1항과 같이 회원으로 가입할 것을 신청한 이용자 중 다음 각 호에 해당하지 않는 한 회원으로 등록합니다. 
					1.가입신청자가 이 약관 제7조 제2항에 의하여 이전에 회원자격을 상실한 적이 있는 경우. 다만 제7조제2항에 의한 회원자격 상실 후 3년이 경과한 자로서 "몰"의 회원재가입 승낙을 얻은 경우에는 예외로 한다. 
					2.가입신청, 등록 내용에 허위, 기재누락, 오기가 있는 경우 
					3.만 19세 미만의 자가 회원 가입 신청을 하는 경우 
					4.본인확인절차에서 본인이 아님이 확인된 경우 
					5.회원탈퇴 후 1개월 이내에 재가입 신청을 하는 경우.다만, 판매회원의 경우 재가입 신청제한 기간은 2개월로 합니다.
					6.회사로부터 회원자격정지 조치 등을 받은 회원이 그 조치 기간에 이용계약을 임의 해지하고 재가입 신청을 하는 경우(재이용이 허락되더라도, 서비스 이용과정에서 본인확인 후 회원자격정지 조치를 받았던 사실이 확인되면 해당 ID의 이용계약이 해지될 수 있음) 
					7."몰" 이용약관의 적용을 받는 자가 해당 약관을 위반한 경우 
					8. 이 약관에 위배되거나 위법 또는 부당한 회원 가입신청임이 확인된 경우 
					9.기타 회원으로 등록하는 것이 "몰"의 기술상 현저히 지장이 있다고 판단되는 경우 
					③ 회원가입계약의 성립 시기는 "몰"의 승낙이 회원에게 도달한 시점으로 합니다. 
					④ 회원은 회원가입시 등록한 사항에 변경이 있는 경우, 상당한 기간 이내에 "몰"에 대하여 회원정보 수정 등의 방법으로 그 변경사항을 알려야 합니다. 
					<br><br>
					제7조(회원 탈퇴 및 자격 상실 등)
					①회원은 다음 각호에서 정한 바에 따라 이용계약을 해지할 수 있습니다. 
					1.회원은 언제든지 회사에 해지의 의사를 통지하여 이용계약을 해지할 수 있습니다. 단, 해지의사를 통지하기 전에 현재 진행 중인 모든 상품의 거래를 완료하거나 철회 또는 취소하여야 하며, 거래의 철회 또는 취소로 인한 불이익은 회원 본인이 부담하여야 합니다. 또한, 회원이 "몰"에 대한 "구매계약" 등의 채무를 전부 이행하지 않으면 회원이 해당 채무를 전부 이행할 때까지 "몰"은 회원의 이용계약 해지를 제한할 수 있으며, 회원이 이 약관과 관계 법령 등을 위반하여 이용이 정지된 경우 "몰"이 재발방지를 위하여 회원의 이용계약 해지를 제한할 수 있습니다. 
					2.회원의 의사로 해지한 경우 "몰"은 회원에게 이메일(E-mail), 전화, 팩스 또는 기타의 방법으로 해지사실을 통지합니다. 이용계약은 "몰"의 해지의사를 회원에게 통지한 시점에 종료됩니다. 
					3.회원의 의사로 해지한 후 회원 재가입, 임의 해지 등을 반복적으로 행하여 "몰"이 제공하는 각종 할인쿠폰, 이벤트 혜택 등 경제적 이익을 편법으로 수취하거나 이 과정에서 명의를 무단으로 사용하는 등 편법과 불법행위를 하는 것을 차단하고자 "몰"는 회원에게 회원 탈퇴한 날로부터 1개월(탈퇴시 회원이 판매회원의 지위도 동시에 가진 상태인 경우에는 2개월)이 지나야 재가입 할 수 있게 하고 있으며 회원은 이 약관이 정하는 회원가입절차와 관련 조항에 따라 "몰"에 통지된 재이용 의사를 "몰"로부터 승낙 받은 이후에 서비스를 재이용할 수 있습니다. 
					4.회원 재가입, 임의해지 등을 반복적으로 행하여 "몰"가 제공하는 각종 할인쿠폰, 이벤트 혜택 등의 경제적 이익을 편법으로 수취하거나 이 과정에서 명의를 무단으로 사용하는 등 편법과 불법 행위를 하는 것을 차단하고자 회원탈퇴 후 1개월(탈퇴시 회원이 판매회원의 지위도 동시에 가진 상태인 경우에는 2개월) 동안 해당 회원의 아이디, 성명, CI, DI, 탈퇴일자, 탈퇴사유 등 개인정보를 보관합니다. 
					②"몰"은 다음 각호에서 정한 바에 따라 이용계약을 해지할 수 있습니다. 
					1."몰"는 회원에게 다음 각목의 1에 해당하는 사유가 발생하거나 확인되면 이용계약을 해지할 수 있습니다. 
					가.다른 회원 또는 "몰"(직원·상담원 포함)의 권리나 명예, 신용 기타 정당한 이익을 침해하거나 대한민국 법령, 공공질서 또는 선량한 풍속에 위배되는 행위를 한 경우 
					나.서비스의 원활한 진행을 방해하거나 방해할 우려가 있는 아래의 행위 등을 하거나 시도한 경우 
					i.합리적 사유 없이 상습적·악의적으로 이의를 제기하는 행위 
					ii. 구매하거나 이용중인 상품 또는 서비스에 특별한 하자가 없음에도 상습적으로 사용 후 취소, 반품 등을 하는 행위 
					iii.그 외 "몰"이 정한 안전거래 이용규칙을 위반한 경우 
					다.회원이 이 약관에 위배되는 행위를 하거나 이 약관에서 정한 해지사유가 발생한 경우 
					라.회원에게 제6조에서 정한 이용계약의 승낙거부사유가 있음이 확인된 경우 
					2."몰"이 해지할 때에는 "몰"은 회원에게 이메일(E-mail), 전화, 팩스, 기타의 방법으로 해지 사유를 밝혀 해지 의사를 통지합니다. 이용계약은 "몰"의 해지의사가 회원에게 도달한 시점에 종료됩니다. 단, 이메일(E-mail)을 통한 해지의사 통지의 경우 발송시점을 도달시점으로 간주합니다. 
					3.본 항에 따라 "몰"이 이용계약을 해지하더라도, 해지 이전에 이미 체결된 "구매계약"의 완결에 관해서는 해당 구매계약 및 본 약관이 계속 적용됩니다. 
					4.본 항에서 정한 바에 따라 이용계약이 종료될 때에는 "몰"은 별도 통지 없이 해당 회원과 관련된 "구매계약" 또는 거래를 취소 또는 해지할 수 있고, "구매계약"에 따른 채무가 이행되지 아니하는 경우 회원은 취소 또는 해지된 "구매계약" 또는 거래의 모든 채무를 전부 이행하여야 합니다. 
					5.본 항에서 정한 바에 따라 이용계약이 종료되면 "몰"은 회원의 재이용 신청을 그 승낙하지 않을 수 있습니다. 
					③이용계약의 종료와 관련하여 발생한 손해에 대해서는 자신의 귀책사유로 이용계약이 종료된 해당 회원이 책임을 져야 하고, "몰"는 귀책사유가 없는 한 책임을 지지 않습니다. 
					④"몰"이 회원자격을 상실시키는 경우에는 회원등록을 말소합니다. 이 경우 회원에게 이를 통지하고, 회원등록 말소 전에 최소한 30일 이상의 기간을 정하여 소명할 기회를 부여합니다. 
					<br><br>
					제8조(회원에 대한 통지)
					① "몰"이 회원에 대한 통지를 하는 경우, 회원이 "몰"과 미리 약정하여 지정한 전자우편 주소나 이동전화SMS 등으로 할 수 있습니다. 
					② "몰"은 불특정다수 회원에 대한 통지의 경우 1주일이상 "몰" 게시판에 게시함으로서 개별 통지에 갈음할 수 있습니다. 다만, 회원 본인의 거래와 관련하여 중대한 영향을 미치는 사항에 대하여는 개별통지를 합니다. 
					<br><br>
					제9조(구매계약 신청 및 개인정보 제공 동의 등)
					① "몰"이용자는 "몰"상에서 다음 또는 이와 유사한 방법에 의하여 구매 또는 "구매계약"(이하 "구매 등"이라 한다)을 신청하며, "몰"은 이용자가 "구매 등"의 신청을 함에 있어서 다음의 각 내용을 알기 쉽게 제공하여야 합니다. 
					1."재화 등"의 검색 및 선택 
					2. 받는 사람의 성명, 주소, 전화번호, 전자우편주소(또는 이동전화번호) 등의 입력 
					3.약관내용, 청약철회권이 제한되는 서비스, 배송료.설치비 등의 비용부담과 관련한 내용에 대한 확인 
					4.이 약관에 동의하고 위 3.호의 사항을 확인하거나 거부하는 표시(예, 마우스 클릭) 
					5."재화 등"의 "구매 등" 신청 및 이에 관한 확인 또는 "몰"의 확인에 대한 동의 6.결제방법의 선택 
					② "몰"이 제3자에게 이용자 개인정보를 제공할 필요가 있는 경우 1) 개인정보를 제공받는 자, 2)개인정보를 제공받는 자의 개인정보 이용목적, 3) 제공하는 개인정보의 항목, 4) 개인정보를 제공받는 자의 개인정보 보유 및 이용기간을 이용자에게 알리고 동의를 받아야 합니다. (동의를 받은 사항이 변경되는 경우에도 같습니다.) 
					③ "몰"이 제3자에게 이용자의 개인정보를 취급할 수 있도록 업무를 위탁하는 경우에는 1) 개인정보 취급위탁을 받는 자, 2) 개인정보 취급위탁을 하는 업무의 내용을 구매자에게 알리고 동의를 받아야 합니다. (동의를 받은 사항이 변경되는 경우에도 같습니다.) 다만, 서비스제공에 관한 계약이행을 위해 필요하고 구매자의 편의증진과 관련된 경우에는 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」에서 정하고 있는 방법으로 개인정보 취급방침을 통해 알림으로써 고지절차와 동의절차를 거치지 않아도 됩니다. 
					<br><br>
					제10조 (계약의 성립)
					①"몰"은 제9조와 같은 "구매 등" 신청에 대하여 다음 각 호에 해당하면 승낙하지 않을 수 있습니다. 다만, 미성년자와 계약을 체결하는 경우에는 법정대리인의 동의를 얻지 못하면 미성년자 본인 또는 법정대리인이 계약을 취소할 수 있다는 내용을 고지하여야 합니다. 
					1.신청 내용에 허위, 기재누락, 오기가 있는 경우 
					2.미성년자가 담배, 주류 등 청소년보호법에서 금지하는 재화 및 용역을 구매하는 경우 
					3.기타 구매신청에 승낙하는 것이 "몰" 기술상 현저히 지장이 있다고 판단하는 경우 
					② "몰"의 승낙이 제12조 제1항의 수신확인통지형태로 이용자에게 도달한 시점에 계약이 성립한 것으로 봅니다. 
					③ "몰"의 승낙의 의사표시에는 이용자의 구매 신청에 대한 확인 및 판매가능 여부, 구매신청의 정정 취소 등에 관한 정보 등을 포함하여야 합니다. 
					<br><br>
					제11조(지급방법) 
					"몰"에서 구매한 재화 또는 용역에 대한 대금지급방법은 다음 각 호의 방법중 개별 "구매계약"에서 허용하는 방법으로 할 수 있습니다. 단, "몰"은 이용자의 지급방법에 대하여 재화 등의 대금에 어떠한 명목의 수수료도 추가하여 징수할 수 없습니다. 
					1. 폰뱅킹, 인터넷뱅킹, 메일 뱅킹 등의 각종 계좌이체 
					2. 선불카드, 직불카드, 신용카드 등의 각종 카드 결제 
					3. 온라인무통장입금 
					4. 전자화폐에 의한 결제 
					5. 수령 시 대금지급 
					6. 마일리지 등 "몰"이 지급한 포인트에 의한 결제 
					7. "몰"과 계약을 맺었거나 "몰"이 인정한 상품권에 의한 결제 
					8. 기타 전자적 지급 방법에 의한 대금 지급 등 
					<br><br>
					제11조의 1(할인쿠폰)
					① 할인쿠폰은 "몰"이 무상으로 발행하는 쿠폰으로, 발행대상, 발행경로, 사용대상 등에 따라 구분될 수 있으며, 할인쿠폰의 세부구분, 할인금액(할인율), 사용방법, 사용기한 및 제한에 대한 사항은 할인쿠폰 또는 서비스화면에 표시됩니다. 할인쿠폰의 종류 및 내용과 발급여부에 관하여는 "몰"의 정책에 따라 달라질 수 있습니다. 
					②할인쿠폰은 현금으로 출금될 수 없으며, 할인쿠폰에 표시된 유효기간이 만료되거나 이용계약이 종료되면 소멸합니다. 
					③할인쿠폰은 회사에서 별도로 명시한 경우를 제외하고는 타인에게 양도할 수 없으며, 부정한 목적이나 용도로 사용할 수 없습니다. 이를 위반한 경우 회사는 할인쿠폰을 소멸시키거나 회원자격을 정지할 수 있습니다. 
					④회원이 부정한 방법으로 보관금, 할인쿠폰을 획득한 사실이 확인될 경우 회사는 회원의 보관금, 할인쿠폰 회수, ID 삭제 및 형사고발 등 기타 조치를 취할 수 있습니다. 
					<br><br>
					제11조의 2(보관금)
					①회원은 환급 또는 환불받을 금액을 보관금으로 "몰"에 예치할 수 있으며 이 보관금을 구매 등의 결제 수단으로 사용할 수 있습니다. 
					②회원은 보관금의 환급을 요구할 수 있으며 "몰"은 환급계좌 등의 확인을 거쳐 지체없이 지급합니다. 
					<br><br>
					제12조(수신확인통지.구매신청 변경 및 취소)
					① "몰"은 이용자의 구매 등에 관한 신청이 있는 경우 이용자에게 수신확인통지를 합니다. 수신확인통지는 "몰"에서 회원이 확인 가능한 방법으로의 통지, 전자우편주소(E-mail), 전화, 팩스 또는 기타의 방법으로 합니다. 
					② 수신확인통지를 받은 이용자는 의사표시의 불일치 등이 있는 경우에는 수신확인통지를 받은 후 즉시 구매신청 변경 및 취소를 요청할 수 있고 "몰"은 배송 전에 이용자의 요청이 있는 경우에는 지체 없이 그 요청에 따라 처리하여야 합니다. 다만 이미 대금을 지불한 경우에는 제15조의 청약철회 등에 관한 규정에 따릅니다. 
					<br><br>
					제13조(재화 등의 공급)
					① "몰"은 이용자와 재화 등의 공급시기에 관하여 별도의 약정이 없는 이상, 이용자가 청약을 한 날부터 7일 이내에 재화 등을 배송할 수 있도록 주문제작, 포장 등 기타의 필요한 조치를 취합니다. 다만, "몰"이 이미 재화 등의 대금의 전부 또는 일부를 받은 경우에는 대금의 전부 또는 일부를 받은 날부터 3영업일 이내에 조치를 취합니다.이때 "몰"은 이용자가 재화 등의 공급 절차 및 진행 사항을 확인할 수 있도록 적절한 조치를 합니다. 
					② "몰"은 이용자가 구매한 재화에 대해 배송수단, 수단별 배송비용 부담자, 수단별 배송기간 등을 명시합니다. 만약 "몰"이 약정 배송기간을 초과한 경우에는 그로 인한 이용자의 손해를 배상하여야 합니다. 다만 "몰"이 고의.과실이 없음을 입증한 경우에는 그러하지 아니합니다. 
					<br><br>
					제14조(환급) 
					"몰"은 이용자가 구매신청한 재화 등이 품절 등의 사유로 인도 또는 제공을 할 수 없을 때에는 지체 없이 그 사유를 이용자에게 통지하고 사전에 재화 등의 대금을 받은 경우에는 대금을 받은 날부터 3영업일 이내에 환급하거나 환급에 필요한 조치를 취합니다.
					<br><br>
					제15조(청약철회 등)
					① "몰"과 재화등의 구매에 관한 계약을 체결한 이용자는 「전자상거래 등에서의 소비자보호에 관한 법률」 제13조 제2항에 따른 계약내용에 관한 서면을 받은 날(그 서면을 받은 때보다 재화 등의 공급이 늦게 이루어진 경우에는 재화 등을 공급받거나 재화 등의 공급이 시작된 날을 말합니다)부터 7일 이내에는 청약의 철회를 할 수 있습니다. 다만, 청약철회에 관하여 「전자상거래 등에서의 소비자보호에 관한 법률」에 달리 정함이 있는 경우에는 동 법 규정에 따릅니다. 
					②이용자는 재화 등을 배송 받은 경우 다음 각 호의 1에 해당하는 경우에는 반품 및 교환을 할 수 없습니다. 
					1.이용자에게 책임 있는 사유로 재화 등이 멸실 또는 훼손된 경우(다만, 재화 등의 내용을 확인하기 위하여 포장 등을 훼손한 경우에는 청약철회를 할 수 있습니다) 
					2.이용자의 사용 또는 일부 소비에 의하여 재화 등의 가치가 현저히 감소한 경우 
					3.시간의 경과에 의하여 재판매가 곤란할 정도로 재화등의 가치가 현저히 감소한 경우 
					4.같은 성능을 지닌 재화 등으로 복제가 가능한 경우 그 원본인 재화 등의 포장을 훼손한 경우 
					5.기타 구매자가 환불이나 교환을 요청할 수 없는 합리적인 사유가 있는 경우 
					③제2항 제2호 내지 제5호의 경우에 "몰"이 사전에 청약철회 등이 제한되는 사실을 소비자가 쉽게 알 수 있는 곳에 명기하거나 시용상품을 제공하는 등의 조치를 하지 않았다면 이용자의 청약철회 등이 제한되지 않습니다. 
					④이용자는 제1항 및 제2항의 규정에 불구하고 재화 등의 내용이 표시·광고 내용과 다르거나 계약내용과 다르게 이행된 때에는 당해 재화 등을 공급받은 날부터 3월 이내, 그 사실을 안 날 또는 알 수 있었던 날부터 30일 이내에 청약철회 등을 할 수 있습니다. 
					⑤반품이나 교환에 필요한 왕복 배송비와 기타 필요한 비용은 귀책사유가 있는 쪽에서 부담합니다. 
					⑥반품을 신청할 때 반품송장번호를 기재하지 않으면 반품처리와 환불이 지연될 수 있습니다. 
					⑦교환신청을 하더라도 교환할 물품의 재고가 없으면 교환할 수 없으며, 이 때는 반품으로 처리됩니다. 
					⑧교환에 드는 비용은 물품하자의 경우에는 "몰" 또는 판매자가 왕복배송비를 부담하나 이용자의 변심에 의한 경우에는 이용자가 부담합니다. 
					⑨배송상의 문제로 이용자가 손해를 보았을 때 그에 대한 책임은 해당 배송업체를 지정한 "몰" 또는 판매자에게 있습니다. 
					⑩"몰"은 이용자의 교환 또는 반품의 요청이 정당하지 않다고 판단하면 이용자의 의사표시를 취소할 수 있습니다. 또한, 이용자의 교환, 반품 등이 접수된 날로부터 14일이 지날 때까지 이미 수령한 상품을 "몰"또는 판매자에게 반환하지 않거나 전화, 이메일(E-mail) 등으로 연락되지 않으면 교환, 반품의 의사를 철회한 것으로 간주할 수 있습니다. 
					⑪카드결제로 구매한 건의 환불은 카드결제 취소를 통하여 하는 것을 원칙으로 합니다. 
					⑫이용자는 상품이 발송되기 전까지 "구매계약"을 취소할 수 있으며, 배송 중이면 취소가 아닌 반품절차에 의해 처리됩니다. 
					⑬결제완료 상태에서는 취소신청 접수 시 즉시 취소처리가 완료됩니다. 
					⑭이용자가 "몰"과 구매계약 이외에 렌탈계약, 할부계약 등을 체결하는 경우에는 개별 계약에서 정한 절차에 따라 청약철회 등을 할 수 있습니다. 
					<br><br>
					제16조(청약철회 등의 효과)
					① "몰"은 이용자로부터 재화 등을 반환받은 경우 3영업일 이내에 이미 지급받은 재화 등의 대금을 환급합니다. 이 경우 "몰"이 이용자에게 재화등의 환급을 지연한때에는 그 지연기간에 대하여 「전자상거래 등에서의 소비자보호에 관한 법률 시행령」제21조의3에서 정하는 지연이자율을 곱하여 산정한 지연이자를 지급합니다. 
					② "몰"은 위 대금을 환급함에 있어서 이용자가 신용카드 또는 전자화폐 등의 결제수단으로 재화 등의 대금을 지급한 때에는 지체 없이 당해 결제수단을 제공한 사업자로 하여금 재화 등의 대금의 청구를 정지 또는 취소하도록 요청합니다. 
					③ 청약철회 등의 경우 공급받은 재화 등의 반환에 필요한 비용은 이용자가 부담합니다. "몰"은 이용자에게 청약철회 등을 이유로 위약금 또는 손해배상을 청구하지 않습니다. 다만 재화 등의 내용이 표시·광고 내용과 다르거나 계약내용과 다르게 이행되어 청약철회 등을 하는 경우 재화 등의 반환에 필요한 비용은 "몰"이 부담합니다. 
					④ 이용자가 재화 등을 제공받을 때 발송비를 부담한 경우에 "몰"은 청약철회 시 그 비용을 누가 부담하는지를 이용자가 알기 쉽도록 명확하게 표시합니다. 
					<br><br>
					제17조(개인정보보호)
					①"몰"은 이용자의 개인정보 수집시 서비스제공을 위하여 필요한 범위에서 최소한의 개인정보를 수집합니다. 
					②"몰"은 회원가입시 구매계약이행에 필요한 정보를 미리 수집하지 않습니다. 다만, 관련 법령상 의무이행을 위하여 구매계약 이전에 본인확인이 필요한 경우로서 최소한의 특정 개인정보를 수집하는 경우에는 그러하지 아니합니다. 
					③"몰"은 이용자의 개인정보를 수집·이용하는 때에는 당해 이용자에게 그 목적을 고지하고 동의를 받습니다. 
					④"몰"은 수집된 개인정보를 목적외의 용도로 이용할 수 없으며, 새로운 이용목적이 발생한 경우 또는 제3자에게 제공하는 경우에는 이용·제공단계에서 당해 이용자에게 그 목적을 고지하고 동의를 받습니다. 다만, 관련 법령에 달리 정함이 있는 경우에는 예외로 합니다. 
					⑤"몰"이 제3항과 제4항에 의해 이용자의 동의를 받아야 하는 경우에는 개인정보관리 책임자의 신원(소속, 성명 및 전화번호, 기타 연락처), 정보의 수집목적 및 이용목적, 제3자에 대한 정보제공 관련사항(제공받은자, 제공목적 및 제공할 정보의 내용) 등 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」 제22조 제1항 및 제24조의2 제1항이 규정한 사항을 미리 명시하거나 고지해야 하며 이용자는 언제든지 이 동의를 철회할 수 있습니다. 
					⑥이용자는 언제든지 "몰"이 가지고 있는 자신의 개인정보에 대해 열람 및 오류정정을 요구할 수 있으며 "몰"은 이에 대해 지체 없이 필요한 조치를 취할 의무를 집니다. 이용자가 오류의 정정을 요구한 경우에는 "몰"은 그 오류를 정정할 때까지 당해 개인정보를 이용하지 않습니다. 
					⑦ "몰"은 개인정보 보호를 위하여 이용자의 개인정보를 취급하는 자를 최소한으로 제한하여야 하며 신용카드, 은행계좌 등을 포함한 이용자의 개인정보의 분실, 도난, 유출, 동의 없는 제3자 제공, 변조 등으로 인한 이용자의 손해에 대하여 모든 책임을 집니다. 
					⑧"몰" 또는 그로부터 개인정보를 제공받은 제3자는 개인정보의 수집목적 또는 제공받은 목적을 달성한 때에는 당해 개인정보를 지체 없이 파기합니다. 
					⑨"몰"은 개인정보의 수집·이용·제공에 관한 동의란을 미리 선택한 것으로 설정해두지 않습니다. 또한 개인정보의 수집·이용·제공에 관한 이용자의 동의거절시 제한되는 서비스를 구체적으로 명시하고, 필수수집항목이 아닌 개인정보의 수집·이용·제공에 관한 이용자의 동의 거절을 이유로 회원가입 등 서비스 제공을 제한하거나 거절하지 않습니다. 
					⑩연결"몰" 또는 피연결"몰"에서는 우리 "몰"의 개인정보취급방침이 적용되지 않습니다. 링크된 사이트 및 상품 등을 제공하는 제3자의 개인정보 취급과 관련하여서는 해당 사이트 및 제3자의 개인정보취급방침을 확인할 책임이 회원에게 있으며, 회사는 이에 대하여 책임을 부담하지 않습니다. 
					⑪"몰"은 다음과 같은 경우에 법이 허용하는 범위 내에서 회원의 개인정보를 제3자에게 제공할 수 있습니다. 
					1.수사기관이나 기타 정부기관으로부터 정보제공을 요청 받은 경우 
					2.회원이 법령을 위반하는 등의 부정행위를 확인하기 위해 필요한 경우 
					3.기타 법률에 의해 요구되는 경우 
					<br><br>
					제18조("몰"의 의무)
					① "몰"은 법령과 이 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 이 약관이 정하는 바에 따라 지속적이고, 안정적으로 재화.용역을 제공하는데 최선을 다하여야 합니다. 
					② "몰"은 이용자가 안전하게 인터넷 서비스를 이용할 수 있도록 이용자의 개인정보(신용정보 포함)보호를 위한 보안 시스템을 갖추어야 합니다. 
					③ "몰"이 상품이나 용역에 대하여 「표시.광고의 공정화에 관한 법률」 제3조 소정의 부당한 표시.광고행위를 함으로써 이용자가 손해를 입은 때에는 이를 배상할 책임을 집니다. 
					④ "몰"은 이용자가 원하지 않는 영리목적의 광고성 전자우편을 발송하지 않습니다. 
					<br><br>
					제19조(회원의 ID 및 비밀번호에 대한 의무)
					① ID와 비밀번호에 관한 관리책임은 회원에게 있습니다. 
					② 회원은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다. 
					③ 회원이 자신의 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 "몰"에 통보하고 "몰"의 안내가 있는 경우에는 그에 따라야 합니다. 
					<br><br>
					제20조(이용자의 의무) 이용자는 다음 행위를 하여서는 안 됩니다.
					1.신청 또는 변경시 허위 내용의 등록 
					2.타인의 정보 도용 
					3."몰"에 게시된 정보의 변경 
					4."몰"이 정한 정보 이외의 정보(컴퓨터 프로그램 등) 등의 송신 또는 게시 
					5."몰" 기타 제3자의 저작권 등 지적재산권에 대한 침해 
					6."몰" 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위 
					7.외설 또는 폭력적인 메시지, 화상, 음성, 기타 공서양속에 반하는 정보를 몰에 공개 또는 게시하는 행위 
					<br><br>
					제21조(연결"몰"과 피연결"몰" 간의 관계)
					① 상위 "몰"과 하위 "몰"이 하이퍼링크(예: 하이퍼링크의 대상에는 문자, 그림 및 동화상 등이 포함됨)방식 등으로 연결된 경우, 전자를 연결 "몰"(웹 사이트)이라고 하고 후자를 피연결 "몰"(웹사이트)이라고 합니다. 
					② 연결"몰"은 피연결"몰"이 독자적으로 제공하는 재화 등에 의하여 이용자와 행하는 거래에 대해서 보증 책임을 지지 않는다는 뜻을 연결"몰"의 초기화면 또는 연결되는 시점의 팝업화면으로 명시한 경우에는 그 거래에 대한 보증 책임을 지지 않습니다. 
					<br><br>
					제22조(저작권의 귀속 및 이용제한)
					①"몰"이 작성한 저작물에 대한 저작권 기타 지적재산권은 "몰"에 귀속합니다. 
					②이용자는 "몰"을 이용함으로써 얻은 정보 중 "몰"에게 지적재산권이 귀속된 정보를 "몰"의 사전 승낙 없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다. ③"몰"은 약정에 따라 이용자에게 귀속된 저작권을 사용하는 경우 당해 이용자에게 통보하여야 합니다. 
					④회원이 "몰"의 서비스를 이용하면서 작성한 각종 게시물의 저작권은 회원 본인에게 있으며, 해당 게시물의 저작권 침해를 비롯한 민·형사상 모든 책임은 회원 본인이 집니다. 
					⑤"몰"은 회원이 등록한 게시물을 검색사이트나 다른 사이트에 노출할 수 있으며, 판촉, 홍보 및 기타의 자료로 무상으로 사용할 수 있습니다. 또한, 회사가 제공하는 서비스 내에서 회원 게시물을 복제, 전시, 전송, 배포할 수 있으며 2차적 저작물과 편집저작물로 작성 할 수 있습니다. 다만, 해당 게시물을 등록한 회원이 게시물의 삭제 또는 사용중지를 요청하면 회사는 관련 법률에 따라 보존해야 하는 사항을 제외하고 즉시 삭제 또는 사용을 중지합니다. 
					⑥본 조 제5항에 언급된 회사의 사용권은 "몰" 서비스를 운영하는 동안에만 확정적으로 유효합니다. 
					⑦"몰"이 본 조 제5항 이외의 방법으로 회원의 게시물을 상업적으로 이용하고자 할 때에는, 전화, 팩스, 이메일(E-mail)등의 방법으로 미리 회원의 동의를 얻어야 합니다. 회사가 본 항에 따라 회원의 게시물을 상업적으로 이용할 때 회사는 별도의 보상제도를 운영할 수 있습니다. 
					⑧"몰"이 작성한 저작물에 대한 저작권과 지적 재산권은 회사에 귀속합니다. 
					⑨이용자가 "몰"을 이용하여 얻은 정보를 회사의 승낙 없이 복제, 송신, 출판, 배포, 방송, 기타 방법으로 이용하거나 제3자에게 이용하게 할 때 그에 대한 책임은 이용자 본인에게 있습니다. 
					⑩회원은 "몰" 내에서 자신의 저작권이 침해되면 회사가 운영하는 신고센터 제도를 이용하여 자신의 정당한 권리를 보호받을 수 있습니다. 
					⑪게시물의 내용이 다음 각 호의 내용을 담고 있을 때 "몰"은 게시물을 삭제하거나 게시자에게 특정 서비스의 이용제한 또는 정지, 이용계약의 해지 등의 조치를 할 수 있습니다. 이때 게시물이 삭제되면 해당 게시물과 관련된 게시물(답변글, 댓글 등)도 모두 삭제됩니다. 
					1.대한민국의 법령을 위반하는 내용을 포함하는 경우 
					2.타인의 권리나 명예, 신용 기타 정당한 이익을 침해하는 경우 
					3.정보통신기기의 오작동을 일으킬 수 있는 악성코드나 데이터를 포함하는 경우 
					4.사회 공공질서나 미풍양속에 위배되는 경우 
					5.기타 제1호 내지 제4호에 준하는 중대한 사유로 말미암아 회사가 제공하는 서비스의 원활한 진행을 방해하는 것으로 판단되는 경우 
					⑫"몰"이 제11항에 따라 게시물을 삭제했을 때, 해당 게시자는 "몰"에 이의를 제기하여 구제받을 수 있습니다. 
					<br><br>
					제23조(분쟁해결)
					① "몰"은 이용자가 제기하는 정당한 의견이나 불만을 반영하고 그 피해를 보상처리하기 위하여 피해보상처리기구를 설치.운영합니다. 
					② "몰"은 이용자로부터 제출되는 불만사항 및 의견은 우선적으로 그 사항을 처리합니다. 다만, 신속한 처리가 곤란한 경우에는 이용자에게 그 사유와 처리일정을 즉시 통보해 드립니다. 
					③ "몰"과 이용자 간에 발생한 전자상거래 분쟁과 관련하여 이용자의 피해구제신청이 있는 경우에는 공정거래위원회 또는 시·도지사가 의뢰하는 분쟁조정기관의 조정에 따를 수 있습니다. 
					제24조(재판권 및 준거법)
					① "몰"과 이용자 간에 발생한 전자상거래 분쟁에 관한 소송은 제소 당시의 이용자의 주소에 의하고, 주소가 없는 경우에는 거소를 관할하는 지방법원의 전속관할로 합니다. 다만, 제소 당시 이용자의 주소 또는 거소가 분명하지 않거나 외국 거주자의 경우에는 민사소송법상의 관할법원에 제기합니다. 
					② "몰"과 이용자 간에 제기된 전자상거래 소송에는 대한민국 법령을 적용합니다. 
					제 25 조 (기타 조항)
					①"몰"은 필요하면 특정 서비스나 기능의 전부 또는 일부를 "몰"을 통해 미리 공지한 후 일시적 또는 영구적으로 수정하거나 중단할 수 있습니다. 
					②각 당사자는 상대방의 서면 동의 없이 이 약관상의 권리와 의무를 제3자에게 양도하거나 처분할 수 없습니다. 
					③ 이 약관과 관련하여 당사자 간의 합의에 따라 추가로 작성된 계약서, 협정서, 통보서 등과 회사의 정책변경, 법령의 제·개정 또는 공공기관의 고시나 지침 등에 따라 "몰"이 "몰"에 공지하는 내용도 이용계약의 일부를 구성합니다. 
					④"몰"은 구매자 회원이 서비스를 이용할 때 발생할 수 있는 정당한 의견이나 불만 사항을 적극적으로 수렴하여 해결하고, 회원 상호 간의 분쟁을 조정하기 위하여 고객센터를 설치하고 운영합니다. "몰"은 회원이 제기하는 각종 불만사항과 의견을 적극적으로 검토한 후 정당하다고 판단될 때에는 이를 신속하게 처리하며, 즉시 처리하기가 어려운 사항이 있으면 그 사유와 처리기간을 전자우편주소(E-mail), 전화, 팩스 또는 기타의 방법으로 회원에게 통보합니다. 
					<br><br>
					[부칙] 본 약관은 2017년 8월 1일부터 적용됩니다.
                </div>
                <div class="radio">
                    <input type="radio" id="private3"
                     name="private2" value="accept">
                    <label for="private3">동의함</label>
                
                    <input type="radio" id="private4"
                     name="private2" value="reject" checked>
                    <label for="private4">동의안함</label>
                  </div>
            </div>
        </div>

        <!-- 섹션 04 -->
        <div class="s04">
            <div class="tit" id="order">상품주문하기</div>
			
            <!-- 탭 선택 -->
            <div class="cont-btn">
                <div class="toggle_btn active" id="btn-tab04">여행을 준비하다!</div>
                <div class="toggle_btn" id="btn-tab05">일상이 여행이다!</div>
                <div class="toggle_btn" id="btn-tab06">우리집이 호텔이다!</div>
            </div>		
			
            <div class="table">
                <div class="table-header">
                    <div class="item">
                        <div class="td">상품명</div>
                        <div class="td">일반구매가</div>
                        <div class="td">할인구매가</div>
                        <div class="td"></div>
                    </div>
                </div>
<!-- 여행을 준비하다 START -->		
				<div class="tab active" id="tab04">
                <div class="table-list" style="display:inline">
                    <div class="item">
                        <div class="td" id="product_1">인바디다이얼(W) + 인바디밴드</div>
                        <div class="td" style="text-decoration: line-through;">₩340,000</div>
                        <div class="td">₩300,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck1" name="chk" value="300000" onclick="javascript:totalAmt(this.form,'인바디다이얼(W) + 인바디밴드','0','300000','A1');javascript:clickCamping();">
								
                                <label for="ck1"><span></span></label>
								<input type="hidden" name="name0" id="name0" value="인바디다이얼(W) + 인바디밴드">
                            </div>
                        </div>
                    </div>

                    <div class="item">
                        <div class="td" id="product_2">자이로 엑스 홈 워킹패드 런닝머신 워킹머신</div>
                        <div class="td" style="text-decoration: line-through;">₩799,000</div>
                        <div class="td">₩790,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck2" name="chk" value="790000" onclick="javascript:totalAmt(this.form,'자이로 엑스 홈 워킹패드 런닝머신 워킹머신','1','790000','A2');javascript:clickCamping();">
								
                                <label for="ck2"><span></span></label>
								<input type="hidden" name="name1" id="name1" value="자이로 엑스 홈 워킹패드 런닝머신 워킹머신">
                            </div>
                        </div>
                    </div>

                    <div class="item">
                        <div class="td" id="product_3">NEW 숀리 엑스바이크 x 10 엑스텐 실내자전거</div>
                        <div class="td" style="text-decoration: line-through;">₩179,100</div>
                        <div class="td">₩175,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck3" name="chk" value="175000" onclick="javascript:totalAmt(this.form,'NEW 숀리 엑스바이크 x 10 엑스텐 실내자전거','2','175000','A3');javascript:clickCamping();">
								
                                <label for="ck3"><span></span></label>
								<input type="hidden" name="name2" id="name2" value="NEW 숀리 엑스바이크 x 10 엑스텐 실내자전거">
                            </div>
                        </div>
                    </div>

                    <div class="item">
                        <div class="td" id="product_4">이화에스엠피 데일리 오피스 바이크</div>
                        <div class="td" style="text-decoration: line-through;">₩299,000</div>
                        <div class="td">₩260,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck4" name="chk" value="260000" onclick="javascript:totalAmt(this.form,'이화에스엠피 데일리 오피스 바이크','3','260000','A4');javascript:clickCamping();">
								
                                <label for="ck4"><span></span></label>
								<input type="hidden" name="name3" id="name3" value="이화에스엠피 데일리 오피스 바이크">
                            </div>
                        </div>
                    </div>

                    <div class="item" style="display:none">
                        <div class="td" id="product_5">테일러메이드 심쿵 메탈우드 세트4 (초/중급자)</div>
                        <div class="td" style="text-decoration: line-through;">₩1,398,000</div>
                        <div class="td">₩1,250,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck5"name="chk" value="1250000" onclick="javascript:totalAmt(this.form,'테일러메이드 심쿵 메탈우드 세트4 (초/중급자)','4','1250000','A5');javascript:clickCamping();">
								
                                <label for="ck5"><span></span></label>
								<input type="hidden" name="name4" id="name4" value="테일러메이드 심쿵 메탈우드 세트4 (초/중급자)">
                            </div>
                        </div>
                    </div>

                    <div class="item" style="display:none">
                        <div class="td" id="product_6">테일러메이드 심쿵7 P770세트 (중/상급자)</div>
                        <div class="td" style="text-decoration: line-through;">₩3,860,000</div>
                        <div class="td">₩3,450,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck6" name="chk" value="3450000" onclick="javascript:totalAmt(this.form,'테일러메이드 심쿵7 P770세트 (중/상급자)','5','3450000','A6');javascript:clickCamping();">
								
                                <label for="ck6"><span></span></label>
								<input type="hidden" name="name5" id="name5" value="테일러메이드 심쿵7 P770세트 (중/상급자)">
                            </div>
                        </div>
                    </div>

                    <div class="item">
                        <div class="td" id="product_7">마루망SG 풀세트</div>
                        <div class="td" style="text-decoration: line-through;">₩2,850,000</div>
                        <div class="td">₩2,600,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck7" name="chk" value="2600000" onclick="javascript:totalAmt(this.form,'마루망SG 풀세트','6','2600000','A7');javascript:clickCamping();">
								
                                <label for="ck7"><span></span></label>
								<input type="hidden" name="name6" id="name6" value="마루망SG 풀세트">
                            </div>
                        </div>
                    </div>
					
                    <div class="item">
                        <div class="td" id="product_8">마루망SG 여성 풀세트</div>
                        <div class="td" style="text-decoration: line-through;">₩2,850,000</div>
                        <div class="td">₩2,600,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck8" name="chk" value="2600000" onclick="javascript:totalAmt(this.form,'마루망SG 여성 풀세트','7','2600000','A8');javascript:clickCamping();">
								
                                <label for="ck8"><span></span></label>
								<input type="hidden" name="name7" id="name7" value="마루망SG 여성 풀세트">
                            </div>
                        </div>
                    </div>					

 
                    <div class="item">
                        <div class="td" id="product_9">마제스티 퍼터 MJ 103M</div>
                        <div class="td" style="text-decoration: line-through;">₩800,000</div>
                        <div class="td">₩650,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck9" name="chk" value="650000" onclick="javascript:totalAmt(this.form,'마제스티 퍼터 MJ 103M','8','650000','A9');javascript:clickCamping();">
								
                                <label for="ck9"><span></span></label>
								<input type="hidden" name="name8" id="name8" value="마제스티 퍼터 MJ 103M">
                            </div>
                        </div>
                    </div>
					
                    <div class="item">
                        <div class="td" id="product_10">후지필름 카메라 X100V</div>
                        <div class="td" style="text-decoration: line-through;">₩1,699,000</div>
                        <div class="td">₩1,600,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck10" name="chk" value="1600000" onclick="javascript:totalAmt(this.form,'후지필름 카메라 X100V','9','1600000','A10');javascript:clickCamping();">
								
                                <label for="ck10"><span></span></label>
								<input type="hidden" name="name9" id="name9" value="후지필름 카메라 X100V">
                            </div>
                        </div>
                    </div>
					
                    <div class="item" style="display:none">
                        <div class="td" id="product_11">미니 빔프로젝터 캐미빔 MP250</div>
                        <div class="td" style="text-decoration: line-through;">₩429,000</div>
                        <div class="td">₩416,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck11" name="chk" value="416000" onclick="javascript:totalAmt(this.form,'미니 빔프로젝터 캐미빔 MP250','10','416000','A11');javascript:clickCamping();">
								
                                <label for="ck11"><span></span></label>
								<input type="hidden" name="name10" id="name10" value="미니 빔프로젝터 캐미빔 MP250">
                            </div>
                        </div>
                    </div>		

                    <div class="item" >
                        <div class="td" id="product_12">RBZ 풀세트 남성용</div>
                        <div class="td" style="text-decoration: line-through;">₩1,420,000</div>
                        <div class="td">₩1,300,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck12" name="chk" value="1300000" onclick="javascript:totalAmt(this.form,'RBZ 풀세트 남성용','11','1300000','A12');javascript:clickCamping();">
								
                                <label for="ck12"><span></span></label>
								<input type="hidden" name="name11" id="name11" value="RBZ 풀세트 남성용">
                            </div>
                        </div>
                    </div>	


                    <div class="item" >
                        <div class="td" id="product_13">젝시오 11 드라이버</div>
                        <div class="td" style="text-decoration: line-through;">₩680,000</div>
                        <div class="td">₩646,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck13" name="chk" value="646000" onclick="javascript:totalAmt(this.form,'젝시오 11 드라이버','12','646000','A13');javascript:clickCamping();">
								
                                <label for="ck13"><span></span></label>
								<input type="hidden" name="name12" id="name12" value="젝시오 11 드라이버">
                            </div>
                        </div>
                    </div>	

                    <div class="item" >
                        <div class="td" id="product_14">젝시오 11 페어웨이우드</div>
                        <div class="td" style="text-decoration: line-through;">₩440,000</div>
                        <div class="td">₩420,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck14" name="chk" value="420000" onclick="javascript:totalAmt(this.form,'젝시오 11 페어웨이우드','13','440000','A14');javascript:clickCamping();">
								
                                <label for="ck14"><span></span></label>
								<input type="hidden" name="name13" id="name13" value="젝시오 11 페어웨이우드">
                            </div>
                        </div>
                    </div>	

                    <div class="item" >
                        <div class="td" id="product_15">젝시오 11 유틸리티우드</div>
                        <div class="td" style="text-decoration: line-through;">₩290,000</div>
                        <div class="td">₩275,500</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck15" name="chk" value="275500" onclick="javascript:totalAmt(this.form,'젝시오 11 유틸리티우드','14','275500','A15');javascript:clickCamping();">
								
                                <label for="ck15"><span></span></label>
								<input type="hidden" name="name14" id="name14" value="젝시오 11 유틸리티우드">
                            </div>
                        </div>
                    </div>	

                    <div class="item" >
                        <div class="td" id="product_16">젝시오 11 남성 8 아이언세트</div>
                        <div class="td" style="text-decoration: line-through;">₩1,280,000</div>
                        <div class="td">₩1,200,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck16" name="chk" value="1200000" onclick="javascript:totalAmt(this.form,'젝시오 11 남성 8 아이언세트','15','1200000','A16');javascript:clickCamping();">
								
                                <label for="ck16"><span></span></label>
								<input type="hidden" name="name15" id="name15" value="젝시오 11 남성 8 아이언세트">
                            </div>
                        </div>
                    </div>	

                    <div class="item" >
                        <div class="td" id="product_17">젝시오 11 여성 드라이버</div>
                        <div class="td" style="text-decoration: line-through;">₩680,000</div>
                        <div class="td">₩646,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck17" name="chk" value="646000" onclick="javascript:totalAmt(this.form,'젝시오 11 여성 드라이버','16','646000','A17');javascript:clickCamping();">
								
                                <label for="ck17"><span></span></label>
								<input type="hidden" name="name16" id="name16" value="젝시오 11 여성 드라이버">
                            </div>
                        </div>
                    </div>	

                    <div class="item" >
                        <div class="td" id="product_18">젝시오 11 여성 페어웨이우드</div>
                        <div class="td" style="text-decoration: line-through;">₩440,000</div>
                        <div class="td">₩418,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck18" name="chk" value="418000" onclick="javascript:totalAmt(this.form,'젝시오 11 여성 페어웨이우드','17','418000','A18');javascript:clickCamping();">
								
                                <label for="ck18"><span></span></label>
								<input type="hidden" name="name17" id="name17" value="젝시오 11 여성 페어웨이우드">
                            </div>
                        </div>
                    </div>		

                   <div class="item" >
                        <div class="td" id="product_19">젝시오 11 여성 유틸리티우드</div>
                        <div class="td" style="text-decoration: line-through;">₩290,000</div>
                        <div class="td">₩275,500</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck19" name="chk" value="275500" onclick="javascript:totalAmt(this.form,'젝시오 11 여성 유틸리티우드','18','275500','A19');javascript:clickCamping();">
								
                                <label for="ck19"><span></span></label>
								<input type="hidden" name="name18" id="name18" value="젝시오 11 여성 유틸리티우드">
                            </div>
                        </div>
                    </div>							
					
					
				</div>					
				</div>
<!-- 여행을 준비하다 END -->					

<!-- 일상이 여행이다 START -->	
					<div class="tab" id="tab05">
					<div class="table-list" style="display:inline">
					
                    <div class="item">
                        <div class="td" id="product_20">2021 치사이클 뉴트로(정품 미니펌프 증정 중)</div>
                        <div class="td" style="text-decoration: line-through;">₩1,110,000</div>
                        <div class="td">₩1,050,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck20" name="chk" value="1050000" onclick="javascript:totalAmt(this.form,'2021 치사이클 뉴트로(정품 미니펌프 증정 중)','19','1050000','B1');javascript:clickCamping();">
								
                                <label for="ck20"><span></span></label>
								<input type="hidden" name="name19" id="name19" value="2021 치사이클 뉴트로(정품 미니펌프 증정 중)">
                            </div>
                        </div>
                    </div>	
					
                    <div class="item">
                        <div class="td" id="product_21">아이나비스포츠 로드기어CT 전동킥보드</div>
                        <div class="td" style="text-decoration: line-through;">₩329,000</div>
                        <div class="td">₩299,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck21" name="chk" value="299000" onclick="javascript:totalAmt(this.form,'아이나비스포츠 로드기어CT 전동킥보드','20','299000','B2');javascript:clickCamping();">
								
                                <label for="ck21"><span></span></label>
								<input type="hidden" name="name20" id="name20" value="아이나비스포츠 로드기어CT 전동킥보드">
                            </div>
                        </div>
                    </div>		

                    <div class="item">
                        <div class="td" id="product_22">세그웨이 나인봇 맥스 전동킥보드</div>
                        <div class="td" style="text-decoration: line-through;">₩889,000</div>
                        <div class="td">₩859,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck22" name="chk" value="859000" onclick="javascript:totalAmt(this.form,'세그웨이 나인봇 맥스 전동킥보드','21','859000','B3');javascript:clickCamping();">
								
                                <label for="ck22"><span></span></label>
								<input type="hidden" name="name21" id="name21" value="세그웨이 나인봇 맥스 전동킥보드">
                            </div>
                        </div>
                    </div>							

					
					
                    <div class="item">
                        <div class="td" id="product_23">여성 삼각로고 나일론 숄더백(20FW/블랙)</div>
                        <div class="td" style="text-decoration: line-through;">₩1,810,000</div>
                        <div class="td">₩1,700,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck23" name="chk" value="1700000" onclick="javascript:totalAmt(this.form,'여성 삼각로고 나일론 숄더백(20FW/블랙)','22','1700000','B4');javascript:clickCamping();">
								
                                <label for="ck23"><span></span></label>
								<input type="hidden" name="name22" id="name22" value="여성 삼각로고 나일론 숄더백(20FW/블랙)">
                            </div>
                        </div>
                    </div>		

                    <div class="item" style="display:none">
                        <div class="td" id="product_24">여성 나일론 숄더백(20FW/블랙)</div>
                        <div class="td" style="text-decoration: line-through;">₩1,394,000</div>
                        <div class="td">₩1,300,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck24" name="chk" value="1300000" onclick="javascript:totalAmt(this.form,'여성 나일론 숄더백(20FW/블랙)','23','1300000','B5');javascript:clickCamping();">
								
                                <label for="ck24"><span></span></label>
								<input type="hidden" name="name23" id="name23" value="여성 나일론 숄더백(20FW/블랙)">
                            </div>
                        </div>
                    </div>							
					
                    <div class="item" style="display:none">
                        <div class="td" id="product_25">여성 다이노 크로스백(20FW/블랙)</div>
                        <div class="td" style="text-decoration: line-through;">₩1,394,000</div>
                        <div class="td">₩1,350,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck25" name="chk" value="1350000" onclick="javascript:totalAmt(this.form,'여성 다이노 크로스백(20FW/블랙)','24','1350000','B6');javascript:clickCamping();">
								
                                <label for="ck25"><span></span></label>
								<input type="hidden" name="name24" id="name24" value="여성 다이노 크로스백(20FW/블랙)">
                            </div>
                        </div>
                    </div>	

                    <div class="item" style="display:none">
                        <div class="td" id="product_26">여성 더블지퍼 크로스 바디 백(20FW/블랙)</div>
                        <div class="td" style="text-decoration: line-through;">₩1,624,000</div>
                        <div class="td">₩1,600,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck26" name="chk" value="1600000" onclick="javascript:totalAmt(this.form,'여성 더블지퍼 크로스 바디 백(20FW/블랙)','25','1600000','B7');javascript:clickCamping();">
								
                                <label for="ck26"><span></span></label>
								<input type="hidden" name="name25" id="name25" value="여성 더블지퍼 크로스 바디 백(20FW/블랙)">
                            </div>
                        </div>
                    </div>		

                   <div class="item" style="display:none">
                        <div class="td" id="product_27">여성 다이아그램 숄더백(20FW/블랙)</div>
                        <div class="td" style="text-decoration: line-through;">₩1,350,000</div>
                        <div class="td">₩1,310,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck27" name="chk" value="1310000" onclick="javascript:totalAmt(this.form,'여성 다이아그램 숄더백(20FW/블랙)','26','1310000','B8');javascript:clickCamping();">
								
                                <label for="ck27"><span></span></label>
								<input type="hidden" name="name26" id="name26" value="여성 다이아그램 숄더백(20FW/블랙)">
                            </div>
                        </div>
                    </div>							
					
                   <div class="item" style="display:none">
                        <div class="td" id="product_28">클래식 체크 캐시미어 머플러(20FW/화이트)</div>
                        <div class="td" style="text-decoration: line-through;">₩502,000</div>
                        <div class="td">₩480,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck28" name="chk" value="480000" onclick="javascript:totalAmt(this.form,'클래식 체크 캐시미어 머플러(20FW/화이트)','27','480000','B9');javascript:clickCamping();">
								
                                <label for="ck28"><span></span></label>
								<input type="hidden" name="name27" id="name27" value="클래식 체크 캐시미어 머플러(20FW/화이트)">
                            </div>
                        </div>
                    </div>	

                   <div class="item">
                        <div class="td" id="product_29">클래식 체크 캐시미어 머플러(20FW/그레이)</div>
                        <div class="td" style="text-decoration: line-through;">₩502,000</div>
                        <div class="td">₩480,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck29" name="chk" value="480000" onclick="javascript:totalAmt(this.form,'클래식 체크 캐시미어 머플러(20FW/그레이)','28','480000','B10');javascript:clickCamping();">
								
                                <label for="ck29"><span></span></label>
								<input type="hidden" name="name28" id="name28" value="클래식 체크 캐시미어 머플러(20FW/그레이)">
                            </div>
                        </div>
                    </div>						
					
                   <div class="item">
                        <div class="td" id="product_30">여성 GRAND METIS 롱패딩 (19FW/블랙)</div>
                        <div class="td" style="text-decoration: line-through;">₩1,610,000</div>
                        <div class="td">₩1,580,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck30" name="chk" value="1580000" onclick="javascript:totalAmt(this.form,'여성 GRAND METIS 롱패딩 (19FW/블랙)','29','1580000','B11');javascript:clickCamping();">
								
                                <label for="ck30"><span></span></label>
								<input type="hidden" name="name29" id="name29" value="여성 GRAND METIS 롱패딩 (19FW/블랙)">
                            </div>
                        </div>
                    </div>	

                   <div class="item">
                        <div class="td" id="product_31">여성 CAUSAPCAL 파카 롱패딩 (19FW/블랙)</div>
                        <div class="td" style="text-decoration: line-through;">₩1,658,500</div>
                        <div class="td">₩1,600,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck31" name="chk" value="1600000" onclick="javascript:totalAmt(this.form,'여성 CAUSAPCAL 파카 롱패딩 (19FW/블랙)','30','1600000','B12');javascript:clickCamping();">
								
                                <label for="ck31"><span></span></label>
								<input type="hidden" name="name30" id="name30" value="여성 CAUSAPCAL 파카 롱패딩 (19FW/블랙)">
                            </div>
                        </div>
                    </div>	

                   <div class="item">
                        <div class="td" id="product_32">남성 BIG RIDGE PARKA 패딩 (19FW/블랙)</div>
                        <div class="td" style="text-decoration: line-through;">₩1,621,500</div>
                        <div class="td">₩1,600,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck32" name="chk" value="1600000" onclick="javascript:totalAmt(this.form,'남성 BIG RIDGE PARKA 패딩 (19FW/블랙)','31','1600000','B13');javascript:clickCamping();">
								
                                <label for="ck32"><span></span></label>
								<input type="hidden" name="name31" id="name31" value="남성 BIG RIDGE PARKA 패딩 (19FW/블랙)">
                            </div>
                        </div>
                    </div>	

                  <div class="item">
                        <div class="td" id="product_33">여성 서스캐처원 롱 패딩 (19FW/블랙)</div>
                        <div class="td" style="text-decoration: line-through;">₩1,610,000</div>
                        <div class="td">₩1,580,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck33" name="chk" value="1580000" onclick="javascript:totalAmt(this.form,'여성 서스캐처원 롱 패딩 (19FW/블랙)','32','1580000','B14');javascript:clickCamping();">
								
                                <label for="ck33"><span></span></label>
								<input type="hidden" name="name32" id="name32" value="여성 서스캐처원 롱 패딩 (19FW/블랙)">
                            </div>
                        </div>
                    </div>	

                  <div class="item">
                        <div class="td" id="product_34">여성 아이벡스 롱패딩 (18FW/블랙)</div>
                        <div class="td" style="text-decoration: line-through;">₩1,460,500</div>
                        <div class="td">₩1,450,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck34" name="chk" value="1580000" onclick="javascript:totalAmt(this.form,'여성 아이벡스 롱패딩 (18FW/블랙)','33','1580000','B15');javascript:clickCamping();">
								
                                <label for="ck34"><span></span></label>
								<input type="hidden" name="name33" id="name33" value="여성 아이벡스 롱패딩 (18FW/블랙)">
                            </div>
                        </div>
                    </div>	

                  <div class="item">
                        <div class="td" id="product_35">남성 웨스트 고어 롱 파카 (18FW/블랙)</div>
                        <div class="td" style="text-decoration: line-through;">₩1,587,000</div>
                        <div class="td">₩1,550,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck35" name="chk" value="1550000" onclick="javascript:totalAmt(this.form,'남성 웨스트 고어 롱 파카 (18FW/블랙)','34','1550000','B16');javascript:clickCamping();">
								
                                <label for="ck35"><span></span></label>
								<input type="hidden" name="name34" id="name34" value="남성 웨스트 고어 롱 파카 (18FW/블랙)">
                            </div>
                        </div>
                    </div>		

                  <div class="item">
                        <div class="td" id="product_36">남성 웨스트 고어 롱 파카 (18FW/네이비)</div>
                        <div class="td" style="text-decoration: line-through;">₩1,587,000</div>
                        <div class="td">₩1,550,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck36" name="chk" value="1550000" onclick="javascript:totalAmt(this.form,'남성 웨스트 고어 롱 파카 (18FW/네이비)','35','1550000','B17');javascript:clickCamping();">
								
                                <label for="ck36"><span></span></label>
								<input type="hidden" name="name35" id="name35" value="남성 웨스트 고어 롱 파카 (18FW/네이비)">
                            </div>
                        </div>
                    </div>		

                  <div class="item">
                        <div class="td" id="product_37">남성 웨스트 고어 롱 패딩 (18FW/카키)</div>
                        <div class="td" style="text-decoration: line-through;">₩1,587,000</div>
                        <div class="td">₩1,550,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck37" name="chk" value="1550000" onclick="javascript:totalAmt(this.form,'남성 웨스트 고어 롱 패딩 (18FW/카키)','36','1550000','B18');javascript:clickCamping();">
								
                                <label for="ck37"><span></span></label>
								<input type="hidden" name="name36" id="name36" value="남성 웨스트 고어 롱 패딩 (18FW/카키)">
                            </div>
                        </div>
                    </div>

                  <div class="item">
                        <div class="td" id="product_38">여성 SALMON RIVER 롱 파카 (18FW/카키)</div>
                        <div class="td" style="text-decoration: line-through;">₩1,587,000</div>
                        <div class="td">₩1,550,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck38" name="chk" value="1550000" onclick="javascript:totalAmt(this.form,'여성 SALMON RIVER 롱 파카 (18FW/카키)','37','1550000','B19');javascript:clickCamping();">
								
                                <label for="ck38"><span></span></label>
								<input type="hidden" name="name37" id="name37" value="여성 SALMON RIVER 롱 파카 (18FW/카키)">
                            </div>
                        </div>
                    </div>		

                  <div class="item">
                        <div class="td" id="product_39">여성 스틸링 롱 패딩 (18FW/블랙)</div>
                        <div class="td" style="text-decoration: line-through;">₩1,265,000</div>
                        <div class="td">₩1,250,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck39" name="chk" value="1250000" onclick="javascript:totalAmt(this.form,'여성 스틸링 롱 패딩 (18FW/블랙)','38','1250000','B20');javascript:clickCamping();">
								
                                <label for="ck39"><span></span></label>
								<input type="hidden" name="name38" id="name38" value="여성 스틸링 롱 패딩 (18FW/블랙)">
                            </div>
                        </div>
                    </div>	

                  <div class="item">
                        <div class="td" id="product_40">세그웨이-나인봇 전동킥보드 MAX </div>
                        <div class="td" style="text-decoration: line-through;">₩858,000</div>
                        <div class="td">₩800,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck40" name="chk" value="800000" onclick="javascript:totalAmt(this.form,'세그웨이-나인봇 전동킥보드 MAX','39','800000','B21');javascript:clickCamping();">
								
                                <label for="ck40"><span></span></label>
								<input type="hidden" name="name39" id="name39" value="세그웨이-나인봇 전동킥보드 MAX ">
                            </div>
                        </div>
                    </div>	

                  <div class="item" style="display:none">
                        <div class="td" id="product_41">샤오미 치사이클 EF1 Plus 2021 </div>
                        <div class="td" style="text-decoration: line-through;">₩1,150,000</div>
                        <div class="td">₩1,090,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck41" name="chk" value="1090000" onclick="javascript:totalAmt(this.form,'샤오미 치사이클 EF1 Plus 2021','40','1090000','B22');javascript:clickCamping();">
								
                                <label for="ck41"><span></span></label>
								<input type="hidden" name="name40" id="name40" value="샤오미 치사이클 EF1 Plus 2021">
                            </div>
                        </div>
                    </div>		

                  <div class="item" style="display:none">
                        <div class="td" id="product_42">SONY 플레이스테이션4 프로(PS4PRO) 블랙(CHU-7218BB01) </div>
                        <div class="td" style="text-decoration: line-through;">₩490,000</div>
                        <div class="td">₩480,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck42" name="chk" value="480000" onclick="javascript:totalAmt(this.form,'SONY 플레이스테이션4 프로(PS4PRO) 블랙(CHU-7218BB01)','41','480000','B23');javascript:clickCamping();">
								
                                <label for="ck42"><span></span></label>
								<input type="hidden" name="name41" id="name41" value="SONY 플레이스테이션4 프로(PS4PRO) 블랙(CHU-7218BB01)">
                            </div>
                        </div>
                    </div>
					</div>
				</div>					
<!-- 일상이 여행이다 END -->	
					
<!-- 우리집이 호텔이다 -->		
				<div class="tab" id="tab06">

				<div class="table-list" style="display:inline">		


				
                  <div class="item">
                        <div class="td" id="product_43">Crystal UHD TV 138 cm</div>
                        <div class="td" style="text-decoration: line-through;">₩1,151,200</div>
                        <div class="td">₩1,080,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck43" name="chk" value="1080000" onclick="javascript:totalAmt(this.form,'Crystal UHD TV 138 cm','42','1080000','C1');javascript:clickCamping();">
								
                                <label for="ck43"><span></span></label>
								<input type="hidden" name="name42" id="name42" value="Crystal UHD TV 138 cm">
                            </div>
                        </div>
                    </div>	

                  <div class="item" style="display:none">
                        <div class="td" id="product_44">LG전자 울트라 HDTV 138cm 55UT641S0NB</div>
                        <div class="td" style="text-decoration: line-through;">₩906,500</div>
                        <div class="td">₩780,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck44" name="chk" value="780000" onclick="javascript:totalAmt(this.form,'LG전자 울트라 HDTV 138cm 55UT641S0NB','43','780000','C2');javascript:clickCamping();">
								
                                <label for="ck44"><span></span></label>
								<input type="hidden" name="name43" id="name43" value="LG전자 울트라 HDTV 138cm 55UT641S0NB">
                            </div>
                        </div>
                    </div>	

                  <div class="item">
                        <div class="td" id="product_45">삼성전자 제트 무선청소기 + 청정스테이션 패키지</div>
                        <div class="td" style="text-decoration: line-through;">₩1,421,200</div>
                        <div class="td">₩1,240,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck45" name="chk" value="1240000" onclick="javascript:totalAmt(this.form,'삼성전자 제트 무선청소기 + 청정스테이션 패키지','44','1240000','C3');javascript:clickCamping();">
								
                                <label for="ck45"><span></span></label>
								<input type="hidden" name="name44" id="name44" value="삼성전자 제트 무선청소기 + 청정스테이션 패키지">
                            </div>
                        </div>
                    </div>	

                  <div class="item" style="display:none">
                        <div class="td" id="product_46">LG전자 코드제로 A9S ThinQ 물걸레 무선청소기</div>
                        <div class="td" style="text-decoration: line-through;">₩1,360,000</div>
                        <div class="td">₩1,250,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck46" name="chk" value="1250000" onclick="javascript:totalAmt(this.form,'LG전자 코드제로 A9S ThinQ 물걸레 무선청소기','45','1250000','C4');javascript:clickCamping();">
								
                                <label for="ck46"><span></span></label>
								<input type="hidden" name="name45" id="name45" value="LG전자 코드제로 A9S ThinQ 물걸레 무선청소기">
                            </div>
                        </div>
                    </div>	

                  <div class="item">
                        <div class="td" id="product_47">Miele C3 파켓 청소기</div>
                        <div class="td" style="text-decoration: line-through;">₩551,600</div>
                        <div class="td">₩520,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck47" name="chk" value="520000" onclick="javascript:totalAmt(this.form,'Miele C3 파켓 청소기','46','520000','C5');javascript:clickCamping();">
								
                                <label for="ck47"><span></span></label>
								<input type="hidden" name="name46" id="name46" value="Miele C3 파켓 청소기">
                            </div>
                        </div>
                    </div>	

                  <div class="item" style="display:none">
                        <div class="td" id="product_48">다이슨 무선청소기 V11 220AW 컴플리트</div>
                        <div class="td" style="text-decoration: line-through;">₩1,082,200</div>
                        <div class="td">₩1,030,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck48" name="chk" value="1030000" onclick="javascript:totalAmt(this.form,'다이슨 무선청소기 V11 220AW 컴플리트','47','1030000','C6');javascript:clickCamping();">
								
                                <label for="ck48"><span></span></label>
								<input type="hidden" name="name47" id="name47" value="다이슨 무선청소기 V11 220AW 컴플리트">
                            </div>
                        </div>
                    </div>	

                  <div class="item" style="display:none">
                        <div class="td" id="product_49">삼성전자 무풍 큐브 공기청정기 47+47m²</div>
                        <div class="td" style="text-decoration: line-through;">₩1,098,000</div>
                        <div class="td">₩1,000,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck49" name="chk" value="1000000" onclick="javascript:totalAmt(this.form,'삼성전자 무풍 큐브 공기청정기 47+47m²','48','1000000','C7');javascript:clickCamping();">
								
                                <label for="ck49"><span></span></label>
								<input type="hidden" name="name48" id="name48" value="삼성전자 무풍 큐브 공기청정기 47+47m²">
                            </div>
                        </div>
                    </div>		

                  <div class="item">
                        <div class="td" id="product_50">IQAir 프리미엄 공기청정기 HealthPro 100</div>
                        <div class="td" style="text-decoration: line-through;">₩1,652,400</div>
                        <div class="td">₩1,500,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck50" name="chk" value="1500000" onclick="javascript:totalAmt(this.form,'IQAir 프리미엄 공기청정기 HealthPro 100','49','1500000','C8');javascript:clickCamping();">
								
                                <label for="ck50"><span></span></label>
								<input type="hidden" name="name49" id="name49" value="IQAir 프리미엄 공기청정기 HealthPro 100">
                            </div>
                        </div>
                    </div>		

                  <div class="item">
                        <div class="td" id="product_51">Vifa Oslo(오슬로) 블루투스 스피커</div>
                        <div class="td" style="text-decoration: line-through;">₩1,652,400</div>
                        <div class="td">₩1,500,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck51" name="chk" value="1500000" onclick="javascript:totalAmt(this.form,'Vifa Oslo(오슬로) 블루투스 스피커','50','1500000','C9');javascript:clickCamping();">
								
                                <label for="ck51"><span></span></label>
								<input type="hidden" name="name50" id="name50" value="Vifa Oslo(오슬로) 블루투스 스피커">
                            </div>
                        </div>
                    </div>		

                 <div class="item" style="display:none">
                        <div class="td" id="product_52">LG전자 트롬 스타일러 블랙틴트미러 S5MBA</div>
                        <div class="td" style="text-decoration: line-through;">₩2,114,000</div>
                        <div class="td">₩1,900,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck52" name="chk" value="1900000" onclick="javascript:totalAmt(this.form,'LG전자 트롬 스타일러 블랙틴트미러 S5MBA','51','1900000','C10');javascript:clickCamping();">
								
                                <label for="ck52"><span></span></label>
								<input type="hidden" name="name51" id="name51" value="LG전자 트롬 스타일러 블랙틴트미러 S5MBA">
                            </div>
                        </div>
                    </div>	

                <div class="item">
                        <div class="td" id="product_53">지펠 양문형냉장고 815L RS82M6000S8</div>
                        <div class="td" style="text-decoration: line-through;">₩1,036,800</div>
                        <div class="td">₩1,000,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck53" name="chk" value="1000000" onclick="javascript:totalAmt(this.form,'지펠 양문형냉장고 815L RS82M6000S8','52','1000000','C11');javascript:clickCamping();">
								
                                <label for="ck53"><span></span></label>
								<input type="hidden" name="name52" id="name52" value="지펠 양문형냉장고 815L RS82M6000S8">
                            </div>
                        </div>
                    </div>	

                <div class="item" style="display:none">
                        <div class="td" id="product_54">LG전자 DIOS 김치톡톡 스탠드형 김치냉장고 327L K330W14</div>
                        <div class="td">₩1,570,800</div>
                        <div class="td">₩1,450,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck54" name="chk" value="1450000" onclick="javascript:totalAmt(this.form,'LG전자 DIOS 김치톡톡 스탠드형 김치냉장고 327L K330W14','53','1450000','C12');javascript:clickCamping();">
								
                                <label for="ck54"><span></span></label>
								<input type="hidden" name="name53" id="name53" value="LG전자 DIOS 김치톡톡 스탠드형 김치냉장고 327L K330W14">
                            </div>
                        </div>
                    </div>	

                <div class="item">
                        <div class="td" id="product_55">삼성전자 갤럭시북 Flex NT950QCG-X716(i7,16GB,512GB,39.6cm)</div>
                        <div class="td" style="text-decoration: line-through;">₩2,858,800</div>
                        <div class="td">₩2,500,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck55" name="chk" value="2500000" onclick="javascript:totalAmt(this.form,'삼성전자 갤럭시북 Flex NT950QCG-X716(i7,16GB,512GB,39.6cm)','54','2500000','C13');javascript:clickCamping();">
								
                                <label for="ck55"><span></span></label>
								<input type="hidden" name="name54" id="name54" value="삼성전자 갤럭시북 Flex NT950QCG-X716(i7,16GB,512GB,39.6cm)">
                            </div>
                        </div>
                    </div>	

                <div class="item" style="display:none">
                        <div class="td" id="product_56">LG전자 그램 17 17Z90N-VA5IK (i5-1035G7,16GB,256GB,17인치)</div>
                        <div class="td" style="text-decoration: line-through;">₩2,171,600</div>
                        <div class="td">₩1,980,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck56" name="chk" value="1980000" onclick="javascript:totalAmt(this.form,'LG전자 그램 17 17Z90N-VA5IK (i5-1035G7,16GB,256GB,17인치)','55','1980000','C14');javascript:clickCamping();">
								
                                <label for="ck56"><span></span></label>
								<input type="hidden" name="name55" id="name55" value="LG전자 그램 17 17Z90N-VA5IK (i5-1035G7,16GB,256GB,17인치)">
                            </div>
                        </div>
                    </div>	

                <div class="item">
                        <div class="td" id="product_57">비너스 퀸 동영돌침대</div>
                        <div class="td" style="text-decoration: line-through;">₩1,680,000</div>
                        <div class="td">₩1,500,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck57" name="chk" value="1500000" onclick="javascript:totalAmt(this.form,'비너스 퀸 동영돌침대','56','1500000','C15');javascript:clickCamping();">
								
                                <label for="ck57"><span></span></label>
								<input type="hidden" name="name56" id="name56" value="비너스 퀸 동영돌침대">
                            </div>
                        </div>
                    </div>	

                <div class="item">
                        <div class="td" id="product_58">뉴황제 퀸 동영돌침대</div>
                        <div class="td" style="text-decoration: line-through;">₩1,090,000</div>
                        <div class="td">₩970,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck58" name="chk" value="970000" onclick="javascript:totalAmt(this.form,'뉴황제 퀸 동영돌침대','57','970000','C16');javascript:clickCamping();">
								
                                <label for="ck58"><span></span></label>
								<input type="hidden" name="name57" id="name57" value="뉴황제 퀸 동영돌침대">
                            </div>
                        </div>
                    </div>	

                <div class="item">
                        <div class="td" id="product_59">엘레강스 소파 동영돌소파</div>
                        <div class="td" style="text-decoration: line-through;">₩1,290,000</div>
                        <div class="td">₩1,150,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck59" name="chk" value="115000" onclick="javascript:totalAmt(this.form,'엘레강스 소파 동영돌소파','58','115000','C17');javascript:clickCamping();">
								
                                <label for="ck59"><span></span></label>
								<input type="hidden" name="name58" id="name58" value="엘레강스 소파 동영돌소파">
                            </div>
                        </div>
                    </div>	

                <div class="item">
                        <div class="td" id="product_60">매트리스 토퍼 프리미엄 (SS/Q/K)(무색,Q)</div>
                        <div class="td" style="text-decoration: line-through;">₩399,900</div>
                        <div class="td">₩390,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck60" name="chk" value="390000" onclick="javascript:totalAmt(this.form,'매트리스 토퍼 프리미엄 (SS/Q/K)(무색,Q)','59','390000','C18');javascript:clickCamping();">
								
                                <label for="ck60"><span></span></label>
								<input type="hidden" name="name59" id="name59" value="매트리스 토퍼 프리미엄 (SS/Q/K)(무색,Q)">
                            </div>
                        </div>
                    </div>	

                <div class="item">
                        <div class="td" id="product_61">매트리스 토퍼 프리미엄 (SS/Q/K)(무색,K)</div>
                        <div class="td" style="text-decoration: line-through;">₩448,000</div>
                        <div class="td">₩430,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck61" name="chk" value="430000" onclick="javascript:totalAmt(this.form,'매트리스 토퍼 프리미엄 (SS/Q/K)(무색,K)','60','430000','C19');javascript:clickCamping();">
								
                                <label for="ck61"><span></span></label>
								<input type="hidden" name="name60" id="name60" value="매트리스 토퍼 프리미엄 (SS/Q/K)(무색,K)">
                            </div>
                        </div>
                    </div>	

                <div class="item" style="display:none">
                        <div class="td" id="product_62">경동나비엔 온수매트 EQM560-H 쿠션형(S/Q/K)(무색,퀸)</div>
                        <div class="td" style="text-decoration: line-through;">₩398,800</div>
                        <div class="td">₩390,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck62" name="chk" value="390000" onclick="javascript:totalAmt(this.form,'경동나비엔 온수매트 EQM560-H 쿠션형(S/Q/K)(무색,퀸)','61','390000','C20');javascript:clickCamping();">
								
                                <label for="ck62"><span></span></label>
								<input type="hidden" name="name61" id="name61" value="경동나비엔 온수매트 EQM560-H 쿠션형(S/Q/K)(무색,퀸)">
                            </div>
                        </div>
                    </div>	

                <div class="item" style="display:none">
                        <div class="td" id="product_63">경동나비엔 온수매트 EQM560-H 쿠션형(S/Q/K)(무색,킹)</div>
                        <div class="td" style="text-decoration: line-through;">₩425,200</div>
                        <div class="td">₩410,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck63" name="chk" value="410000" onclick="javascript:totalAmt(this.form,'경동나비엔 온수매트 EQM560-H 쿠션형(S/Q/K)(무색,퀸)','62','410000','C21');javascript:clickCamping();">
								
                                <label for="ck63"><span></span></label>
								<input type="hidden" name="name62" id="name62" value="경동나비엔 온수매트 EQM560-H 쿠션형(S/Q/K)(무색,퀸)">
                            </div>
                        </div>
                    </div>

                <div class="item">
                        <div class="td" id="product_64">몽베르 전동 1인용 All천연면피가죽 리클라이너 소파</div>
                        <div class="td" style="text-decoration: line-through;">₩1,380,000</div>
                        <div class="td">₩1,150,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck64" name="chk" value="1150000" onclick="javascript:totalAmt(this.form,'몽베르 전동 1인용 All천연면피가죽 리클라이너 소파','63','1150000','C22');javascript:clickCamping();">
								
                                <label for="ck64"><span></span></label>
								<input type="hidden" name="name63" id="name63" value="몽베르 전동 1인용 All천연면피가죽 리클라이너 소파">
                            </div>
                        </div>
                    </div>	

                <div class="item">
                        <div class="td" id="product_65">허먼밀러_Mirra 2 black</div>
                        <div class="td" style="text-decoration: line-through;">₩1,470,000</div>
                        <div class="td">₩1,350,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck65" name="chk" value="1350000" onclick="javascript:totalAmt(this.form,'허먼밀러_Mirra 2 black','64','1350000','C23');javascript:clickCamping();">
								
                                <label for="ck65"><span></span></label>
								<input type="hidden" name="name64" id="name64" value="몽베르 전동 1인용 허먼밀러_Mirra 2 black">
                            </div>
                        </div>
                    </div>	

                <div class="item">
                        <div class="td" id="product_66">허먼밀러_New Aeron Full(Graphite,B,New Headrest 추가)</div>
                        <div class="td" style="text-decoration: line-through;">₩2,131,500</div>
                        <div class="td">₩1,950,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck66" name="chk" value="1950000" onclick="javascript:totalAmt(this.form,'허먼밀러_New Aeron Full(Graphite,B,New Headrest 추가)','65','1950000','C24');javascript:clickCamping();">
								
                                <label for="ck66"><span></span></label>
								<input type="hidden" name="name65" id="name65" value="허먼밀러_New Aeron Full(Graphite,B,New Headrest 추가)">
                            </div>
                        </div>
                    </div>	

                <div class="item">
                        <div class="td" id="product_67">코아스 1200 무빙데스크 OSD1201</div>
                        <div class="td" style="text-decoration: line-through;">₩1,028,800</div>
                        <div class="td">₩950,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck67" name="chk" value="950000" onclick="javascript:totalAmt(this.form,'코아스 1200 무빙데스크 OSD1201','66','950000','C25');javascript:clickCamping();">
								
                                <label for="ck67"><span></span></label>
								<input type="hidden" name="name66" id="name66" value="코아스 1200 무빙데스크 OSD1201">
                            </div>
                        </div>
                    </div>	

                <div class="item">
                        <div class="td" id="product_68">S.O.U.L 루이스 티테이블 L</div>
                        <div class="td" style="text-decoration: line-through;">₩476,000</div>
                        <div class="td">₩450,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck68" name="chk" value="450000" onclick="javascript:totalAmt(this.form,'S.O.U.L 루이스 티테이블 L','67','450000','C26');javascript:clickCamping();">
								
                                <label for="ck68"><span></span></label>
								<input type="hidden" name="name67" id="name67" value="S.O.U.L 루이스 티테이블 L">
                            </div>
                        </div>
                    </div>	

                <div class="item">
                        <div class="td" id="product_69">S.O.U.L 셀마 티테이블</div>
                        <div class="td" style="text-decoration: line-through;">₩336,000</div>
                        <div class="td">₩270,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck69" name="chk" value="270000" onclick="javascript:totalAmt(this.form,'S.O.U.L 셀마 티테이블','68','270000','C27');javascript:clickCamping();">
								
                                <label for="ck69"><span></span></label>
								<input type="hidden" name="name68" id="name68" value="S.O.U.L 셀마 티테이블">
                            </div>
                        </div>
                    </div>	
					
               <div class="item">
                        <div class="td" id="product_70">캠핑카 올인원 패키지 1박 2일(36시간)</div>
                        <div class="td" style="text-decoration: line-through;">₩690,000</div>
                        <div class="td">₩610,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck70" name="chk" value="610000" onclick="javascript:totalAmt(this.form,'캠핑카 올인원 패키지 1박 2일(36시간)','69','610000','C28');javascript:clickCamping();">
								
                                <label for="ck70"><span></span></label>
								<input type="hidden" name="name69" id="name69" value="캠핑카 올인원 패키지 1박 2일(36시간)">
                            </div>
                        </div>
                    </div>	
					
					
               <div class="item">
                        <div class="td" id="product_71">캠핑카 올인원 패키지 2박 3일(60시간)</div>
                        <div class="td" style="text-decoration: line-through;">₩960,000</div>
                        <div class="td">₩880,000</div>
                        <div class="td">
                            <div class="form-checkbox">
                                <input type="checkbox" id="ck71" name="chk" value="880000" onclick="javascript:totalAmt(this.form,'캠핑카 올인원 패키지 2박 3일(60시간)','70','880000','C29');javascript:clickCamping();";>
								
                                <label for="ck71"><span></span></label>
								<input type="hidden" name="name70" id="name70" value="캠핑카 올인원 패키지 2박 3일(60시간)">
                            </div>
                        </div>
                    </div>						

					
					</div>
				</div>					
<!-- 우리집이 호텔이다 END -->					
					
                </div>

                <div class="total">
                    <div class="item-list">

                        <div class="item" id="no0" style="display:none">
                            <div class="name" id="productNm0"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt0">0원</div>
                        </div>
                        
                        <div class="item" id="no1" style="display:none">
                            <div class="name" id="productNm1"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt1">0원</div>
                        </div>
						
                        <div class="item" id="no2" style="display:none">
                            <div class="name" id="productNm2"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt2">0원</div>
                        </div>						

                        <div class="item" id="no3" style="display:none">
                            <div class="name" id="productNm3"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt3">0원</div>
                        </div>		

                        <div class="item" id="no4" style="display:none">
                            <div class="name" id="productNm4"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt4">0원</div>
                        </div>		

                        <div class="item" id="no5" style="display:none">
                            <div class="name" id="productNm5"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt5">0원</div>
                        </div>		

                        <div class="item" id="no6" style="display:none">
                            <div class="name" id="productNm6"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt6">0원</div>
                        </div>		

                        <div class="item" id="no7" style="display:none">
                            <div class="name" id="productNm7"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt7">0원</div>
                        </div>		

                        <div class="item" id="no8" style="display:none">
                            <div class="name" id="productNm8"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt8">0원</div>
                        </div>		

                        <div class="item" id="no9" style="display:none">
                            <div class="name" id="productNm9"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt9">0원</div>
                        </div>	
						
                       <div class="item" id="no10" style="display:none">
                            <div class="name" id="productNm10"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt10">0원</div>
                        </div>
                        
                        <div class="item" id="no11" style="display:none">
                            <div class="name" id="productNm11"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt11">0원</div>
                        </div>
						
                        <div class="item" id="no12" style="display:none">
                            <div class="name" id="productNm12"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt12">0원</div>
                        </div>						

                        <div class="item" id="no13" style="display:none">
                            <div class="name" id="productNm13"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt13">0원</div>
                        </div>		

                        <div class="item" id="no14" style="display:none">
                            <div class="name" id="productNm14"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt14">0원</div>
                        </div>		

                        <div class="item" id="no15" style="display:none" >
                            <div class="name" id="productNm15"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt15">0원</div>
                        </div>		

                        <div class="item" id="no16" style="display:none">
                            <div class="name" id="productNm16"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt16">0원</div>
                        </div>		

                        <div class="item" id="no17" style="display:none">
                            <div class="name" id="productNm17"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt17">0원</div>
                        </div>		

                        <div class="item" id="no18" style="display:none" >
                            <div class="name" id="productNm18"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt18">0원</div>
                        </div>		

                        <div class="item" id="no19" style="display:none">
                            <div class="name" id="productNm19"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt19">0원</div>
                        </div>					

                      <div class="item" id="no20" style="display:none">
                            <div class="name" id="productNm20"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt20">0원</div>
                        </div>
                        
                        <div class="item" id="no21" style="display:none">
                            <div class="name" id="productNm21"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt21">0원</div>
                        </div>
						
                        <div class="item" id="no22" style="display:none">
                            <div class="name" id="productNm22"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt22">0원</div>
                        </div>						

                        <div class="item" id="no23" style="display:none">
                            <div class="name" id="productNm23"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt23">0원</div>
                        </div>		

                        <div class="item" id="no24" style="display:none">
                            <div class="name" id="productNm24"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt24">0원</div>
                        </div>		

                        <div class="item" id="no25" style="display:none">
                            <div class="name" id="productNm25"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt25">0원</div>
                        </div>		

                        <div class="item" id="no26" style="display:none">
                            <div class="name" id="productNm26"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt26">0원</div>
                        </div>		

                        <div class="item" id="no27" style="display:none">
                            <div class="name" id="productNm27"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt27">0원</div>
                        </div>		

                        <div class="item" id="no28" style="display:none">
                            <div class="name" id="productNm28"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt28">0원</div>
                        </div>		

                        <div class="item" id="no29" style="display:none" >
                            <div class="name" id="productNm29"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt29">0원</div>
                        </div>	

                      <div class="item" id="no30" style="display:none">
                            <div class="name" id="productNm30"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt30">0원</div>
                        </div>
                        
                        <div class="item" id="no31" style="display:none">
                            <div class="name" id="productNm31"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt31">0원</div>
                        </div>
						
                        <div class="item" id="no32" style="display:none">
                            <div class="name" id="productNm32"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt32">0원</div>
                        </div>						

                        <div class="item" id="no33" style="display:none">
                            <div class="name" id="productNm33"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt33">0원</div>
                        </div>		

                        <div class="item" id="no34" style="display:none">
                            <div class="name" id="productNm34"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt34">0원</div>
                        </div>		

                        <div class="item" id="no35" style="display:none">
                            <div class="name" id="productNm35"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt35">0원</div>
                        </div>		

                        <div class="item" id="no36" style="display:none">
                            <div class="name" id="productNm36"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt36">0원</div>
                        </div>		

                        <div class="item" id="no37" style="display:none">
                            <div class="name" id="productNm37"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt37">0원</div>
                        </div>		

                        <div class="item" id="no38" style="display:none">
                            <div class="name" id="productNm38"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt38">0원</div>
                        </div>		

                        <div class="item" id="no39" style="display:none">
                            <div class="name" id="productNm39"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt39">0원</div>
                        </div>									
	
                      <div class="item" id="no40" style="display:none">
                            <div class="name" id="productNm40"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt40">0원</div>
                        </div>
                        
                        <div class="item" id="no41" style="display:none">
                            <div class="name" id="productNm41"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt41">0원</div>
                        </div>
						
                        <div class="item" id="no42" style="display:none">
                            <div class="name" id="productNm42"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt42">0원</div>
                        </div>						

                        <div class="item" id="no43" style="display:none">
                            <div class="name" id="productNm43"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt43">0원</div>
                        </div>		

                        <div class="item" id="no44" style="display:none">
                            <div class="name" id="productNm44"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt44">0원</div>
                        </div>		

                        <div class="item" id="no45" style="display:none">
                            <div class="name" id="productNm45"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt45">0원</div>
                        </div>		

                        <div class="item" id="no46" style="display:none">
                            <div class="name" id="productNm46"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt46">0원</div>
                        </div>		

                        <div class="item" id="no47" style="display:none">
                            <div class="name" id="productNm47"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt47">0원</div>
                        </div>		

                        <div class="item" id="no48" style="display:none" >
                            <div class="name" id="productNm48"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt48">0원</div>
                        </div>		

                        <div class="item" id="no49" style="display:none">
                            <div class="name" id="productNm49"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt49">0원</div>
                        </div>									
						
                      <div class="item" id="no50" style="display:none">
                            <div class="name" id="productNm50"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt50">0원</div>
                        </div>
                        
                        <div class="item" id="no51" style="display:none">
                            <div class="name" id="productNm51"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt51">0원</div>
                        </div>
						
                        <div class="item" id="no52" style="display:none">
                            <div class="name" id="productNm52"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt52">0원</div>
                        </div>						

                        <div class="item" id="no53" style="display:none">
                            <div class="name" id="productNm53"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt53">0원</div>
                        </div>		

                        <div class="item" id="no54" style="display:none">
                            <div class="name" id="productNm54"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt54">0원</div>
                        </div>		

                        <div class="item" id="no55" style="display:none">
                            <div class="name" id="productNm55"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt55">0원</div>
                        </div>		

                        <div class="item" id="no56" style="display:none">
                            <div class="name" id="productNm56"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt56">0원</div>
                        </div>		

                        <div class="item" id="no57" style="display:none">
                            <div class="name" id="productNm57"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt57">0원</div>
                        </div>	

                        <div class="item" id="no58" style="display:none">
                            <div class="name" id="productNm58"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt58">0원</div>
                        </div>	

                        <div class="item" id="no59" style="display:none">
                            <div class="name" id="productNm59"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt59">0원</div>
                        </div>	
                        <div class="item" id="no60" style="display:none">
                            <div class="name" id="productNm60"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt60">0원</div>
                        </div>								
                        <div class="item" id="no61" style="display:none">
                            <div class="name" id="productNm61"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt61">0원</div>
                        </div>		
                        <div class="item" id="no62" style="display:none">
                            <div class="name" id="productNm62"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt62">0원</div>
                        </div>		
                        <div class="item" id="no63" style="display:none">
                            <div class="name" id="productNm63"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt63">0원</div>
                        </div>		
                        <div class="item" id="no64" style="display:none">
                            <div class="name" id="productNm64"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt64">0원</div>
                        </div>		
                        <div class="item" id="no65" style="display:none">
                            <div class="name" id="productNm65"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt65">0원</div>
                        </div>		
                        <div class="item" id="no66" style="display:none">
                            <div class="name" id="productNm66"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt66">0원</div>
                        </div>		
                        <div class="item" id="no67" style="display:none">
                            <div class="name" id="productNm67"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt67">0원</div>
                        </div>	
                        <div class="item" id="no68" style="display:none">
                            <div class="name" id="productNm68"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt68">0원</div>
                        </div>			
                        <div class="item" id="no69" style="display:none">
                            <div class="name" id="productNm69"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt69">0원</div>
                        </div>	
                        <div class="item" id="no70" style="display:none">
                            <div class="name" id="productNm70"></div>
                            <div class="count">X1</div>
                            <div class="price"id="productAmt70">0원</div>
                        </div>	
		
						
						
						
						

						<div class="item" id="total" >
						</div>
						
                    </div>
                    <div class="total_price">
                        총계 : <span id="total_price">0</span>원
                    </div>
                </div>
            </div>
        </div>

        <!-- 섹션 05 -->
        <div class="s05">
            <div class="form">
                <div class="item">
                    <div class="tit">
                        이름
                    </div>
                    <div class="content">
                        <input type="text" name="nm" id="nm">
                    </div>
                </div>
                <div class="item tel">
                    <div class="tit">
                        휴대폰 번호
                    </div>
                    <div class="content">
                        <input type="text" name="hp1" id="hp1" maxlength="3" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/><span class="dash">-</span>
                        <input type="text" name="hp2" id="hp2" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/><span class="dash">-</span>
                        <input type="text" name="hp3" id="hp3" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>
                    </div>
                </div>
                <div class="item addr" id="addr">
                    <div class="tit">
                        상품배송받으실 주소
                    </div>
                    <div class="content">
						<div class="item tel">
							<input type="text" name="post" id="post" colspan="2" readOnly>
							<input type="button" class="button" size="8px" maxlength="8" name="postTxt" id="postTxt" value="우편번호" onclick="javascript:onPost();">
							<!--<button class="button" onclick="javascript:onPost();">우편번호</button>-->
						</div>
                        <div class="addr1"><input type="text" maxlength="50" name="addr1" id="addr1" readOnly></div>
                        <div class="addr2"><input type="text" maxlength="50" name="addr2" id="addr2"></div>
                    </div>
                </div>

                <div class="item addr"  style="display:none" id="rent">
                    <div class="tit">
                        이용 희망일 기재
                    </div>
                    <div class="content">
						<div class="item tel">
							<input type="text" name="startday" id="startday" value="" onkeyup="chgDate(this)" maxlength="10" placeholder="YYYY-MM-DD부터"> <span class="dash">~</span> <input type="text" name="endday" id="endday" value="" onkeyup="chgDate(this)" maxlength="10" placeholder="YYYY-MM-DD까지" >
						</div>
                    </div>
                </div>				
                <div class="item">
                    <div class="tit">
                        여행상품권 총사용 금액
                    </div>
                    <div class="content">
						<!--<input type="text" name="amt" id="amt" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>-->
						<input type="text" name="amt" id="amt" maxlength="8" onKeyup="inputNumberAutoComma(this);">
						<span class="dash">원</span>
                        <!--<input type="text"><span class="dash">X</span>
                        <input type="text"><span class="dash">매</span>-->
                    </div>
                </div>
            </div>
            <div class="cont-btn">
                <div class="btn-submit"><a href="javascript:save();">작성완료</a></div>
            </div>
        </div>

        <!-- 섹션 06 -->
        <div class="s06">
            <div class="tit">롯데제이티비 여행상품권 이용 안내</div>
            <div class="p-list">
                <p><span class="num">①</span> 원하는 제품 선정 후 제품정보  및 개인정보제공 동의 후 양식 작성  부탁드립니다.</p>
                <p><span class="num">②</span> 구매 관련 SMS 수신 후 안내에 따라 롯데제이티비 여행 상품권 접수 (영업일 기준 약 2~3일 소요)</p>
                <p><span class="num">③</span> 상담원 통하여 여행 상품권 접수 확인 및 추가요금 납부/환불 처리 후 제품이 발송됩니다.</p>
                <p><span class="num">④</span> 변경 및 취소 시 상담원 통하여 유선으로 확인 부탁 드립니다.</p>
                <p><span class="num">⑤</span> 해당 프로모션은 2020년 12월 1일 부터 2021년 3월 31일까지 진행됩니다.</p>
            </div>
            <div class="notice">
                <p>
                    <span class="num">※</span> 
                    여행상품권은 액면가의 60% 이상 이용시 잔액 환불되며, 일시구매만 가능합니다. <br>
                </p>
                <span class="info">(인수형장기 구매 불가)</span>
                <p>
                    <span class="num">※</span> 
                    <span>
                        상담가능시간 평일(09:00 ~ 17:00) / 롯데제이티비 이용성 대리 (02-6313-8247)
						<!--상담가능시간 평일(09:00 ~ 17:00) / 롯데제이티비 한경호 책임 (02-6313-8246)-->
						<!--상담가능시간 평일(09:00 ~ 17:00) / 롯데제이티비 김동현 (02-6313-8248)-->
                    </span>
                </p>
            </div>
        </div>
    </div>
</div>
 
</form>
</body>

<script>

    $(function(){
        // 버튼(탭 메뉴 토글)
        $('.toggle_btn').on('click', buttonToggleEvent);
    });
    // 버튼 부모-자식 토글
    function buttonToggleEvent(e){
        var parent = $(e.currentTarget).parent();
		var targetId = e.currentTarget.id;

        if(parent.hasClass('tabbtn')){
            if($(e.currentTarget).hasClass('active')){
                return;
            }
        }

        parent.children().removeClass('active');
        $(e.currentTarget).toggleClass('active');
        buttonTabActivation(e);
	   
	   
	   
    }
	
	function addComma(num) {
	    var regexp = /\B(?=(\d{3})+(?!\d))/g;
	    return num.toString().replace(regexp, ',');
	}	

    // 탭 버튼 활성화 이벤트
    function buttonTabActivation(e){
        var targetId = e.currentTarget.id.split('-')[1];
		
        //$('.tab').removeClass('active');
        //$('#' + targetId).addClass('active');

		if(targetId=="tab01"||targetId=="tab04"){	
			$('.tab').removeClass('active');
			$('#tab01').addClass('active');			
			$('#tab04').addClass('active');	
			//$('#btn-tab04').addClass('active');	
		}
		if(targetId=="tab02"||targetId=="tab05"){	
			$('.tab').removeClass('active');
			$('#tab02').addClass('active');	
			$('#tab05').addClass('active');			
			//$('#btn-tab05').addClass('active');	
		}
		if(targetId=="tab03"||targetId=="tab06"){		
			$('.tab').removeClass('active');
			$('#tab03').addClass('active');	
			$('#tab06').addClass('active');			
			//$('#btn-tab06').addClass('active');	
		}	


    }
	
	$(document).ready(function(){

	});	 
	
	function save(){
		
		//날짜 길이
		var startday = $('#startday').val().length;
		var endday = $('#endday').val().length;
		
		
		//상품 선택 시 display옵션
		var productNm = "";
		var productNm0 = document.getElementById("productNm0").innerText;
		var productNm1 = document.getElementById("productNm1").innerText;
		var productNm2 = document.getElementById("productNm2").innerText;
		var productNm3 = document.getElementById("productNm3").innerText;
		var productNm4 = document.getElementById("productNm4").innerText;
		var productNm5 = document.getElementById("productNm5").innerText;
		var productNm6 = document.getElementById("productNm6").innerText;
		var productNm7 = document.getElementById("productNm7").innerText;
		var productNm8 = document.getElementById("productNm8").innerText;
		var productNm9 = document.getElementById("productNm9").innerText;
		var productNm10 = document.getElementById("productNm10").innerText;
		var productNm11 = document.getElementById("productNm11").innerText;
		var productNm12 = document.getElementById("productNm12").innerText;
		var productNm13 = document.getElementById("productNm13").innerText;
		var productNm14 = document.getElementById("productNm14").innerText;
		var productNm15 = document.getElementById("productNm15").innerText;
		var productNm16 = document.getElementById("productNm16").innerText;
		var productNm17 = document.getElementById("productNm17").innerText;
		var productNm18 = document.getElementById("productNm18").innerText;
		var productNm19 = document.getElementById("productNm19").innerText;		
		var productNm20 = document.getElementById("productNm20").innerText;
		var productNm21 = document.getElementById("productNm21").innerText;
		var productNm22 = document.getElementById("productNm22").innerText;
		var productNm23 = document.getElementById("productNm23").innerText;
		var productNm24 = document.getElementById("productNm24").innerText;
		var productNm25 = document.getElementById("productNm25").innerText;
		var productNm26 = document.getElementById("productNm26").innerText;
		var productNm27 = document.getElementById("productNm27").innerText;
		var productNm28 = document.getElementById("productNm28").innerText;
		var productNm29 = document.getElementById("productNm29").innerText;		
		var productNm30 = document.getElementById("productNm30").innerText;
		var productNm31 = document.getElementById("productNm31").innerText;
		var productNm32 = document.getElementById("productNm32").innerText;
		var productNm33 = document.getElementById("productNm33").innerText;
		var productNm34 = document.getElementById("productNm34").innerText;
		var productNm35 = document.getElementById("productNm35").innerText;
		var productNm36 = document.getElementById("productNm36").innerText;
		var productNm37 = document.getElementById("productNm37").innerText;
		var productNm38 = document.getElementById("productNm38").innerText;
		var productNm39 = document.getElementById("productNm39").innerText;
		var productNm40 = document.getElementById("productNm40").innerText;
		var productNm41 = document.getElementById("productNm41").innerText;
		var productNm42 = document.getElementById("productNm42").innerText;
		var productNm43 = document.getElementById("productNm43").innerText;
		var productNm44 = document.getElementById("productNm44").innerText;
		var productNm45 = document.getElementById("productNm45").innerText;
		var productNm46 = document.getElementById("productNm46").innerText;
		var productNm47 = document.getElementById("productNm47").innerText;
		var productNm48 = document.getElementById("productNm48").innerText;
		var productNm49 = document.getElementById("productNm49").innerText;		
		var productNm50 = document.getElementById("productNm50").innerText;
		var productNm51 = document.getElementById("productNm51").innerText;
		var productNm52 = document.getElementById("productNm52").innerText;
		var productNm53 = document.getElementById("productNm53").innerText;
		var productNm54 = document.getElementById("productNm54").innerText;
		var productNm55 = document.getElementById("productNm55").innerText;
		var productNm56 = document.getElementById("productNm56").innerText;
		var productNm57 = document.getElementById("productNm57").innerText;
		var productNm58 = document.getElementById("productNm58").innerText;
		var productNm59 = document.getElementById("productNm59").innerText;
		var productNm60 = document.getElementById("productNm60").innerText;
		var productNm61 = document.getElementById("productNm61").innerText;
		var productNm62 = document.getElementById("productNm62").innerText;
		var productNm63 = document.getElementById("productNm63").innerText;
		var productNm64 = document.getElementById("productNm64").innerText;
		var productNm65 = document.getElementById("productNm65").innerText;
		var productNm66 = document.getElementById("productNm66").innerText;
		var productNm67 = document.getElementById("productNm67").innerText;
		var productNm68 = document.getElementById("productNm68").innerText;
		var productNm69 = document.getElementById("productNm69").innerText;
		var productNm70 = document.getElementById("productNm70").innerText;

		var chkcount = $("input:checkbox[name=chk]:checked").length;


		if(productNm0.length > 0){
			productNm0 = document.getElementById("productNm0").innerText;
			productNm += "|"+productNm0;
		}
		if(productNm1.length > 0){
			productNm1 = document.getElementById("productNm1").innerText;
			productNm += "|"+productNm1;
		}
		if(productNm2.length > 0){
			productNm2 = document.getElementById("productNm2").innerText;
			productNm += "|"+productNm2;
		}
		if(productNm3.length > 0){
			productNm3 = document.getElementById("productNm3").innerText;
			productNm += "|"+productNm3;
		}
		if(productNm4.length > 0){
			productNm4 = document.getElementById("productNm4").innerText;
			productNm += "|"+productNm4;
		}
		if(productNm5.length > 0){
			productNm5 = document.getElementById("productNm5").innerText;
			productNm += "|"+productNm5;
		}
		if(productNm6.length > 0){
			productNm6 = document.getElementById("productNm6").innerText;
			productNm += "|"+productNm6;
		}
		if(productNm7.length > 0){
			productNm7 = document.getElementById("productNm7").innerText;
			productNm += "|"+productNm7;
		}
		if(productNm8.length > 0){
			productNm8 = document.getElementById("productNm8").innerText;
			productNm += "|"+productNm8;
		}
		if(productNm9.length > 0){
			productNm9 = document.getElementById("productNm9").innerText;
			productNm +="|"+ productNm9;
		}
		if(productNm10.length > 0){
			productNm10 = document.getElementById("productNm10").innerText;
			productNm += "|"+productNm10;
		}
		if(productNm11.length > 0){
			productNm11 = document.getElementById("productNm11").innerText;
			productNm += "|"+productNm11;
		}
		if(productNm12.length > 0){
			productNm12 = document.getElementById("productNm12").innerText;
			productNm += "|"+productNm12;
		}
		if(productNm13.length > 0){
			productNm13 = document.getElementById("productNm13").innerText;
			productNm += "|"+productNm13;
		}
		if(productNm14.length > 0){
			productNm14 = document.getElementById("productNm14").innerText;
			productNm += "|"+productNm14;
		}
		if(productNm15.length > 0){
			productNm15 = document.getElementById("productNm15").innerText;
			productNm += "|"+productNm15;
		}
		if(productNm16.length > 0){
			productNm16 = document.getElementById("productNm16").innerText;
			productNm += "|"+productNm16;
		}
		if(productNm17.length > 0){
			productNm17 = document.getElementById("productNm17").innerText;
			productNm += "|"+productNm17;
		}
		if(productNm18.length > 0){
			productNm18 = document.getElementById("productNm18").innerText;
			productNm += "|"+productNm18;
		}
		if(productNm19.length > 0){
			productNm19 = document.getElementById("productNm19").innerText;
			productNm +="|"+ productNm19;
		}
		if(productNm20.length > 0){
			productNm20 = document.getElementById("productNm20").innerText;
			productNm += "|"+productNm20;
		}
		if(productNm21.length > 0){
			productNm21 = document.getElementById("productNm21").innerText;
			productNm += "|"+productNm21;
		}
		if(productNm22.length > 0){
			productNm22 = document.getElementById("productNm22").innerText;
			productNm += "|"+productNm22;
		}
		if(productNm23.length > 0){
			productNm23 = document.getElementById("productNm23").innerText;
			productNm += "|"+productNm23;
		}
		if(productNm24.length > 0){
			productNm24 = document.getElementById("productNm24").innerText;
			productNm += "|"+productNm24;
		}
		if(productNm25.length > 0){
			productNm25 = document.getElementById("productNm25").innerText;
			productNm += "|"+productNm25;
		}
		if(productNm26.length > 0){
			productNm26 = document.getElementById("productNm26").innerText;
			productNm += "|"+productNm26;
		}
		if(productNm27.length > 0){
			productNm27 = document.getElementById("productNm27").innerText;
			productNm += "|"+productNm27;
		}
		if(productNm28.length > 0){
			productNm28 = document.getElementById("productNm28").innerText;
			productNm += "|"+productNm28;
		}
		if(productNm29.length > 0){
			productNm29 = document.getElementById("productNm29").innerText;
			productNm +="|"+ productNm29;
		}
		if(productNm30.length > 0){
			productNm30 = document.getElementById("productNm30").innerText;
			productNm += "|"+productNm30;
		}
		if(productNm31.length > 0){
			productNm31 = document.getElementById("productNm31").innerText;
			productNm += "|"+productNm31;
		}
		if(productNm32.length > 0){
			productNm32 = document.getElementById("productNm32").innerText;
			productNm += "|"+productNm32;
		}
		if(productNm33.length > 0){
			productNm33 = document.getElementById("productNm33").innerText;
			productNm += "|"+productNm33;
		}
		if(productNm34.length > 0){
			productNm34 = document.getElementById("productNm34").innerText;
			productNm += "|"+productNm34;
		}
		if(productNm35.length > 0){
			productNm35 = document.getElementById("productNm35").innerText;
			productNm += "|"+productNm35;
		}
		if(productNm36.length > 0){
			productNm36 = document.getElementById("productNm36").innerText;
			productNm += "|"+productNm36;
		}
		if(productNm37.length > 0){
			productNm37 = document.getElementById("productNm37").innerText;
			productNm += "|"+productNm37;
		}
		if(productNm38.length > 0){
			productNm38 = document.getElementById("productNm38").innerText;
			productNm += "|"+productNm38;
		}
		if(productNm39.length > 0){
			productNm39 = document.getElementById("productNm39").innerText;
			productNm +="|"+ productNm39;
		}
		if(productNm40.length > 0){
			productNm40 = document.getElementById("productNm40").innerText;
			productNm += "|"+productNm40;
		}
		if(productNm41.length > 0){
			productNm41 = document.getElementById("productNm41").innerText;
			productNm += "|"+productNm41;
		}
		if(productNm42.length > 0){
			productNm42 = document.getElementById("productNm42").innerText;
			productNm += "|"+productNm42;
		}
		if(productNm43.length > 0){
			productNm43 = document.getElementById("productNm43").innerText;
			productNm += "|"+productNm43;
		}
		if(productNm44.length > 0){
			productNm44 = document.getElementById("productNm44").innerText;
			productNm += "|"+productNm44;
		}
		if(productNm45.length > 0){
			productNm45 = document.getElementById("productNm45").innerText;
			productNm += "|"+productNm45;
		}
		if(productNm46.length > 0){
			productNm46 = document.getElementById("productNm46").innerText;
			productNm += "|"+productNm46;
		}
		if(productNm47.length > 0){
			productNm47 = document.getElementById("productNm47").innerText;
			productNm += "|"+productNm47;
		}
		if(productNm48.length > 0){
			productNm48 = document.getElementById("productNm48").innerText;
			productNm += "|"+productNm48;
		}
		if(productNm49.length > 0){
			productNm49 = document.getElementById("productNm49").innerText;
			productNm +="|"+ productNm49;
		}		
		if(productNm50.length > 0){
			productNm50 = document.getElementById("productNm50").innerText;
			productNm += "|"+productNm50;
		}
		if(productNm51.length > 0){
			productNm51 = document.getElementById("productNm51").innerText;
			productNm += "|"+productNm51;
		}
		if(productNm52.length > 0){
			productNm52 = document.getElementById("productNm52").innerText;
			productNm += "|"+productNm52;
		}
		if(productNm53.length > 0){
			productNm53 = document.getElementById("productNm53").innerText;
			productNm += "|"+productNm53;
		}
		if(productNm54.length > 0){
			productNm54 = document.getElementById("productNm54").innerText;
			productNm += "|"+productNm54;
		}
		if(productNm55.length > 0){
			productNm55 = document.getElementById("productNm55").innerText;
			productNm += "|"+productNm55;
		}
		if(productNm56.length > 0){
			productNm56 = document.getElementById("productNm56").innerText;
			productNm += "|"+productNm56;
		}
		if(productNm57.length > 0){
			productNm57 = document.getElementById("productNm57").innerText;
			productNm += "|"+productNm57;
		}
		if(productNm58.length > 0){
			productNm58 = document.getElementById("productNm58").innerText;
			productNm += "|"+productNm58;
		}
		if(productNm59.length > 0){
			productNm59 = document.getElementById("productNm59").innerText;
			productNm += "|"+productNm59;
		}	
		if(productNm60.length > 0){
			productNm60 = document.getElementById("productNm60").innerText;
			productNm += "|"+productNm60;
		}	
		if(productNm61.length > 0){
			productNm61 = document.getElementById("productNm61").innerText;
			productNm += "|"+productNm61;
		}	
		if(productNm62.length > 0){
			productNm62 = document.getElementById("productNm62").innerText;
			productNm += "|"+productNm62;
		}	
		if(productNm63.length > 0){
			productNm63 = document.getElementById("productNm63").innerText;
			productNm += "|"+productNm63;
		}	
		if(productNm64.length > 0){
			productNm64 = document.getElementById("productNm64").innerText;
			productNm += "|"+productNm64;
		}	
		if(productNm65.length > 0){
			productNm65 = document.getElementById("productNm65").innerText;
			productNm += "|"+productNm65;
		}	

		if(productNm66.length > 0){
			productNm66 = document.getElementById("productNm66").innerText;
			productNm += "|"+productNm66;
		}	
		if(productNm67.length > 0){
			productNm67 = document.getElementById("productNm67").innerText;
			productNm += "|"+productNm67;
		}	
		if(productNm68.length > 0){
			productNm68 = document.getElementById("productNm68").innerText;
			productNm += "|"+productNm68;
		}	
		if(productNm69.length > 0){
			productNm69 = document.getElementById("productNm69").innerText;
			productNm += "|"+productNm69;
		}	
		if(productNm70.length > 0){
			productNm70 = document.getElementById("productNm70").innerText;
			productNm += "|"+productNm70;
		}			
		

		//개인정보 동의여부 radio
		var private1 = $(':radio[name="private1"]:checked').val();
		var private2 = $(':radio[name="private2"]:checked').val();
		var private3 = $(':radio[name="private3"]:checked').val();
		
		
		//상품 checkbox
		var chk = jQuery("input:checkbox[name='chk']").is(":checked");
		
		//이름
		var nm = $("#nm").val();
		
		//휴대폰번호
		var hp1 = $("#hp1").val();
		var hp2 = $("#hp2").val();
		var hp3 = $("#hp3").val();
		
		//주소
		var addr1 = $("#addr1").val();
		var addr2 = $("#addr2").val();
		
		//캠핑카 선택 여부
		var campinga = jQuery("input:checkbox[id='ck59']").is(":checked");
		var campingb = jQuery("input:checkbox[id='ck60']").is(":checked");
		var chkcount = $("input:checkbox[name=chk]:checked").length;
		
		//이용시작일,이용종료일
		var in_day    = $("#startday").val();
		var out_day   = $("#endday").val();

		
		//상품권 금액
		var amt = $("#amt").val();
		var totamt = document.getElementById("total_price").innerText;
		
		amt = amt.replace(/[^\d]+/g, '');
		totamt = totamt.replace(/[^\d]+/g, '');
		
		//개인정보 동의여부
		if(private1!="accept"){
			alert("개인정보 이용 동의를 하셔야 진행할 수 있습니다.");
			//$("#private1").focus();
			document.getElementsByName("private1")[0].focus();
			return false;
		}
		if(private3!="accept"){
			alert("개인정보 제3자 제공 동의를 하셔야 진행할 수 있습니다.");
			//$("#private2").focus();
			document.getElementsByName("private3")[0].focus();
			return false;
		}			
		if(private2!="accept"){
			alert("이용약관 동의를 하셔야 진행할 수 있습니다.");
			//$("#private2").focus();
			document.getElementsByName("private2")[0].focus();
			return false;
		}

			
		//상품 선택 현황
		if( chk == false ) {
			alert("상품을 선택해 주세요.");
			$("#order").focus();
			return false;
		}
		//이름
		if(nm == ""){
			alert("이름을 입력해 주세요.");
			$("#nm").focus();
			return false;
		}
		//휴대폰번호 
		if(hp1 == ""){
			alert("휴대폰번호를 입력해 주세요.");
			$("#hp1").focus();
			return false;
		}		
		if(hp2 == ""){
			alert("휴대폰번호를 입력해 주세요.");
			$("#hp2").focus();
			return false;
		}
		if(hp3 == ""){
			alert("휴대폰번호를 입력해 주세요.");
			$("#hp3").focus();
			return false;
		}
		
		
		if(campinga==false && campingb == true && chkcount ==1){
			if(startday == "" || endday == ""){
				alert("이용 희망일을 기재해 주세요.");
				$("#startday").focus();
				return false;			
			}
			if(startday != 10){
				alert("이용 시작일을 확인해주세요. 날짜 형식이 맞지않습니다.");
				$("#startday").focus();
				return false;
			}
			if(endday != 10){
				alert("이용 종료일을 확인해주세요. 날짜 형식이 맞지않습니다.");
				$("#endday").focus();
				return false;
			}			
		}
		else if(campinga==true && campingb == false && chkcount ==1){
			if(startday == "" || endday == ""){
				alert("이용 희망일을 기재해 주세요.");
				$("#startday").focus();
				return false;			
			}
			if(startday != 10){
				alert("이용 시작일을 확인해주세요. 날짜 형식이 맞지않습니다.");
				$("#startday").focus();
				return false;
			}
			if(endday != 10){
				alert("이용 종료일을 확인해주세요. 날짜 형식이 맞지않습니다.");
				$("#endday").focus();
				return false;
			}				
		}	
		else if(campinga==true && campingb == true && chkcount ==2){
			if(startday == "" || endday == ""){
				alert("이용 희망일을 기재해 주세요.");
				$("#startday").focus();
				return false;			
			}
			if(startday != 10){
				alert("이용 시작일을 확인해주세요. 날짜 형식이 맞지않습니다.");
				$("#startday").focus();
				return false;
			}
			if(endday != 10){
				alert("이용 종료일을 확인해주세요. 날짜 형식이 맞지않습니다.");
				$("#endday").focus();
				return false;
			}				
			
		}	
		else if(campinga==true && campingb == false && chkcount ==2){
			if(startday == "" || endday == ""){
				alert("이용 희망일을 기재해 주세요.");
				$("#startday").focus();
				return false;			
			}
			if(startday != 10){
				alert("이용 시작일을 확인해주세요. 날짜 형식이 맞지않습니다.");
				$("#startday").focus();
				return false;
			}
			if(endday != 10){
				alert("이용 종료일을 확인해주세요. 날짜 형식이 맞지않습니다.");
				$("#endday").focus();
				return false;
			}				
			
			//주소
			if(addr1 == ""){
				alert("주소를 입력해 주세요.");
				$("#addr1").focus();
				return false;
			}
			if(addr2 == ""){
				alert("주소를 입력해 주세요.");
				$("#addr2").focus();
				return false;
			}			
		}	
		else if(campinga==false && campingb == true && chkcount ==2){
			if(startday == "" || endday == ""){
				alert("이용 희망일을 기재해 주세요.");
				$("#startday").focus();
				return false;			
			}
			if(startday != 10){
				alert("이용 시작일을 확인해주세요. 날짜 형식이 맞지않습니다.");
				$("#startday").focus();
				return false;
			}
			if(endday != 10){
				alert("이용 종료일을 확인해주세요. 날짜 형식이 맞지않습니다.");
				$("#endday").focus();
				return false;
			}				
			
			//주소
			if(addr1 == ""){
				alert("주소를 입력해 주세요.");
				$("#addr1").focus();
				return false;
			}
			if(addr2 == ""){
				alert("주소를 입력해 주세요.");
				$("#addr2").focus();
				return false;
			}	
		}	
		else if(campinga==false && campingb == false && chkcount ==2){
			//주소
			if(addr1 == ""){
				alert("주소를 입력해 주세요.");
				$("#addr1").focus();
				return false;
			}
			if(addr2 == ""){
				alert("주소를 입력해 주세요.");
				$("#addr2").focus();
				return false;
			}
		}else{
			//주소
			if(addr1 == ""){
				alert("주소를 입력해 주세요.");
				$("#addr1").focus();
				return false;
			}
			if(addr2 == ""){
				alert("주소를 입력해 주세요.");
				$("#addr2").focus();
				return false;
			}
		}				

		
		if(amt == ""){
			alert("여행상품권 금액을 입력해 주세요.");
			$("#amt").focus();
			return false;
		}
	

		var mst_dataset = {
				  nm	 			: $("#nm").val()
				, hp 				: $("#hp1").val()+$("#hp2").val()+$("#hp3").val()
				, addr1 			: $("#addr1").val()
				, addr2 			: $("#addr2").val()					
				, amt				: amt
				, totamt			: totamt
				, post				: $("#post").val()
				, privateyn 		: 'Y'
				,cnt				: String(chkcount)
				,productnm			: productNm
				,in_day             : in_day
				,out_day            : out_day
				//,email				: 'khhan@lottejtb.com' //한경호책임
				,email				: 'yslee2@lottejtb.com'//이용성대리
				//n = parseInt(str.replace(/,/g,""));
			};		
			
		var jsonDataMst = JSON.stringify(mst_dataset);
		
		$.ajax({
			url			: '/page/myomee/insertOrderApply.do', 
			type 		: 'post', 
			//data 		: {"mst" : jsonDataMst, "dtl" : jsonDataDtl3},
			data 		: {"mst" : jsonDataMst},
			dataType 	: 'json', 
			cache		: false,
			success 	: function (data){ 

				if(data.result) {
					//저장
					alert("주문이 성공적으로 신청되었습니다.");
					location.href = "/page/myomee/insertOrderApply.do";
					window.location.reload();//페이지 새로고침
				}else{
					//에러
					alert("신청 중 오류가 발생했습니다. 다시 시도해주세요.\n오류가 계속되면 관리자에게 문의해주세요."); 
				}
			}, 
			error : function(a,b,c){ 
				alert("알수없는 예외가 발생했습니다."); 
			} 
		});


	}
	


	//체크박스 선택 후 금액 계산
	function totalAmt(frm,productNm,no,amt,productNo){
		
	   var sum = 0;//합계금액
	   var total=0;
	   var product;//제품명
	   var count = frm.chk.length;//체크된갯수  

	   for(var i=0; i < count; i++ ){
		   if( frm.chk[i].checked == true ){
			sum += parseInt(frm.chk[i].value);
		   }
	   }
	   //총금액표기
	   document.getElementById("total_price").innerHTML = comma(sum);
	   

	   //제품명,금액 표기
	   for(var i=0; i < count; i++ ){
		   if( frm.chk[i].checked == true ){
				document.getElementById("no"+i).style.display="flex";
				console.log("name : "+document.getElementById("name"+i).value);
				console.log("amt : "+comma(frm.chk[i].value));
				console.log("i : "+i);
				document.getElementById("productNm"+i).innerHTML = document.getElementById("name"+i).value ;
				document.getElementById("productAmt"+i).innerHTML = comma(frm.chk[i].value);	
		   }
		   if( frm.chk[i].checked == false ){
				document.getElementById("no"+i).style.display="none";
		   }
	    }

	}

	//금액 콤마 표시 
	function comma(num){
	
		var len, point, str; 
		   
		num = num + ""; 
		point = num.length % 3 ;
		len = num.length; 
	   
		str = num.substring(0, point); 
		while (point < len) { 
			if (str != "") str += ","; 
			str += num.substring(point, point + 3); 
			point += 3; 
		} 
		 
		return str;
	 
	}
	
	//문자입력방지 및 숫자comma
	function inputNumberAutoComma(obj) {
		
		var number = obj.value;
		var integer = obj.value;
		var point = number.indexOf(".");
		var decimal = "";
		var chekcd = "";

		// 첫번째 수부터 소수점 기호( . )를 사용 방지
		if(number.charAt(0) == ".") {
			alert("첫번째 수부터 소수점 기호( . )를 사용할 수 없습니다.");
			obj.value = "";
			return false;
		}
		
		// 소수점이 존재하면 태우는 분기
		if(point > 0) {

			// 소수점 앞 자리값만을 따로 담는다.
			integer = number.substr(0, point);

			// 소수점 아래 자리값만을 따로 담는다.
			decimal = number.substr((point + 1), number.length);
			chekcd = inputNumberisFinit(decimal);

			if(chekcd == "N") {
				alert("문자는 입력하실 수 없습니다.");
				obj.value = "";
				return false;
			}
		}

		// 정수형의 콤마를 제거한다.
		integer = integer.replace(/\,/g, "");
		chekcd = inputNumberisFinit(integer);

		if(chekcd == "N") {
			alert("문자는 입력하실 수 없습니다.");
			obj.value = "";
			return false;
		}

		// 정수형을 한번더 점검한다.
		integer = inputNumberWithComma(inputNumberRemoveComma(integer));
		
		// 소수가 존재하면 나누었던 콤마 기호를 삽입한다.
		if(point > 0) {
			obj.value = integer + "." + decimal;
		}
		
		// 소수가 존재하지 않는다면 콤마값을 넣은 정수만 삽입한다.
		else {
			obj.value = integer;
		}
	}

	// 천단위 이상의 숫자에 콤마( , )를 삽입하는 함수
	function inputNumberWithComma(str) {
		str = String(str);
		return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,");
	}

	// 콤마( , )가 들어간 값에 콤마를 제거하는 함수
	function inputNumberRemoveComma(str) {
		str = String(str);
		return str.replace(/[^\d]+/g, "");
	}

	// 문자 여부를 확인하고 문자가 존재하면 N, 존재하지 않으면 Y를 리턴한다.
	function inputNumberisFinit(str) {
		if(isFinite(str) == false) {
			return "N";
		} else {
			return "Y";
		}
	}	
	
	//우편번호 주소API
	function onPost(){
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("addr2").value = extraAddr;
                
                } else {
                    document.getElementById("addr2").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('post').value = data.zonecode;
                document.getElementById("addr1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("addr2").focus();
            }
        }).open();
	}
	
	//캠핑카 팝업
	function compingPop	(){
		window.open("https://fit.lottejtb.com/common/js/page/myomee/assets/img/hotel/C28detail.jpg","","width=2469,height=1648,toolbar=no,menubar=no,location=no,scrollbars=yes,status=no,resizable=yes");		
	}	
	
	//캠핑카 클릭 시 주소,일자 display 변경
	function clickCamping(val){
		
		var campinga = jQuery("input:checkbox[id='ck59']").is(":checked");
		var campingb = jQuery("input:checkbox[id='ck60']").is(":checked");
		var chkcount = $("input:checkbox[name=chk]:checked").length;

		if(campinga==false && campingb == true && chkcount ==1){
			document.getElementById("rent").style.display="flex";
			document.getElementById("addr").style.display="none";
		}
		else if(campinga==true && campingb == false && chkcount ==1){
			document.getElementById("rent").style.display="flex";
			document.getElementById("addr").style.display="none";
		}	
		else if(campinga==true && campingb == true && chkcount ==2){
			document.getElementById("rent").style.display="flex";
			document.getElementById("addr").style.display="none";
		}	
		else if(campinga==true && campingb == false && chkcount ==2){
			document.getElementById("rent").style.display="flex";
			document.getElementById("addr").style.display="flex";
		}	
		else if(campinga==false && campingb == true && chkcount ==2){
			document.getElementById("rent").style.display="flex";
			document.getElementById("addr").style.display="flex";
		}	
		else if(campinga==false && campingb == false && chkcount ==2){
			document.getElementById("rent").style.display="none";
			document.getElementById("addr").style.display="flex";
		}else{
			document.getElementById("rent").style.display="none";
			document.getElementById("addr").style.display="flex";
		}			
		
		//document.getElementById("rent").style.display="flex";
		//document.getElementById("addr").style.display="none";		

	}
	
	//날짜형식 포멧
	function chgDate(el){
		 el.value = el.value.replace(/(\d\d\d\d)(\d\d)(\d\d)/g, '$1-$2-$3');
	}



	
	
</script>