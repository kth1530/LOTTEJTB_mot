package com.lottejtb.framework.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.log4j.Logger;

public class XssRequestReplaceWrapper extends HttpServletRequestWrapper {
    
    protected static final Logger LOGGER = Logger.getLogger(XssRequestReplaceWrapper.class);
    public XssRequestReplaceWrapper(HttpServletRequest request) {
        super(request);
        if(LOGGER.isDebugEnabled()){
        	LOGGER.debug( "CoXssRequestReplaceWrapper ");
        }
    }

    public String getParameter(String key) {
        String value = null;
        try {
            value = super.getParameter(key);
            if (value != null) {
            	 if(!value.contains("/ac/lgoinAction.do")){
            		 value = xssReplace(key);
            	 }
            }
        } catch (Exception e) {
            try {
				throw e;
			} catch (Exception e1) {
				if(LOGGER.isDebugEnabled()){
					LOGGER.error(e1.getMessage());
				}
			}
        }
        return value;
    }

    public String[] getParameterValues(String key) {
        String[] values =super.getParameterValues(key);   
        try {
            if (values != null) {
                for (int i = 0; i < values.length; i++) {
                    values[i] = xssReplaceValue(values[i]);     
                }
            }
        } catch (Exception e) {
        	try {
				throw e;
			} catch (Exception e1) {
				if(LOGGER.isDebugEnabled()){
					LOGGER.error(e1.getMessage());
				}
			}
        }
        return values;
    }
    
    private String xssReplace(String key) throws Exception{
        String rslt   = (super.getParameter(key) == null) ? "" : super.getParameter(key);
        rslt = rslt.trim();
        if(LOGGER.isDebugEnabled()){
        	LOGGER.debug("=======================================================");
        	LOGGER.debug("= before key =["+key+"]     rslt =["+rslt+"]");
        }

        if(
                rslt!=null &&
                !rslt.equals("")
                )
        {
//            rslt = rslt.replaceAll("&","&#38;");
//            rslt = rslt.replaceAll("/","&#47;");
//            rslt = rslt.replaceAll("<","&#60;");
//            rslt = rslt.replaceAll(">","&#62;");
//            rslt = rslt.replaceAll("@","&#64;");
        	
        	rslt = rslt.replaceAll("&","&amp;");
        	rslt = rslt.replaceAll("<","&lt;");
        	rslt = rslt.replaceAll(">","&gt;");
            rslt = rslt.replaceAll("/","&frasl;");
            rslt = rslt.replaceAll("@","&#64;");
            rslt = rslt.replaceAll("\"","&quot;");
            rslt = rslt.replaceAll("'","&quot;");
        }    
        
        if(LOGGER.isDebugEnabled()){
        	LOGGER.debug("= after  key =["+key+"]     rslt =["+rslt+"]");
        	LOGGER.debug("=======================================================");
        }
        
        return rslt;
    }
    
    /**
     * value 값의 문자를 직접 치환하여 return
     * 
     */
    private String xssReplaceValue(String originValue){
    	String value = originValue.trim();
    	if(LOGGER.isDebugEnabled()){
    		LOGGER.debug("=======================================================");
    		LOGGER.debug("= before value =["+value+"] ");
    	}
    	
    	if(
    			value!=null &&
    			!value.equals("")
    			)
    	{
//            rslt = rslt.replaceAll("&","&#38;");
//            rslt = rslt.replaceAll("/","&#47;");
//            rslt = rslt.replaceAll("<","&#60;");
//            rslt = rslt.replaceAll(">","&#62;");
//            rslt = rslt.replaceAll("@","&#64;");
    		
    		value = value.replaceAll("&","&amp;");
    		value = value.replaceAll("<","&lt;");
    		value = value.replaceAll(">","&gt;");
    		value = value.replaceAll("/","&frasl;");
    		value = value.replaceAll("@","&#64;");
    		value = value.replaceAll("\"","&quot;");
    		value = value.replaceAll("'","&quot;");
    	}    
    	
    	if(LOGGER.isDebugEnabled()){
    		LOGGER.debug("= after  key =["+value+"]");
    		LOGGER.debug("=======================================================");
    	}
    	
    	return value;
    }
}
