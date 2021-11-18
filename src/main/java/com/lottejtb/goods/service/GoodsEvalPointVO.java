package com.lottejtb.goods.service;

import com.lottejtb.comm.service.CommDefaultVO;


public class GoodsEvalPointVO extends CommDefaultVO {
	private static final long serialVersionUID = 7220469063130093354L;

	private int goods_eval_seq = 0;
	private String eval_item_cd = "";
	private int eval_point = 0;
	
	
	public int getGoods_eval_seq() {
		return goods_eval_seq;
	}
	public void setGoods_eval_seq(int goods_eval_seq) {
		this.goods_eval_seq = goods_eval_seq;
	}
	public String getEval_item_cd() {
		return eval_item_cd;
	}
	public void setEval_item_cd(String eval_item_cd) {
		this.eval_item_cd = eval_item_cd;
	}
	public int getEval_point() {
		return eval_point;
	}
	public void setEval_point(int eval_point) {
		this.eval_point = eval_point;
	}
	
	
}
