/**
 * Determine the mobile operating system.
 * This function either returns 'iOS', 'Android' or 'unknown'
 *
 * @returns {String}
 */
function getMobileOperatingSystem() {
	var userAgent = navigator.userAgent || navigator.vendor || window.opera;

	if( userAgent.match( /iPad/i ) || userAgent.match( /iPhone/i ) || userAgent.match( /iPod/i ) ){
		return 'iOS';

	}else if( userAgent.match( /Android/i ) ){

		return 'Android';
	}else{
		return 'unknown';
	}
}

var mobileOperatingSystem = getMobileOperatingSystem();
//console.log("user-agent:"+mobileOperatingSystem);