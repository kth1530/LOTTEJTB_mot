<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

    <%

     String email = (String)request.getParameter("email");
     String sms = (String)request.getParameter("sms");

	 SimpleDateFormat original_format = new SimpleDateFormat("yyyyMMdd");
	 SimpleDateFormat new_format = new SimpleDateFormat("yyyy-MM-dd");
 
    %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>�Ե�����Ƽ��</title>
<link href="http://www.lottejtb.com/css/common.css" type="text/css" rel="stylesheet" />

<style type="text/css">
	a:link {font-family:����; font-size:11px; color:#2e2d2d; text-decoration:none}
	a:visited {font-family:����; font-size:11px; color:#2e2d2d; text-decoration:none}
	a:active {font-family:����; font-size:11px; color:#2e2d2d; text-decoration:none}
	a:hover {font-family:����; font-size:11px; color:#2e2d2d; text-decoration:none}
</style>

</head>

<body>
    <div style="width:728px; margin:auto;"><img src="http://www.lottejtb.com/images/d_mail/2016/161201_lottejtb/161201_img_01.jpg" /></div>
    <div style="width:728px; margin:auto; border:1px solid #e9e9e9; background-color:#fcfcfc;">
        <div><img src="http://www.lottejtb.com/images/d_mail/2016/161201_lottejtb/161212_img_01.jpg" /></div>
    
        <!--�����ڸ�Ī-->
        <div style="width:666px; height:45px; padding:0 0 0 31px;">
            <div style="width:175px; float:left;"><img src="http://www.lottejtb.com/images/d_mail/2016/161201_lottejtb/tit_01.jpg"></div>
<!--            <div style="height:20px; width:481px; font-family:Dotum; font-size:12px; font-weight:bold; color:#333333; padding:17px 0 0 200px;"> -->
			<div style="height:20px; font-family:Dotum; font-size:12px; font-weight:bold; color:#333333; padding:17px 0 0 200px;">
              <label for="textfield">�Ե�����Ƽ���</label>
              <input type="hidden" name="minput1" id="minput1" style="height:40px; width:463px; border:1px solid #dcdcdc; font-family:����; font-size:12px; font-weight:bold; line-height:44px; color:#333333; padding-left:15px;" value="�Ե�����Ƽ���"/>
            </div>
        </div>
        <!--//�����ڸ�Ī-->
        <div><img src="http://www.lottejtb.com/images/d_mail/2016/161201_lottejtb/161212_img_02.jpg" /></div>
        
        <!--E-mail-->
        <div style="width:666px; height:45px; padding:0 0 0 31px;">
            <div style="width:175px; float:left;"><img src="http://www.lottejtb.com/images/d_mail/2016/161201_lottejtb/tit_02.jpg"></div>
<!--            <div style="height:20px; width:481px; font-family:Dotum; font-size:12px; font-weight:bold; color:#333333; padding:17px 0 0 200px;"> -->
			<div style="height:20px; font-family:Dotum; font-size:12px; font-weight:bold; color:#333333; padding:17px 0 0 200px;"> 
              <label for="textfield">
			<%
			if(email.equals("1")){
				out.print("");
			}		
			else{
			Date original_edate = original_format.parse(email);
			String email_date = new_format.format(original_edate);

			 out.print(email_date);
			}
			%></label>

              <input type="hidden" name="minput2" id="minput2" style="height:40px; width:463px; border:1px solid #dcdcdc; font-family:����; font-size:12px; font-weight:bold; line-height:44px; color:#333333; padding-left:15px;" />
            </div>
        </div>
        <!--//E-mail-->
        
        <!--SMS-->
        <div style="width:666px; height:45px; padding:5px 0 0 31px;">
            <div style="width:175px; float:left;"><img src="http://www.lottejtb.com/images/d_mail/2016/161201_lottejtb/tit_03.jpg"></div>
<!--            <div style="height:20px; width:481px; font-family:Dotum; font-size:12px; font-weight:bold; color:#333333; padding:17px 0 0 200px;"> -->
			<div style="height:20px; font-family:Dotum; font-size:12px; font-weight:bold; color:#333333; padding:17px 0 0 200px;"> 
              <label for="textfield">
			   <%
			if(sms.equals("1")){
				out.print("");
			}		
			else{
			Date original_sdate = original_format.parse(sms);
			String sms_date = new_format.format(original_sdate);

			 out.print(sms_date);
			}
			%></label>
              <input type="hidden" name="minput3" id="minput1" style="height:40px; width:463px; border:1px solid #dcdcdc; font-family:����; font-size:12px; font-weight:bold; line-height:44px; color:#333333; padding-left:15px;" />
            </div>
        </div>
        <!--//SMS-->
        
        
        <div><img src="http://www.lottejtb.com/images/d_mail/2016/161201_lottejtb/161212_img_03.jpg" border="0" usemap="#Map" /></div>
    </div>
    <div style="width:730px; margin:auto; padding-top:10px;">
       <table cellpadding="0" cellspacing="0" border="0" width="730">
          <tr>
             <td height="3" bgcolor="#b9000a"></td>
          </tr>
          <tr>
             <td style="font-family:����; font-size:11px; color:#555555; padding:15px 0 15px 10px; line-height:17px; letter-spacing:-0.01em;">�� ������ ������Ÿ� �̿����� �� ������ȣ� ���� ���� ��50�� ��8�׿� �ǰ��� ���� �����̹Ƿ� ���ŵ��� ���ο� ������� �߼۵Ǿ����ϴ�.<br>
                  �Ե�����Ƽ��� ���� ��ǥ�̻� ī�̸� ���ξƸ�, �ȱԵ� / ����Ư���� ���α� ����� 88 ��ȯ���� 3��<br>
                  ����ڵ�Ϲ�ȣ : 201-86-02089 / ����Ǹž� �Ű��ȣ : �� 2017-��������-0734ȣ / TEL : 02)6313-8000 / FAX : 02)6234-1514</td>
          </tr>
          <tr>
             <td height="1" bgcolor="#d8d8d8"></td>
          </tr>
       
       </table>
    </div>


      <map name="Map" id="Map">
        <area shape="rect" coords="244,160,485,209" href="http://www.lottejtb.com" target="_blank" />
      </map>


</body>
</html>
