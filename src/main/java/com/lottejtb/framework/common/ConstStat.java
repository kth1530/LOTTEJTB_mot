package com.lottejtb.framework.common;

public final class ConstStat extends CommConstStat {
    
    private ConstStat() {
    }
    /**  서비스 성공 **/
    public static final String CODE_SUCCESS       = "200";
    public static final String CODE_NO_SESSION     = "404";
    
    /** DB 테이블 이름  **/
    public static final String BIT_NOTICE = "TBL_NOTICE"; // 공지사항
    
    /** mode  **/
    public static final String MODE_WRITE = "wrt";
    public static final String MODE_EDIT = "edit";
    public static final String MODE_ATT_FILE_DELETE = "attfileDelete";
    public static final String MODE_DELETE = "Delete";
    public static final String MODE_LIST = "list";
    
        
}