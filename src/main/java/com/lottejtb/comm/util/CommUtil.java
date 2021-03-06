package com.lottejtb.comm.util;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.nio.ByteBuffer;
import java.nio.charset.CharacterCodingException;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.Map;
import java.util.Random;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.apache.http.impl.cookie.DateParseException;
import org.apache.http.impl.cookie.DateUtils;
import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartFile;

import com.lottejtb.framework.common.CommProperty;

import eu.medsea.mimeutil.MimeUtil;

/**
 * <pre class="doc_class">
 * Title: CommUtil.java 
 * Description
 *  - 시스템 전반적으로 사용하는 Util 메서드를 정의
 * 주로 문자열 , 숫자, Date를 가공하는 Util 메서드
 * </pre>
 */
public final class CommUtil {
    private static Logger logger = Logger.getLogger(com.lottejtb.comm.util.CommUtil.class);

    public static ArrayList<String> listTrim(ArrayList<String> orgList) {
        ArrayList<String> destList = new ArrayList<String>();
        if (orgList == null) {
            return orgList;
        }

        for (String str : orgList) {
            if (str == null)
                continue;

            destList.add(str.trim());
        }

        return destList;
    }

    /**
     * String Array 중복값 제거
     * 
     * @param strArray
     * @return
     */
    public static String[] removeDup(String[] strArray) {
        if (strArray == null || strArray.length == 0)
            return null;
        LinkedHashSet<String> hSet = new LinkedHashSet<String>();

        for (String str : strArray) {
            if (!StringUtils.isBlank(str))
                hSet.add(str.trim());
        }

        return hSet.toArray(new String[hSet.size()]);
    }

    /**
     * 배열 내 중복 제거.
     * 
     * @param strArray
     * @return
     */
    public static String[] removeDup(ArrayList<String> strArray) {
        if (strArray == null)
            return null;
        LinkedHashSet<String> hSet = new LinkedHashSet<String>();

        for (String str : strArray) {
            if (!StringUtils.isBlank(str))
                hSet.add(str.trim());
        }

        return hSet.toArray(new String[hSet.size()]);
    }

    // 파일 업로드 Mime detector 등록
    static {
        MimeUtil.registerMimeDetector("eu.medsea.mimeutil.detector.MagicMimeMimeDetector");
    }

    private CommUtil() {
    }

    /**
     * 해당 String이 null 이거나 length가 0인지 검사
     * 
     * @param str
     * @return
     */
    public static boolean isEmpty(String str) {
        if (str == null || str.trim().length() == 0) {
            return true;
        }
        return false;
    }

    /**
     * 해당 Object가 null 인지 검사
     * 
     * @param obj
     * @return
     */
    public static boolean isEmpty(Object obj) {
        if (obj == null) {
            return true;
        }
        try {
            if (((String) obj).trim().length() == 0) {
                return true;
            }
        } catch (Exception e) {
        	//e.printStackTrace();
        	System.err.print("Trim Error!");
        }
        return false;
    }

    /**
     * 넘어온 String이 null일 경우 "" 빈 공백 처리를 한다.
     * 
     * @param str
     * @return
     */
    public static String checkEmpty(String str) {
        return checkEmpty(str, "");
    }

    /**
     * 넘어온 String값이 null 일경우 ret String으로 대체 한다.
     * 
     * @param str
     * @param ret
     * @return
     */
    public static String checkEmpty(String str, String ret) {
        return str == null ? ret : str;
    }

    /**
     * 넘어온 String값이 null or "" 일경우 "0" 으로 대체 한다.
     * 
     * @param str
     * @return
     */
    public static String checkEmptyZero(String str) {
        if (str.equals("") || str == null) {
            str = "0";
        }
        return str;
    }

    /**
     * 해당 Object내의 멤버 변수의 값을 key=value 형식으로 변환하여 반환<br>
     * 일반적으론 해당 객체내의 toString의 Override 용으로 사용한다.
     * 
     * @param obj
     * @return
     */
    public static String objToString(Object obj) {
        return ToStringBuilder.reflectionToString(obj, ToStringStyle.SHORT_PREFIX_STYLE);
    }

    /**
     * 현재 년도에 addYear를 더한 값을 구하여 YYYY로 반환
     * 
     * @param addYear
     * @return
     */
    public static String getYYYY(int addYear) {
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy");
        java.util.Calendar cal = java.util.Calendar.getInstance();
        cal.add(Calendar.YEAR, addYear);
        return sdf.format(cal.getTime());
    }

    /**
     * 현재 년도에 addMonth 더한 값을 구하여 MM로 반환
     * 
     * @param addMonth
     * @return
     */
    public static String getMM(int addMonth) {
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("MM");
        java.util.Calendar cal = java.util.Calendar.getInstance();
        cal.add(Calendar.MONTH, addMonth);
        return sdf.format(cal.getTime());
    }

    /**
     * 현재 년도 YYYY를 구한다.
     * 
     * @return
     */
    public static String getYYYY() {
        return getYYYY(0);
    }

    /**
     * 현재 월 MM를 구한다.
     * 
     * @return
     */
    public static String getMM() {
        return getMM(0);
    }

    /**
     * 현재 일자를 yyyyMM 형식으로 반환
     * 
     * @return
     */
    public static String getYYYYMM() {
        return getYYYYMM(0);
    }

    /**
     * 현재년월 + addMonth -> 가져올 yyyyMM<br>
     * 예) getYYYYMM(-1) ==> 한달전 yyyyMM 를 가져옴.
     * 
     * @param addMonth
     * @return
     */
    public static String getYYYYMM(int addMonth) {
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMM");
        java.util.Calendar cal = java.util.Calendar.getInstance();
        cal.add(Calendar.MONTH, addMonth);
        return sdf.format(cal.getTime());
    }

    /**
     * 현재년월 + addMonth -> 가져올 yyyyMMdd<br>
     * 예) getYYYYMMdd(-1) ==> 한달전 yyyyMMdd 를 가져옴.
     * 
     * @param addMonth
     * @return
     */
    public static String getYYYYMMDDAddMth(int addMonth) {
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMdd");
        java.util.Calendar cal = java.util.Calendar.getInstance();
        cal.add(Calendar.MONTH, addMonth);
        return sdf.format(cal.getTime());
    }

    /**
     * 현재 일자에 addDate 만큼 일자를 더한 후 <br>
     * 넘어온 format형식으로 반환한다.
     * 
     * @param format
     * @param addDate
     * @return
     */
    public static String getYYYYMMDD(String format, int addDate) {
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(format);
        java.util.Calendar cal = java.util.Calendar.getInstance();
        cal.add(Calendar.DATE, addDate);
        return sdf.format(cal.getTime());
    }

    /**
     * 현재 일자를 yyyyMMddHHmmssS 형식으로 반환
     * 
     * @return
     */
    public static String getCurTime() {
        return getYYYYMMDD("yyyyMMddHHmmssS", 0);
    }

    /**
     * 현재 일자를 yyyyMMdd 형식으로 반환
     * 
     * @return
     */
    public static String getYYYYMMDD() {
        return getYYYYMMDD("yyyyMMdd", 0);
    }

    /**
     * 어제 일자를 가져온다.
     * 
     * @return
     */
    public static String getYesterDay() {
        return getYYYYMMDD("yyyyMMdd", -1);
    }

    /**
     * 현재 일자를 넘어온 format 형식으로 반환
     * 
     * @param format
     * @return
     */
    public static String getYYYYMMDD(String format) {
        return getYYYYMMDD(format, 0);
    }

    /**
     * 현재일자에 addDate를 더한 일자를 yyyyMMdd 형식으로 반환
     * 
     * @param addDate
     * @return
     */
    public static String getYYYYMMDD(int addDate) {
        return getYYYYMMDD("yyyyMMdd", addDate);
    }

    public static String getAddDate(String fromdate, String format, int addYear, int addMonth, int addDate) throws ParseException {
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(format);
        Date date = sdf.parse(fromdate);
        Calendar cal = new GregorianCalendar();

        cal.setTime(date);
        cal.add(Calendar.YEAR, addYear);
        cal.add(Calendar.MONTH, addMonth);
        cal.add(Calendar.DATE, addDate);

        SimpleDateFormat sdf2 = new SimpleDateFormat(format);
        return sdf2.format(cal.getTime());
    }

    /**
     * 요일을 추출한다. 일=1 월=2 화=3 수=4 목=5 금=6 토=7
     * 
     * @param date
     * @return
     */
    public static int getDayofWeek(String fromdate) throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Date date = sdf.parse(fromdate);
        Calendar cal = new GregorianCalendar();
        cal.setTime(date);
        return cal.get(Calendar.DAY_OF_WEEK);
    }

    /**
     * 게시판 타입의 parent type을 구한다.
     * 
     * @param category
     * @param board_type
     * @return
     */
    public static String resolveBoardType(String category, String board_type) {
        if (category.equals("community")) {
            if (board_type == null || "community".equals(board_type)) {
                return "community";
            } else if ("free".equals(board_type) || "review".equals(board_type) || "notice".equals(board_type)) {
                return board_type;
            } else {
                return null;
            }
        } else if ("customer".equals(category)) {
            return "faq";
        }
        return null;
    }

    /**
     * 해당 int에 세자리마다 콤마를 찍어 String type으로 반환한다.
     * 
     * @param num
     * @return
     */
    public static String decimalFormat(int num) {
        return decimalFormat(num, "#,###");
    }

    /**
     * 해당 int를 넘어온 format 형식으로 반환하여 String type으로 반환
     * 
     * @param num
     * @param format
     * @return
     */
    public static String decimalFormat(int num, String format) {
        DecimalFormat df = new DecimalFormat(format);
        return df.format(num);
    }

    /**
     * 해당 long 값을 세자리 콤마를 찍어 String type으로 반환
     * 
     * @param num
     * @return
     */
    public static String decimalFormat(long num) {
        return decimalFormat(num, "#,###");
    }

    /**
     * 해당 long값을 format 형식으로 반환
     * 
     * @param num
     * @param format
     * @return
     */
    public static String decimalFormat(long num, String format) {
        DecimalFormat df = new DecimalFormat(format);
        return df.format(num);
    }

    /**
     * 해당 double값을 세자리 콤마를 찍어 반환
     * 
     * @param num
     * @return
     */
    public static String decimalFormat(double num) {
        return decimalFormat(num, "#,###.##");
    }

    /**
     * 해당 float값을 세자리 콤마를 찍어 반환
     * 
     * @param num
     * @return
     */
    public static String decimalFormat(float num) {
        return decimalFormat(num, "#,###.##");
    }

    /**
     * 해당 double 값을 format 형식으로 반환
     * 
     * @param num
     * @param format
     * @return
     */
    public static String decimalFormat(double num, String format) {
        DecimalFormat df = new DecimalFormat(format);
        return df.format(num);
    }

    /**
     * SMS를 보내기 위해 현재 일자를 date 형식(yyyy-MM-dd HH:mm:ss)으로 변환
     * 
     * @return
     */
    public static String getSMSDate() {
        return getYYYYMMDD("yyyy-MM-dd HH:mm:ss");
    }

    /**
     * 현재일자를 yyMM 형식으로 반환
     * 
     * @return
     */
    public static String getYYMM() {
        return getYYYYMMDD("yyMM");
    }

    /**
     * sms를 보내기 위한 Unique sequence를 구한다.
     * 
     * @return
     */
    public static String getSMSSeq() {
        //String seq = getYYYYMMDD("yyyyMMddHHmmssS");
        StringBuilder seqSb = new StringBuilder();
        seqSb.append(getYYYYMMDD("yyyyMMddHHmmssS"));
        if (seqSb.length() < 18) {
            for (int k = seqSb.length(); k < 18; k++)
                //seq += "0";
            	seqSb.append("0");
        }
        return "MB" + seqSb.toString();
    }
    
    /**
     * spring MVC에서 parameter에 값이 겹치는 경우 String 배열이 String으로 변환되면서, <br>
     * 콤마로 값이 구분 되는데, 이를 파싱하여 맨 마지막 값을 추출하여 가져온다.
     * 
     * @param str
     * @return
     */
    public static String removeWrongParameter(String str) {
        if (str == null)
            return "";
        int seq = str.indexOf(',');
        if (seq > 0) {
            return str.substring(str.indexOf(',') + 1);
        }
        return str;
    }

    /**
     * String을 Unicode(HexString)으로 변환하여 가져옴.
     * 
     * @param str
     * @return
     */
    public static String strToUnicode(String str) {
        if (str == null)
            return null;
        //String uni = "";
        StringBuilder uniSb = new StringBuilder();
        for (int i = 0; i < str.length(); i++) {
            char chr = str.charAt(i);
            String hex = Integer.toHexString(chr);
            uniSb.append("%u"+hex);
            //uni += "%u" + hex;
        }
        return uniSb.toString();
    }

    /**
     * uniCode(HexString)을 일반 String으로 변환하여 반환
     * 
     * @param uni
     * @return
     */
    public static String uniCodeToStr(String uni) {
        if (uni == null)
            return null;
        //String str = "";
        StringBuilder strSb = new StringBuilder();
        StringTokenizer str1 = new StringTokenizer(uni, "%u");
        while (str1.hasMoreTokens()) {
            String str2 = str1.nextToken();
            try {
                int i = Integer.parseInt(str2, 16);
                strSb.append((char)i);
                //str += (char) i;
            } catch (Exception e) {
                //str += str2;
            	strSb.append(str2);
            }
        }
        return strSb.toString();
    }

    /**
     * HTML 태그 제거
     * 
     * @param str
     * @return
     */
    public static String removeTag(String str) {
        if (str == null) {
            return "";
        }

        return str.replaceAll("\\<.*?\\>", "");

    }

    /**
     * HTML 태그 및 주석 기타 등등 제거 <, >, ", ', &, %, !, --
     */
    public static String removeHtmlSpecials(String str) {
        if (str == null) {
            return "";
        }

        return str.replaceAll("(<|>|\"|'|&|%|!|--)", "");
    }

    public static String removeHtmlTag(String html) {
        html = CommUtil.checkEmpty(html);
        html = html.replaceAll("&amp;", "&");
        html = html.replaceAll("&lt;", "<");
        html = html.replaceAll("&gt;", ">");
        Pattern pattern = Pattern.compile("\\<(\\/?)(\\w+)*([^<>]*)>");
        Matcher matcher = pattern.matcher(html);
        if (matcher.find())
            return matcher.replaceAll("");

        html = html.replaceAll("&", "&amp;");
        html = html.replaceAll("<", "&lt;");
        html = html.replaceAll(">", "&gt;");
        return html;
    }

    /**
     * HTML 스크립트 및 프레임 폼 태그 제거
     * 
     * @param str
     * @return
     */
    public static String removeScript(String str) {
        if (str == null) {
            return "";
        }

        return str.replaceAll("\".*\\s?>//b", "").replaceAll("\\r?\\n", "").replaceAll("(amp;)+", "amp;").replaceAll("&amp;", "&")
                .replaceAll("&lt;", "<").replaceAll("&gt;", ">").replaceAll("<(?i)(script).*?>.*</(?i)(script).*?>", "")
                .replaceAll("</?(?i)(input|textarea|iframe|frame|script|select).*?>?", "").replaceAll("<(?i)(script).*?>.*$", "")
                .replaceAll("(?i)(document.write|alert)\\(.*\\);?", "");
    }

    /**
     * parameter 직접 입력 script 태그 제거
     * 
     * @param str
     * @return
     */
    public static String removeUrlScript(String str) {
        if (str == null) {
            return "";
        }

        return str.replaceAll("%22", "\"").replaceAll("(&lt;|%3C)", "<").replaceAll("(&gt;|%3E)", ">").replaceAll("\".*\\s?>", "")
                .replaceAll("\\r?\\n", "").replaceAll("(amp;)+", "amp;").replaceAll("&amp;", "&")
                .replaceAll("<(?i)(script).*?>.*</(?i)(script).*?>", "")
                .replaceAll("</?(?i)(input|textarea|iframe|frame|script|select).*?>", "").replaceAll("<(?i)(script).*?>.*$", "")
                .replaceAll("(?i)(document.write|alert)\\(.*\\);?", "");
    }

    /**
     * 해당 Text를 주어진 길이 만큼 자른다.
     * 
     * @param szText
     * @param nLength
     * @return
     */
    public static String strCut(String szText, int nLength) {
        return strCut(szText, null, nLength, 0, true, true);
    }

    /**
     * 이미지 태그를 포함하고 있는지 여부 검사
     * 
     * @param str
     * @return
     */
    public static boolean findImgTag(String str) {
        if (str == null)
            return false;
        Pattern p = Pattern.compile("<IMG[^>]*>", Pattern.CASE_INSENSITIVE);
        return p.matcher(str).find();
    }

    /**
     * @param szText
     * @param szKey
     * @param nLength
     * @param nPrev
     * @param isNotag
     * @param isAdddot
     * @return
     */
    public static String strCut(String szText, String szKey, int nLength, int nPrev, boolean isNotag, boolean isAdddot) {
        if (szText == null) {
            return "";
        }
        String r_val = szText;
        int oF = 0, oL = 0, rF = 0, rL = 0;
        int nLengthPrev = 0;
        Pattern p = Pattern.compile("<(/?)([^<>]*)?>", Pattern.CASE_INSENSITIVE);

        if (isNotag) {
            r_val = p.matcher(r_val).replaceAll("");
        }
        r_val = r_val.replaceAll("&amp;", "&");
        r_val = r_val.replaceAll("(!/|\r|\n|&nbsp;)", "");

        try {
            byte[] bytes = r_val.getBytes("UTF-8");
            if (szKey != null && !szKey.equals("")) {
                nLengthPrev = (r_val.indexOf(szKey) == -1) ? 0 : r_val.indexOf(szKey);
                nLengthPrev = r_val.substring(0, nLengthPrev).getBytes("MS949").length;
                nLengthPrev = (nLengthPrev - nPrev >= 0) ? nLengthPrev - nPrev : 0;
            }

            int j = 0;

            if (nLengthPrev > 0)
                while (j < bytes.length) {
                    if ((bytes[j] & 0x80) != 0) {
                        oF += 2;
                        rF += 3;
                        if (oF + 2 > nLengthPrev) {
                            break;
                        }
                        j += 3;
                    } else {
                        if (oF + 1 > nLengthPrev) {
                            break;
                        }
                        ++oF;
                        ++rF;
                        ++j;
                    }
                }

            j = rF;

            while (j < bytes.length) {
                if ((bytes[j] & 0x80) != 0) {
                    if (oL + 2 > nLength) {
                        break;
                    }
                    oL += 2;
                    rL += 3;
                    j += 3;
                } else {
                    if (oL + 1 > nLength) {
                        break;
                    }
                    ++oL;
                    ++rL;
                    ++j;
                }
            }

            r_val = new String(bytes, rF, rL, "UTF-8"); // charset �ɼ�

            if (isAdddot && rF + rL + 3 <= bytes.length) {
                r_val += "..";
            }
        } catch (UnsupportedEncodingException e) {
            //e.printStackTrace();
        	System.err.print("Byte Change Error!");
        }

        return r_val;
    }

    /**
     * 파일명에서 확장자만 축출하여 반환(dot 포함)
     * 
     * @param str
     * @return
     */
    public static String parseFileExt(String str) {
        if (str == null)
            return "";
        if (str.lastIndexOf('.') > 0) {
            return str.substring(str.lastIndexOf('.'));
        } else {
            return "";
        }
    }

    /**
     * 파일 확장자 가져오기.(dot 포함하지 않음)
     * 
     * @param str
     * @return
     */
    public static String getFileExt(String str) {
        if (str == null)
            return "";
        if (str.lastIndexOf('.') > 0) {
            return str.substring(str.lastIndexOf('.') + 1);
        } else {
            return "";
        }
    }

    /**
     * 주어진 파일명에서 확장자만 축출 한 후 현재시간+확장자 명으로 변환.
     * 
     * @param orig
     * @return
     */
    public static String getCurFileName(String orig) {
        if (orig == null)
            return "";
        return CommUtil.getCurTime() + parseFileExt(orig);
    }

    /**
     * 주어진 파일명에서 확장자를 축출 후 , 현재시간 + 시퀀스값+확장자 명으로 변환
     * 
     * @param orig
     * @param seq
     * @return
     */
    public static String getCurFileName(String orig, int seq) {
        return getCurFileName(orig, "" + seq);
    }

    public static String getCurFileName(String orig, String seq) {
        if (orig == null)
            return "";
        return CommUtil.getCurTime() + "_" + seq + parseFileExt(orig);
    }

    /**
     * 주어진 8자리 date String값을 주어진 division(- . / 등)으로 구분하여 반환.
     * 
     * @param yyyymmdd
     * @param division
     * @return
     */
    public static String parseDate(String yyyymmdd, String division) {
        if (yyyymmdd == null) {
            return "";
        }
        if (yyyymmdd.length() == 8)
            return yyyymmdd.substring(0, 4) + division + yyyymmdd.substring(4, 6) + division + yyyymmdd.substring(6);
        else if (yyyymmdd.length() == 6)
            return yyyymmdd.substring(0, 4) + division + yyyymmdd.substring(4, 6);

        return yyyymmdd;
    }

    /**
     * 주어진 8자리 date 값을 yyyy.MM.dd 로 변환
     * 
     * @param yyyymmdd
     * @return
     */
    public static String parseDotDate(String yyyymmdd) {
        return parseDate(yyyymmdd, ".");
    }

    /**
     * 주어진 8자리 date 값을 yyyy-MM-dd 로 변경
     * 
     * @param yyyymmdd
     * @return
     */
    public static String parseDashDate(String yyyymmdd) {
        return parseDate(yyyymmdd, "-");
    }

    /**
     * 해당 일자에서 division 제거
     * 
     * @param org
     * @param division
     * @return
     */
    public static String removeDivision(String org, String division) {
        if (org == null)
            return "";
        else
            return org.replaceAll(division, "");
    }

    /**
     * yyyy.MM.dd 에서 yyyyMMdd로 변경
     * 
     * @param org
     * @return
     */
    public static String removeDot(String org) {
        return removeDivision(org, "\\.");
    }

    /**
     * yyyy-MM-dd 에서 yyyyMMdd로 변경
     * 
     * @param org
     * @return
     */
    public static String removeDash(String org) {
        return removeDivision(org, "-");
    }

    /**
     * yyyy/MM/dd 에서 yyyyMMdd로 변경
     * 
     * @param org
     * @return
     */
    public static String removeSlash(String org) {
        return removeDivision(org, "/");
    }

    /**
     * 해당 문자열에서 reverseSlash(\)를 제거
     * 
     * @param org
     * @return
     */
    public static String removeReverseSlash(String org) {
        return removeDivision(org, "\\");
    }

    /**
     * 해당 월의 마지막 일자를 구한다.
     * 
     * @param yyyymm
     * @return
     */
    public static int getLastDayOfMonth(String yyyymm) {
        if (yyyymm == null || yyyymm.length() == 0) {
            return 0;
        }

        Calendar cal = Calendar.getInstance();
        int yyyy = Integer.parseInt(yyyymm.substring(0, 4));
        int mm = Integer.parseInt(yyyymm.substring(4, 6));
        cal.set(yyyy, mm - 1, 1);
        int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        return lastDay;
    }

    /**
     * ExtJs의 date 형식에서 yyyyMMdd 형식으로 변환<br>
     * 2009-10-13T00:00:00 To 20091013
     * 
     * @param extJsDate
     * @return
     */
    public static String parseExtJsDate(Object extJsDate) {
        if (isEmpty(extJsDate)) {
            return "";
        }
        String _extjsDate = (String) extJsDate;

        return _extjsDate.replaceAll("-", "").substring(0, 8);
    }

    /**
     * ExtJs의 date 형식에서 yyyyMMdd 형식으로 변환<br>
     * 2009-10-13T00:00:00 To 20091013
     * 
     * @param extJsDate
     * @return
     */
    public static String parseExtJsDateYm(Object extJsDate) {
        if (isEmpty(extJsDate)) {
            return "";
        }
        String _extjsDate = (String) extJsDate;

        return _extjsDate.replaceAll("-", "").substring(0, 6);
    }

    public static final int TWO_DIGIT_MAX_INT = 1036;
    public static final int THREE_DIGIT_MAX_INT = 27935;

    public static final int TWO_DIGIT_MAX = 99;
    public static final int TWO_DIGIT_DIV_NUM = 36;

    public static final int THREE_DIGIT_MAX = 999;
    public static final int THREE_DIGIT_DIV_NUM = TWO_DIGIT_MAX_INT;

    public static final int ALPHABET_START_NUM = 65;

    /**
     * 1부터 27935까지의 숫자를 001 ~ zzz 까지의 값으로 변환 <br>
     * <b>계산식<b> <br>
     * 2자리 max값 : 1035 <br>
     * a~z : 26 <br>
     * 세자리 숫자 max값 : 999 <br>
     * a00, b00 ... y00,z00: 26 <br>
     * 1035 * 26 + 999 +26 = 27935
     * 
     * @param num
     * @return
     */
    public static String getDigit3Max(int num) {
        StringBuffer max = new StringBuffer();
        if (num < 1000) {
            if (num < 10)
                return "00" + num;
            if (num < 100)
                return "0" + num;
            else
                return "" + num;
        } else {
            int subNum = num - 999;
            int alphabetReadyNum = ((subNum - 1) / THREE_DIGIT_DIV_NUM);
            int alphabetReadyDivNum = ((subNum - 1) % THREE_DIGIT_DIV_NUM);
            if (alphabetReadyNum > 25) {
                return "error";
            } else {
                max.append((char) (ALPHABET_START_NUM + alphabetReadyNum));
                max.append(getDigit2Max(alphabetReadyDivNum));
            }
            return max.toString();
        }
    }

    /**
     * 1 부터 1035까지의 숫자를 01 ~ zz 까지의 값으로 변환.<br>
     * 계산식 <br>
     * 0~9 : 10 <br>
     * a~z : 26 <br>
     * 두자리 숫자 max값 : 99 <br>
     * (10+26) x 26 + 99 = 1035
     * 
     * @param num
     * @return
     */
    public static String getDigit2Max(int num) {
        StringBuffer max = new StringBuffer();
        if (num < 100) {
            if (num < 10)
                return "0" + num;
            else
                return "" + num;
        } else {
            int subNum = num - TWO_DIGIT_MAX;
            int alphabetReadyNum = ((subNum - 1) / TWO_DIGIT_DIV_NUM);
            int alphabetReadyDivNum = ((subNum - 1) % TWO_DIGIT_DIV_NUM);
            if (alphabetReadyNum > 25) {
                return "error";
            } else {
                max.append((char) (ALPHABET_START_NUM + alphabetReadyNum));
                if (alphabetReadyDivNum < 10) {
                    max.append(alphabetReadyDivNum);
                } else {
                    max.append((char) (ALPHABET_START_NUM + alphabetReadyDivNum - 10));
                }
            }
            return max.toString();
        }
    }

    /**
     * 파일 다운 로드시 한글 이름을 URLEncode 한 후 <br>
     * 올바른 공백 처리를 해준다.
     * 
     * @param str
     * @return
     */
    public static String getEncodedName(String str) {
        String encodedName = "";
        if (isEmpty(str)) {
            return encodedName;
        }
        try {
            encodedName = java.net.URLEncoder.encode(str, "UTF-8").replaceAll("\\+", " ");
        } catch (UnsupportedEncodingException e) {
            encodedName = "";
        }

        return encodedName;
    }

    public static boolean isValidEmail(String email) {
        return true;

        // String expression =
        // "^[\\w\\-]([\\.\\w])+[\\w]+@([\\w\\-]+\\.)+[A-Z]{2,4}$";
        // CharSequence inputStr = email;
        // Pattern pattern = Pattern.compile(expression,
        // Pattern.CASE_INSENSITIVE);
        // Matcher matcher = pattern.matcher(inputStr);
        // return matcher.matches();

    }

    /**
     * n개의 char로 이루어진 임의의 패스워드를 가져온다.
     * 
     * @param n
     * @return
     */
    public static String getPassword(int n) {
        char[] pw = new char[n];
        int c = 'A';
        int r1 = 0;
        for (int i = 0; i < n; i++) {
            r1 = (int) (Math.random() * 3);
            switch (r1) {
                case 0:
                    c = '0' + (int) (Math.random() * 10);
                    break;
                case 1:
                    c = 'a' + (int) (Math.random() * 26);
                    break;
                case 2:
                    c = 'A' + (int) (Math.random() * 26);
                    break;
            }
            pw[i] = (char) c;
        }
        return new String(pw);
    }

    /**
     * 문자열의 실제 Bytes 크기를 가져온다
     * 
     * @param str
     * @return
     */
    public static int getBytes(String str) {
        int length = 0;
        if (str == null) {
            return -1;
        }
        // UTF-8인 경우
        if (isUtf8(str)) {
            for (int i = 0; i < str.length(); i++) {
                if ((str.charAt(i) >= 0x0001) && (str.charAt(i) <= 0x007F)) {
                    length++;
                } else if (str.charAt(i) > 0x07FF) {
                    length += 3;
                } else {
                    length += 2;
                }
            }
        } else {
            for (int i = 0; i < str.length(); i++) {
                if (str.charAt(i) < 0xac00 || str.charAt(i) > 0xd7a3) {
                    length++;
                } else {
                    length += 2;
                }
            }
        }
        return length;
    }

    /**
     * 해당 문자열이 UTF-8 인코딩 된것인지 판단
     * 
     * @param val
     * @return
     */
    public static boolean isUtf8(String val) {
        if (val == null)
            return false;
        else {
            byte[] b;

            try {
                b = val.getBytes("8859_1");
                CharsetDecoder decoder = Charset.forName("UTF-8").newDecoder();
                try {
                    decoder.decode(ByteBuffer.wrap(b));
                } catch (CharacterCodingException e) {
                    return false;
                }
            } catch (UnsupportedEncodingException e1) {
                e1.printStackTrace();
            }
            return true;
        }
    }

    /**
     * 해당 문자열을 UTF-8로 변환<br/>
     * 이미 UTF-8 문자라면 인코딩 무시
     * 
     * @param val
     * @return
     */
    public static String euckrToUtf8(String val) {
        if (isEmpty(val))
            return null;

        if (isUtf8(val)) {
            return val;
        } else {
            try {
                return new String(val.getBytes("8859_1"), "UTF-8");
            } catch (UnsupportedEncodingException e) {
                return val;
            }
        }
    }

    /**
     * 해당 object의 String field를 뽑아서 <br/>
     * UTF-8 인코딩으로 변환
     * 
     * @param obj
     * @return
     */
    public static Object objEuckrToUtf8(Object obj) {
        if (isEmpty(obj))
            return null;

        Field[] fields = obj.getClass().getDeclaredFields();

        for (Field field : fields) {
            if (isStringField(field)) {
                String cFieldName = StringUtils.capitalize(field.getName());
                try {
                    Method setMethod = obj.getClass().getMethod("set" + cFieldName, java.lang.String.class);
                    Method getMethod = obj.getClass().getMethod("get" + cFieldName, null);
                    if (!isEmpty(setMethod) && !isEmpty(getMethod))
                        setMethod.invoke(obj, euckrToUtf8((String) getMethod.invoke(obj, null)));
                } catch (SecurityException e) {
                    //e.printStackTrace();
                	System.err.print("Security Error!");
                } catch (NoSuchMethodException e) {
                	//e.printStackTrace();
                	System.err.print("NoSuchMethod Error!");
                } catch (IllegalArgumentException e) {
                    //e.printStackTrace();
                	System.err.print("IllegalArgument Error!");
                } catch (IllegalAccessException e) {
                    //e.printStackTrace();
                	System.err.print("IllegalAccess Error!");
                } catch (InvocationTargetException e) {
                    //e.printStackTrace();
                	System.err.print("InvocationTarget Error!");
                }
            }
        }

        return obj;
    }

    /**
     * 해당 Field가 String Field인지 판단
     * 
     * @param field
     * @return
     */
    public static boolean isStringField(Field field) {
        if (isEmpty(field))
            return false;
        if ("String".equals(field.getType().getSimpleName()))
            return true;
        else
            return false;
    }

    /**
     * 해당 문자열이 EUC-KR 문자인지 확인
     * 
     * @param val
     * @return
     */
    public static boolean isEucKr(String val) {
        if (val == null)
            return false;
        else {
            byte[] b;

            try {
                b = val.getBytes("8859_1");
                CharsetDecoder decoder = Charset.forName("EUC-KR").newDecoder();
                try {
                    decoder.decode(ByteBuffer.wrap(b));
                } catch (CharacterCodingException e) {
                    return false;
                }
            } catch (UnsupportedEncodingException e1) {
                e1.printStackTrace();
            }
            return true;
        }
    }

    /**
     * 해당문자열을 EUC-KR 로 변환<br/>
     * 이미 EUC-KR문자라면 무시
     * 
     * @param val
     * @return
     */
    public static String utf8ToEuckr(String val) {
        if (isEmpty(val))
            return null;

        if (isEucKr(val)) {
            return val;
        } else {
            try {
                return new String(val.getBytes("8859_1"), "EUC-KR");
            } catch (UnsupportedEncodingException e) {
                return val;
            }
        }
    }

    /**
     * 해당 Object에서 String Field만 뽑아 EUC-KR로 변환
     * 
     * @param obj
     * @return
     */
    public static Object objUtf8ToEuckr(Object obj) {
        if (isEmpty(obj))
            return null;

        Field[] fields = obj.getClass().getDeclaredFields();

        for (Field field : fields) {
            if (isStringField(field)) {
                String cFieldName = StringUtils.capitalize(field.getName());
                try {
                    Method setMethod = obj.getClass().getMethod("set" + cFieldName, java.lang.String.class);
                    Method getMethod = obj.getClass().getMethod("get" + cFieldName, null);
                    if (!isEmpty(setMethod) && !isEmpty(getMethod))
                        setMethod.invoke(obj, utf8ToEuckr((String) getMethod.invoke(obj, null)));
                } catch (SecurityException e) {
                    //e.printStackTrace();
                    System.err.print("Security Error!");
                } catch (NoSuchMethodException e) {
                    //e.printStackTrace();
                	System.err.print("NoSuchMethod Error!");
                } catch (IllegalArgumentException e) {
                    //e.printStackTrace();
                	System.err.print("IllegalArgument Error!");
                } catch (IllegalAccessException e) {
                    //e.printStackTrace();
                	System.err.print("IllegalAccess Error!");
                } catch (InvocationTargetException e) {
                    //e.printStackTrace();
                	System.err.print("InvocationTarget Error!");
                }
            }
        }

        return obj;
    }

    /**
     * 전화번호 체크
     * 
     * @param mdn
     * @return
     */
    public static String checkSmsMdn(String mdn) {
        mdn = CommUtil.checkEmpty(mdn, "none").replaceAll("-", "");
        try {
            if (mdn.length() > 11) {
                throw new Exception();
            }
            Integer.parseInt(mdn);
        } catch (Exception nfe) {
            return null;
        }
        return mdn;
    }

    /**
     * priority 값 체크
     * 
     * @param priority
     * @return
     */
    public static int checkSmsPrty_rank(int prty_rank) {
        switch (prty_rank) {
            case 10:
            case 50:
            case 90:
                return prty_rank;
            default:
                return 50;
        }
    }

    /**
     * 문자열의 body 태크를 삭제한다
     */

    public static String stripBodyTag(String text) {
        if (isEmpty(text)) {
            return text;
        }
        return text.replaceAll("(<|&lt;)(?i)body.*?(>|&gt;).*?(<|&lt;)/(?i)body(>|&gt;)", "").replaceAll(
                "((<|&lt;)(?i)body.*?(>|&gt;)|(<|&lt;)/(?i)body(>|&gt;))", "");

    }

    /**
     * 해당 스트링이 숫자로만 이루어진 값인지 검사
     * 
     * @param str
     * @return
     */
    public static boolean NumberCheck(String str) {
        for (int i = 0; i < str.length(); i++) {
            if (!Character.isDigit(str.charAt(i))) {
                return false;
            }
        }
        return true;
    }

    /**
     * LTRIM 왼쪽 공백 제거
     * 
     * @param source
     * @return
     */
    public static String ltrim(String source) {
        if (isEmpty(source)) {
            return "";
        }
        return source.replaceAll("^\\s+", "");
    }

    /**
     * RTRIM 오른쪽 공백 제거
     * 
     * @param source
     * @return
     */
    public static String rtrim(String source) {
        if (isEmpty(source)) {
            return "";
        }
        return source.replaceAll("\\s+$", "");
    }

    /**
     * TRIM 왼쪽 / 오른쪽 공백 모두 제거
     * 
     * @param source
     * @return
     */
    public static String trim(String source) {
        return ltrim(rtrim(source));
    }

    /**
     * md5로 암호화 한 결과 리턴
     * 
     * @param text
     * @return
     * @throws NoSuchAlgorithmException
     */
    public static String md5(String text) throws NoSuchAlgorithmException {
        if (isEmpty(text)) {
            return "";
        }

        MessageDigest messageDigest;
        StringBuffer sb = new StringBuffer();

        messageDigest = MessageDigest.getInstance("MD5");
        byte[] result = messageDigest.digest(text.getBytes());
        for (byte b : result) {
            sb.append(String.format("%02x", b));
        }

        return sb.toString();
    }

    /**
     * query string의 파라미터를 Map으로 가져온다
     * 
     * @param url
     * @return
     */
    public static Map<String, String> param2Map(String url) {
        if (isEmpty(url)) {
            return null;
        }

        url = url.replaceAll("^.*\\?", "");
        String[] arr = url.split("&");

        Map<String, String> map = new HashMap<String, String>();
        String[] temp = null;

        for (String s : arr) {
            temp = s.split("=", 2);
            if (temp.length > 1) {
                map.put(temp[0], temp[1]);
            } else {
                map.put(temp[0], "");
            }
        }

        return map;
    }

    /**
     * 파일 업로드 유효성 체크<br/>
     * 올바른 이미지 파일인지 검사한다.
     * 
     * @param mf MultipartFile
     * @return 이미지 파일 여부(true/false)
     */
    public static boolean isValidImageFile(MultipartFile mf) {
        String mimeType = isValidImageType(mf);
        if (isEmpty(mimeType)) {
            return false;
        } else {
            return true;
        }

    }

    /**
     * 해당 파일이 이미지 파일일 경우에만 mimeType 리턴<br/>
     * 이미지 파일이 아닐 경우 NULL 리턴
     * 
     * @param mf MultipartFile
     * @return mimeType
     */
    public static String isValidImageType(MultipartFile mf) {
        if (mf == null) {
            logger.error("==파일업로드 MultipartFile is NULL");
            return null;
        }
        // 1. 확장자 체크
        String ext = CommUtil.getFileExt(mf.getOriginalFilename());

        String[] validImageExt = CommProperty.getProperty("valid.image.ext").split(",");

        int validCnt = 0;
        for (int i = 0; i < validImageExt.length; i++) {
            if (ext.equalsIgnoreCase(validImageExt[i])) {
                validCnt++;
                break;
            }
        }
        if (validCnt == 0) {
            logger.error("==허용되지 않는 확장자:" + ext);
            return null;
        }

        // 2. mimeType 체크
        String mimeType = "";
        try {
            Collection<?> mimeTypes = MimeUtil.getMimeTypes(mf.getBytes());
            mimeType = mimeTypes.toString();
            logger.info("mimeType:" + mimeType);
        } catch (Exception e) {
            //e.printStackTrace();
        	System.err.print("Collection Error!");
        }

        if (!mimeType.startsWith("image")) {
            logger.error("==허용되지 않는 MIME 타입:" + mimeType);
            return null;
        }
        return mimeType;
    }

    /**
     * 파일 업로드 유효성 체크 <br/>
     * 파일 확장자 및 mimeType 목록을 받아 유효성 검사
     * 
     * @param mf MultipartFile
     * @param validExt 허용 확장자 목록
     * @param validMimeType 허용 마임타입 목록
     * @return 올바른 마임타입인지 여부(true/false)
     */
    public static boolean isValidFile(MultipartFile mf, String[] validExt, String[] validMimeType) {
        String mimeType = isValidMimeType(mf, validExt, validMimeType);
        if (isEmpty(mimeType)) {
            return false;
        } else {
            return true;
        }
    }

    /**
     * 해당하는 파일이 허용하는 mimeType 목록에 있는 경우만 mimeType을 리턴<br/>
     * 허용하지 않는 타입일 경우에는 NULL 리턴
     * 
     * @param mf MultipartFile
     * @param validExt 허용하는 확장자 목록
     * @param validMimeType 허용하는 마임타입 목록
     * @return mimeType
     */
    public static String isValidMimeType(MultipartFile mf, String[] validExt, String[] validMimeType) {
        if (mf == null) {
            logger.error("==파일업로드 MultipartFile is NULL");
            return null;
        }

        if (validExt == null || validExt.length == 0) {
            logger.error("==파일업로드 valid Ext Array is NULL ");
            return null;
        }

        if (validMimeType == null || validMimeType.length == 0) {
            logger.error("==파일업로드 validMimeType Array is NULL ");
            return null;
        }

        if (logger.isInfoEnabled()) {
            logger.info("validExt 목록:" + Arrays.toString(validExt));
            logger.info("validMimeType 목록:" + Arrays.toString(validMimeType));
        }
        // 1. 확장자 체크
        String ext = CommUtil.getFileExt(mf.getOriginalFilename());

        int validCnt = 0;
        for (int i = 0; i < validExt.length; i++) {
            if (ext.equalsIgnoreCase(validExt[i])) {
                validCnt++;
                break;
            }
        }

        // 이미지 확장자 기본 체크
        String[] validImageExt = CommProperty.getProperty("valid.image.ext").split(",");
        for (int i = 0; i < validImageExt.length; i++) {
            if (ext.equalsIgnoreCase(validImageExt[i])) {
                validCnt++;
                break;
            }
        }

        if (validCnt == 0) {
            logger.error("==허용되지 않는 확장자:" + ext);
            return null;
        }

        // 2. mimeType 체크
        String mimeType = "";
        try {
            Collection<?> mimeTypes = MimeUtil.getMimeTypes(mf.getBytes());
            mimeType = mimeTypes.toString();
            logger.info("mimeType:" + mimeType);
        } catch (Exception e) {
            //e.printStackTrace();
        	System.err.print("Collection Error!");
        }

        validCnt = 0;
        for (int i = 0; i < validMimeType.length; i++) {
            if (mimeType.equalsIgnoreCase(validMimeType[i])) {
                validCnt++;
                break;
            }
        }

        // 이미지 mimeType 기본 체크
        if (mimeType.startsWith("image"))
            validCnt++;

        if (validCnt == 0) {
            logger.error("==허용되지 않는 MIME 타입:" + mimeType);
            return null;
        }

        return mimeType;
    }

    /**
     * Sequence Id 값을 받아 URL로 분리하여준다.
     * 
     * @param cont_id
     * @return
     */
    public static String getStroageUrl(String cont_id) throws Exception {
        String url = null;
        if (isEmpty(cont_id) || cont_id.length() != 10) {
            throw new Exception("컨텐츠 아이디가 10자리가 아닙니다.");
        }
        url = cont_id.substring(0, 4) + "/" + cont_id.substring(4, 7) + "/" + cont_id.substring(7, 10);
        return url;
    }

    static Random random = new Random(System.currentTimeMillis());

    /**
     * 인증 키 값을 가져온다.
     * 
     * @param length = 난수 길이 (NCA = 16 자리)
     * @param user_id = 해당 유저 ID
     * @return randomKey = 'user_id={0}&auth_key={1}'
     */
    public static String getAuthKey(int length, String user_id) {
        char[] jum = new char[length];
        int c = 'A';
        int rnd = 0;
        for (int i = 0; i < length; i++) {
            rnd = (int) (Math.random() * 3);
            switch (rnd) {
                case 0:
                    c = '0' + Math.abs(random.nextInt(10));
                    break;
                case 1:
                    c = 'a' + Math.abs(random.nextInt(26));
                    break;
                case 2:
                    c = 'A' + Math.abs(random.nextInt(26));
                    break;
            }
            jum[i] = (char) c;
        }
        String randomKey = "user_id=" + user_id + "&auth_key=" + new String(jum);
        return randomKey;
    }

    public static String removeQuotation(String str) {
        if (StringUtils.isEmpty(str))
            return str;
        return str.replaceAll("\"", "&quote;").replaceAll("\'", "&quote;");
    }

    // HttpServletRequest 에서 암호화된 MDN 꺼내기
    public static String getNateCaEncMdn(HttpServletRequest request) {

        String sEncNateMdn = "";

        if (request == null) {
            return sEncNateMdn;
        }

        if (logger.isDebugEnabled())
            logger.debug("request.getHeader() == " + request.getHeader("user-agent"));

        String sUserAgent = request.getHeader("user-agent");
        String[] sSplitUserAgent = sUserAgent.split(";");
        String[] sSplitMdn = null;
        for (int i = 0; i < sSplitUserAgent.length; i++) {
            if (sSplitUserAgent[i].toUpperCase().startsWith("MDN")) {
                sSplitMdn = sSplitUserAgent[i].split(":");
                sEncNateMdn = sSplitMdn[1];
            }
        }

        return sEncNateMdn;
    }

    // HttpServletRequest 에서 암호화된 MDN 꺼내기
    public static String getNateCaModelName(HttpServletRequest request) {

        String sNateModelName = "";

        if (request == null) {
            return sNateModelName;
        }

        String sUserAgent = request.getHeader("user-agent");
        String[] sSplitUserAgent = sUserAgent.split(";");
        String[] sSplitMdn = null;
        for (int i = 0; i < sSplitUserAgent.length; i++) {
            if (sSplitUserAgent[i].toUpperCase().startsWith("MODEL")) {
                sSplitMdn = sSplitUserAgent[i].split(":");
                sNateModelName = sSplitMdn[1];
            }
        }

        return sNateModelName;
    }

    // HttpServletRequest 에서 Android 버전 꺼내기
    public static String getNateCaAndVer(HttpServletRequest request) {

        String sAndVer = "";

        if (request == null) {
            return sAndVer;
        }

        if (logger.isDebugEnabled())
            logger.debug("request.getHeader() == " + request.getHeader("user-agent"));

        String sUserAgent = request.getHeader("user-agent");
        System.out.println("//======================");
        System.out.println("user-agent : "+sUserAgent);
        System.out.println("//======================");
        String[] sSplitUserAgent = sUserAgent.split(";");
        String[] sSplitAndVer = null;
        for (int i = 0; i < sSplitUserAgent.length; i++) {
            if (sSplitUserAgent[i].toUpperCase().contains("ANDROID")) {
                sSplitAndVer = sSplitUserAgent[i].trim().split(" ");
                sAndVer = "android version : "+sSplitAndVer[1];
            }else if ( sSplitUserAgent[i].toUpperCase().contains("IPHONE")){
                sAndVer = "iPhone";
            }else if ( sSplitUserAgent[i].toUpperCase().contains("IPAD")){
                sAndVer = "iPad";
            }else if ( sSplitUserAgent[i].toUpperCase().contains("WINDOWS CE")){
                sAndVer = "Windows CE";
            }
        }

        return sAndVer;
    }

    public static String removeExtTempDate(Object obj) {
        try {
            return removeExtTempDate((String) obj);
        } catch (Exception e) {
            return null;
        }
    }

    public static String removeExtTempDate(String str) {
        if (StringUtils.isBlank(str)) {
            return str;
        }
        return str.replaceAll("\\.[0-9]+$", "");
    }

    /**
     * 생년월일, 성별로 만 나이 구하기(생일지난여부 확인)
     * 
     * @param user_bthd
     * @param user_sex
     * @return Age
     */
    public static int getBrthToAge(String user_bthd, String user_sex) {
        int iBrthyear, result = 0;
        if ("1".equals(user_sex) || "2".equals(user_sex) || "5".equals(user_sex) || "6".equals(user_sex)) {
            iBrthyear = Integer.parseInt("19" + user_bthd.substring(0, 2));
        } else {
            iBrthyear = Integer.parseInt("20" + user_bthd.substring(0, 2));
        }
        result = Integer.parseInt(getYYYY()) - iBrthyear;
        java.util.Calendar cal = java.util.Calendar.getInstance();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
        try {
            if (cal.getTime().after(simpleDateFormat.parse(getYYYY() + user_bthd.substring(2, 6))))
                result = result + 1; // 생일이 지난 경우
        } catch (ParseException e) {
            //e.printStackTrace();
        	System.err.print("Parse Error!");
            return 0;
        }
        return result < 0 ? 0 : result; // 음수인 경우 0 return
    }

    /**
     * 두 날짜 사이의 일자 계산
     * 
     * @param begin
     * @param end
     * @return
     * @throws Exception
     */
    public static long diffOfDate(String begin, String end) throws Exception {
        String[] format = { "yyyy-MM-dd", "yyyyMMdd" };
        Date start_date = DateUtils.parseDate(begin, format);
        Date end_date = DateUtils.parseDate(end, format);
        return diffOfDate(start_date, end_date);
    }

    /**
     * 두 날짜 사이의 일자 계산
     * 
     * @param beginDate
     * @param endDate
     * @return
     * @throws Exception
     */
    public static long diffOfDate(Date beginDate, Date endDate) throws Exception {
        long diff = endDate.getTime() - beginDate.getTime();
        long diffDays = diff / (24 * 60 * 60 * 1000);
        return diffDays;
    }

    public static int dayOfMonth(String yyyyMM) throws DateParseException {
        if (yyyyMM == null || yyyyMM.length() != 6) {
            return 0;
        }
        String[] format = { "yyyy-MM-dd", "yyyyMMdd" };
        Date date = DateUtils.parseDate(yyyyMM + "01", format);
        return dayOfMonth(date);
    }

    public static int dayOfMonth(Date date) {
        GregorianCalendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        return calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
    }
    
    /**
     *유니코드를 String 으로 바꿔주는 또는 반대로 해주는 메소드들
     * 
     * Modified By JesusEUN 2012 11 26
     * 
     */
     public static String StrtoUni(String str){
         //String uni="";
         StringBuilder uniSb = new StringBuilder();
         
         for(int intLoop=0;intLoop<str.length();intLoop++){
          
              if((intLoop+1)%2==1){
               char char1=str.charAt(intLoop);
               char char2=str.charAt(intLoop+1);
               char chr=(char) (char1-char2);
               String hex=Integer.toHexString(chr);
               uniSb.append("\\u"+ hex);
               //uni+="\\u"+hex;
              }
        }
        return uniSb.toString();
     }
        
    public static String UnitoStr(String uni){
               
       String str="";
       StringBuilder strSb = new StringBuilder();
       StringTokenizer str1=new StringTokenizer(uni,"\\u");
               
       while(str1.hasMoreTokens()){
            String str2=str1.nextToken();
            int intLoop=Integer.parseInt(str2,16);
            
            strSb.append((char)intLoop);
            //str+=(char)intLoop;
        }
       return strSb.toString();
   }
    
   //입력 파라미터에 대한 검증 
   public static String filterXSS(String param) {
       
	  if(param == null)   param = "";
    	
	  param = param.replaceAll("<", "&lt;");
	  param = param.replaceAll(">", "&gt;");
	  param = param.replaceAll("&", "&amp;");
	  param = param.replaceAll("\"", "&quot;");
	  
      return param;
	 
   }

   
}
