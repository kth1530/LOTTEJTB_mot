package com.lottejtb.comm.service;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

public class CommDefaultVO implements Serializable {
    
    /** 검색조건 */
    private String searchCondition = "";
    /** 검색Keyword */
    private String searchKeyword = "";
    private String sort;
    private int gotopage = 1;  //paging 처리 현재 선택된 page 번호
    private int pageunit = 10; //하단에 나오는 페이지 출력 수
    private int pagesize = 10; //리스트에 출력되는 게시글 수
    private int totalcnt = 0; // 레코드의 총 갯수
    private int pagecount = 0; //레코드 페이지 카운트
    private String searchcate = "";
    private int rn; //rownum
    
	private int startRow;         //시작번호
	private int endRow;           //종료번호
    
    public String getSearchCondition() {
        return searchCondition;
    }

    public void setSearchCondition(String searchCondition) {
        this.searchCondition = searchCondition;
    }

    public String getSearchKeyword() {
        return searchKeyword;
    }

    public void setSearchKeyword(String searchKeyword) {
        this.searchKeyword = searchKeyword;
    }

    public int getGotopage() {
        return gotopage;
    }

    public void setGotopage(int gotopage) {
        this.gotopage = gotopage;
    }
    
    public int getPagecount() {
        return pagecount;
    }

    public void setPagecount(int pagecount) {
        this.pagecount = pagecount;
    }

    public int getPageunit() {
        return pageunit;
    }

    public void setPageunit(int pageunit) {
        this.pageunit = pageunit;
    }

    public int getPagesize() {
        return pagesize;
    }

    public void setPagesize(int pagesize) {
        this.pagesize = pagesize;
    }

    public int getTotalcnt() {
        return totalcnt;
    }

    public void setTotalcnt(int totalcnt) {
        this.totalcnt = totalcnt;
    }
    

    public String getSearchcate() {
        return searchcate;
    }

    public void setSearchcate(String searchcate) {
        this.searchcate = searchcate;
    }

    public int getRn() {
        return rn;
    }

    public void setRn(int rn) {
        this.rn = rn;
    }
    
    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }
    
    public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}

	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}