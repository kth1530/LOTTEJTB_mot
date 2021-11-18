// -----------------------------------------------------------------------------
// 결제 화면 관련 스크립트 정리 
// -----------------------------------------------------------------------------

// 결제화면으로 이동  
function fn_goPay(seqNo, price) {
	document.location.replace('/free/account/pay_free.do?seqNo='+ seqNo); //+'&selAir='+ selAir +'&selHotel='+ selHotel +'&selRentcar='+ selRentcar);
}

//결제화면으로 이동  
function fn_goPayComplete() {
	document.location.replace('/free/account/pay_end_free.do');
}