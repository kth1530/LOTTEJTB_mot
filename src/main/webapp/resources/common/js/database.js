var menuMapT = {
	openDB : window.openDatabase("LOTTE","1.0","LOTTE JTB", 100000),
	createT : function(){
		var createA = function(tx){
			tx.executeSql('DROP TABLE IF EXISTS TB_MENUMAP');
			tx.executeSql('CREATE TABLE IF NOT EXISTS TB_MENUMAP (ctgSeq, ctgNm, ctgSeqMap, ctgNmMap)');
		}
		
		menuMapT.openDB.transaction(createA, menuMapT.error, menuMapT.successT);
	},
	
	insertT:function(callback, a, b, c, d){
		var insertA = function(tx){
			var insertStr = "INSERT INTO TB_MENUMAP (ctgSeq, ctgNm, ctgSeqMap, ctgNmMap) VALUES ('"+ a +"', '"+ b +"', '"+ c +"', '"+ d +"')";
			
			tx.executeSql(insertStr);
		}
		
		menuMapT.openDB.transaction(insertA, menuMapT.errorT, callback);
	},
	
	selectT:function(callback, a){
		var selectA = function(tx){
			if(nullToBlank(a) == ""){
				tx.executeSql('SELECT * FROM TB_MENUMAP', [], callback, menuMapT.errorT);
			}else{
				tx.executeSql('SELECT * FROM TB_MENUMAP WHERE ctgSeq = ?', [a], callback, menuMapT.errorT);
			}
		}
		
		menuMapT.openDB.transaction(selectA, menuMapT.errorT);
	},

	errorT:function(err){
		console.log("Error processing SQL: "+err);
		console.log(err);
	},
	
	successT:function(data){
		console.log("ActiveT 쿼리데이타");
	}
}

var bannerT = {
	openDB : window.openDatabase("LOTTE","1.0","LOTTE JTB", 1000000),
	createT : function(){
		var createA = function(tx){
			tx.executeSql('DROP TABLE IF EXISTS TB_BANNER');
			tx.executeSql('CREATE TABLE IF NOT EXISTS TB_BANNER (division, tabCode, title1, description1, pathLocal1, pathServer1, alt1, linkUrl1, targetType1, insDt, insId, updDt, updId, gdNm1, gdPrice1)');
		}
		
		bannerT.openDB.transaction(createT, bannerT.errorT, bannerT.successT);
	},
	
	errorT:function(err){
		console.log("Error processing SQL: "+err);
	},
	
	successT:function(data){
		console.log("ActiveT 쿼리데이타");
	}
}

var leftMenuT = {
	openDB : window.openDatabase("LOTTE", "1.0", "LOTTE JTB", 1000000),
	createT : function(){
		var createA = function(tx){
			tx.executeSql('DROP TABLE IF EXISTS TB_LEFTMENU');
			tx.executeSql('CREATE TABLE IF NOT EXISTS TB_LEFTMENU (ctgSeq, ctgNm, ctgUprSeq, ctgDispOrder, ctgTypeCd, cmsId, leafYn, meno, goodsTypeCd, areaCd, subAreaCd, dispYn, ctgDispYn, ctgDepth, ctgPath)');
		}
		
		leftMenuT.openDB.transaction(createA, leftMenuT.errorT, leftMenuT.successT);
	},
	insertT : function(a, b, c, d, e, f, g, h, i, j, k, l, m, n, o){
		var insertA = function(tx){
			var insertStr = "INSERT INTO TB_LEFTMENU (ctgSeq, ctgNm, ctgUprSeq, ctgDispOrder, ctgTypeCd, cmsId, leafYn, meno, goodsTypeCd, areaCd, subAreaCd, dispYn, ctgDispYn, ctgDepth, ctgPath)";
				insertStr = "VALUES ('"+ a +"', '"+ b +"', '"+ c +"', '"+ d +"', '"+ e +"', '"+ f +"', '"+ g +"', '"+ h +"', '"+ i +"', '"+ j +"', '"+ k +"', '"+ l +"', '"+ m +"', '"+ n +"', '"+ o +"')";
			
			tx.executeSql(insertStr)
		}
		
		leftMenuT.openDB.transaction(insertA, leftMenuT.errorT, leftMenuT.successT);
	},
	selectT : function(callback, a){
		var selectA = function(tx){
			if(nullToBlank(a) == ""){
				tx.executeSql('SELECT * FROM TB_LEFTMENU', [], callback, leftMenuT.errorT);
			}else{
				tx.executeSql('SELECT * FROM TB_LEFTMENU WHERE ctgUprSeq = ?', [a], callback, leftMenuT.errorT);
			}
		}
		
		leftMenuT.openDB.transaction(selectT, leftMenuT.errorT);
	},
	errorT:function(err){
		console.log("Error processing SQL: "+err);
	},
	
	successT:function(data){
		// console.log("ActiveT 쿼리데이타");
	},
}

// ---------------------------------------------------------------------------------------------------------------------------------------------
// 항공예약 > 항공 예약 처리 API > BodyDTO 정보 
// ---------------------------------------------------------------------------------------------------------------------------------------------
var rsvAirBodyDtoT = {
	openDB : window.openDatabase("LOTTE", "1.0", "LOTTE JTB", 1000000),
	createT : function(){
		var createA = function(tx){
			tx.executeSql('DROP TABLE IF EXISTS TB_RSV_AIR_BODYDTO');
			tx.executeSql('CREATE TABLE IF NOT EXISTS TB_RSV_AIR_BODYDTO (jSessionID, rsvUserId, rsvUserNm, rsvEnSurNm, rsvEnFirstNm, rsvHtel, rsvBirth, rsvEmail, rsvRemark, gdsCd, availTy, routeTy, currency, totSaleCharge, totTaxCharge, adtCnt, chdCnt, infCnt, fmsKey, ruleKey, pmoId)');
		}
		
		rsvAirBodyDtoT.openDB.transaction(createA, rsvAirBodyDtoT.errorT, function(){ console.log('TB_RSV_AIR_BODYDTO Create'); });
	},
	insertT : function(a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u){
		var insertA = function(tx){
			var insertStr = "INSERT INTO TB_RSV_AIR_BODYDTO (jSessionID, rsvUserId, rsvUserNm, rsvEnSurNm, rsvEnFirstNm,  rsvHtel, rsvBirth, rsvEmail, rsvRemark, gdsCd, availTy, routeTy, currency, totSaleCharge, totTaxCharge, adtCnt, chdCnt, infCnt, fmsKey, ruleKey, pmoId)";
				insertStr += "VALUES ('"+ a +"', '"+ b +"', '"+ c +"', '"+ d +"', '"+ e +"', '"+ f +"', '"+ g +"', '"+ h +"', '"+ i +"', '"+ j +"', '"+ k +"','"+ l +"', '" + m +"', '"+ n +"', '"+o+"','" + p + "', '" + q + "', '" + r + "', '" + s + "', '" + t + "', '" + u + "')";
			// console.log(insertStr);
			tx.executeSql(insertStr)
		}
		
		rsvAirBodyDtoT.openDB.transaction(insertA, rsvAirBodyDtoT.errorT, rsvAirBodyDtoT.successT);
	},
	selectT : function(callback, a){
		var selectA = function(tx){
			if(nullToBlank(a) == ""){
				tx.executeSql('SELECT * FROM TB_RSV_AIR_BODYDTO', [], callback, rsvAirBodyDtoT.errorT);
			}else{
				tx.executeSql('SELECT * FROM TB_RSV_AIR_BODYDTO WHERE jSessionID = ?', [a], callback, rsvAirBodyDtoT.errorT);
			}
		}
		
		rsvAirBodyDtoT.openDB.transaction(selectA, rsvAirBodyDtoT.errorT);
	},
	updateT : function(a, b, c, d, e, f, g, h, i){
		var updateA = function(tx){
			var updateStr = "UPDATE TB_RSV_AIR_BODYDTO SET ";
				updateStr += " rsvUserId = '" + a + "',";
				updateStr += " rsvUserNm = '" + b + "', ";
				updateStr += " rsvEnSurNm ='" + c + "', ";
				updateStr += " rsvHtel = '" + d + "', ";
				updateStr += " rsvBirth = '" + e + "', ";
				updateStr += " rsvEmail = '" + f + "', ";
				updateStr += " rsvRemark = '" + g + "', ";
				updateStr += " rsvEnFirstNm = '" + h + "' "; 
				updateStr += " WHERE jSessionID = '" + i + "'";
			
			// console.log(updateStr);
			tx.executeSql(updateStr);
		}
		
		rsvAirBodyDtoT.openDB.transaction(updateA, rsvAirBodyDtoT.errorT, rsvAirBodyDtoT.successT);
	},	
	deleteT : function(a){
		var deleteA = function(tx){
			var deleteStr = "DELETE FROM TB_RSV_AIR_BODYDTO ";
				updateStr += " WHERE jSessionID = '" + a + "'";

			tx.executeSql(deleteStr);
		}
		
		rsvAirBodyDtoT.openDB.transaction(deleteA, rsvAirBodyDtoT.errorT, rsvAirBodyDtoT.successT);
	},			
	clearT : function(){
		var createA = function(tx){
			tx.executeSql('DROP TABLE IF EXISTS TB_RSV_AIR_BODYDTO');
		}
		
		rsvAirBodyDtoT.openDB.transaction(createA, rsvAirBodyDtoT.errorT, rsvAirBodyDtoT.successT);
	},	
	errorT:function(err){
		console.log(err);
		console.log("Error TB_RSV_AIR_BODYDTO processing SQL: "+err);
	},
	
	successT:function(data){
		// console.log("TB_RSV_AIR_BODYDTO 쿼리데이타");
	},
	
}

var rsvMstUserInfo = {
	openDB : window.openDatabase("LOTTE", "1.0", "LOTTE JTB", 1000000),
	createT : function(){
		var createA = function(tx){
			tx.executeSql('DROP TABLE IF EXISTS TB_RSV_MST_USER');
			tx.executeSql('CREATE TABLE IF NOT EXISTS TB_RSV_MST_USER (jSessionID, resKorNm, resLastNm, resFirstNm, resEmail, resPhoneNum, resBirthday, resUserId, concMix, saleAmtTot, saleAmtAir, saleAmtHtl, saleAmtRnt, airDiscntAmt, htlDiscntAmt, rntDiscntAmt)');
		}
		
		rsvMstUserInfo.openDB.transaction(createA, function(err){
			console.log("Create Error");
			console.log(err);
		}, function(){ console.log("TB_RSV_MST_USER Create"); });
	},
	insertT : function(callback, a, b, c, d, e, f, g, h, i, j, k, l, m, o, p, q){
		var insertA = function(tx){
			var query = "INSERT INTO TB_RSV_MST_USER (jSessionID, resKorNm, resLastNm, resFirstNm, resEmail, resPhoneNum, resBirthday, resUserId, concMix, saleAmtTot, saleAmtAir, saleAmtHtl, saleAmtRnt, airDiscntAmt, htlDiscntAmt, rntDiscntAmt)";
				query += " VALUES ('"+ a +"', '"+ b +"', '"+ c +"', '"+ d +"', '"+ e +"', '"+ f +"', '"+ g +"', '"+ h +"', '"+ i +"', '"+ j +"', '"+ k +"', '"+ l +"', '"+ m +"', '"+ o +"', '"+ p +"', '"+ q +"')";
				
				tx.executeSql(query);
		}
		
		rsvMstUserInfo.openDB.transaction(insertA, function(err){
			console.log("Insert Error");
			console.log(err);
		}, callback);
	},
	updateT : function(callback, a, b, c, d, e, f, g, h){
		var updateA = function(tx){
			var query = "UPDATE TB_RSV_MST_USER SET";
				query += " resKorNm = '"+ a +"',";
				query += " resLastNm = '"+ b +"',";
				query += " resFirstNm = '"+ c +"',";
				query += " resEmail = '"+ d +"',";
				query += " resPhoneNum = '"+ e +"',";
				query += " resBirthday = '"+ f +"',";
				query += " resUserId = '"+ g +"'";
				query += "WHERE jSessionID = '"+ h +"'";
			
			tx.executeSql(query);
		}
		
		rsvMstUserInfo.openDB.transaction(updateA, function(err){
			console.log("TB_RSV_MST_USER Update");
			console.log(err);
		}, callback);
	},
	deleteT : function(a){
		var deleteA = function(tx){
			var query = "DELETE FROM TB_RSV_MST_USER";
			if(nullToBlank(a) != ""){
				query += "WHERE jSessionId = '"+ a +"'";
			}
			
			tx.executeSql(query);
		}
		
		rsvMstUserInfo.openDB.transaction(deleteA, function(err){
			console.log("TB_RSV_MST_USER Delete");
			console.log(err);
		}, function(){ console.log("TB_RSV_MST_USER Delete") });
	},
	selectT : function(callback, a){
		var selectA = function(tx){
			if(nullToBlank(a) != ""){
				tx.executeSql('SELECT * FROM TB_RSV_MST_USER', [], callback, rsvMstUserInfo.errorT);
			}else{
				tx.executeSql('SELECT * FROM TB_RSV_MST_USER WHERE jSessionID = ?', [a], callback, rsvMstUserInfo.errorT);
			}
		}
		
		rsvMstUserInfo.openDB.transaction(selectA, rsvMstUserInfo.errorT);
	},
	errorT : function(err){
		console.log(err);
	}
}

// ---------------------------------------------------------------------------------------------------------------------------------------------
// 항공예약 > 항공 예약 처리 API > SegmentGroup 정보 
// ---------------------------------------------------------------------------------------------------------------------------------------------
var rsvAirSegmentGroupT = {
	openDB : window.openDatabase("LOTTE", "1.0", "LOTTE JTB", 1000000),
	createT : function(){
		var createA = function(tx){
			tx.executeSql('DROP TABLE IF EXISTS TB_RSV_AIR_SEGMENTGROUP');
			tx.executeSql('CREATE TABLE IF NOT EXISTS TB_RSV_AIR_SEGMENTGROUP (jSessionID, availNo, segNo, carrierCd, opCarrierCd, fltNo, fltEquip, depDt, depTm, depCd, arrDt, arrTm, arrCd, eTketYn, bookingClas, depTerminal, arrTerminal, codeShare, codeShareNm, cabinClas, durationTm, cnxTy)');
		}
		
		rsvAirSegmentGroupT.openDB.transaction(createA, rsvAirSegmentGroupT.errorT, function(){ console.log("TB_RSV_AIR_SEGMENTGROUP Create"); });
	},
	insertT : function(a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v){
		var insertA = function(tx){
			var insertStr = "INSERT INTO TB_RSV_AIR_SEGMENTGROUP (jSessionID, availNo, segNo, carrierCd, opCarrierCd, fltNo, fltEquip, depDt, depTm, depCd, arrDt, arrTm, arrCd, eTketYn, bookingClas, depTerminal, arrTerminal, codeShare, codeShareNm, cabinClas, durationTm, cnxTy)";
				insertStr += "VALUES ('"+ a +"', '"+ b +"', '"+ c +"', '"+ d +"', '"+ e +"', '"+ f +"', '"+ g +"', '"+ h +"', '"+ i +"', '"+ j +"', '"+ k +"', '"+ l +"', '"+ m +"', '"+ n +"', '"+ o +"', '" + p + "', '" + q + "', '" + r + "', '" + s + "', '" + t +"', '"+u+"', '"+v+"')";
			// console.log(insertStr);
			tx.executeSql(insertStr)
		}
		
		rsvAirSegmentGroupT.openDB.transaction(insertA, rsvAirSegmentGroupT.errorT, rsvAirSegmentGroupT.successT);
	},
	selectT : function(callback, a){
		var selectA = function(tx){
			if(nullToBlank(a) == ""){
				tx.executeSql('SELECT * FROM TB_RSV_AIR_SEGMENTGROUP', [], callback, rsvAirSegmentGroupT.errorT);
			}else{
				tx.executeSql('SELECT * FROM TB_RSV_AIR_SEGMENTGROUP WHERE jSessionID = ? ORDER BY availNo', [a], callback, rsvAirSegmentGroupT.errorT);
			}
		}
		
		rsvAirSegmentGroupT.openDB.transaction(selectA, rsvAirSegmentGroupT.errorT);
	},
	deleteT : function(a){
		var deleteA = function(tx){
			var deleteStr = "DELETE FROM TB_RSV_AIR_SEGMENTGROUP ";
				updateStr += " WHERE jSessionID = '" + a + "'";

			tx.executeSql(deleteStr);
		}
		
		rsvAirSegmentGroupT.openDB.transaction(deleteA, rsvAirSegmentGroupT.errorT, rsvAirSegmentGroupT.successT);
	},			
	clearT : function(){
		var createA = function(tx){
			tx.executeSql('DROP TABLE IF EXISTS TB_RSV_AIR_SEGMENTGROUP');
		}
		
		rsvAirSegmentGroupT.openDB.transaction(createA, rsvAirSegmentGroupT.errorT, rsvAirSegmentGroupT.successT);
	},	
	errorT:function(err){
		console.log("Error TB_RSV_AIR_SEGMENTGROUP processing SQL: "+err);
	},
	
	successT:function(data){
		// console.log("TB_RSV_AIR_SEGMENTGROUP 쿼리데이타");
	},
	
}

// ---------------------------------------------------------------------------------------------------------------------------------------------
// 항공예약 > 항공 예약 처리 API > paxGroup 정보 
// ---------------------------------------------------------------------------------------------------------------------------------------------
var rsvAirPaxGroupT = {
	openDB : window.openDatabase("LOTTE", "1.0", "LOTTE JTB", 1000000),
	createT : function(){
		var createA = function(tx){
			tx.executeSql('DROP TABLE IF EXISTS TB_RSV_AIR_PAXGROUP');
			tx.executeSql('CREATE TABLE IF NOT EXISTS TB_RSV_AIR_PAXGROUP (jSessionID, paxNo, paxTy, paxTyNo, krPaxNm, enSurNm, enFirstNm, dateOfBirth, paxTel, paxEmail, gender, passportYn, fareCharge, taxCharge, cabinClas, bookingClas, vCarrierCd, discntCharge, fuelSurcharge, qCharge, upCharge, pmoDiscntCharge, pmoUpCharge)');
		}
		
		rsvAirPaxGroupT.openDB.transaction(createA, rsvAirPaxGroupT.errorT, rsvAirPaxGroupT.successT);
	},
	insertT : function(a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, r, s, t, u, v, w, x){
		var insertA = function(tx){
			var insertStr = "INSERT INTO TB_RSV_AIR_PAXGROUP (jSessionID, paxNo, paxTy, paxTyNo, krPaxNm, enSurNm, enFirstNm, dateOfBirth, paxTel, paxEmail, gender, passportYn, fareCharge, taxCharge, cabinClas, bookingClas, vCarrierCd, discntCharge, fuelSurcharge, qCharge, upCharge, pmoDiscntCharge, pmoUpCharge)";
				insertStr += "VALUES ('"+ a +"', '"+ b +"', '"+ c +"', '"+ d +"', '"+ e +"', '"+ f +"', '"+ g +"', '"+ h +"', '"+ i +"', '"+ j +"', '"+ k +"', '"+ l +"', '"+ m +"', '"+ n +"', '"+ o +"', '"+ p +"', '"+ r +"', '"+ s +"', '"+ t +"', '"+ u +"', '"+ v +"', '"+ w +"', '"+ x +"')";
			// console.log(insertStr);
			tx.executeSql(insertStr)
		}
		
		rsvAirPaxGroupT.openDB.transaction(insertA, rsvAirPaxGroupT.errorT, rsvAirPaxGroupT.successT);
	},
	selectT : function(callback, a){
		var selectA = function(tx){
			if(nullToBlank(a) == ""){
				tx.executeSql('SELECT * FROM TB_RSV_AIR_PAXGROUP  ORDER BY paxNo, paxTy', [], callback, rsvAirPaxGroupT.errorT);
			}else{
				tx.executeSql('SELECT * FROM TB_RSV_AIR_PAXGROUP WHERE jSessionID = ? ORDER BY paxNo, paxTy', [a], callback, rsvAirPaxGroupT.errorT);
			}
		}
		
		rsvAirPaxGroupT.openDB.transaction(selectA, rsvAirPaxGroupT.errorT);
	},
	updateT : function(a, b, c, d, e, f, g, h, i, j, k){
		var updateA = function(tx){
			// krPaxNm, enSurNm, enFirstNm, dataOfBirth, paxTel, paxEmail, gender, passportYn
			var updateStr = "UPDATE TB_RSV_AIR_PAXGROUP SET ";
				updateStr += " krPaxNm = '" + a + "',";
				updateStr += " enSurNm = '" + b + "', ";
				updateStr += " enFirstNm ='" + c + "', ";
				updateStr += " dateOfBirth = '" + d + "', ";
				updateStr += " paxTel = '" + e + "', ";
				updateStr += " paxEmail = '" + f + "', ";
				updateStr += " gender = '" + g + "', "; 
				updateStr += " passportYn='" + h + "' ";
				updateStr += " WHERE jSessionID = '" + i + "'";
				updateStr += " AND paxTy = '" + j + "'";
				updateStr += " AND paxTyNo = '" + k + "'";
			
			// console.log(updateStr);
			tx.executeSql(updateStr);
		}
		
		rsvAirPaxGroupT.openDB.transaction(updateA, rsvAirPaxGroupT.errorT, rsvAirPaxGroupT.successT);
	},	

	deleteT : function(a){
		var deleteA = function(tx){
			var deleteStr = "DELETE FROM TB_RSV_AIR_PAXGROUP ";
				updateStr += " WHERE jSessionID = '" + a + "'";

			tx.executeSql(deleteStr);
		}
		
		rsvAirPaxGroupT.openDB.transaction(deleteA, rsvAirPaxGroupT.errorT, rsvAirPaxGroupT.successT);
	},				
	clearT : function(){
		var createA = function(tx){
			tx.executeSql('DROP TABLE IF EXISTS TB_RSV_AIR_PAXGROUP');
		}
		
		rsvAirPaxGroupT.openDB.transaction(createA, rsvAirPaxGroupT.errorT, rsvAirPaxGroupT.successT);
	},	
	errorT:function(err){
		console.log("Error TB_RSV_AIR_PAXGROUP processing SQL: "+err);
	},
	
	successT:function(data){
		// console.log("TB_RSV_AIR_PAXGROUP 쿼리데이타");
	},
	
}

// ---------------------------------------------------------------------------------------------------------------------------------------------
// 항공예약 > 항공 예약 처리 API > fareDataBean 정보 
// ---------------------------------------------------------------------------------------------------------------------------------------------
var rsvAirFareDataBeanT = {
	openDB : window.openDatabase("LOTTE", "1.0", "LOTTE JTB", 1000000),
	createT : function(){
		var createA = function(tx){
			tx.executeSql('DROP TABLE IF EXISTS TB_RSV_AIR_FAREDATABEAN');
			tx.executeSql('CREATE TABLE IF NOT EXISTS TB_RSV_AIR_FAREDATABEAN (jSessionID, availNo, segNo, fareBasis, fareTy, paxTy, cabinClas, rbd, breakPoint)');
		}
		
		rsvAirFareDataBeanT.openDB.transaction(createA, rsvAirFareDataBeanT.errorT, rsvAirFareDataBeanT.successT);
	},
	insertT : function(a, b, c, d, e, f, g, h, i){
		var insertA = function(tx){
			var insertStr = "INSERT INTO TB_RSV_AIR_FAREDATABEAN (jSessionID, availNo, segNo, fareBasis, fareTy, paxTy, cabinClas, rbd, breakPoint)";
				insertStr += "VALUES ('"+ a +"', '"+ b +"', '"+ c +"', '"+ d +"', '"+ e +"', '"+ f +"', '"+ g +"', '"+ h +"', '"+ i +"')";
			// console.log(insertStr);
			tx.executeSql(insertStr)
		}
		
		rsvAirFareDataBeanT.openDB.transaction(insertA, rsvAirFareDataBeanT.errorT, rsvAirFareDataBeanT.successT);
	},
	selectT : function(callback, a){
		var selectA = function(tx){
			if(nullToBlank(a) == ""){
				tx.executeSql('SELECT * FROM TB_RSV_AIR_FAREDATABEAN', [], callback, rsvAirFareDataBeanT.errorT);
			}else{
				tx.executeSql('SELECT * FROM TB_RSV_AIR_FAREDATABEAN WHERE jSessionID = ? ORDER BY availNo', [a], callback, rsvAirFareDataBeanT.errorT);
			}
		}
		
		rsvAirFareDataBeanT.openDB.transaction(selectA, rsvAirFareDataBeanT.errorT);
	},
	deleteT : function(a){
		var deleteA = function(tx){
			var deleteStr = "DELETE FROM TB_RSV_AIR_FAREDATABEAN ";
				updateStr += " WHERE jSessionID = '" + a + "'";

			tx.executeSql(deleteStr);
		}
		
		rsvAirFareDataBeanT.openDB.transaction(deleteA, rsvAirFareDataBeanT.errorT, rsvAirFareDataBeanT.successT);
	},					
	clearT : function(){
		var createA = function(tx){
			tx.executeSql('DROP TABLE IF EXISTS TB_RSV_AIR_FAREDATABEAN');
		}
		
		rsvAirFareDataBeanT.openDB.transaction(createA, rsvAirFareDataBeanT.errorT, rsvAirFareDataBeanT.successT);
	},	
	errorT:function(err){
		console.log("Error TB_RSV_AIR_FAREDATABEAN processing SQL: "+err);
	},
	
	successT:function(data){
		// console.log("TB_RSV_AIR_PAXGROUP 쿼리데이타");
	},
	
}