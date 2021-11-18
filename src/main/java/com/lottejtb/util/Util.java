package com.lottejtb.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;

public class Util {
	
	private final Logger logger = Logger.getLogger(this.getClass());
	
	public static String isNull(String str)
    {
        if ((str == null) || (str.trim().equals("")) || (str.trim().equals("null") || (str.trim().equals("NULL"))) )
            return "";
        else
            return str;
    }
    
  //(vary)
	public static String nvl(Object arg, String ch){
		if(arg == null) return ch;
		String str = String.valueOf(arg);
		if(str.trim().equals("") || str.trim().equalsIgnoreCase("null") || str.trim().equalsIgnoreCase("undefined")) return ch;
		return str;
	}
	//(vary)
	public static String nvl(Object arg){
		return nvl(arg, "");
	}
	//(vary)
    public static int nvl(Object arg, int i){
		if(arg == null) return i;
		String tempS = "";
		try{
			tempS = nvl(arg);
			if("".equals(tempS)){
				return i;
			}else{
				return Integer.valueOf(tempS);
			}
		}catch(Exception e){
			return i;
		}
	}
    
    public static String nvl(String str, String NVLString)
    {
        return NVL(str,NVLString);
    }

    public static String NVL(String str, String NVLString)
    {
        if ((str == null) || (str.trim().equals("")) || (str.trim().equals("null") || (str.trim().equals("NULL"))) )
            return NVLString;
        else
            return str;
    }

    public static int nvl(String str, int NVLInt)
    {
        return NVL(str,NVLInt);
    }

    public static int NVL(String str, int NVLInt)
    {
        if ((str == null) || (str.trim().equals("")) || (str.trim().equals("null") || (str.trim().equals("NULL"))) )
            return NVLInt;
        else
            return Integer.parseInt(str);
    }
    
    public static double nvl(Object str, double NVLDouble)
    {
        return NVL(nvl(str), NVLDouble);
    }
    
    public static double nvl(String str, double NVLDouble)
    {
        return NVL(str,NVLDouble);
    }

    public static double NVL(String str, double NVLDouble)
    {
        if ((str == null) || (str.trim().equals("")) || (str.trim().equals("null") || (str.trim().equals("NULL"))) )
            return NVLDouble;
        else
            return Double.parseDouble(str);
    }

    public static String nullTrim(String p_str)
    {
        if(p_str==null)
            return "";
        else
            return p_str;
    }

    public static String nullnbsp(String p_null)
    {
        String v_returnStr = p_null;
        if ( p_null == null || p_null.trim().equals("") || p_null.trim().equals("null") || p_null.trim().equals("NULL") )   {
            v_returnStr = "&nbsp;";
        }
        return v_returnStr;
    }

    public static String null2nbsp(String p_null)
    {
        String v_returnStr = p_null;
        if ( p_null == null || p_null.trim().equals("") || p_null.trim().equals("null") || p_null.trim().equals("NULL") )   {
            v_returnStr = "&nbsp;";
        }
        return v_returnStr;
    }

    public static String null2zero(String p_str)
    {
        if(p_str==null || p_str.trim().equals("") || p_str.trim().equals("null") || p_str.trim().equals("NULL"))
            return "0";
        else
            return p_str;
    }

    public static java.sql.Date isNullDate(java.sql.Date p_date)
    {
        if(p_date==null)
            return new java.sql.Date(-1);
        else
            return p_date;
    }

    public static boolean isKSC( String str )
    {
        try
        {
            if( str.equals( new String(str.getBytes("KSC5601"),"KSC5601") ) )
                return true;
            else
                return false;
        }
        catch(UnsupportedEncodingException e) { return false;}

    }

    public static String toKSC(String str)
    {
        return ToKSC5601(str);
    }
    public static String ToKSC5601(String ko){
        if(ko != null && ko != ""){
            String new_str=null;

            try{
                if( ko.equals( new String(ko.getBytes("KSC5601"),"KSC5601"))  )
                    new_str = ko;
                 else
                    new_str = new String(ko.getBytes("8859_1"),"KSC5601");
            }catch(java.io.UnsupportedEncodingException ue){
                new_str = "";
            }
            return new String(new_str);

        } else
            return "";

    }


    public static String toENC(String str)
    {
        return ToUS8859(str);
    }

    public static String ToUS8859(String en){
        if(en != null && en != ""){
            String new_str=null;

            try{
                if( en.equals( new String(en.getBytes("KSC5601"),"KSC5601"))  )
                    new_str = new String(en.getBytes("KSC5601"),"8859_1");
                 else
                    new_str = en;
            }catch(java.io.UnsupportedEncodingException ue){
                new_str = "";
            }
            return new_str;

        } else
            return "";
    }

    public static String replaceNoHTML(String p_str)
    {
        if ( p_str == null )
        {
            p_str = "";
        }
        else
        {
            p_str = p_str.trim();
            p_str = replace(p_str,"&","&amp");
            p_str = replace(p_str,"<","&lt");
            p_str = replace(p_str,">","&gt");
            p_str = replace(p_str,"'","&quot");
            p_str = replace(p_str,"\"","");
        }

        return p_str;
    }

    public static String replaceBR(String p_str)
    {
        if ( p_str == null )
        {
            p_str = "";
        }
        else
        {
            p_str = p_str.trim();
            p_str = replace(p_str,"\n","<br>");
        }

        return p_str;
    }

    public static String replaceYesHTML(String p_str)
    {
        if ( p_str == null )
        {
            p_str = "";
        }
        else
        {
            p_str = p_str.trim();
            p_str = replace(p_str,"&","&amp");
            p_str = replace(p_str,"'","&quot");
            p_str = replace(p_str,"\"","");
            p_str = replace(p_str,"##","-");
        }

        return p_str;
    }

    public static String limitString(String p_str,String p_tailstr,int p_len)
    {
        p_str=p_str.trim();
        if(p_str.length() > p_len)
            p_str=p_str.substring(0, p_len - p_tailstr.length());
        return p_str;
    }

	public static String replace(String line, String oldString, String newString)
    {
        for(int index = 0; (index = line.indexOf(oldString, index)) >= 0; index += newString.length()){        	
            line = line.substring(0, index) + newString + line.substring(index + oldString.length());
        }
        
        return line;
    }
    
    public static String getDateYoil(String p_dateStr) throws ParseException{
    	
    	DateFormat df = new SimpleDateFormat("yyyyMMdd");
    	Date date = df.parse(p_dateStr);
    	Calendar calendar = Calendar.getInstance();
    	calendar.setTime(date);
    	
    	int p_int = calendar.get(Calendar.DAY_OF_WEEK);
    	String p_str = null;
    	
		switch(p_int) {
	    	case 1:p_str = "��";break;
			case 2:p_str = "��";break;
			case 3:p_str = "ȭ";break;
			case 4:p_str = "��";break;
			case 5:p_str = "��";break;
			case 6:p_str = "��";break;
			case 7:p_str = "��";break;
		}
    	
    	return p_str;
    }

    public static String getDateString(java.sql.Date p_date,int day_flag)
    {
        String dateStr="";
        GregorianCalendar g=new GregorianCalendar(Locale.KOREA);
        g.setGregorianChange(p_date);

        if ( day_flag == 1 )    {
            dateStr=dateStr+"-"+g.get(Calendar.YEAR);
            dateStr=dateStr+"-"+g.get(Calendar.DATE);
            dateStr=dateStr+g.get(Calendar.MONTH);
        }
        if ( day_flag == 2 )    {
            dateStr=dateStr+"-"+g.get(Calendar.YEAR);
            dateStr=dateStr+"-"+g.get(Calendar.DATE);
            dateStr=dateStr+g.get(Calendar.MONTH);
            dateStr=dateStr+" "+g.get(Calendar.HOUR);
        }
        if ( day_flag == 3 )    {
            dateStr=dateStr+"-"+g.get(Calendar.YEAR);
            dateStr=dateStr+"-"+g.get(Calendar.DATE);
            dateStr=dateStr+g.get(Calendar.MONTH);
            dateStr=dateStr+" "+g.get(Calendar.HOUR);
            dateStr=dateStr+":"+g.get(Calendar.SECOND);
        }

        return dateStr;
    }

    public static String getDateString(java.util.Date p_date,String dateFormat)
    {
        String dateStr="";
        java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(dateFormat);
        dateStr = formatter.format(p_date);
        return dateStr;
    }

    public static String getDateString(String p_date,String p_formmater)
    {
        if (p_date.equals("") || p_date.length() < 8){
            return p_date;
        }
        return p_date.substring(0,4) + p_formmater + p_date.substring(4,6) + p_formmater + p_date.substring(6,8);
    }

    public static String getDateHyphen(String p_dateStr, String p_hyphen)   {
        if ( isNull(p_dateStr).length() == 8 )  {
            p_dateStr = p_dateStr.substring(0,4) + p_hyphen + p_dateStr.substring(4,6) + p_hyphen + p_dateStr.substring(6,8);
        }
        return p_dateStr;
    }
    public static String getDateHyphen(String p_dateStr)    {
        if ( isNull(p_dateStr).length() == 8 )  {
            p_dateStr = p_dateStr.substring(0,4) + "-" + p_dateStr.substring(4,6) + "-" + p_dateStr.substring(6,8)+"-";
        }
        return p_dateStr;
    }

    public static String getDateHyphen1(String p_dateStr)   {
        if ( isNull(p_dateStr).length() == 8 )  {
            p_dateStr = p_dateStr.substring(0,4) + "�� " + Integer.parseInt(p_dateStr.substring(4,6)) + "�� " + Integer.parseInt(p_dateStr.substring(6,8))+"��";
        }
        return p_dateStr;
    }
    public static String moneyFormValue(String n)
    {
        boolean nFlag=true;

        String o     = "";
        String p     = "";
        String minus = "";

        if ( n.substring(0,1).equals("-") ) {
            minus = n.substring(0,1);
            n     = n.substring(1);
        }

        if ( n.indexOf(".")>0 ) {
            o = n.substring(0, n.indexOf("."));
            p = n.substring(n.indexOf(".")+1, n.length());
        }
        else    {
            o = n;
        }

        o = Util.replace(o," ","");
        o = Util.replace(o,",","");
        o = Util.replace(o,"+","");

        int tLen = o.length();
        StringBuilder tMoneySb = new StringBuilder();
        String tMoney = "";
        for(int i=0;i<tLen;i++){
            if (i!=0 && ( i % 3 == tLen % 3) ){
            	tMoneySb.append(",");
            }
            
            if(i < tLen ){
            	tMoneySb.append(o.charAt(i));
            }
        }

        if ( p.length()>0 )     tMoney += "."+p;
        if ( nFlag == false )   tMoney = "-"+tMoney;

        if ( minus.equals("-") ) {
            tMoney = minus + tMoney;
        }

        return tMoney;
    }
    public static String transDate(java.sql.Date p_date)
    {
        String v_year="&nbsp;";
        String v_month="";
        String v_day="";

        if( !(p_date==null || p_date.toString().equals("") || p_date.toString().equals("null")) ) {
            StringTokenizer v_st=new StringTokenizer(p_date.toString(),"- ");

            v_year=v_st.nextToken();
            v_month=v_st.nextToken()+"-";
            v_day=v_st.nextToken()+"-";
        }
        return v_month+v_day+v_year;
    }
    public static int parseInt( String str )
    {

        if( str == null || str.equals("") )
        {
            return 0;
        }else{
            try{
                return Integer.parseInt(str);
            }catch(NumberFormatException e){
                return 0;
            }
        }
    }



    public static long parseLong( String str )
    {

        if( str == null || str.equals("") )
        {
            return 0L;
        }else{
            try{
                return Long.parseLong(str);
            }catch(NumberFormatException e){
                return 0L;
            }
        }
    }


    public static float parseFloat( String str )
    {

        if( str == null || str.equals("") )
        {
            return 0f;
        }else{
            try{
                return Float.parseFloat(str);
            }catch(NumberFormatException e){
                return 0f;
            }
        }
    }

    public static double parseDouble( String str )
    {

        if( str == null || str.equals("") )
        {
            return 0;
        }else{
            try{
                return Double.parseDouble(str);
            }catch(NumberFormatException e){
                return 0;
            }
        }
    }

    public static String getSQLResult( Connection conn , String sql )
    {
    	PreparedStatement ps = null;
        StringBuffer    returnString= new StringBuffer();
        Statement       stm         = null;
        ResultSet       rs          = null;

        try{
            //stm = conn.createStatement();
            //rs  = stm.executeQuery( sql );
        	ps = conn.prepareStatement(sql);
        	rs = ps.executeQuery();

            while( rs != null && rs.next() )
            {
                returnString.append( Util.nvl(rs.getString(1),""));
            }
        }catch(SQLException e){
        	//e.printStackTrace();
        	System.err.println("SQL Error!");
        }finally{

            try{
                if( rs != null )
                {
                    rs.close();
                    rs = null;
                }

                if( stm != null )
                {
                    stm.close();
                    stm = null;
                }
            }catch(SQLException e){ 
            	//e.printStackTrace();
            	System.err.println("SQL Error!");
            }
        }

        return returnString.toString();
    }

    //String�� ������ �޾Ƽ� ���ϴ� ���� ���� �����ڸ� �־��ش�.
    //Enter(\n)�� ������� �ٲپ���
    //�ֻ���� website���� multiline�� ����Ҷ� �����

    public static String getMultiline( String str, int cutSize , String lineBreaker)
    {
        StringBuffer    tempStrBuffer   = new StringBuffer("");
        StringBuffer    strBuffer       = new StringBuffer("");
        StringTokenizer strToken        = new StringTokenizer(str,"\n");

        while( strToken.hasMoreElements() )
        {
            tempStrBuffer.append( strToken.nextToken() + " " );
        }

        int length      = tempStrBuffer.length();
        int startIndex  = 0 ;

        try{
            while( length >  startIndex ){
                strBuffer.append( tempStrBuffer.substring( startIndex, startIndex + cutSize ) + lineBreaker );
                startIndex += cutSize;
            }

        }catch(Exception e){
            strBuffer.append(tempStrBuffer.substring(startIndex, length));
        }

        return strBuffer.toString();
    }
    //  Java���� OutOfIndexException�߻���������� substring
    public static String substring( String str, int startIndex , int endIndex)
    {
        if( str == null )
            return "";

        String returnString = "";
        int lastIndex = str.length();

        if( lastIndex < startIndex )
            return "";

        if( (lastIndex+1) < endIndex )
        {
            returnString = str.substring( startIndex , lastIndex);
        }else{
            returnString = str.substring( startIndex , endIndex);
        }

        return returnString;

    }
    //  ���ڿ��� �޾� DB�� ���� �� �ֵ��� ���ʿ� single quotation�� �־���
    public static String word( String str )
    {
        String string = str;

        if( string == null )
            string = "";
        return ( "'" + string + "'" );
    }
    //  ���ڿ��� �޾� DB�� ���� �� �ֵ��� ���ʿ� single quotation�� �־��ְ� %% �߰����ش�
    public static String wordLike( String str )
    {
        String string = str;

        if( string == null )
            string = "";
        return ( "'%" + string + "%'" );
    }


    public static String getStackTraceAsString(Exception e) {

        ByteArrayOutputStream bytes = new ByteArrayOutputStream();
        PrintWriter writer = new PrintWriter(bytes, true);
        e.printStackTrace(writer);

        return bytes.toString();
    }

    public static boolean inStrCheck(String inStr, String chkStr[]) {
        boolean chkFlag = false;

        for ( int i=0; i<chkStr.length; i++ )   {
            if ( inStr.indexOf(chkStr[i]) >= 0 )    {   chkFlag = true;     break;  }
            else    {                                   chkFlag = false;            }
        }

        return chkFlag;
    }

    public static String getNowDateString(String p_format)  {
        if ( isNull(p_format) == "" )
            p_format = "yyyy-MM-dd";

        java.util.Date v_now = new java.util.Date();
        java.text.SimpleDateFormat v_vans = new java.text.SimpleDateFormat( p_format );
        String v_now_date=v_vans.format(v_now);

        return v_now_date;
    }

    /**
     * ����ڿ�(strTarget)���� ���й��ڿ�(strDelim)�� �������� ���ڿ��� �и��Ͽ�
     * �� �и��� ���ڿ��� �迭�� �Ҵ��Ͽ� ��ȯ�Ѵ�.
     *
     * @param strTarget �и� ��� ���ڿ�
     * @param strDelim ���н�ų ���ڿ��μ� ��� ���ڿ����� ���Ե��� �ʴ´�.
     * @return �и��� ���ڿ��� ���� �迭�� �ݳ��Ͽ� ��ȯ�Ѵ�.
     */
    public static String[] split(String strTarget, String strDelim){
        // StringTokenizer�� �����ڰ� �������� ��ø�Ǿ� ���� ��� ��� ���ڿ��� ��ȯ���� ����.
        // ��� �Ʒ��� ���� �ۼ���.

        int index = 0;
        String[] resultStrArray = new String[search(strTarget,strDelim)+1];
        String strCheck = new String(strTarget);
        while(strCheck.length() != 0) {
            int begin = strCheck.indexOf(strDelim);
            if(begin == -1) {
                resultStrArray[index] = strCheck;
                break;
            } else {
                int end = begin + strDelim.length();
                resultStrArray[index++] = strCheck.substring(0, begin);

                strCheck = strCheck.substring(end);
                if(strCheck.length()==0 ){
                    resultStrArray[index] = strCheck;
                    break;
                }
            }
        }
        return resultStrArray;
    }

    /**
     * ����ڿ�(strTarget)���� ���й��ڿ�(strDelim)�� �������� ���ڿ��� �и��Ͽ�
     * �� �и��� ���ڿ��� �迭�� �Ҵ��Ͽ� ��ȯ�Ѵ�.
     *
     * @param strTarget �и� ��� ���ڿ�
     * @param strDelim ���н�ų ���ڿ��μ� ��� ���ڿ����� ���Ե��� �ʴ´�.
     * @param bContainNull ���еǾ��� ���ڿ��� ��鹮�ڿ��� ���Կ���.
     *                     true : ����, false : �������� ����.
     * @return �и��� ���ڿ��� ���� �迭�� �ݳ��Ͽ� ��ȯ�Ѵ�.
     */
    public static String[] split(String strTarget, String strDelim, boolean bContainNull){
        int index = 0;
        String[] resultStrArray = new String[search(strTarget,strDelim)+1];
        String strCheck = new String(strTarget);
        while(strCheck.length() != 0) {
            int begin = strCheck.indexOf(strDelim);
            if(begin == -1) {
                resultStrArray[index] = strCheck;
                break;
            } else {
                int end = begin + strDelim.length();
                if(bContainNull){
                    resultStrArray[index++] = strCheck.substring(0, begin);
                }
                strCheck = strCheck.substring(end);
                if(strCheck.length()==0 && bContainNull){
                    resultStrArray[index] = strCheck;
                    break;
                }
            }
        }
        return resultStrArray;
    }

    /**
     * ����ڿ�(strTarget)���� �������ڿ�(strSearch)�� �˻��� Ƚ����,
     * �������ڿ��� ������ 0 �� ��ȯ�Ѵ�.
     *
     * @param strTarget ����ڿ�
     * @param strSearch �˻��� ���ڿ�
     * @return �������ڿ��� �˻��Ǿ����� �˻��� Ƚ����, �˻����� �ʾ����� 0 �� ��ȯ�Ѵ�.
     */
    public static int search(String strTarget, String strSearch){
        int result=0;
        String strCheck = new String(strTarget);
        for(int i = 0; i < strTarget.length(); ){
            int loc = strCheck.indexOf(strSearch);
            if(loc == -1) {
                break;
            } else {
                result++;
                i = loc + strSearch.length();
                strCheck = strCheck.substring(i);
            }
        }
        return result;
    }

    //  ���ڿ��� �޾Ƽ� null�̸� ��� ���ڿ��� ����
    public static String NVL(String str)    {
        if ((str == null) || (str.trim().equals("")) || (str.trim().equals("null")))
            return "";
        else
            return str;
    }


    //  ���ڿ��� ���̸� ��ü�� float�� ����
    public static float NVL(String str, float NVLFloat) {
        if ((str == null) || (str.trim().equals("")) || (str.trim().equals("null")))
            return NVLFloat;
        else
            return Float.parseFloat(str);
    }

    //  ���� 0 -> 00000 �� ��ȯ�Ϸ��Ҷ� ���
    //  webnara���� ������ ������ �Ϸ��� ������ ��� blank(b)  bbbb0 �̷������� ó���� �ؾ��Ѵ�.
    public static String setTextBlank(String v_inTxt, int v_maxLen, String v_BlankTxt)
    {
        String v_tempStr = "";
        StringBuilder v_tempStrSb = new StringBuilder();

        if ( !v_inTxt.equals("") )  {
            for ( int i=0; i<v_maxLen; i++ )    {
                //v_tempStr += v_BlankTxt;
            	v_tempStrSb.append(v_BlankTxt);
            }
            v_inTxt = v_tempStrSb.toString() + v_inTxt;

            v_inTxt = v_inTxt.substring(v_inTxt.length()-v_maxLen,v_inTxt.length());
        }

        return v_inTxt;
    }

    //  HtmlEditer �� Html �ڵ� ��ȯ(�Է���)
    public static String EditerEncode(String inStr) {
        if ( !isNull(inStr).equals("") )    {
            inStr = replace(inStr, "'", "&#39;");
            inStr = replace(inStr, "\"", "&#34;");
            inStr = replace(inStr, ",", "&#44;");
            inStr = replace(inStr, "<", "&lt;");
            inStr = replace(inStr, ">", "&gt;");
        }
        return inStr;
    }
    //  HtmlEditer �� Html �ڵ� ��ȯ(������)
    public static String EditerDecode(String inStr) {
        if ( !isNull(inStr).equals("") )    {
            inStr = replace(inStr, "&#39;", "'");
            inStr = replace(inStr, "&#34;", "\"");
            inStr = replace(inStr, "&#44;", ",");
            inStr = replace(inStr, "&lt;", "<");
            inStr = replace(inStr, "&gt;", ">");
        }
        return inStr;
    }
    //  ���ϸ��� Ȯ���� ��������
    public static String getFileNameExt(String p_file_name)
    {
        String right = "";
        int vb_strFlag = 0;

        vb_strFlag = p_file_name.indexOf(".");
        if (vb_strFlag != -1 )  {
            right = p_file_name.substring(vb_strFlag+1, p_file_name.length());
        }

        if ( right.indexOf(".") != -1 ) {
            right = getFileNameExt(right);
        }

        return right;
    }

    //  ���ϸ� Ȯ���ڿ��� �̹��� ���� �̸� �����ϱ�
    //  �Ϲ����� Ȯ���ڴ� �ش� xxx.gif�� return�ϰ�, �׿ܴ� etc.gif�� return�Ѵ�.
    public static String getExtImage(String p_FileNameExt)
    {
        String vb_retImgFileName = "";

        String vb_ImageExt[] = {    "arj","bmp","com","doc","exe",
                                    "gif","hlp","htm","html","hwp",
                                    "jpg","mdb","mp3","mpeg","mpg",
                                    "pdf","ppt","ra","ram","rar",
                                    "txt","wav","xls","zip" };
        p_FileNameExt = p_FileNameExt.toLowerCase();

        for ( int i=0; i<vb_ImageExt.length; i++ )
            if ( p_FileNameExt.equals(vb_ImageExt[i]) )
                vb_retImgFileName = vb_ImageExt[i];

        if ( vb_retImgFileName.equals("") )
            vb_retImgFileName = "etc";

        vb_retImgFileName += ".gif";

        return vb_retImgFileName;
    }
    //  HashMap�ִ� key,code�� �̿��ؼ� URL String�� ����� �������ش�.
    public static String getHashLink(HashMap linkHash)  {

        StringBuffer sb = new StringBuffer();

        if ( linkHash!=null )   {
            Set set = linkHash.keySet();
            Iterator e = set.iterator();
            while (e.hasNext()){
                String key = (String)e.next();
                String value = (String)linkHash.get(key);

                sb.append("&"+key+"="+value);
            }
        }

        return sb.toString();
    }

    //  �������ڸ� ��������� ǥ���Ͽ� �����´�.
    public static String getMoneyFormat(String n)
    {

        //  java���� �⺻�����ϴ°��� ������������ ���������� ������.
        //  DecimalFormat dollarFmt = new DecimalFormat("##########.00");
        //  dollarFmt.format(amount)

        boolean nFlag=true;

        String o = "";
        String p = "";

        if ( n.indexOf(".")>0 ) {
            o = n.substring(0, n.indexOf("."));
            p = n.substring(n.indexOf(".")+1, n.length());
        }
        else    {
            o = n;
        }

        o = replace(o," ","");
        o = replace(o,",","");
        o = replace(o,"+","");

        int tLen = o.length();
        StringBuilder tMoneySb = new StringBuilder();
        String tMoney = "";
        for(int i=0;i<tLen;i++){
            if (i!=0 && ( i % 3 == tLen % 3) ) {
            	tMoneySb.append(",");
            }
            
            if(i < tLen ) {
            	tMoneySb.append(o.charAt(i));
            }
        }
        
        tMoney = tMoneySb.toString();

        if ( p.length()>0 )     tMoney += "."+p;
        if ( nFlag == false )   tMoney = "-"+tMoney;
        if ( tMoney.substring(0 , 1 ).equals("-") && tMoney.substring(1 , 2 ).equals(",")) tMoney = tMoney.substring( 0 , 1 ) + tMoney.substring( 2 , tMoney.length() );

        return tMoney;
    }
 
    public static BigDecimal getRound(double dataDouble, int seat ) {

        BigDecimal bd = new BigDecimal(dataDouble);
        bd = bd.setScale( seat, BigDecimal.ROUND_HALF_UP );

        return bd;

    }

    public static String orderByColumn(String query, String columnName, String order) {
        String str = query + " ORDER BY " + columnName + " " + order +" \n";
        return str;
    }

    //  ����, �ѱ� ȥ�� ���ڿ��� ������ ���̿��� �߶��ִ� �Լ�
    public static String shortCutString(String str, int limit) {
        if (str == null || limit < 4) return str;

        int len = str.length();
        int cnt=0, index=0;

        while (index < len && cnt < limit) {
            if (str.charAt(index++) < 256)
                cnt++;
            else {
                if(cnt < limit-3) {
                    cnt += 2;
                } else {
                    break;
                }
            }
        }

        if (index < len)
            str = str.substring(0, index).concat("...");

        return str;
    }

    //   ���ڿ��� ���̰� len���� ������
    // ���ڿ��� ���̰� len�� �ɶ� ���� ����� �߰� �Ѵ�.
    public static String getAppendBlank(String p_str , int len) {

        //String str = p_str;
    	StringBuilder strSb = new StringBuilder();
    	strSb.append(p_str);
        int str_length = strSb.length();

        if( str_length < len ) {
            for( int i=0; i< len - str_length; i++ ) {
                //str += "&nbsp;";
            	strSb.append("&nbsp;");
            }

        }

        return strSb.toString();
    }

    // ī�� �ڸ��� ���� XXXX�߰��ؼ� �����ֱ�
    public static String addCardNoHide(String str,int iLoc){

        if(str != null && str.length() == 16){

            switch(iLoc){
                case 0:
                return str.substring(0,4)+"-"+str.substring(4,8)+"-"+str.substring(8,12)+"-"+str.substring(12,16);
                case 1:
                return "xxxx-"+str.substring(4,8)+"-"+str.substring(8,12)+"-"+str.substring(12,16);
                case 2:
                return str.substring(0,4)+"-xxxx-"+str.substring(8,12)+"-"+str.substring(12,16);
                case 3:
                return str.substring(0,4)+"-"+str.substring(4,8) +"-xxxx-"+str.substring(12,16);
                case 4:
                return str.substring(0,4)+"-"+str.substring(4,8)+"-"+str.substring(8,12)+"-xxxx";
                case 5:
                    return str.substring(0,4)+"-"+str.substring(4,8)+"-"+str.substring(8,12)+"-"+"-xx"+str.substring(14,16);
                default:
                return str.substring(0,4)+"-"+str.substring(4,8)+"-"+str.substring(8,12)+"-xxxx";
            }
        }

        return str;
    }

    /**
     * ����ڵ�Ϲ�ȣ ǥ��
     * @param str
     * @return str
     */
    public static String addBizNoFormat(String str) {
        if(str != null && str.length() == 10) {
            return str.substring(0,3)+"-"+str.substring(3,5)+"-"+str.substring(5,10);
        }
        return str;
    }

    /**
     * ��� select box ��
     * @param int,int,String
     * @return str
     * jong
     */

    public static String getOptions(int s, int cnt , String selected){
        StringBuffer buffer = new StringBuffer();
        String tmp;
        for(int i=s;i<=cnt;i++){
            if ( i < 10){
                tmp =  "0"+String.valueOf(i);
            }else{
                tmp =  String.valueOf(i);
            }
            if(tmp.equals(selected)) buffer.append("<OPTION VALUE='"+tmp+"' SELECTED >" + tmp + "</OPTION>\n");
            else                     buffer.append("<OPTION VALUE='"+tmp+"' >" + tmp + "</OPTION>\n");
        }
        return buffer.toString();
    }

    /**
     * ���ϸ� ��
     * @param int,int,String
     * @return str
     *  jong
     */
    public static String createSourceFileName(String realFileName) {
        SimpleDateFormat sdFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        return new StringBuffer(realFileName).append("_").append(sdFormat.format(new GregorianCalendar().getTime())).toString();
    }

    /**
     * <pre>
     * ���ڿ��� �޾Ƽ� Enter Key�� Ư�����ڿ�(`)�� ��ȯ�ϰų�
     * Ư�����ڿ��� Enter key�� ��ȯ��...
     * - Informix thin driver Bug ������ SQL���� ��� ���Ű ����.
     * </pre>
     * @param   String      ��ȯ ���
     * @param   nFlag       ��ȯ ����
     * @return  'String'
     */
    public static String convertRN(String str, int  nFlag)
    {
        StringBuffer dbStr = new StringBuffer();
        int i = 0;

        if(str == null)
        {
            return "";
        }
        else
        {
            if( nFlag > 0)  //����̸� Enter Key�� `�� ��ȯ
            {

                str = str.replace( '\r', '`');
                str = str.replace( '\n', '`');

                return str;
            }
            else            //�����̸� `�� Enter Key�� ��ȯ
            {
                for(; i < str.length(); i++)
                {

                    if( (str.charAt(i) == '`') && ((i+1) < str.length()) &&  (str.charAt(i+1) == '`') )
                    {
                        i++;
                        dbStr.append("\r\n");
                    }
                    else
                    {
                        dbStr.append(str.charAt(i));
                    }

                }//end for

            }//end sub if-else

        }//end main if-else

        return  dbStr.toString();
    } //end convertRN method

    /**
     * ��Ű���� �����Ѵ�.
     * �������ڸ� -1�� �༭ ��ũ�� ������� �ʴ´�.
     *
     * @param res            : HttpServletResponse
     * @param name           : ��Ű�̸�
     * @param value          : ��Ű ��
     * @throws java.io.UnsupportedEncodingException
     */
    public static void setCookie(HttpServletResponse res, String name, String value)
        throws UnsupportedEncodingException {
        //��ũ�� ������� �ʴ´�.
        setCookie(res, name, value, -1);
    }

    /**
     * ��Ű���� �����Ѵ�.
     *
     * @param res            : HttpServletResponse
     * @param name           : ��Ű�̸�
     * @param value          : ��Ű ��
     * @param expire         : ��������
     * @throws UnsupportedEncodingException
     */
    public static void setCookie(HttpServletResponse res,String name,String value,int expire)
        throws UnsupportedEncodingException {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(expire);
        cookie.setPath("/");
        res.addCookie(cookie);
    }

    /**
     * ��Ű���� �����´�.
     * @param req            : HttpServletRequest
     * @param cookieName     : ��Ű�̸�
     * @return               :
     * @throws UnsupportedEncodingException
     */
    public static String getCookie(HttpServletRequest req, String cookieName)
        throws UnsupportedEncodingException {
        Cookie [] cookies = req.getCookies();
        if (cookies==null) return "";
        String value = "";
        for(int i=0;i<cookies.length;i++) {
           if(cookieName.equals(cookies[i].getName())) {
               value = URLDecoder.decode(cookies[i].getValue(),"MS949");
               break;
           }
       }
       return value;
    }

    /**
     * ������ ���� ����
     * ���ڿ� ���̱� �� ��� TEXT1,TEXT, <-- ������ ���ڿ��� �����Ѵ�.
     *
     * @param req            : oriString ��
     * @return               : oriString ��
     * @throws UnsupportedEncodingException
     */
    public static String cutEndChar(String sParam) {
        String sReturn = "";

        //������ ���ڸ� ����
        if(!sParam.equals("")){
            sReturn = sParam.substring(0,sParam.length()-1);
        }

        return sReturn;
    }
    
  //list to json string
	public String listToJsonString(List<Map<String, Object>> list){
		return objectToJsonString(list);
	}
	
	//map to json string
	public String mapToJsonString(Map map){
		return objectToJsonString(map);
	}
	
	public  String objectToJsonString(Object obj){
		String jsonStr = "";
		ObjectMapper mapper = new ObjectMapper();
		try {
			jsonStr = mapper.writeValueAsString(obj);
		} catch (JsonGenerationException e) {
			logger.error("JsonGenerationException : " + e.getMessage());
		} catch (JsonMappingException e) {
			logger.error("JsonMappingException : " + e.getMessage());
		} catch (IOException e) {
			logger.error("IOException : " + e.getMessage());
		}
		return jsonStr;
	}
	
    /**
    * ** 반드시 열고 닫아야 함 **
    * #r빨강r#
	   #b 파랑b#
	   #v바이올렛v#
	   #s볼드s#  중복적용예시 #rs 빨강볼드rs#
      #r빨강r#
    * @param v
    * @return
    */
    public static String convertStringTotag(String v){
    	   v.replaceAll("\"", "").replaceAll("'", "`").replaceAll("\r\n", "<br/>").replaceAll("\r", "").replaceAll("\n", "").replaceAll("\t", "").replaceAll("\\\\", "").replaceAll(" ", "").replaceAll("\u0000", "");

    	   String retVal  = "";
           if(v != null && !v.equals("")){
                   retVal = v;
                   if(v.indexOf("#rs") != -1 && v.lastIndexOf("rs#") != -1) retVal = retVal.replaceAll("#rs", "<font style=color:#D42B2D;font-weight:bold;>").replaceAll("rs#", "</font>"); //레드볼드
                   if(v.indexOf("#bs") != -1 && v.lastIndexOf("bs#") != -1) retVal = retVal.replaceAll("#bs", "<font style=color:#3442A9;font-weight:bold;>").replaceAll("bs#", "</font>"); //파랑볼드
                   if(v.indexOf("#vs") != -1 && v.lastIndexOf("vs#") != -1) retVal = retVal.replaceAll("#vs", "<font style=color:#7b4eb9;font-weight:bold;>").replaceAll("vs#", "</font>"); //바이올렛볼드
                   
                   if(v.indexOf("#r") != -1 && v.lastIndexOf("r#") != -1)  retVal = retVal.replaceAll("#r", "<font style=color:#D42B2D;>").replaceAll("r#", "</font>"); //레드
                   if(v.indexOf("#b") != -1 && v.lastIndexOf("b#") != -1) retVal = retVal.replaceAll("#b", "<font style=color:#3442A9;>").replaceAll("b#", "</font>"); //파랑
                   if(v.indexOf("#v") != -1 && v.lastIndexOf("v#") != -1) retVal = retVal.replaceAll("#v", "<font style=color:#7b4eb9;>").replaceAll("v#", "</font>"); //바이올렛
                   
                   if(v.indexOf("#s") != -1 && v.lastIndexOf("s#") != -1) retVal = retVal.replaceAll("#s", "<font style=font-weight:bold;>").replaceAll("s#", "</font>"); //볼드
                   
                   retVal = retVal.replaceAll("\r\n", "<br/>");
                   
            }else{
                   retVal = v;
           }
           return retVal; 
     }
    
	public static String strip_tags (String input) {
		String retVal = "";
       
		if(input != null){
			retVal = input.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
		}
       
		retVal = convertStringTotag(retVal);
       
		return retVal;
	}	
}
