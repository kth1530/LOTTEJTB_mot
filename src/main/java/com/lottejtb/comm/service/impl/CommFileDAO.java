package com.lottejtb.comm.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.lottejtb.comm.service.CommFileVO;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("CommFileDAO")
public class CommFileDAO extends EgovAbstractDAO {
	
	public int insertFileInfo(CommFileVO fileVO) {
		return (Integer) insert("CommFileDAO.insertFileInfo", fileVO);
	}
	public String insertFileInfoByIntnum(CommFileVO fileVO) {
		return (String) insert("CommFileDAO.insertFileInfoByIntnum", fileVO);
	}
	public List selectFileList(CommFileVO fileVO) {
		return list("CommFileDAO.selectFileList", fileVO);
	}
	public CommFileVO selectFileDetail(CommFileVO fileVO) {
		return (CommFileVO) select("CommFileDAO.selectFileDetail", fileVO);
	}
	public void deleteFileInfo(CommFileVO fileVO) {
		delete("CommFileDAO.deleteFileInfo", fileVO);
	}
	public void deleteFileInfoRef(CommFileVO fileVO) {
		delete("CommFileDAO.deleteFileInfoRef", fileVO);
	}
	public void updateFileInfo(CommFileVO fileVO) {
		update("CommFileDAO.updateFileInfo", fileVO);
	}
}