package com.lottejtb.util;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import com.tmax.bi.nlp.AutoDic;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

public class AutoComplete extends EgovAbstractServiceImpl{
	private static AutoDic dic;
	/************** 로컬서버 **************/
	//private final String FST_PATH = "C:/Users/Administrator/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp1/wtpwebapps/LotteJTBmoT/WEB-INF/auto.fst2";
	//private final String TXT_PATH = "C:/Users/Administrator/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp1/wtpwebapps/LotteJTBmoT/WEB-INF/auto.txt";
	/************** 로컬서버 **************/
	
	/************** 개발, 운영서버 **************/
	private final String FST_PATH = "/home/MOBILE_WEB/public_html/WEB-INF/auto.fst2";
	private final String TXT_PATH = "/home/MOBILE_WEB/public_html/WEB-INF/auto.txt";
	/************** 개발, 운영서버 **************/
	
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
	public AutoComplete(){
		try{
			if(dic == null){
				dic = new AutoDic();

				dic.LoadFST(FST_PATH);
				dic.LoadData(TXT_PATH);
			}
		}catch(Exception e){
			//e.printStackTrace();
			System.err.println("AutoDic Error!");
		}
	}
	
	public List getItems(String keyword){
		if( !"".equals(keyword) && keyword != null){
			keyword = keyword.replace(" ", "_");

			List suggestList = dic.processQuery(keyword);
			if(suggestList != null){
				return dic.processQuery(keyword);
			}else{
				return new ArrayList();
			}
		}else{
			return new ArrayList();
		}
	}
}
