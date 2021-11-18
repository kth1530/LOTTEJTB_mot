package com.lottejtb.comm.web;

import java.io.Serializable;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.lottejtb.comm.service.CommMemberVO;

public class CommLoginSessionManager implements Serializable {
    
    private static final long serialVersionUID = 1L;
    private CommMemberVO loginVO;
    
    public CommMemberVO getLoginVO() {
        if (loginVO == null) {
            this.loginVO = new CommMemberVO();
        }
        return loginVO;
    }
    public CommMemberVO getLoginVO(HttpServletRequest request) {
        if( loginVO == null){
            this.loginVO = (CommMemberVO) request.getSession().getAttribute("loginVO");
        }
        return loginVO;
    }
    
    public void setSession(CommMemberVO vo) {
        this.loginVO = vo;
    }
    
    /** 현재 request 의 세션 초기화
     * @param req
     */
    public void removeSession(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        session.invalidate();
    }
    
    /** 세션 중복 체크 */
    public boolean isLogin(String userid){
        boolean isLogin = false;
        if( userid.equals(loginVO.getUserid())){
            isLogin = true;
        }
        return isLogin;
    }
    
}