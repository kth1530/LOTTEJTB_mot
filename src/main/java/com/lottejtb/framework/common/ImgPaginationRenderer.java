package com.lottejtb.framework.common;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

public class ImgPaginationRenderer extends AbstractPaginationRenderer {
	
	public ImgPaginationRenderer() {
		
		firstPageLabel ="<a href=\"#\" class=\"prev\" onclick=\"{0}({1}); return false;\" onkeypress=\"{0}({1}); return false;\"><img src=\"/common/images/common/pagin_pp.gif\" alt=\"첫페이지\" border=\"0\"/></a>&#160;&nbsp;"; 
        previousPageLabel ="<a href=\"#\" class=\"prev\" onclick=\"{0}({1}); return false;\" onkeypress=\"{0}({1}); return false;\"><img src=\"/common/images/common/pagin_prev.gif\" alt=\"이전페이지\" border=\"0\"/></a>&#160;";
        currentPageLabel ="<strong>{0}</strong>&#160;";
        otherPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\" onkeypress=\"{0}({1}); return false;\">{2}</a>&#160;";
        nextPageLabel ="<a href=\"#\" class=\"next\"  onclick=\"{0}({1}); return false;\" onkeypress=\"{0}({1}); return false;\"><img src=\"/common/images/common/pagin_next.gif\" alt=\"다음페이지\" border=\"0\"/></a>&#160;&nbsp;";
        lastPageLabel ="<a href=\"#\" class=\"next\" onclick=\"{0}({1}); return false;\" onkeypress=\"{0}({1}); return false;\"><img src=\"/common/images/common/pagin_nn.gif\" alt=\"끝페이지\" border=\"0\"/></a>&#160;";

	}
}