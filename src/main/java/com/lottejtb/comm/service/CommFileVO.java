package com.lottejtb.comm.service;

import java.util.Arrays;

public class CommFileVO extends CommDefaultVO {
	
	private static final long serialVersionUID = 1L;
    
    private int    uniqueNum = 0;
	private String parentNum;
	private String tbl;
	private String attOrg;
	private String attFile;
	private String fileExt;
	private String volume;
	private String filePath;
	private String fileSize;
	private String creater;
	private String mimeType;
	private String wdate;
	
	private boolean[] isChanged;
	private String[]  parentNumber;
	private String[]  tblNm;
	private String[]  uniqueNumber;
	
    public int getUniqueNum() {
        return uniqueNum;
    }
    public void setUniqueNum(int uniqueNum) {
        this.uniqueNum = uniqueNum;
    }
    public String getParentNum() {
        return parentNum;
    }
    public void setParentNum(String parentNum) {
        this.parentNum = parentNum;
    }
    public String getTbl() {
        return tbl;
    }
    public void setTbl(String tbl) {
        this.tbl = tbl;
    }
    public String getAttOrg() {
        return attOrg;
    }
    public void setAttOrg(String attOrg) {
        this.attOrg = attOrg;
    }
    public String getAttFile() {
        return attFile;
    }
    public void setAttFile(String attFile) {
        this.attFile = attFile;
    }
    public String getFileExt() {
        return fileExt;
    }
    public void setFileExt(String fileExt) {
        this.fileExt = fileExt;
    }
    public String getVolume() {
        return volume;
    }
    public void setVolume(String volume) {
        this.volume = volume;
    }
    public String getFilePath() {
        return filePath;
    }
    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }
    public String getFileSize() {
        return fileSize;
    }
    public void setFileSize(String fileSize) {
        this.fileSize = fileSize;
    }
    public String getCreater() {
        return creater;
    }
    public void setCreater(String creater) {
        this.creater = creater;
    }
    public String getMimeType() {
        return mimeType;
    }
    public void setMimeType(String mimeType) {
        this.mimeType = mimeType;
    }
    public String getWdate() {
        return wdate;
    }
    public void setWdate(String wdate) {
        this.wdate = wdate;
    }
    public boolean[] getIsChanged() {
        return isChanged;
    }
    public void setIsChanged(boolean[] isChanged) {
        this.isChanged = isChanged;
    }
    public String[] getParentNumber() {
        return parentNumber;
    }
    public void setParentNumber(String[] parentNumber) {
        this.parentNumber = parentNumber;
    }
    public String[] getTblNm() {
        return tblNm;
    }
    public void setTblNm(String[] tblNm) {
        this.tblNm = tblNm;
    }
    public String[] getUniqueNumber() {
        return uniqueNumber;
    }
    public void setUniqueNumber(String[] uniqueNumber) {
        this.uniqueNumber = uniqueNumber;
    }
    
    @Override
    public String toString() {
        return "CommFileVO [uniqueNum=" + uniqueNum + ", parentNum="
                + parentNum + ", tbl=" + tbl + ", attOrg=" + attOrg
                + ", attFile=" + attFile + ", fileExt=" + fileExt + ", volume="
                + volume + ", filePath=" + filePath + ", fileSize=" + fileSize
                + ", creater=" + creater + ", mimeType=" + mimeType
                + ", wdate=" + wdate + ", isChanged="
                + Arrays.toString(isChanged) + ", parentNumber="
                + Arrays.toString(parentNumber) + ", tblNm="
                + Arrays.toString(tblNm) + ", uniqueNumber="
                + Arrays.toString(uniqueNumber) + "]";
    }
	
    
    	
}