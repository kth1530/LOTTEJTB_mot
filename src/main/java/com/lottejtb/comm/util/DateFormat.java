package com.lottejtb.comm.util;

import java.util.HashMap;
import java.util.Map;

public class DateFormat {
	
	private static DateFormat dateformat = new DateFormat();
	
    private DateFormat(){
    	
    }
    
    public static DateFormat getInstance(){
        return dateformat;
    }
    
    public Object getDataFormatMap(String param){
        return getKorDateValue(param);
    }
    
    public String getKorDateValue(String str){
    	if("SS_DATE_FMT_4MD".equals(str)){
    		return "YYYY-MM-DD";
    	}else if("SS_DATE_FMT_2MD".equals(str)){
    		return "YY-MM-DD";
    	}else if("SS_DATE_FMT_MD".equals(str)){
    		return "MM-DD";
    	}else if("SS_DATE_FMT_4MD_HMS".equals(str)){
    		return "YYYY-MM-DD HH24:MI:SS";
    	}else if("SS_DATE_FMT_2MD_HMS".equals(str)){
    		return "YY-MM-DD HH24:MI:SS";
    	}else if("SS_DATE_FMT_MD_HMS".equals(str)){
    		return "MM-DD HH24:MI:SS";
    	}else if("SS_DATE_FMT_4MD_HM".equals(str)){
    		return "YYYY-MM-DD HH24:MI";
    	}else if("SS_DATE_FMT_2MD_HM".equals(str)){
    		return "YY-MM-DD HH24:MI";
    	}else if("SS_DATE_FMT_MD_HM".equals(str)){
    		return "MM-DD HH24:MI";
    	}else if("SS_DATE_FMT_HMS".equals(str)){
    		return "HH24:MI:SS";
    	}else if("SS_DATE_FMT_HM".equals(str)){
    		return "HH24:MI";
    	}else if("SS_4YMD_HMS".equals(str)){
    		return "MM/dd/yyyy HH:mm:ss";
    	}else if("SS_4YMD_HM".equals(str)){
    		return "MM/dd/yyyy HH:mm";
    	}else if("SS_2YMD_HMS".equals(str)){
    		return "yy-MM-dd HH:mm:ss";
    	}else if("SS_2YMD_HM".equals(str)){
    		return "yy-MM-dd HH:mm";
    	}else if("SS_TS".equals(str)){
    		return "HH:mm:ss";
    	}else if("SS_TM".equals(str)){
    		return "HH:mm";
    	}
    	
    	return "FAIL";
    }
    
    public String getEngDateValue(String str){
    	if("SS_DATE_FMT_4MD".equals(str)){
    		return "MM/DD/YYYY";
    	}else if("SS_DATE_FMT_2MD".equals(str)){
    		return "MM/DD/YY";
    	}else if("SS_DATE_FMT_MD".equals(str)){
    		return "MM/DD";
    	}else if("SS_DATE_FMT_4MD_HMS".equals(str)){
    		return "MM/DD/YYYY HH24:MI:SS";
    	}else if("SS_DATE_FMT_2MD_HMS".equals(str)){
    		return "MM/DD/YY HH24:MI:SS";
    	}else if("SS_DATE_FMT_MD_HMS".equals(str)){
    		return "MM/DD HH24:MI:SS";
    	}else if("SS_DATE_FMT_4MD_HM".equals(str)){
    		return "MM/DD/YYYY HH24:MI";
    	}else if("SS_DATE_FMT_2MD_HM".equals(str)){
    		return "MM/DD/YY HH24:MI";
    	}else if("SS_DATE_FMT_MD_HM".equals(str)){
    		return "MM/DD HH24:MI";
    	}else if("SS_DATE_FMT_HMS".equals(str)){
    		return "HH24:MI:SS";
    	}else if("SS_DATE_FMT_HM".equals(str)){
    		return "HH24:MI";
    	}else if("SS_4YMD_HMS".equals(str)){
    		return "MM/dd/yyyy HH:mm:ss";
    	}else if("SS_4YMD_HM".equals(str)){
    		return "MM/dd/yyyy HH:mm";
    	}else if("SS_2YMD_HMS".equals(str)){
    		return "yy-MM-dd HH:mm:ss";
    	}else if("SS_2YMD_HM".equals(str)){
    		return "yy-MM-dd HH:mm";
    	}else if("SS_TS".equals(str)){
    		return "HH:mm:ss";
    	}else if("SS_TM".equals(str)){
    		return "HH:mm";
    	}
    	
    	
    	return "FAIL";
    }

	public static final String NAT_PREFIX = "KOR";
	public static final String ENG_PREFIX = "ENG";
	public static final String NAT_YYYY_MM = "yyyy-MM";
	public static final String ENG_YYYY_MM = "MM/yyyy";
	
}
