package com.lottejtb.comm.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

public interface CommFileService{
	
    int CommUPload(CommFileVO fileVo,HttpServletRequest request) throws Exception;
    
	int insertFileInfo(CommFileVO fileVO,String Path) throws Exception;

	String insertFileInfoByIntnum(CommFileVO fileVO) throws Exception;
	
	List selectFileList(CommFileVO fileVO) throws Exception;
    
	CommFileVO selectFileDetail(CommFileVO fileVO) throws Exception;
	
	void deleteFileInfo(CommFileVO fileVO,String FULL_PATH) throws Exception;
	
	void updateFileInfo(CommFileVO fileVO,String oldfile) throws Exception;
	
	boolean makeDirectory(String path) throws Exception;
	
	void deleteDirectory(String path)throws Exception;
	
	void deleteFile(String path)throws Exception;
	
	int insertBitAttFile(HttpServletRequest request, String parentNum, String parentTbl);
	
	int insertBitAttFile(MultipartFile mFile, String parentNum, String parentTbl);

	int confirmImageFile(HttpServletRequest request, String parentTbl) throws Exception;
	
}