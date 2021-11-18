package com.lottejtb.goods.rn.service;

import com.lottejtb.comm.service.CommDefaultVO;

/**
* 클래스명    :  상품 관련 이미지 정보 
* @ClassDesc  : 상품 관련 이미지 정보 
* @FileName   : RNGDImgVO.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2017.02.03 /  / 최초작성
*/


public class RNGDImgVO  extends CommDefaultVO   {
	
	private static final long serialVersionUID = 2198645104515268636L;
	
	private String goods_cd = "";
	private int seq = 0;
	private String img_title = "";
	private String save_file_nm = "";
	private String goods_desc = "";
	
	private String img_path = "";
	private int disp_grade = 0;
	
	public RNGDImgVO() {
		// TODO Auto-generated constructor stub
	}

	public String getGoods_cd() {
		return goods_cd;
	}

	public void setGoods_cd(String goods_cd) {
		this.goods_cd = goods_cd;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getImg_title() {
		return img_title;
	}

	public void setImg_title(String img_title) {
		this.img_title = img_title;
	}

	public String getSave_file_nm() {
		return save_file_nm;
	}

	public void setSave_file_nm(String save_file_nm) {
		this.save_file_nm = save_file_nm;
	}

	public String getGoods_desc() {
		return goods_desc;
	}

	public void setGoods_desc(String goods_desc) {
		this.goods_desc = goods_desc;
	}

	public String getImg_path() {
		return img_path;
	}

	public void setImg_path(String img_path) {
		this.img_path = img_path;
	}

	public int getDisp_grade() {
		return disp_grade;
	}

	public void setDisp_grade(int disp_grade) {
		this.disp_grade = disp_grade;
	}

	/*=========================================================================
	 *  홈페이지 썸네일 가져오는 부분 
	 ==========================================================================*/
	
	public String chgImage(String image, String type) {
		int lastIndex = 0;
		String prefix_filename = "";
		String ext_filename 		= "";
		String thumb_file = "";
		
		if(image == null || image == "") {
			
			return "";
		} else {
			lastIndex = image.lastIndexOf('.');
			prefix_filename = image.substring(0, lastIndex);
			ext_filename = image.substring(lastIndex, image.length());	
			
			if(type == "L") {				// 리스트 화면 
				thumb_file = prefix_filename + "_440"  + ext_filename;
				

				return thumb_file;

			} else if(type == "D") {		// 상세 화면 
				// thumb_file = prefix_filename + "_490" + ext_filename;
				thumb_file = prefix_filename + "_440" + ext_filename;
				return thumb_file;
			}			
		}
		
		return "";
	}
}
