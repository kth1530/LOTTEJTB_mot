package com.lottejtb.goods.service;

import com.lottejtb.comm.service.CommDefaultVO;

/**
* 클래스명    : 호텔 정보를 담고 있는 클래스   
* @ClassDesc  : 호텔 정보를 담고 있는 클래스     
* @FileName   : HotelInfoVO.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.15 /  / 최초작성
*/

public class HotelInfoVO extends CommDefaultVO {
	private static final long serialVersionUID = 6495747203641602057L;

	private String city_cd = "";
	private String cd_nm01 = "";
	private String country_cd = "";
	private String cd_nm = "";
	private String op_cd = "";
	
	private String lodge_cd = "";
	private String lodge_class_cd = "";
	private String lodge_nm = "";
	private String lodge_knm = "";
	private String lodge_grade = "";
	
	private String checkin_time = "";
	private String checkout_time = "";
	private int parlor_cnt = 0;
	private int floor_cnt = 0;
	private String address = "";
	
	private String phone_no = "";
	private String fax_no = "";
	private String homepage_url = "";
	private String location_desc = "";
	private String dist_to_airp = "";
	
	private String rent_car_yn = "";
	private String golf_yn = "";
	private String handicap_yn = "";
	private String health_club_yn = "";
	private String meeting_room_yn = "";
	
	private String parking_yn = "";
	private String pool_yn = "";
	private String restaurant_yn = "";
	private String sauna_yn = "";
	private String gift_shop_yn = "";
	
	private String business_yn = "";
	private String casino_yn = "";
	private String tennis_yn = "";
	private String barber_shop_yn = "";
	private String beauty_shop_yn = "";
	
	private String entertainment_yn = "";
	private String coffee_shop_yn = "";
	private String use_yn = "";
	private int eval_points = 0;
	private String rec_yn = "";
	
	private int rec_order = 0;
	private String hit_yn = "";
	private int hit_order = 0;
	private String prize = "";
	private String hotel_desc = "";
	
	private String hotel_grade = "";
	private String img_titles = "";
	private String img_paths = "";
	private String info_descs = "";
	private String add_facil = "";
	
	private String traffic = "";
	private String img_nm = "";
	private String img_alt = "";
	private int det_seq = 0;
	private String comm_desc_det = "";
	
	private String img_title = "";
	private String img_path = "";
	private String img_desc = "";
	private String img_link = "";
	private String img_pop_yn = "";
	
	private String comm_type = "";

	public String getCity_cd() {
		return city_cd;
	}

	public void setCity_cd(String city_cd) {
		this.city_cd = city_cd;
	}

	public String getCd_nm01() {
		return cd_nm01;
	}

	public void setCd_nm01(String cd_nm01) {
		this.cd_nm01 = cd_nm01;
	}

	public String getCountry_cd() {
		return country_cd;
	}

	public void setCountry_cd(String country_cd) {
		this.country_cd = country_cd;
	}

	public String getCd_nm() {
		return cd_nm;
	}

	public void setCd_nm(String cd_nm) {
		this.cd_nm = cd_nm;
	}

	public String getOp_cd() {
		return op_cd;
	}

	public void setOp_cd(String op_cd) {
		this.op_cd = op_cd;
	}

	public String getLodge_cd() {
		return lodge_cd;
	}

	public void setLodge_cd(String lodge_cd) {
		this.lodge_cd = lodge_cd;
	}

	public String getLodge_class_cd() {
		return lodge_class_cd;
	}

	public void setLodge_class_cd(String lodge_class_cd) {
		this.lodge_class_cd = lodge_class_cd;
	}

	public String getLodge_nm() {
		return lodge_nm;
	}

	public void setLodge_nm(String lodge_nm) {
		this.lodge_nm = lodge_nm;
	}

	public String getLodge_knm() {
		return lodge_knm;
	}

	public void setLodge_knm(String lodge_knm) {
		this.lodge_knm = lodge_knm;
	}

	public String getLodge_grade() {
		return lodge_grade;
	}

	public void setLodge_grade(String lodge_grade) {
		this.lodge_grade = lodge_grade;
	}

	public String getCheckin_time() {
		return checkin_time;
	}

	public void setCheckin_time(String checkin_time) {
		this.checkin_time = checkin_time;
	}

	public String getCheckout_time() {
		return checkout_time;
	}

	public void setCheckout_time(String checkout_time) {
		this.checkout_time = checkout_time;
	}

	public int getParlor_cnt() {
		return parlor_cnt;
	}

	public void setParlor_cnt(int parlor_cnt) {
		this.parlor_cnt = parlor_cnt;
	}

	public int getFloor_cnt() {
		return floor_cnt;
	}

	public void setFloor_cnt(int floor_cnt) {
		this.floor_cnt = floor_cnt;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone_no() {
		return phone_no;
	}

	public void setPhone_no(String phone_no) {
		this.phone_no = phone_no;
	}

	public String getFax_no() {
		return fax_no;
	}

	public void setFax_no(String fax_no) {
		this.fax_no = fax_no;
	}

	public String getHomepage_url() {
		return homepage_url;
	}

	public void setHomepage_url(String homepage_url) {
		this.homepage_url = homepage_url;
	}

	public String getLocation_desc() {
		return location_desc;
	}

	public void setLocation_desc(String location_desc) {
		this.location_desc = location_desc;
	}

	public String getDist_to_airp() {
		return dist_to_airp;
	}

	public void setDist_to_airp(String dist_to_airp) {
		this.dist_to_airp = dist_to_airp;
	}

	public String getRent_car_yn() {
		return rent_car_yn;
	}

	public void setRent_car_yn(String rent_car_yn) {
		this.rent_car_yn = rent_car_yn;
	}

	public String getGolf_yn() {
		return golf_yn;
	}

	public void setGolf_yn(String golf_yn) {
		this.golf_yn = golf_yn;
	}

	public String getHandicap_yn() {
		return handicap_yn;
	}

	public void setHandicap_yn(String handicap_yn) {
		this.handicap_yn = handicap_yn;
	}

	public String getHealth_club_yn() {
		return health_club_yn;
	}

	public void setHealth_club_yn(String health_club_yn) {
		this.health_club_yn = health_club_yn;
	}

	public String getMeeting_room_yn() {
		return meeting_room_yn;
	}

	public void setMeeting_room_yn(String meeting_room_yn) {
		this.meeting_room_yn = meeting_room_yn;
	}

	public String getParking_yn() {
		return parking_yn;
	}

	public void setParking_yn(String parking_yn) {
		this.parking_yn = parking_yn;
	}

	public String getPool_yn() {
		return pool_yn;
	}

	public void setPool_yn(String pool_yn) {
		this.pool_yn = pool_yn;
	}

	public String getRestaurant_yn() {
		return restaurant_yn;
	}

	public void setRestaurant_yn(String restaurant_yn) {
		this.restaurant_yn = restaurant_yn;
	}

	public String getSauna_yn() {
		return sauna_yn;
	}

	public void setSauna_yn(String sauna_yn) {
		this.sauna_yn = sauna_yn;
	}

	public String getGift_shop_yn() {
		return gift_shop_yn;
	}

	public void setGift_shop_yn(String gift_shop_yn) {
		this.gift_shop_yn = gift_shop_yn;
	}

	public String getBusiness_yn() {
		return business_yn;
	}

	public void setBusiness_yn(String business_yn) {
		this.business_yn = business_yn;
	}

	public String getCasino_yn() {
		return casino_yn;
	}

	public void setCasino_yn(String casino_yn) {
		this.casino_yn = casino_yn;
	}

	public String getTennis_yn() {
		return tennis_yn;
	}

	public void setTennis_yn(String tennis_yn) {
		this.tennis_yn = tennis_yn;
	}

	public String getBarber_shop_yn() {
		return barber_shop_yn;
	}

	public void setBarber_shop_yn(String barber_shop_yn) {
		this.barber_shop_yn = barber_shop_yn;
	}

	public String getBeauty_shop_yn() {
		return beauty_shop_yn;
	}

	public void setBeauty_shop_yn(String beauty_shop_yn) {
		this.beauty_shop_yn = beauty_shop_yn;
	}

	public String getEntertainment_yn() {
		return entertainment_yn;
	}

	public void setEntertainment_yn(String entertainment_yn) {
		this.entertainment_yn = entertainment_yn;
	}

	public String getCoffee_shop_yn() {
		return coffee_shop_yn;
	}

	public void setCoffee_shop_yn(String coffee_shop_yn) {
		this.coffee_shop_yn = coffee_shop_yn;
	}

	public String getUse_yn() {
		return use_yn;
	}

	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}

	public int getEval_points() {
		return eval_points;
	}

	public void setEval_points(int eval_points) {
		this.eval_points = eval_points;
	}

	public String getRec_yn() {
		return rec_yn;
	}

	public void setRec_yn(String rec_yn) {
		this.rec_yn = rec_yn;
	}

	public int getRec_order() {
		return rec_order;
	}

	public void setRec_order(int rec_order) {
		this.rec_order = rec_order;
	}

	public String getHit_yn() {
		return hit_yn;
	}

	public void setHit_yn(String hit_yn) {
		this.hit_yn = hit_yn;
	}

	public int getHit_order() {
		return hit_order;
	}

	public void setHit_order(int hit_order) {
		this.hit_order = hit_order;
	}

	public String getPrize() {
		return prize;
	}

	public void setPrize(String prize) {
		this.prize = prize;
	}

	public String getHotel_desc() {
		return hotel_desc;
	}

	public void setHotel_desc(String hotel_desc) {
		this.hotel_desc = hotel_desc;
	}

	public String getHotel_grade() {
		return hotel_grade;
	}

	public void setHotel_grade(String hotel_grade) {
		this.hotel_grade = hotel_grade;
	}

	public String getImg_titles() {
		return img_titles;
	}

	public void setImg_titles(String img_titles) {
		this.img_titles = img_titles;
	}

	public String getImg_paths() {
		return img_paths;
	}

	public void setImg_paths(String img_paths) {
		this.img_paths = img_paths;
	}

	public String getInfo_descs() {
		return info_descs;
	}

	public void setInfo_descs(String info_descs) {
		this.info_descs = info_descs;
	}

	public String getAdd_facil() {
		return add_facil;
	}

	public void setAdd_facil(String add_facil) {
		this.add_facil = add_facil;
	}

	public String getTraffic() {
		return traffic;
	}

	public void setTraffic(String traffic) {
		this.traffic = traffic;
	}

	public String getImg_nm() {
		return img_nm;
	}

	public void setImg_nm(String img_nm) {
		this.img_nm = img_nm;
	}

	public String getImg_alt() {
		return img_alt;
	}

	public void setImg_alt(String img_alt) {
		this.img_alt = img_alt;
	}

	public int getDet_seq() {
		return det_seq;
	}

	public void setDet_seq(int det_seq) {
		this.det_seq = det_seq;
	}

	public String getComm_desc_det() {
		return comm_desc_det;
	}

	public void setComm_desc_det(String comm_desc_det) {
		this.comm_desc_det = comm_desc_det;
	}

	public String getImg_title() {
		return img_title;
	}

	public void setImg_title(String img_title) {
		this.img_title = img_title;
	}

	public String getImg_path() {
		return img_path;
	}

	public void setImg_path(String img_path) {
		this.img_path = img_path;
	}

	public String getImg_desc() {
		return img_desc;
	}

	public void setImg_desc(String img_desc) {
		this.img_desc = img_desc;
	}

	public String getImg_link() {
		return img_link;
	}

	public void setImg_link(String img_link) {
		this.img_link = img_link;
	}

	public String getImg_pop_yn() {
		return img_pop_yn;
	}

	public void setImg_pop_yn(String img_pop_yn) {
		this.img_pop_yn = img_pop_yn;
	}

	public String getComm_type() {
		return comm_type;
	}

	public void setComm_type(String comm_type) {
		this.comm_type = comm_type;
	}

	
}
