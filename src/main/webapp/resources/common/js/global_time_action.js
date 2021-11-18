var globalTimeAction = (function(globalTimeAction, $, undefined){
	
	var GLOBALTIMEMNG = [];
	var runningTimeCheck = false;
	var isRunning = false;

	globalTimeAction.gfn_createTime = function(id, expire, expireCallback, delay, recallfn){
		
		try{
			if(existsTimeId(id))return;
			var endTime = new Date();
			endTime.setSeconds(endTime.getSeconds() + expire);
			endTime.format("yyyyMMddhhmmss");
			var option = {
				id       		: id,
				expire   		: expire,
				start    		: new Date().format("yyyyMMddhhmmss"),
				end      		: endTime.format("yyyyMMddhhmmss"),
				expireCallback 	: expireCallback,
				delay    		: delay,
				recallfn 		: recallfn
			};
			GLOBALTIMEMNG.push(option);
			
			if(!isRunning){
				globalTimeAction.gfn_TimeCheck();
			}
			
		}catch(ex){}
	};
	
	globalTimeAction.gfn_startTimeAction = function(){
		runningTimeCheck = true;
	};
	
	globalTimeAction.gfn_endTimeAction = function(){
		isRunning = false;
		runningTimeCheck = false;
	};

	globalTimeAction.gfn_TimeCheck = function(){
		try{
			
			if(runningTimeCheck){
				
				isRunning = true;
				
				for(var i = 0; i < GLOBALTIMEMNG.length; i++){
					var currentTime = new Date().format("yyyyMMddhhmmss");
					//$("#readerSerial").text(currentTime);
					if(GLOBALTIMEMNG[i]["end"] < currentTime){
						try{
							setTimeout(GLOBALTIMEMNG[i]["expireCallback"]);
						}catch(ex){
							globalTimeAction.gfn_RemoveTime(GLOBALTIMEMNG[i]["id"]);
						}
						globalTimeAction.gfn_RemoveTime(GLOBALTIMEMNG[i]["id"]);
					}else{
						if(GLOBALTIMEMNG[i]["delay"] != null && GLOBALTIMEMNG[i]["delay"] != GLOBALTIMEMNG[i]["recallfn"]){
							try{
								setTimeout(GLOBALTIMEMNG[i]["recallfn"]);
							}catch(ex){
								globalTimeAction.gfn_RemoveTime(GLOBALTIMEMNG[i]["id"]);
							}
						}
					}
				}
				setTimeout(globalTimeAction.gfn_TimeCheck, 1000);
			}
		}catch(ex){}
	};

	globalTimeAction.gfn_RemoveTime = function(id){
		try{
			var index;
			for(var i = 0; i < GLOBALTIMEMNG.length; i++){
				if(GLOBALTIMEMNG[i]["id"] == id){
					index = i;
					break;
				}
			}
			GLOBALTIMEMNG.splice(i, 1);
		}catch(ex){}
	};

	existsTimeId = function(id){
		var exists = false;
		for(var i = 0; i < GLOBALTIMEMNG.length; i++){
			if(GLOBALTIMEMNG[i]["id"] == id){
				exists = true;
				break;
			}
		}
		return exists;
	};

	return globalTimeAction;
})(window.globalTimeAction || {}, jQuery);