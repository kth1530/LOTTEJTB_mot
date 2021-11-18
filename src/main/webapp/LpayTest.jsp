<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript" src="http://10.141.1.40/js/js2015/jquery-1.11.0.min.js"></script>
<script type="text/javascript">
  var jobj;
function returnlpayMemCertIf( data ){
  jobj =  eval("("+data+")");

  
  if(jobj["RESULT_VAL"] == 'S'){
	$("#paymentInfo option").remove();
	var paymentList = jobj["MEMBER_CARD_LIST"];
	for(var i =0;i <jobj["dbio_total_count_"]; i++){
	  	$("#paymentInfo").append("<option value='"+i+"'>"+paymentList[i]["F_C_NM"]+"</option>");
	  }
  }else{
	alert('사용자 인증에 실패했습니다.');
	$("#paymentInfo option").remove();
	$("#paymentInfo").append("<option value=''>결제수단이 없습니다</option>");
  }
  
}

function lpayMemCertIf(){
	document.lpayMemCertIf.P_REQ_NM.value = encodeURI(document.lpayMemCertIf.P_REQ_NM_org.value); 
	document.lpayMemCertIf.returnURL.value ="http://10.141.1.63:38180/returnlpayMemCertIf.jsp"
    document.lpayMemCertIf.action="http://10.141.1.40/jsp/lpay/lpayMemCertIf.faces";
	document.lpayMemCertIf.submit();
}
function returnlpayTranCertIf(data){

	var dlp =  eval("("+data+")");
	
	if(dlp["RESULT_VAL"] == 'S'){
	//alert('?');
	document.dlp.a.value = dlp['a'];
	document.dlp.b.value = dlp['b'];
	document.dlp.c.value = dlp['c'];
	document.dlp.d.value = dlp['d'];
	document.dlp.e.value = dlp['e'];
	document.dlp.f.value = dlp['f'];
	document.dlp.g.value = dlp['g'];
	document.dlp.setKey.value = dlp['setKey'];
	document.dlp.INST_CHO_CD.value = dlp['INST_CHO_CD'];
	document.dlp.SUM_GD_NM_org.value = dlp['P_REQ_NM'];
	document.dlp.P_REQ_HP_NUM.value = dlp['P_REQ_HP_NUM'];
	document.dlp.P_REQ_NM_org.value = dlp['SUM_GD_NM'];
	
	document.dlp.P_REQ_NM.value = encodeURI(document.dlp.P_REQ_NM_org.value); 
    document.dlp.SUM_GD_NM.value = encodeURI(document.dlp.SUM_GD_NM_org.value); 
    
	document.dlp.returnURL.value ="http://10.141.1.63:38180/returnDLP.jsp"
	document.dlp.action="http://10.141.1.40/jsp/lpay/lpay_json.jsp";
	document.dlp.submit();
	}else{
		alert('인증에 실패했습니다.');
	}
	
}

function returdlp(data){

	var resdlp =  eval("("+data+")");
 document.lpayAprvIf.PR_TYPE_CD.value = resdlp['PR_TYPE_CD'];
 document.lpayAprvIf.MEM_M_NUM.value = resdlp['MEM_M_NUM'];

 document.lpayAprvIf.P_REQ_ID.value = resdlp['P_REQ_ID'];
 document.lpayAprvIf.M_TX_NUM.value = resdlp['M_TX_NUM'];

 document.lpayAprvIf.P_REQ_HP_NUM.value = resdlp['P_REQ_HP_NUM'];
 document.lpayAprvIf.P_M_DIV_CD.value = resdlp['P_M_DIV_CD'];
 
 var F_CO_CD =  (resdlp['F_CO_CD'] += "");
	if(F_CO_CD.length ==1){
		F_CO_CD ='0'+F_CO_CD;
	}
	
 document.lpayAprvIf.F_CO_CD.value = F_CO_CD;

 document.lpayAprvIf.P_M_ID.value = resdlp['P_M_ID'];
 document.lpayAprvIf.P_M_NUM.value = resdlp['P_M_NUM'];
 document.lpayAprvIf.P_C_MID.value = resdlp['P_C_MID'];
 document.lpayAprvIf.INST_CHO_CD.value = resdlp['INST_CHO_CD'];
 document.lpayAprvIf.IMONTH_NUM.value = resdlp['IMONTH_NUM'];
 document.lpayAprvIf.REQ_AMT.value = resdlp['REQ_AMT'];
 document.lpayAprvIf.OTC_NUM.value = resdlp['OTC_NUM'];
 document.lpayAprvIf.CAVV.value = resdlp['CAVV'];
 document.lpayAprvIf.ECI.value = resdlp['ECI'];
 document.lpayAprvIf.P_M_DIV_CD.value = resdlp['P_M_DIV_CD'];
 document.lpayAprvIf.XID.value = resdlp['XID'];
 document.lpayAprvIf.TR_ID.value = resdlp['TR_ID'];
 document.lpayAprvIf.CARD_YYMM.value = resdlp['CARD_YYMM'];
 
  document.lpayAprvIf.P_REQ_NM_org.value = resdlp['P_REQ_NM'];
  document.lpayAprvIf.SUM_GD_NM_org.value = resdlp['SUM_GD_NM'];
  document.lpayAprvIf.P_M_ANM_org.value = resdlp['P_M_ANM'];
  document.lpayAprvIf.F_C_NM_org.value = resdlp['F_C_NM'];
  
  
  document.lpayAprvIf.P_REQ_NM.value = encodeURI(document.lpayAprvIf.P_REQ_NM_org.value); 
  document.lpayAprvIf.SUM_GD_NM.value = encodeURI(document.lpayAprvIf.SUM_GD_NM_org.value);
  document.lpayAprvIf.P_M_ANM.value = encodeURI(document.lpayAprvIf.P_M_ANM_org.value);
  document.lpayAprvIf.F_C_NM.value = encodeURI(document.lpayAprvIf.F_C_NM_org.value);  
  
  document.lpayAprvIf.returnURL.value ="http://10.141.1.63:38180/returnlpayAprvIf.jsp"
  document.lpayAprvIf.action="http://10.141.1.40/jsp/lpay/lpayAprvIf.faces";
  document.lpayAprvIf.submit();
 
}

function returnlpayAprvIf(data){
 var res =  eval("("+data+")");
 
  if(res["RESULT_VAL"] == 'S'){
  	alert('성공');
  }else{
  	alert('실패');
  }
  
}

function lpayTranCertIf(){
	var payment =  jobj["MEMBER_CARD_LIST"][$("#paymentInfo").val()];
    
    document.lpayTranCertIf.P_REQ_NM.value = encodeURI(document.lpayTranCertIf.P_REQ_NM_org.value); 
    document.lpayTranCertIf.SUM_GD_NM.value = encodeURI(document.lpayTranCertIf.SUM_GD_NM_org.value); 
	var F_CO_CD =  (payment['F_CO_CD'] += "");
	if(F_CO_CD.length ==1){
		F_CO_CD ='0'+F_CO_CD;
	}
    document.lpayTranCertIf.P_M_DIV_CD.value = payment['P_M_DIV_CD'];
    document.lpayTranCertIf.F_CO_CD.value =F_CO_CD;
    document.lpayTranCertIf.F_C_NM_org.value = payment['F_C_NM'];
    document.lpayTranCertIf.P_M_ID.value = payment['P_M_ID'];
    document.lpayTranCertIf.P_M_ANM_org.value = payment['P_M_ANM'];
    document.lpayTranCertIf.P_M_ANM.value = encodeURI(document.lpayTranCertIf.P_M_ANM_org.value);
    document.lpayTranCertIf.F_C_NM.value = encodeURI(document.lpayTranCertIf.F_C_NM_org.value);  
    
    document.lpayTranCertIf.REQ_AMT.value =document.lpayTranCertIf.GDS_TOT_AMT.value;
    document.lpayTranCertIf.returnURL.value ="http://10.141.1.63:38180/returnlpayTranCertIf.jsp"
    document.lpayTranCertIf.action="http://10.141.1.40/jsp/lpay/lpayTranCertIf.faces";
	document.lpayTranCertIf.submit();
}
function returnlpayCnclIf(data){

	var res =  eval("("+data+")");
 
	if(res["RESULT_VAL"] == 'S'){
		alert('성공');
	}else{
		alert('실패');
	}
}



function lpayCnclIf(){

	document.lpayCnclIf.action="http://10.141.1.40/jsp/lpay/lpayCnclIf.faces";
	 document.lpayCnclIf.returnURL.value ="http://10.141.1.63:38180/returnlpayCnclIf.jsp"
	document.lpayCnclIf.submit();
}
</script>
	
	<a href="javascript:lpayMemCertIf();">맴버인증</a>
	
	<form id="lpayMemCertIf" name="lpayMemCertIf"  method="post" target="sub">
	결제요청타입코드(PR_TYPE_CD) : <input type="text" id="PR_TYPE_CD" name="PR_TYPE_CD" value="6000001"/>
	<br/>
	멤버스 고객번호(MEM_M_NUM):<input type="text" id="MEM_M_NUM" name="MEM_M_NUM" value="1100020289"/>
	<br/>
	결제요청자명(P_REQ_NM) : <input type="text" id="P_REQ_NM_org" name="P_REQ_NM_org" value="김향기"/>
	<br/>
	결제요청자 휴대폰번호(P_REQ_HP_NUM) : <input type="text" id="P_REQ_HP_NUM" name="P_REQ_HP_NUM" value="010265339"/>
	<br/>
	P_REQ_NM :<input type="text" id="PAYOR_HP_NUM" name="PAYOR_HP_NUM" value=""/>
	<input type="hidden" id="returnURL" name="returnURL" value=""/>
	<input type="hidden" id="P_REQ_NM" name="P_REQ_NM" value=""/>
	<br/>
	</form>
	
<select id="paymentInfo" name="paymentInfo">
  <option value="">결제수단이 없습니다.</option>
</select>
<br/>

<a href="javascript:lpayTranCertIf();">거래인증</a>
	<br/>
	<form id="lpayTranCertIf" name="lpayTranCertIf"  method="post" target="sub">
	결제요청자 휴대폰번호(PR_TYPE_CD) : <input type="text" id="PR_TYPE_CD" name="PR_TYPE_CD" value="6000001"/>
	<br/>
	가맹점 거래번호(M_TX_NUM) : <input type="text" id="M_TX_NUM" name="M_TX_NUM" value="p12341234"/>
	<br/>
	멤버스 고객번호(MEM_M_NUM) : <input type="text" id="MEM_M_NUM" name="MEM_M_NUM" value="1100020289"/>
	<br/>
	요약 상품명(SUM_GD_NM) : <input type="text" id="SUM_GD_NM_org" name="SUM_GD_NM_org" value="test상품"/>
	<input type="hidden" id="SUM_GD_NM" name="SUM_GD_NM" value="test상품"/>
	<br/>
	상품금액(총거래금액)(GDS_TOT_AMT) : <input type="text" id="GDS_TOT_AMT" name="GDS_TOT_AMT" value="110"/>
	<br/>
	공급금액(GDS_SUP_AMT) : <input type="text" id="GDS_SUP_AMT" name="GDS_SUP_AMT" value="100"/>
	<br/>
	부가세(GDS_VAT) : <input type="text" id="GDS_VAT" name="GDS_VAT" value="10"/>
	<br/>
	봉사료(PSC_AMT) : <input type="text" id="PSC_AMT" name="PSC_AMT" value=""/>
	<br/>
	<br/>
	결제요청자명(P_REQ_NM) : <input type="text" id="P_REQ_NM_org" name="P_REQ_NM_org" value="김향기"/>
	<input type="hidden" id="P_REQ_NM" name="P_REQ_NM" value=""/>
	<br/>
	결제요청자 휴대폰번호(P_REQ_HP_NUM) : <input type="text" id="P_REQ_HP_NUM" name="P_REQ_HP_NUM" value="010265339"/>
	
	<br/>P_M_DIV_CD:<input type="text" id="P_M_DIV_CD" name="P_M_DIV_CD" value=""/>
	<br/>F_CO_CD:<input type="text" id="F_CO_CD" name="F_CO_CD" value=""/>
	<br/>F_C_NM:<input type="text" id="F_C_NM_org" name="F_C_NM_org" value=""/>
<input type="hidden" id="F_C_NM" name="F_C_NM" value=""/>
	<br/>P_M_ID:<input type="text" id="P_M_ID" name="P_M_ID" value=""/>
	<br/>P_M_ANM:<input type="text" id="P_M_ANM_org" name="P_M_ANM_org" value=""/>
<input type="hidden" id="P_M_ANM" name="P_M_ANM" value=""/>
	<br/>INST_CHO_CD:<input type="text" id="INST_CHO_CD" name="INST_CHO_CD" value="6100001"/>
	<br/>IMONTH_NUM:<input type="text" id="IMONTH_NUM" name="IMONTH_NUM" value="00"/>
	<br/>REQ_AMT:<input type="text" id="REQ_AMT" name="REQ_AMT" value=""/>
	<input type="hidden" id="returnURL" name="returnURL" value=""/>
	</form>
<form id="dlp" name="dlp"  method="post" target="sub">
	<br/>a:<input type="text" id="a" name="a" value=""/>
	<br/>b:<input type="text" id="b" name="b" value=""/>
	<br/>c:<input type="text" id="c" name="c" value=""/>
	<br/>d:<input type="text" id="d" name="d" value=""/>
	<br/>e:<input type="text" id="e" name="e" value=""/>
	<br/>f:<input type="text" id="f" name="f" value=""/>
	<br/>g:<input type="text" id="g" name="g" value=""/>
	<br/>setKey:<input type="text" id="setKey" name="setKey" value=""/>
	<br/>INST_CHO_CD:<input type="text" id="INST_CHO_CD" name="INST_CHO_CD" value=""/>
	<br/>P_REQ_NM:<input type="text" id="P_REQ_NM_org" name="P_REQ_NM_org" value=""/>
	<input type="hidden" id="P_REQ_NM" name="P_REQ_NM" value=""/>
	<br/>P_REQ_HP_NUM:<input type="text" id="P_REQ_HP_NUM" name="P_REQ_HP_NUM" value=""/>
	<br/>SUM_GD_NM:<input type="text" id="SUM_GD_NM_org" name="SUM_GD_NM_org" value=""/>
	<input type="hidden" id="SUM_GD_NM" name="SUM_GD_NM" value=""/>
	<input type="hidden" id="returnURL" name="returnURL" value=""/>
</form>

<form id="lpayAprvIf" name="lpayAprvIf"  method="post" target="sub">
<br/>PR_TYPE_CD:<input type="text" id="PR_TYPE_CD" name="PR_TYPE_CD" value=""/>
<br/>MEM_M_NUM:<input type="text" id="MEM_M_NUM" name="MEM_M_NUM" value=""/>
<br/>SUM_GD_NM:<input type="text" id="SUM_GD_NM_org" name="SUM_GD_NM_org" value=""/>
	<input type="hidden" id="SUM_GD_NM" name="SUM_GD_NM" value=""/>
<br/>P_REQ_ID:<input type="text" id="P_REQ_ID" name="P_REQ_ID" value=""/>
<br/>M_TX_NUM:<input type="text" id="M_TX_NUM" name="M_TX_NUM" value=""/>
<br/>P_REQ_NM: <input type="text" id="P_REQ_NM_org" name="P_REQ_NM_org" value=""/>
	<input type="hidden" id="P_REQ_NM" name="P_REQ_NM" value=""/>
<br/>P_REQ_HP_NUM:<input type="text" id="P_REQ_HP_NUM" name="P_REQ_HP_NUM" value=""/>
<br/>P_C_MID:<input type="text" id="P_C_MID" name="P_C_MID" value=""/>
<br/>P_M_DIV_CD:<input type="text" id="P_M_DIV_CD" name="P_M_DIV_CD" value=""/>
<br/>F_CO_CD:<input type="text" id="F_CO_CD" name="F_CO_CD" value=""/>
<br/>F_C_NM:<input type="text" id="F_C_NM_org" name="F_C_NM_org" value=""/>
<input type="hidden" id="F_C_NM" name="F_C_NM" value=""/>
<br/>P_M_ID:<input type="text" id="P_M_ID" name="P_M_ID" value=""/>
<br/>P_M_NUM:<input type="text" id="P_M_NUM" name="P_M_NUM" value=""/>
<br/>P_M_ANM:<input type="text" id="P_M_ANM_org" name="P_M_ANM_org" value=""/>
<input type="hidden" id="P_M_ANM" name="P_M_ANM" value=""/>
<br/>INST_CHO_CD:<input type="text" id="INST_CHO_CD" name="INST_CHO_CD" value=""/>
<br/>IMONTH_NUM:<input type="text" id="IMONTH_NUM" name="IMONTH_NUM" value=""/>
<br/>REQ_AMT:<input type="text" id="REQ_AMT" name="REQ_AMT" value=""/>
<br/>OTC_NUM:<input type="text" id="OTC_NUM" name="OTC_NUM" value=""/>
<br/>CAVV:<input type="text" id="CAVV" name="CAVV" value=""/>
<br/>ECI:<input type="text" id="ECI" name="ECI" value=""/>
<br/>XID:<input type="text" id="XID" name="XID" value=""/>
<br/>TR_ID:<input type="text" id="TR_ID" name="TR_ID" value=""/>
<br/>CARD_YYMM:<input type="text" id="CARD_YYMM" name="CARD_YYMM" value=""/>
<input type="hidden" id="returnURL" name="returnURL" value=""/>
</form>

<a href="javascript:lpayCnclIf();">거래취소</a>
<form id="lpayCnclIf" name="lpayCnclIf"  method="post" target="sub">
<br/>P_REQ_ID:<input type="text" id="P_REQ_ID" name="P_REQ_ID" value=""/>
<input type="hidden" id="returnURL" name="returnURL" value=""/>
</form>
<iframe id="sub" name="sub"  width="1000" height="1000"  >
</iframe>
</body>
</html>