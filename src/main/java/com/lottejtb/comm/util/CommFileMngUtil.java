package com.lottejtb.comm.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component("CommFileMngUtil")
public class CommFileMngUtil {

    public static final int BUFF_SIZE = 2048;
    
    private static final SimpleDateFormat YYYYMM_FORMAT = new SimpleDateFormat("yyyy_MM",Locale.KOREA);
    
    private CommFileMngUtil(){
	}
    
    /**
     * 서버의 파일을 다운로드한다.
     *
     * @param request
     * @param response
     * @throws Exception
     */
    public static void downFile(HttpServletRequest request, HttpServletResponse response) throws Exception {

	String downFileName = "";
	String orgFileName = "";

	if ((String)request.getAttribute("downFile") == null) {
	    downFileName = "";
	} else {
	    downFileName = (String)request.getAttribute("downFile");
	}

	if ((String)request.getAttribute("orginFile") == null) {
	    orgFileName = "";
	} else {
	    orgFileName = (String)request.getAttribute("orginFile");
	}

	orgFileName = orgFileName.replaceAll("\r", "").replaceAll("\n", "");

	File file = new File(CommWebUtil.filePathBlackList(downFileName));

	if (!file.exists()) {
	    throw new FileNotFoundException(downFileName);
	}

	if (!file.isFile()) {
	    throw new FileNotFoundException(downFileName);
	}

	byte[] b = new byte[BUFF_SIZE]; //buffer size 2K.

	response.setContentType("application/x-msdownload");
	setDisposition(orgFileName,request,response);
	//response.setHeader("Content-Disposition:", "attachment; filename=" + new String(orgFileName.getBytes(), "UTF-8"));
	response.setHeader("Content-Transfer-Encoding", "binary");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");
	

	BufferedInputStream fin = null;
	BufferedOutputStream outs = null;

	try {
		fin = new BufferedInputStream(new FileInputStream(file));
	    outs = new BufferedOutputStream(response.getOutputStream());
	    int read = 0;

		while ((read = fin.read(b)) != -1) {
		    outs.write(b, 0, read);
		}
	} finally {
	    if (outs != null) {
			try {
			    outs.close();
			} catch (Exception ignore) {
				Logger.getLogger(CommFileMngUtil.class).debug("IGNORED: " + ignore.getMessage());
			}
		    }
		    if (fin != null) {
			try {
			    fin.close();
			} catch (Exception ignore) {
				Logger.getLogger(CommFileMngUtil.class).debug("IGNORED: " + ignore.getMessage());
			}
		    }
		}
    }
    

    /**
     * 첨부로 등록된 파일을 서버에 업로드한다.
     *
     * @param file
     * @return
     * @throws Exception
     */
    public static HashMap<String, String> uploadFile(String stordFilePath ,MultipartFile file) throws Exception {

    	
    	
	HashMap<String, String> map = new HashMap<String, String>();
	
	String newName = "";

	String orginFileName = file.getOriginalFilename();

	int index = orginFileName.lastIndexOf(".");
	
	String fileExt = orginFileName.substring(index + 1);
	long size = file.getSize();

	newName = getFildID();
	
	String path = YYYYMM_FORMAT.format(new Date()) + "/";
	path = path.startsWith("/") ?  path : "/" + path;
	String repDir = stordFilePath + path;
	
	String mimeType = URLConnection.guessContentTypeFromName(orginFileName);
	if (mimeType == null) {
		if (orginFileName.endsWith(".doc")) {
			mimeType = "application/msword";
		} else if (orginFileName.endsWith(".xls")) {
			mimeType = "application/vnd.ms-excel";
		} else if (orginFileName.endsWith(".ppt")) {
			mimeType = "application/mspowerpoint";
		} else {
			mimeType = "application/octet-stream";
		}
	}
	
	writeFile(file, newName, repDir);
	
	map.put("fileId",newName);	//뉴 파일 명
	map.put("fileExt", fileExt);	//파일 확장자
	map.put("originFileName", orginFileName); //파일 오리지날 명
	map.put("volume", stordFilePath);
	map.put("filePath", path + newName);
	map.put("filesize", String.valueOf(size));
	map.put("mimeType", mimeType);
	
	return map;
    }

    /**
     * 파일을 실제 물리적인 경로에 생성한다.
     *
     * @param file
     * @param newName
     * @param stordFilePath
     * @throws Exception
     */
    protected static void writeFile(MultipartFile file, String newName, String stordFilePath) throws Exception {
	InputStream stream = null;
	OutputStream bos = null;

	try {
	    stream = file.getInputStream();
	    File cFile = new File(CommWebUtil.filePathBlackList(stordFilePath));

	    if (!cFile.isDirectory()){
	    	cFile.mkdirs();
	    }
	    bos = new FileOutputStream(CommWebUtil.filePathBlackList(stordFilePath + File.separator + newName));

	    int bytesRead = 0;
	    byte[] buffer = new byte[BUFF_SIZE];

	    while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
	    	bos.write(buffer, 0, bytesRead);
	    }
	} catch (Exception e) {
		Logger.getLogger(CommFileMngUtil.class).debug("IGNORED: " + e.getMessage());
	} finally {
	    if (bos != null) {
		try {
		    bos.close();
		} catch (Exception ignore) {
		    Logger.getLogger(CommFileMngUtil.class).debug("IGNORED: " + ignore.getMessage());
		}
	    }
	    if (stream != null) {
		try {
		    stream.close();
		} catch (Exception ignore) {
		    Logger.getLogger(CommFileMngUtil.class).debug("IGNORED: " + ignore.getMessage());
		}
	    }
	}
    }

    /*private static String getTimeStamp() {

	String rtnStr = null;

	// 문자열로 변환하기 위한 패턴 설정(년도-월-일 시:분:초:초(자정이후 초))
	String pattern = "yyyyMMddhhmmssSSS";

	try {
	    SimpleDateFormat sdfCurrent = new SimpleDateFormat(pattern, Locale.KOREA);
	    Timestamp ts = new Timestamp(System.currentTimeMillis());

	    rtnStr = sdfCurrent.format(ts.getTime());
	} catch (Exception e) {
		Logger.getLogger(CommFileMngUtil.class).debug("IGNORED: " + e.getMessage());
	}

	return rtnStr;
    }*/
    
    private static String getFildID() {
    	return UUID.randomUUID().toString();
    }
    
    /**
     * 브라우저 구분 얻기.
     * 
     * @param request
     * @return
     */
    private static String getBrowser(HttpServletRequest request) {
        String header = request.getHeader("User-Agent");
        if (header.indexOf("MSIE") > -1) {
            return "MSIE";
        } else if (header.indexOf("Chrome") > -1) {
            return "Chrome";
        } else if (header.indexOf("Opera") > -1) {
            return "Opera";
        }
        return "Firefox";
    }
    
    /**
     * Disposition 지정하기.
     * 
     * @param filename
     * @param request
     * @param response
     * @throws Exception
     */
    private static void setDisposition(String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
	String browser = getBrowser(request);
	
	String dispositionPrefix = "attachment; filename=";
	String encodedFilename = null;
	
	if ("MSIE".equals(browser)) {
	    encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
	} else if ("Firefox".equals(browser)) {
	    encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
	} else if ("Opera".equals(browser)) {
	    encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
	} else if ("Chrome".equals(browser)) {
	    StringBuffer sb = new StringBuffer();
	    for (int i = 0; i < filename.length(); i++) {
		char c = filename.charAt(i);
		if (c > '~') {
		    sb.append(URLEncoder.encode("" + c, "UTF-8"));
		} else {
		    sb.append(c);
		}
	    }
	    encodedFilename = sb.toString();
	} else {
	    //throw new RuntimeException("Not supported browser");
	    throw new IOException("Not supported browser");
	}
	
	response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);

	if ("Opera".equals(browser)){
	    response.setContentType("application/octet-stream;charset=UTF-8");
	}
    }
}
