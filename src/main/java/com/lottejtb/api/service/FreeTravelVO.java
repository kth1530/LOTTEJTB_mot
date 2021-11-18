package com.lottejtb.api.service;

public class FreeTravelVO {
	private boolean useAir = false;
	private boolean useHotel = false;
	private boolean useRentalcar = false;
	
	public boolean isUseAir() {
		return useAir;
	}
	public void setUseAir(boolean useAir) {
		this.useAir = useAir;
	}
	public boolean isUseHotel() {
		return useHotel;
	}
	public void setUseHotel(boolean useHotel) {
		this.useHotel = useHotel;
	}
	public boolean isUseRentalcar() {
		return useRentalcar;
	}
	public void setUseRentalcar(boolean useRentalcar) {
		this.useRentalcar = useRentalcar;
	}
}
