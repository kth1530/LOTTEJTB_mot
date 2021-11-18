/*
 * 소셜로그인 네이버 함수
 */

//저장된 session 스토리지 삭제.
function fn_naverLogout() {
	//sessionStorage.clear();
	// 저장된 모든 값 삭제
	document.location.href="http://nid.naver.com/nidlogin.logout";
}
