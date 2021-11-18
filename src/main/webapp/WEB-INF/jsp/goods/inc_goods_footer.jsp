<%@ page language='java' contentType='text/html; charset=UTF-8'
    pageEncoding='UTF-8'%>
<%
// 파일명 : inc_goods_footer.jsp
// 설명 : 상품 상세 하단 풋터 부분 
%>	
    <!-- footer /common/js/footer2.js 파일 가져옴 -->
		<a href="#"  class="go-top"><i class="fa fa-angle-up"></i></a>
		<div  class="gfoot"  data-position="fixed" data-tap-toggle="false" data-role="footer" >
			<ul>
				<li style="background:#f7415b">
					<a href="javascript:fn_goMaster()"><img src="/resources/images/btn/Footer_goods_calendar.png" alt="" border="0"/></a>
				</li>
				<li style="background:#7040b3">
					<a href="javascript:alert(\'서비스 준비중입니다.'\)" data-rel="back"><img src="/resources/images/btn/Footer_goods_air.png" alt="" border="0"/></a>
				</li>
				<li style="width:60%;background:#353163">
					<a href="javascript:fn_goReserve()" class="img"><img src="/resources/images/btn/Footer_goods_reserve.png" alt="" border="0"/>예약하기</a>
				</li>
			</ul>
		</div>
	<!--panel /common/js/pannel.js 파일 가져옴-->