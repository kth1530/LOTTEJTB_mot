<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../common/commTagLib.jsp"%>
<head>
<script type="text/javascript" src="https://maps.google.com/maps/api/js?v=3.exp&region=KR&key=AIzaSyD7Ofh1fQwL-osDzzlbdvRjvlG2Y8-nEyU"></script>
<script type="text/javascript">
$(document).ready(function(){
	var testData = {
		"testAir" : 
			[{	name : "testname", 
				id : "testid", 
				paxList : 	
					[	{code : "testcode", 
						cont : "testcont"}, 
						{code : "testcode2", 
						cont : "testcont2"
					}]
			}]
	};	
	
	var testData2 = new FormData();
	/* testData2.append('headDto', {deviceCd : "testCd"});
	testData2.append('bodyDto', {availTy : "testTy"});
	testData2.append('availDto', {arrCtNm : "testNm"});
	 */
	 
	testData2.append('testAir' , [{name : "testname", id : "testid", paxList : [{code : "testcode", cont : "testcont"}, {code : "testcode2", cont : "testcont2"}]}]);
	//testData2.append('data', [{birthDt : "12345678", cabinClas : "whgdmsrj"}]);
		
	
	gfn_callAjax ('/fit/air/testSearchAjax.do', testData, 'console.log');
	
	
	var listData = new FormData();
	listData.append('errCd', 'test1');
	listData.append('errMsg', 'test2');
	listData.append('SysErrCd', 'test3');
	
	gfn_callAjax ('/fit/air/listSearchAjax.do', listData, 'console.log');
	
	var listData2 = {
			errCd : "testist1",
			errMsg : "testist2",
			sysErrCd : "testist3",
			programId : "testist4"
	};
	gfn_callAjax ('/fit/air/listSearchAjax.do', listData2, 'console.log');
});

function fn_fareCerti (_obj) {
	var cdata = $(_obj).parent().attr('ar-data');
	gfn_callAjax ('/fit/air/viewFareCerti.do', cdata, 'fn_showCertiPop');
}

function fn_showCertiPop (_data) {
	var tmpStr = '';
	for (i=0; i<_data.fareCerti.title.length; i++) {
		tmpStr = tmpStr + _data.fareCerti.title[i] + ' : ' + _data.fareCerti.contents[i] + '<br/>'; 
	}
	$('#fareCertiPop').find('#certi_con').html(tmpStr);
	$('#fareCertiPop').show();
}

function fn_detail (_obj) {
	var cdata = $(_obj).parent().attr('ar-data');
	gfn_callAjax ('/fit/air/viewInfo.do', cdata, 'fn_showDetailPop');
}

function fn_showDetailPop (_data) {
	$('#fareDetailPop').show();
}

function fn_sel (_obj) {
	location.href = '/fit/rsv/selList.do';
}

function gfn_callAjax (_url, _data, _fn_scs) {
	$.ajax({
        url: "<c:url value='" + _url + "' />",
        type: 'POST',
        data: _data,
        async: false,
        cache: false,
        dataType : "json",
        contentType: false,
        processData: false,
        success: function (data,status) {
        	eval(_fn_scs)(data);
        },
        error : function(request,status){
        	console.log('request : ' + request);
        	console.log('status : ' + status);
        }
    });
}
</script>
</head>
<body>
<h1>항공 검색 페이지</h1>
<div ar-att="fare_div" ar-data="1">
	<a onclick="fn_fareCerti(this);" style="cursor: pointer;">요금규정</a><br/>
	<a onclick="fn_detail(this);" style="cursor: pointer;">상세보기</a><br/>
	<a onclick="fn_sel(this);" style="cursor: pointer;">선택하기</a><br/>
</div>
<div ar-att="fare_div" ar-data="2">
	<a onclick="fn_fareCerti(this);" style="cursor: pointer;">요금규정</a><br/>
	<a onclick="fn_detail(this);" style="cursor: pointer;">상세보기</a><br/>
	<a onclick="fn_sel(this);" style="cursor: pointer;">선택하기</a><br/>
</div>
<div id="fareCertiPop" style="border: 1px solid; width: 100px; display: none; position: absolute;">
	<p>요금규정 팝업<a style="cursor: pointer;" onclick="$(this).parents('#fareCertiPop').hide();">닫기</a></p><br/>
	<span id="certi_con"></span>
</div>
<div id="fareDetailPop" style="border: 1px solid; width: 100px; display: none; position: absolute;">
	<p>상세보기 팝업<a style="cursor: pointer;" onclick="$(this).parents('#fareDetailPop').hide();">닫기</a></p><br/>
</div>
</body>