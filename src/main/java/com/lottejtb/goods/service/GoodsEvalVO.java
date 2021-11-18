package com.lottejtb.goods.service;

import com.lottejtb.comm.service.CommDefaultVO;


/**
* 클래스명    :  상품평 정보를 담고 있는 클래스 
* @ClassDesc  : 상품평 정보를 담고 있는 클래스
* 				(DI_GOODS_EVAL EVAL , CU_MST CU) 
* @FileName   : GoodsEvalVO.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.11 /  / 최초작성
*/

public class GoodsEvalVO extends CommDefaultVO {

	private static final long serialVersionUID = 3313630621360850378L;

	private int goods_eval_seq = 0; 	// --상품평번호
	private String goods_nm = "";
	private String goods_cd = ""; 		// --상품마스터코드
	private String eval_title = ""; 		// -- 제목 
	private String eval_cnts = ""; 		// -- 상품평 내용 
	
	private int eval_avg = 0;			// -- 평가 평점 
	private String tour_goal_cd = ""; 	// -- 여행목적 [TRP]
	private String cd_nm = "";
	private String goods_type_cd = "";
	private String cd_nm01 = "";
	private String area_cd = "";
	
	private String cd_nm02 = "";
	private int read_cnt = 0;		// 조회수 
	private int recommend_cnt = 0; 	// 추천 횟수 
	private String disp_yn = "";		// 게시 여부 
	private String cust_cd = ""; 	// 고객번호 
	
	private String cust_nm = "";
	private String lotte_id = "";
	private String tel = "";
	private String memo = ""; 		// 찾아가는 방법(메모)
	private String del_yn = "";
	
	private String ins_dt = "";
	private String ins_id = "";
	private String upd_dt = "";
	private String upd_id = "";
	private String eval_point1 = "";
	
	private String eval_point2 = "";
	private String eval_point3 = "";
	private String eval_point4 = "";
	private String satisfaction = "";
	private String comp_cd = "";
	
	
	public String getComp_cd() {
		return comp_cd;
	}
	public void setComp_cd(String comp_cd) {
		this.comp_cd = comp_cd;
	}
	public int getGoods_eval_seq() {
		return goods_eval_seq;
	}
	public void setGoods_eval_seq(int goods_eval_seq) {
		this.goods_eval_seq = goods_eval_seq;
	}
	public String getGoods_nm() {
		return goods_nm;
	}
	public void setGoods_nm(String goods_nm) {
		this.goods_nm = goods_nm;
	}
	public String getGoods_cd() {
		return goods_cd;
	}
	public void setGoods_cd(String goods_cd) {
		this.goods_cd = goods_cd;
	}
	public String getEval_title() {
		return eval_title;
	}
	public void setEval_title(String eval_title) {
		this.eval_title = eval_title;
	}
	public String getEval_cnts() {
		return eval_cnts;
	}
	public void setEval_cnts(String eval_cnts) {
		this.eval_cnts = eval_cnts;
	}
	public int getEval_avg() {
		return eval_avg;
	}
	public void setEval_avg(int eval_avg) {
		this.eval_avg = eval_avg;
	}
	public String getTour_goal_cd() {
		return tour_goal_cd;
	}
	public void setTour_goal_cd(String tour_goal_cd) {
		this.tour_goal_cd = tour_goal_cd;
	}
	public String getCd_nm() {
		return cd_nm;
	}
	public void setCd_nm(String cd_nm) {
		this.cd_nm = cd_nm;
	}
	public String getGoods_type_cd() {
		return goods_type_cd;
	}
	public void setGoods_type_cd(String goods_type_cd) {
		this.goods_type_cd = goods_type_cd;
	}
	public String getCd_nm01() {
		return cd_nm01;
	}
	public void setCd_nm01(String cd_nm01) {
		this.cd_nm01 = cd_nm01;
	}
	public String getArea_cd() {
		return area_cd;
	}
	public void setArea_cd(String area_cd) {
		this.area_cd = area_cd;
	}
	public String getCd_nm02() {
		return cd_nm02;
	}
	public void setCd_nm02(String cd_nm02) {
		this.cd_nm02 = cd_nm02;
	}
	public int getRead_cnt() {
		return read_cnt;
	}
	public void setRead_cnt(int read_cnt) {
		this.read_cnt = read_cnt;
	}
	public int getRecommend_cnt() {
		return recommend_cnt;
	}
	public void setRecommend_cnt(int recommend_cnt) {
		this.recommend_cnt = recommend_cnt;
	}
	public String getDisp_yn() {
		return disp_yn;
	}
	public void setDisp_yn(String disp_yn) {
		this.disp_yn = disp_yn;
	}
	public String getCust_cd() {
		return cust_cd;
	}
	public void setCust_cd(String cust_cd) {
		this.cust_cd = cust_cd;
	}
	public String getCust_nm() {
		return cust_nm;
	}
	public void setCust_nm(String cust_nm) {
		this.cust_nm = cust_nm;
	}
	public String getLotte_id() {
		return lotte_id;
	}
	public void setLotte_id(String lotte_id) {
		this.lotte_id = lotte_id;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	public String getIns_dt() {
		return ins_dt;
	}
	public void setIns_dt(String ins_dt) {
		this.ins_dt = ins_dt;
	}
	public String getIns_id() {
		return ins_id;
	}
	public void setIns_id(String ins_id) {
		this.ins_id = ins_id;
	}
	public String getUpd_dt() {
		return upd_dt;
	}
	public void setUpd_dt(String upd_dt) {
		this.upd_dt = upd_dt;
	}
	public String getUpd_id() {
		return upd_id;
	}
	public void setUpd_id(String upd_id) {
		this.upd_id = upd_id;
	}
	public String getEval_point1() {
		return eval_point1;
	}
	public void setEval_point1(String eval_point1) {
		this.eval_point1 = eval_point1;
	}
	public String getEval_point2() {
		return eval_point2;
	}
	public void setEval_point2(String eval_point2) {
		this.eval_point2 = eval_point2;
	}
	public String getEval_point3() {
		return eval_point3;
	}
	public void setEval_point3(String eval_point3) {
		this.eval_point3 = eval_point3;
	}
	public String getEval_point4() {
		return eval_point4;
	}
	public void setEval_point4(String eval_point4) {
		this.eval_point4 = eval_point4;
	}
	public String getSatisfaction() {
		return satisfaction;
	}
	public void setSatisfaction(String satisfaction) {
		this.satisfaction = satisfaction;
	}
	
	
}
