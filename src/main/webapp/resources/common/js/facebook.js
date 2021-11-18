/*
 * 소셜로그인  페이스북 함수
 */


//임시로그아웃
function fn_facebookLogout() {
	FB.logout(function(response) {
		console.log("fb logout");
	});  
};
