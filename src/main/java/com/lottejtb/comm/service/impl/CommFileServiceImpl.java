package com.lottejtb.comm.service.impl;

import java.io.File;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Date;
import java.util.Locale;
import java.text.SimpleDateFormat;






import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.lottejtb.comm.service.CommFileService;
import com.lottejtb.comm.service.CommFileVO;
import com.lottejtb.comm.util.CommFileManager;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("CommFileService")
public class CommFileServiceImpl extends EgovAbstractServiceImpl implements CommFileService{
	
	private static final Logger logger = Logger.getLogger(CommFileServiceImpl.class);
	
    @Resource(name = "CommFileService")
    private CommFileService fileService;
	
	@Resource(name="CommFileDAO")
	private CommFileDAO fileDao;
	
	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    

    @Override
    public int CommUPload(CommFileVO fileVo, HttpServletRequest request) throws Exception {
        
        int rtn = 0;
        
        try {
            boolean[] isChangedArr = fileVo.getIsChanged();
            String[]  parentNumArr = fileVo.getParentNumber();
            String[]  tblArr       = fileVo.getTblNm();
            String[]  uniqueNumArr = fileVo.getUniqueNumber();
            int totalCnt = isChangedArr.length;
            String oldParentNum = null;
            String tblNm        = null;
            String uniqueNum    = null;
            String targetFilePath = null;
            int fileSeq = 0;
            
            MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;
            List<MultipartFile> mFileList = mptRequest.getFiles("file");
            Iterator<String> fileIter = mptRequest.getFileNames();
            
            String FILE_SAVE_PATH = null;  //파일 저장 경로
            
            InetAddress LOCALHOST = InetAddress.getLocalHost();
            String HOST_ADDR = LOCALHOST.getHostAddress();
            if ("localhost".equals(HOST_ADDR) || HOST_ADDR.indexOf("127.0") > -1 || HOST_ADDR.indexOf("10.141") > -1 || HOST_ADDR.indexOf("192.168") > -1) {
                FILE_SAVE_PATH = propertiesService.getString("userUplaodPathDev") + "/USERUPLOAD";
            }else{
                FILE_SAVE_PATH = propertiesService.getString("userUplaodPathReal") + "/USERUPLOAD";
            }
            
            if( totalCnt > 0 ){
                for( int intLoop=0; intLoop<totalCnt; intLoop++){
                    if( isChangedArr[intLoop] ) { // 기존 파일 삭제
                        oldParentNum = parentNumArr[intLoop];
                        tblNm        = tblArr[intLoop];
                        uniqueNum        = uniqueNumArr[intLoop];
                        /* 배열로 넘어온것을 새로 fileVo에 세팅 */
                        fileVo.setParentNum(oldParentNum);
                        fileVo.setTbl(tblNm);
                        fileVo.setUniqueNum(Integer.valueOf(uniqueNum));
                        
                        if(StringUtils.hasLength(oldParentNum)) {
                            /*
                            SimpleDateFormat YYYYMM_FORMAT = new SimpleDateFormat("yyyy_MM", Locale.KOREA);
                            path = YYYYMM_FORMAT.format(new Date()) + "/";
                            path = path.startsWith("/") ? path : "/" + path;
                            targetFilePath = FILE_SAVE_PATH + path;
                            */
                            CommFileVO resultDetail = fileDao.selectFileDetail(fileVo);
                            if( resultDetail != null ){ //기존 파일이 있다면 삭제 
                                targetFilePath = resultDetail.getFilePath();
                                System.out.println("//==========================");
                                System.out.println(" targetFilePath :  "+targetFilePath);
                                System.out.println("//==========================");
                                fileService.deleteFileInfo(resultDetail, targetFilePath);
                            }
                        }
                        /* 물리 파일 저장 */
                        MultipartFile mFile = mFileList.get(fileSeq);
                        HashMap<String, String> map = CommFileManager.uploadFile(FILE_SAVE_PATH, mFile,null);
                        fileVo.setAttOrg(map.get("attorg"));
                        fileVo.setAttFile(map.get("attfile"));
                        fileVo.setFileExt(map.get("fileExt"));
                        fileVo.setVolume(map.get("volume"));
                        fileVo.setFilePath(map.get("volume") + map.get("filePath"));
                        fileVo.setFileSize(map.get("filesize"));
                        fileVo.setCreater("admin");
                        fileVo.setMimeType(map.get("mimeType"));
                        rtn = this.insertFileInfo(fileVo, FILE_SAVE_PATH);
                        fileSeq++;
                    }
                }
            }else{
                while (fileIter.hasNext()) {
                    MultipartFile mFile = mptRequest.getFile((String) fileIter.next());
                    if (mFile.getSize() > 0) {
                        HashMap<String, String> map = CommFileManager.uploadFile(FILE_SAVE_PATH, mFile,null);
                        fileVo.setAttOrg(map.get("attorg"));
                        fileVo.setAttFile(map.get("attfile"));
                        fileVo.setFileExt(map.get("fileExt"));
                        fileVo.setVolume(map.get("volume"));
                        fileVo.setFilePath(map.get("volume") + map.get("filePath"));
                        fileVo.setFileSize(map.get("filesize"));
                        fileVo.setCreater("admin");
                        fileVo.setMimeType(map.get("mimeType"));
                        rtn = this.insertFileInfo(fileVo, FILE_SAVE_PATH);
                    }
                }
            }
            
        } catch (Exception e) {
            //e.printStackTrace();
        	System.err.print("파일 입출력 오류!");
        }
        
        return rtn;
    }

	@Override
	public int insertFileInfo(CommFileVO fileVO, String Path) throws Exception {
		try {
			makeDirectory(Path);
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.print("폴더생성 오류!");
		}
		return fileDao.insertFileInfo(fileVO);
	}
	
	@Override
	public String insertFileInfoByIntnum(CommFileVO fileVO) throws Exception {
		return fileDao.insertFileInfoByIntnum(fileVO);
	}

	@Override
	public List selectFileList(CommFileVO fileVO) throws Exception {
		return fileDao.selectFileList(fileVO);
	}

	@Override
	public CommFileVO selectFileDetail(CommFileVO fileVO) throws Exception {
		return fileDao.selectFileDetail(fileVO);
	}

	@Override
	public void deleteFileInfo(CommFileVO fileVO,String FULL_PATH) throws Exception {
		if ( !"".equals(FULL_PATH) ) {
			this.deleteFile(FULL_PATH); // 기존 파일 삭제
		}
		fileDao.deleteFileInfo(fileVO);
	}

	@Override
	public void updateFileInfo(CommFileVO fileVO,String oldfile) throws Exception {
		if ( !"".equals(oldfile) ) {
			this.deleteFile(oldfile); // 기존 파일 삭제
		}
		fileDao.updateFileInfo(fileVO);
	}

	@Override
	public boolean makeDirectory(String path) throws Exception {
		
		boolean result = true;
		
		File oFile = new File(path);
		
		if ( !oFile.exists() ) {
			
			if ( !oFile.mkdirs() ) {
				result = false;
			}else{
				result = true;
			}
			
		}
		return result;
	}

	@Override
	public void deleteDirectory(String path) throws Exception {
		deleteDirectory(new File(path));
	}
	
	@Override
	public void deleteFile(String path) throws Exception {
		
		File destFile = new File(path);
		if (destFile.exists()) {
			destFile.delete();
		}
	}

	@Override
	/** 첨부 파일 **/
	public int insertBitAttFile(HttpServletRequest request, String parentNum, String parentTbl) {
		
		int _result = 1; // 첨부파일 넣기 성공
		
		try {

			MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest)request;
			Iterator<String> fileIter = mptRequest.getFileNames();
			String FILE_SAVE_PATH = null;
			
			InetAddress LOCALHOST = InetAddress.getLocalHost();
			String HOST_ADDR = LOCALHOST.getHostAddress();
			if ("localhost".equals(HOST_ADDR) || HOST_ADDR.indexOf("127.0") > -1 || HOST_ADDR.indexOf("10.141") > -1 || HOST_ADDR.indexOf("192.168") > -1) {
			    FILE_SAVE_PATH = propertiesService.getString("userUplaodPathDev") + "/USERUPLOAD";
			}else{
			    FILE_SAVE_PATH = propertiesService.getString("userUplaodPathReal") + "/USERUPLOAD";
			}
			
			int rtn = 0;
			CommFileVO fileVo = new CommFileVO();
			while (fileIter.hasNext()) {
				MultipartFile mFile = mptRequest.getFile((String) fileIter.next());
				if (mFile.getSize() > 0) {
					HashMap<String, String> map = CommFileManager.uploadFile(FILE_SAVE_PATH, mFile,null);
					fileVo.setParentNum(parentNum);
					fileVo.setTbl(parentTbl);
					fileVo.setAttOrg(map.get("attorg"));
					fileVo.setAttFile(map.get("attfile"));
					fileVo.setFileExt(map.get("fileExt"));
					fileVo.setFilePath(map.get("volume") + map.get("filePath"));
					fileVo.setFileSize(map.get("filesize"));
					fileVo.setMimeType(map.get("mimeType"));
					rtn = this.insertFileInfo(fileVo, FILE_SAVE_PATH);
				}
			}
			
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.print("첨부파일 오류!");
			_result = 0; // 첨부파일 넣기 실패
		}
		
		return _result;
	}

	@Override
	/** 첨부 파일 **/
	public int insertBitAttFile(MultipartFile mFile, String parentNum, String parentTbl) {
		
		int _result = 1; // 첨부파일 넣기 성공
		int rtn = 0;
		try {
			
			String FILE_SAVE_PATH = propertiesService.getString("path.repositoryPath.real") + "/BITMARU";
			CommFileVO fileVo = new CommFileVO();
			if (mFile.getSize() > 0) {
				HashMap<String, String> map = CommFileManager.uploadFile(FILE_SAVE_PATH, mFile,null);
				fileVo.setParentNum(parentNum);
				fileVo.setTbl(parentTbl);
				fileVo.setAttOrg(map.get("attorg"));
				fileVo.setAttFile(map.get("attfile"));
				fileVo.setFileExt(map.get("fileExt"));
				fileVo.setFilePath(map.get("volume") + map.get("filePath"));
				fileVo.setFileSize(map.get("filesize"));
				fileVo.setMimeType(map.get("mimeType"));
				rtn = this.insertFileInfo(fileVo, FILE_SAVE_PATH);
			}
			
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.print("첨부파일 오류!");
			_result = 0; // 첨부파일 넣기 실패
		}
		
		return _result;
	}
	
	@Override
	public int confirmImageFile(HttpServletRequest request, String parentTbl) throws Exception {
		
		int _result = 1;
		
		List<String> mimeCheckList = new ArrayList<String>();
		mimeCheckList.add("image/jpeg");
		mimeCheckList.add("image/pjpeg");
		mimeCheckList.add("image/gif");
		mimeCheckList.add("image/png");
		
		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest)request;
		Iterator<String> fileIter = mptRequest.getFileNames();
		while (fileIter.hasNext()) {
			MultipartFile mFile = mptRequest.getFile((String) fileIter.next());
			if ( mFile.getSize() > 0) {
				
				HashMap<String, String> map = CommFileManager.uploadFile("", mFile,mimeCheckList);
				if ( "0".equals(map.get("mimeCheck")) ){
					return 0;
				}else{
					return 1;
				}
			}
		}
		
		
		return _result;
	}

	private void deleteDirectory(File file) {

		// 폴더인가?
		if (file.isDirectory()) { 

			if (file.list().length == 0) { 
				// 폴더내 파일이 없으면 폴더삭제
				file.delete();
			} else {
				String files[] = file.list();
				for (String temp : files) {
					File fileDelete = new File(file, temp);
					this.deleteDirectory(fileDelete);
				}

				if (file.list().length == 0) {
					file.delete();
				}
			}

		} else {
			file.delete(); // 파일이면 삭제
		}
	}

	
}