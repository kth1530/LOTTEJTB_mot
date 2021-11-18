package com.lottejtb.framework.common;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lottejtb.comm.util.CommResourceCloseHelper;
import com.lottejtb.comm.util.CommWebUtil;

public class CommProperties {
    
    private static final Logger logger = LoggerFactory.getLogger(CommProperties.class);
    final static  String FILE_SEPARATOR = System.getProperty("file.separator"); // \를 표시함 
    public static final String RELATIVE_PATH_PREFIX = CommProperties.class.getResource("../").getPath().substring(0, CommProperties.class.getResource("../").getPath().lastIndexOf("com"));
    public static final String COMMON_PROPERTIES_FILE = RELATIVE_PATH_PREFIX + "config" + FILE_SEPARATOR + "globals.properties";
    
    private CommProperties(){
	}
    
    /* 인자로 주어진 문자열을 Key 값으로 하는 상대경로 프로퍼티 값을 절대경로로 반환 */
    public static String getPathProperty(String keyName) throws IOException{
        String value = "";
        
        logger.debug("getPathProperty : {} = {}", COMMON_PROPERTIES_FILE, keyName);
        
        FileInputStream fis = null;
        try {
            Properties props = new Properties();
            fis = new FileInputStream(CommWebUtil.filePathBlackList(COMMON_PROPERTIES_FILE));
            props.load(new BufferedInputStream(fis));
            value = props.getProperty(keyName).trim();
            value = RELATIVE_PATH_PREFIX + "config" + System.getProperty("file.separator") + value;
        } catch (FileNotFoundException fne) {
            logger.debug("Property file not found.", fne);
            throw new RuntimeException("Property file not found", fne);
        } catch (IOException ioe) {
            logger.debug("Property file IO exception", ioe);
            throw new RuntimeException("Property file IO exception", ioe);
        } finally {        	
        	if(fis != null){
        		fis.close();
        	}
            CommResourceCloseHelper.close(fis);
        }
        
        return value;
    }
    
    public static String getPathProperty(String fileName, String key) throws IOException {
        FileInputStream fis = null;
        try {
            Properties props = new Properties();
            
            fis = new FileInputStream(CommWebUtil.filePathBlackList(fileName));
            props.load(new BufferedInputStream(fis));

            String value = props.getProperty(key);
            value = RELATIVE_PATH_PREFIX + "egovProps" + System.getProperty("file.separator") + value;
            fis.close();
            return value;
        } catch (FileNotFoundException fne) {
            logger.debug("Property file not found.", fne);
            throw new RuntimeException("Property file not found", fne);
        } catch (IOException ioe) {
            logger.debug("Property file IO exception", ioe);
            throw new RuntimeException("Property file IO exception", ioe);
        } finally {
        	if(fis != null){
        		fis.close();
        	}
            CommResourceCloseHelper.close(fis);
        }
    }
    
    public static String getProperty(String fileName, String key) throws IOException{
        FileInputStream fis = null;
        try {
            Properties props = new Properties();
            fis = new FileInputStream(CommWebUtil.filePathBlackList(fileName));
            props.load(new BufferedInputStream(fis));
            fis.close();
            String value = props.getProperty(key);
            return value;
        } catch (FileNotFoundException fne) {
            logger.debug("Property file not found.", fne);
            throw new RuntimeException("Property file not found", fne);
        } catch (IOException ioe) {
            logger.debug("Property file IO exception", ioe);
            throw new RuntimeException("Property file IO exception", ioe);
        } finally {
        	if(fis != null){
        		fis.close();
        	}
            CommResourceCloseHelper.close(fis);
        }
    }
    
    /**
     * 인자로 주어진 문자열을 Key값으로 하는 프로퍼티 값을 반환한다(Globals.java 전용)
     * @param keyName String
     * @return String
     */
    public static String getProperty(String keyName) throws IOException{
        String value = "";
        
        logger.debug("getProperty : {} = {}", COMMON_PROPERTIES_FILE, keyName);
        
        FileInputStream fis = null;
        try {
            Properties props = new Properties();

            fis = new FileInputStream(CommWebUtil.filePathBlackList(COMMON_PROPERTIES_FILE));
            
            props.load(new BufferedInputStream(fis));
            
            fis.close();
            if (props.getProperty(keyName) == null) {
                return "";
            }
            value = props.getProperty(keyName).trim();
        } catch (FileNotFoundException fne) {
            logger.debug("Property file not found.", fne);
            throw new RuntimeException("Property file not found", fne);
        } catch (IOException ioe) {
            logger.debug("Property file IO exception", ioe);
            throw new RuntimeException("Property file IO exception", ioe);
        } finally {
        	if(fis != null){
        		fis.close();
        	}
            CommResourceCloseHelper.close(fis);
        }
        
        return value;
    }
    
    public static ArrayList<Map<String, String>> loadPropertyFile(String property) throws IOException{

        ArrayList<Map<String, String>> keyList = new ArrayList<Map<String, String>>();

        String src = property.replace('\\', File.separatorChar).replace('/', File.separatorChar);
        FileInputStream fis = null;
        try {

            File srcFile = new File(CommWebUtil.filePathBlackList(src));
            if (srcFile.exists()) {

                Properties props = new Properties();
                fis = new FileInputStream(src);
                props.load(new BufferedInputStream(fis));
                fis.close();

                Enumeration<?> plist = props.propertyNames();
                if (plist != null) {
                    while (plist.hasMoreElements()) {
                        Map<String, String> map = new HashMap<String, String>();
                        String key = (String) plist.nextElement();
                        map.put(key, props.getProperty(key));
                        keyList.add(map);
                    }
                }
            }
        } catch (IOException ex) {
            logger.debug("IO Exception", ex);
            throw new RuntimeException(ex);
        } finally {
        	if(fis != null){
        		fis.close();
        	}
            CommResourceCloseHelper.close(fis);
        }

        return keyList;
    }
}