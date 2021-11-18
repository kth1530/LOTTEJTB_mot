<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@page import="java.net.URLDecoder"%>
<%@ page import = "com.tmax.prowave.adapter.*" %>

<%
	//�Ķ���� �� ����
	String query = request.getQueryString();
	 
	String[] params = query.split("&");//�Ķ���� �и�
	java.util.Map<String, String> map = new java.util.HashMap<String, String>();   
	for (String param : params) {   
		String name = param.split("=")[0];   
		String value = param.split("=")[1];   
		map.put(name, value);   
	}   
	
	String cardType = URLDecoder.decode(map.get("cardType"), "euc-kr");//ī������
	String trType = URLDecoder.decode(map.get("trType"), "euc-kr"); //�ŷ�����
	String custNm = URLDecoder.decode(map.get("custNm"), "euc-kr");//����
	String goodsNm = URLDecoder.decode(map.get("goodsNm"), "euc-kr");//ǰ��
	
	String fromNm = map.get("fromNm");// �����»�� �̸�
	if (fromNm == null)
		fromNm = "";

	
	String personAuthCode = request.getParameter("personAuthCode"); // ��������
	if ( personAuthCode == null )
		personAuthCode = "";
	else if ( personAuthCode.length() == 13 ) // �ֹι�ȣ�� ��� ���ڸ� ����	
		personAuthCode = personAuthCode.substring(0,6)	+ "-*******";
	else {
		int len = personAuthCode.length();
		personAuthCode = personAuthCode. substring(0,len-4)	+ "****";
	}	
		
	String trdDate = request.getParameter("trdDate"); // �ŷ�����
	if ( trdDate == null ){
		trdDate = "";
	}else{
	}
	
	String pubDate = request.getParameter("pubDate"); // ��������
	if ( pubDate == null )
		pubDate = "";	
	else {
	}	
	
	String apprCode = request.getParameter("apprCode"); // ���ι�ȣ
	if ( apprCode == null )
		apprCode = "";
	
	String supplyAmt = ""; // �ݾ�
	supplyAmt = request.getParameter("supplyAmt");
	if ( supplyAmt == null )
		supplyAmt = "";
		
	String vat = ""; // �ΰ���
	vat = request.getParameter("vat");
	if ( vat == null )
		vat = "";
		
	String coverCharge = ""; // �����
	coverCharge = request.getParameter("coverCharge");
	if ( coverCharge == null )
		coverCharge = "";
		
	String totAmt = ""; // �հ�
	totAmt = request.getParameter("totAmt");
	if ( totAmt == null )
		totAmt = "";
		
	String busiNo = ""; // ����� ��� ��ȣ
	busiNo = request.getParameter("busiNo");
	if ( busiNo == null )
		busiNo = "";
	
	String validTerm = ""; //��ȿ�Ⱓ
	validTerm = request.getParameter("validTerm");
	if ( validTerm == null )
		validTerm = "";

	

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>Travel&amp;Life LOTTEJTB</title>
<script type="text/javascript" src="http://www.lottejtb.com/js/js2015/jquery-1.11.0.min.js"></script>
<script src="http://www.lottejtb.com/js/js2015/mail_modal_box.js"></script>
<link href="http://www.lottejtb.com/css/popup.css" type="text/css" rel="stylesheet" />
<link href="http://www.lottejtb.com/css/css2015/common.css" type="text/css" rel="stylesheet" />
</head>
<%
	// �ݱ� ��ư ǥ�� ���� ( ���������� �Ѿ���� �ݱ� ��ư�� �Ⱥ����� )
	String closeShow = request.getParameter("closeShow");
	if ( "Y".equals(closeShow )){
		closeShow = "Y";
	}else{
		closeShow = "N";
	}
	
	//���������� ���� ����
	String resCd = request.getParameter("resCd");//�����ȣ
	
	//���������� ȣ��
	ChannelManager instance = ChannelManager.getInstance();
	Channel channel  = instance.getChannel();  		
	channel.setAnnotated(false);			
	
	channel.registerValue("RES_CD", resCd);//		
	channel.correspondWith("T2-CO/COCompanySO/searchCompanyInfo");	
	
	//���������� ����� ����
	busiNo = (String) channel.lookupValue("BUSI_NO");//����ڹ�ȣ
	if ( busiNo.length() == 10 ) {
		String temp = busiNo;
		busiNo = temp.substring(0,3) + "-" + temp.substring(3,5) + "-" + temp.substring(5,10);
	}	
		
	String repreNm = (String) channel.lookupValue("REPRE_NM");//��ǥ��
	if ( repreNm == null )
		repreNm = "";
		
	String compNm = (String) channel.lookupValue("COMP_NM");//������
	if ( compNm == null )
		compNm = "";
		
	String compAddr1 = (String) channel.lookupValue("COMP_ADDR1");//�ּ�
	if ( compAddr1 == null )
		compAddr1 = "";


%>
 <%!
 public String printAmt(String str, int index) {
 	String temp = "";
 	if ( str != null && str.length() >= index ) {
 		temp = str.substring(str.length()-index,str.length()-index+1);
 	}
 	else
 		temp = "";
 	return temp;	
 }
  %>
<body>
<table width="800" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
    	<td>
    		<table width="800" border="0" cellspacing="0" cellpadding="0">
        		<tr>
          			<td align="left"><img src="http://www.lottejtb.com/images/img2015/mail/logo.gif" alt="lotte jtb" /></td>
          			<td align="right">          			
          				<pw:outputLink value="http://www.lottejtb.com/xhtml/index.xhtml" target="_blank">
          				<img src="http://www.lottejtb.com/images/img2015/mail/top_btn.gif" alt="Ȩ������ �ٷΰ���"  style="border:none" />
          				</pw:outputLink>          			          	       
          			</td>  
        		</tr>
      		</table>
      	</td>
  	</tr>
 	<tr>
    	<td style="border:1px solid #d1d1d1;padding:19px 0" align="center">
    		<table width="770" border="0" cellspacing="0" cellpadding="0">
        		<tr>
          			<td valign="top" style="background:url(http://www.lottejtb.com/images/img2015/mail/bg02.gif) no-repeat left top;height:113px;width:770px;padding:22px 0 0 119px">
          				<table width="100%" border="0" cellspacing="0" cellpadding="0">
              				<tr>
                				<td style="font-family: Malgun Gothic, Dotum, Verdana;font-size:16px;font-weight:bold;padding-bottom:10px;line-height:160%;color:#444;text-align:left;height: 119px;">���� �ȳ��ϼ���.<br />LOTTEJTB���� �����Ͻ� <span style="color:#b43785">�����ǰ�� ������</span> �Դϴ�.<br />�̿����ּż� �����մϴ�.</td>
              				</tr>              
            			</table>
            		</td>
        		</tr>
        		<tr>
          			<td align="center" style="padding: 20px 0 50px 0;">
          				<table width="418" border="0" cellspacing="0" cellpadding="0" style="border:1px solid #d1d1d1;" >
						  <tr>
						    <td>
						    	<div style="color  :#7b4eb9; background: url('http://www.lottejtb.com/images/img2015/content/print_bg.gif') no-repeat 0 0;height: 50px;">
										<p style="font-size: 18px;font-family:���� ���;color: #fff;padding: 15px 0 0 15px;font-weight: normal;font-weight: bold;">������</p>
									</div>
								</td>
						  </tr>
						  <tr>
						    <td style="padding-top: 5px;">
							    <img src="http://www.lottejtb.com/images/img2015/content/pop_logo.jpg" alt="LOTTE Holidays �Ե�Ȧ������" align="left" style="padding-left: 10px;">
							    
						    </td>
						  </tr>
						  <tr>
						    <td height="500" align="center" valign="middle"><table width="400" border="1" cellpadding="0" cellspacing="0" bordercolor="#dbdbdb">
						      <tr>
						        <td width="197" height="32" align="right" valign="bottom" background="http://www.lottejtb.com/images/popup/taxsave_card.gif" style="background-repeat:no-repeat;"><%=cardType %>&nbsp;</td>
						        <td width="197" height="32" align="right" valign="bottom" background="http://www.lottejtb.com/images/popup/taxsave_name.gif" style="background-repeat:no-repeat;"><%=custNm%>&nbsp;&nbsp;</td>
						      </tr>
						      <tr>
						        <td height="32" colspan="2" align="right" valign="bottom" background="http://www.lottejtb.com/images/popup/taxsave_03.gif" style="background-repeat:no-repeat;"><%=personAuthCode %>&nbsp;</td>
						        </tr>
						      <tr>
						        <td height="32" colspan="2" align="center" valign="middle"><table width="395" height="32" border="0" cellpadding="0" cellspacing="0">
						          <tr>
						            <td width="120" align="right" valign="bottom" background="http://www.lottejtb.com/images/popup/taxsave_04.gif" style="background-repeat:no-repeat;"><%=validTerm %></td>
						            <td width="1" bgcolor="#dbdbdb"></td>
						            <td width="140" align="right" valign="bottom" background="http://www.lottejtb.com/images/popup/taxsave_05.gif" style="background-repeat:no-repeat;"><%=trdDate%>&nbsp;</td>
						            <td width="1" bgcolor="#dbdbdb"></td>
						            <td align="right" valign="bottom" background="http://www.lottejtb.com/images/popup/taxsave_06.gif" style="background-repeat:no-repeat;">&nbsp;&nbsp;</td>
						          </tr>
						        </table></td>
						        </tr>
						      <tr>
						        <td height="32" align="right" valign="bottom" background="http://www.lottejtb.com/images/popup/taxsave_07.gif" style="background-repeat:no-repeat;"><%=trType%>&nbsp;&nbsp;</td>
						        <td height="32" align="right" valign="bottom" background="http://www.lottejtb.com/images/popup/taxsave_08.gif" style="background-repeat:no-repeat;"><%=goodsNm %>&nbsp;</td>
						      </tr>
						      <tr>
						        <td height="132" colspan="2" align="center" valign="middle" background="http://www.lottejtb.com/images/popup/taxsave_bg.gif" style="background-repeat:no-repeat;"><table width="395" border="0" cellspacing="0" cellpadding="0">
						          <tr>
									<td width="80" height="14" align="left" valign="middle"><img src="http://www.lottejtb.com/images/popup/taxsave_02_01.gif" width="47" height="11" /></td>
						            <td width="1" rowspan="11" bgcolor="#dbdbdb"></td>
						            <td width="90" rowspan="2" align="center" valign="middle">��&nbsp;&nbsp;�� </td>
						            <td width="1" rowspan="11" bgcolor="#dbdbdb"></td>
						            <td width="27" rowspan="2" align="center" valign="bottom" class="blackb"><%=printAmt(supplyAmt,8) %></td>
						            <td width="1" rowspan="11"><img src="http://www.lottejtb.com/images/popup/taxsave_dot_line.gif" width="1" height="131" /></td>
						            <td width="27" rowspan="2" align="center" valign="bottom" background="http://www.lottejtb.com/images/taxsave/taxsave_100.gif" class="blackb"><%=printAmt(supplyAmt,7) %></td>
						            <td width="1" rowspan="11" bgcolor="#dbdbdb"></td>
						            <td width="27" rowspan="2" align="center" valign="bottom" class="blackb"><%=printAmt(supplyAmt,6) %></td>
						            <td width="1" rowspan="11"><img src="http://www.lottejtb.com/images/popup/taxsave_dot_line.gif" width="1" height="131" /></td>
						            <td width="27" rowspan="2" align="center" valign="bottom" class="blackb"><%=printAmt(supplyAmt,5) %></td>
						            <td width="1" rowspan="11"><img src="http://www.lottejtb.com/images/popup/taxsave_dot_line.gif" width="1" height="131" /></td>
						            <td width="27" rowspan="2" align="center" valign="bottom" background="http://www.lottejtb.com/images/taxsave/taxsave_1000.gif" class="blackb"><%=printAmt(supplyAmt,4) %></td>
						            <td width="1" rowspan="11" bgcolor="#dbdbdb"></td>
						            <td width="27" rowspan="2" align="center" valign="bottom" class="blackb"><%=printAmt(supplyAmt,3) %></td>
						            <td width="1" rowspan="11"><img src="http://www.lottejtb.com/images/popup/taxsave_dot_line.gif" width="1" height="131" /></td>
						            <td width="27" rowspan="2" align="center" valign="bottom" class="blackb"><%=printAmt(supplyAmt,2) %></td>
						            <td width="1" rowspan="11"><img src="http://www.lottejtb.com/images/popup/taxsave_dot_line.gif" width="1" height="131" /></td>
						            <td width="27" rowspan="2" align="center" valign="bottom" background="http://www.lottejtb.com/images/popup/taxsave_won.gif" class="blackb"><%=printAmt(supplyAmt,1) %></td>
						          </tr>
						          <tr>
						            <td height="18" align="center"></td>
						          </tr>
									
						          <tr>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						          </tr>
						          <tr>
						            <td height="14" align="left" valign="middle"><img src="http://www.lottejtb.com/images/popup/taxsave_02_02.gif" width="47" height="11" /></td>
						            <td rowspan="2" align="center" valign="middle">�ΰ���</td>
						            <td rowspan="2" align="center" valign="bottom"><%=printAmt(vat,8) %></td>
						            <td rowspan="2" align="center" valign="bottom"><%=printAmt(vat,7) %></td>
						            <td rowspan="2" align="center" valign="bottom"><%=printAmt(vat,6) %></td>
						            <td rowspan="2" align="center" valign="bottom"><%=printAmt(vat,5) %></td>
						            <td rowspan="2" align="center" valign="bottom"><%=printAmt(vat,4) %></td>
						            <td rowspan="2" align="center" valign="bottom"><%=printAmt(vat,3) %></td>
						            <td rowspan="2" align="center" valign="bottom"><%=printAmt(vat,2) %></td>
						            <td rowspan="2" align="center" valign="bottom"><%=printAmt(vat,1) %></td>
						          </tr>
						          <tr>
						            <td height="18" align="center" valign="middle">&nbsp;</td>
						          </tr>
						          <tr>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						          </tr>
						          <tr>
						            <td height="14" align="left"><img src="http://www.lottejtb.com/images/popup/taxsave_02_03.gif" width="47" height="11" /></td>
						            <td rowspan="2" align="center" valign="middle">�����</td>
						            <td rowspan="2" align="center" valign="bottom"><%=printAmt(coverCharge,8) %></td>
						            <td rowspan="2" align="center" valign="bottom"><%=printAmt(coverCharge,7) %></td>
						            <td rowspan="2" align="center" valign="bottom"><%=printAmt(coverCharge,6) %></td>
						            <td rowspan="2" align="center" valign="bottom"><%=printAmt(coverCharge,5) %></td>
						            <td rowspan="2" align="center" valign="bottom"><%=printAmt(coverCharge,4) %></td>
						            <td rowspan="2" align="center" valign="bottom"><%=printAmt(coverCharge,3) %></td>
						            <td rowspan="2" align="center" valign="bottom"><%=printAmt(coverCharge,2) %></td>
						            <td rowspan="2" align="center" valign="bottom"><%=printAmt(coverCharge,1) %></td>
						          </tr>
						          <tr>
						            <td height="18" align="center">&nbsp;</td>
						          </tr>
						          <tr>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						            <td height="1" bgcolor="dbdbdb"></td>
						          </tr>
						          <tr>
						            <td height="14" align="left"><img src="http://www.lottejtb.com/images/popup/taxsave_02_04.gif" width="47" height="11" /></td>
						            <td rowspan="2" align="center" valign="middle">��&nbsp;&nbsp;��</td>
						            <td rowspan="2" align="center" valign="bottom"><%=printAmt(totAmt,8) %></td>
						            <td rowspan="2" align="center" valign="bottom"><%=printAmt(totAmt,7) %></td>
						            <td rowspan="2" align="center" valign="bottom"><%=printAmt(totAmt,6) %></td>
						            <td rowspan="2" align="center" valign="bottom"><%=printAmt(totAmt,5) %></td>
						            <td rowspan="2" align="center" valign="bottom"><%=printAmt(totAmt,4) %></td>
						            <td rowspan="2" align="center" valign="bottom"><%=printAmt(totAmt,3) %></td>
						            <td rowspan="2" align="center" valign="bottom"><%=printAmt(totAmt,2) %></td>
						            <td rowspan="2" align="center" valign="bottom"><%=printAmt(totAmt,1) %></td>
						          </tr>
						          <tr>
						            <td height="18" align="center">&nbsp;</td>
						          </tr>
						        </table></td>
						        </tr>
						      <tr>
						        <td height="32" align="left" valign="bottom" background="http://www.lottejtb.com/images/popup/taxsave_09.gif" style="background-repeat:no-repeat;"><%=repreNm%>&nbsp;</td>
						        <td height="32" align="right" valign="bottom" background="http://www.lottejtb.com/images/popup/taxsave_10.gif" style="background-repeat:no-repeat;"><%=apprCode%>&nbsp;</td>
						      </tr>
						      <tr>
						        <td height="32" align="center" valign="middle" background="http://www.lottejtb.com/images/popup/taxsave_11.gif" style="background-repeat:no-repeat;">&nbsp;</td>
						        <td height="32" align="right" valign="bottom" background="http://www.lottejtb.com/images/popup/taxsave_12.gif" style="background-repeat:no-repeat;"><%=compNm %>&nbsp;</td>
						      </tr>
						      <tr>
						        <td height="32" colspan="2" align="right" valign="bottom" background="http://www.lottejtb.com/images/popup/taxsave_add.gif" style="background-repeat:no-repeat;"><%=compAddr1%>&nbsp;</td>
						        </tr>
						      <tr>
						        <td height="32" align="center" valign="middle" background="http://www.lottejtb.com/images/popup/taxsave_13.gif" style="background-repeat:no-repeat;">&nbsp;</td>
						        <td height="32" align="right" valign="bottom" background="http://www.lottejtb.com/images/popup/taxsave_14.gif" style="background-repeat:no-repeat;"><%=busiNo%>&nbsp;</td>
						      </tr>
						      <tr>
						        <td height="32" align="right" valign="bottom" background="http://www.lottejtb.com/images/popup/taxsave_15.gif" style="background-repeat:no-repeat;">���� 1577-6511 / �λ� 1577-2511&nbsp;&nbsp;</td>
						        <td height="32" align="right" valign="bottom" background="http://www.lottejtb.com/images/popup/taxsave_16.gif" style="background-repeat:no-repeat;"><%=pubDate %>&nbsp;&nbsp;</td>
						      </tr>
						    </table></td>
						  </tr>
						</table>
            		</td>
        		</tr>    
      		</table>
 		</td>
  	</tr>
  	<tr>
    	<td>    		    		
    		<pw:outputLink value="http://www.lottejtb.com/xhtml/customer/submain/submain.xhtml" target="_blank">
			<img src="http://www.lottejtb.com/images/img2015/mail/bottom_banner01_b.gif" alt="���������� �ٷΰ���"  width="398" style="border:none" />
			</pw:outputLink>						        
			<pw:outputLink value="http://www.lottejtb.com/xhtml/customer/complain/complain.xhtml" target="_blank">
			<img src="http://www.lottejtb.com/images/img2015/mail/bottom_banner02_b.gif" alt="������Ű� �ٷΰ���"  width="398" style="border:none" />
			</pw:outputLink>
    	</td>	
  	</tr>
  	
  	<tr>
    	<td><img src="http://www.lottejtb.com/images/img2015/mail/footer01.gif" alt="" /></td>
  	</tr>
</table>

</body>
</html>
