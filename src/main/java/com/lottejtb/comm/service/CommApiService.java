package com.lottejtb.comm.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface CommApiService{
    
    String eanApiHotelList(CommEanAPIVO vo,HttpServletRequest request) throws Exception;
    CommExchangeVO exchangeInfo(CommExchangeVO vo) throws Exception;
    List totalExchangeInfo() throws Exception;
}