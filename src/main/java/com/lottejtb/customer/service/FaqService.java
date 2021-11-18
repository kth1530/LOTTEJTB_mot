package com.lottejtb.customer.service;

import java.util.List;

public interface FaqService {

	List selectFaqList(FaqVO vo) throws Exception;	
	FaqVO selectFaqListAllCount(FaqVO vo) throws Exception;	
	List selectFaqFirstList(FaqVO vo) throws Exception;
}
