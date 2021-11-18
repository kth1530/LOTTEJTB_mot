<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.lottejtb.front.air.service.*" %>
<%@ page import="com.lottejtb.comm.util.*" %>


<%
	// 파일명 : pop_mileage.jsp
	// 설명 : 마일리지 (새창)

	String cust_cd = (String) request.getAttribute("cust_cd");
	String knm = (String) request.getAttribute("knm");
	String email = (String) request.getAttribute("email");
	String age = (String) request.getAttribute("age");
	String sex = (String) request.getAttribute("sex");
	RsvAirVO rsvAir = (RsvAirVO) request.getAttribute("rsvAirResult");

%>
<script src="/resources/common/js/fit/common.js"></script>
<script type='text/javascript'>
	/* *************************************************************************** */
	// [AJAX] 데이타 통신 부분 
	
	var rsvAirPaxList = null;
	var paxCnt = 0;

	// 탑승객 1 ~ 10
	var paxNo1;
	var paxTy1;
	var mileageNo1;
	var carrierCd1;
	var sendYn1;

	var paxNo2;
	var paxTy2;
	var mileageNo2;
	var carrierCd2;
	var sendYn2;

	var paxNo3;
	var paxTy3;
	var mileageNo3;
	var carrierCd3;
	var sendYn3;

	var paxNo4;
	var paxTy4;
	var mileageNo4;
	var carrierCd4;
	var sendYn4;

	var paxNo5;
	var paxTy5;
	var mileageNo5;
	var carrierCd5;
	var sendYn5;

	var paxNo6;
	var paxTy6;
	var mileageNo6;
	var carrierCd6;
	var sendYn6;

	var paxNo7;
	var paxTy7;
	var mileageNo7;
	var carrierCd7;
	var sendYn7;

	var paxNo8;
	var paxTy8;
	var mileageNo8;
	var carrierCd8;
	var sendYn8;

	var paxNo9;
	var paxTy9;
	var mileageNo9;
	var carrierCd9;
	var sendYn9;

	var paxNo10;
	var paxTy10;
	var mileageNo10;
	var carrierCd10;
	var sendYn10;

	// 항공 탑승객 리스트 조회 
	function fn_AirPaxList() {

		var formData = new FormData();
		formData.append('seqNo', '<%=rsvAir.getAirRsvSeqno()%>');

		
		cfn_ajax({
			type: "POST",
			async: false,
			url: "/free/account/srchRsvAirPaxListAjax.do",
			data: formData,
			dataType: "json",
			cache: false,
			noloading:"no",
			timeOut: (5*60*1000),
			success: function(res) {
				rsvAirPaxList = res.rsvAirPaxList;
				paxCnt = rsvAirPaxList.length;

				var html = "";
				
				// 항공 마일리지 정보 입력 리스트 
				if(rsvAirPaxList != null) {
					for(var i = 0; i < rsvAirPaxList.length; i++) {

						html = html + "							<table class='pop_table2 ft_th_tl ft_td_tl mt7'>";
						html = html + "								<input type='hidden' id='paxNo"+rsvAirPaxList[i].paxNo+"' name='paxNo"+rsvAirPaxList[i].paxNo+"' data-role='none' value='"+rsvAirPaxList[i].paxNo+"'/>";
						html = html + "								<input type='hidden' id='paxTy"+rsvAirPaxList[i].paxNo+"' name='paxTy"+rsvAirPaxList[i].paxNo+"' data-role='none' value='"+rsvAirPaxList[i].paxTyGb+"'/>";
						html = html + "								<colgroup>";
						html = html + "									<col style='width: 35%' />";
						html = html + "									<col style='width: 65%' />";
						html = html + "								</colgroup>";
						html = html + "								<tbody>";
						html = html + "									<tr>";
						html = html + "										<th>탑승객</th>";
						html = html + "										<td>" + rsvAirPaxList[i].enSurNm + " / " + rsvAirPaxList[i].enFirstNm + "</td>";
						html = html + "									</tr>";
						html = html + "									<tr>";
						html = html + "										<th>탑승 항공사</th>";
						html = html + "										<td><%=rsvAir.getCarrierNm()%></td>";
						html = html + "									</tr>";
						html = html + "									<tr>";
						html = html + "									<th>적립 항공사</th>";
						html = html + "										<td>";
						// 적립 항공사 리스트 조회 
						html = html + "											<span id='selectbox_airList"+rsvAirPaxList[i].paxNo+"' name='selectbox_airList"+rsvAirPaxList[i].paxNo+"'></span>";
						html = html + "										</td>";
						html = html + "									</tr>";
						html = html + "									<tr>";
						html = html + "										<th>항공사<br>마일리지 번호<em class='f_red'>*</em></th>";
						html = html + "										<td><input type='text' name='mileageNo"+rsvAirPaxList[i].paxNo+"' id='mileageNo"+rsvAirPaxList[i].paxNo+"' class='mles_input' value=''/></td>";
						html = html + "									</tr>";
						html = html + "								</tbody>";
						html = html + "							</table>";

					}
				}

				
				$("#div_airMileageList").html(html);


			},
			error:function(err){
				//console.log(err);
			},
			complete:function(){
				fn_srchAirList();
			}
		});
	};	

	function fn_srchAirList() {
		var formData = new FormData();
		// formData.append("grp_cd", "MAILGB");
		var airList = null;

		cfn_ajax({
			url : "/fit/rsv/srchAirMileageListAjax.do",
			type : "POST",
			data : formData,
			async : false,
			dataType : "json",
			cache : false,
			noloading : "no",
			timeOut : (5 * 60 * 1000),
			success : function(res) {
				airList = res.airList;
				var html = "";

				// html = html + "											<select name='carrierCd"+rsvAirPaxList[i].paxNo+"' id='carrierCd"+rsvAirPaxList[i].paxNo+"' class='mles_select'>";
				// html = html + "												<option value='<%=rsvAir.getCarrierCd()%>'><%=rsvAir.getCarrierNm()%></option>";
				// html = html + "											</select>";
				for(var idx=0; idx < paxCnt; idx++) {
					var p_idx = idx+1;
					html = html + "<select id='carrierCd"+p_idx+"' name='carrierCd"+p_idx+"' class='mles_select'>";
					if (airList != null) {
						for (var i = 0; i < airList.length; i++) {
							if(i == 0) {
								if(nullToBlank(airList[i]["carrierKrNm"]) != '') {
									html = html + "<option value='"+airList[i]["carrierCd"]+"' selected>" + airList[i]["carrierKrNm"] + "</option>";
								} else {
									html = html + "<option value='"+airList[i]["carrierCd"]+"' selected>" + airList[i]["carrierEnNm"] + "</option>";
								}
							} else {
								if(nullToBlank(airList[i]["carrierKrNm"]) != '') {
									html = html + "<option value='"+airList[i]["carrierCd"]+"'>" + airList[i]["carrierKrNm"] + "</option>";
								} else {
									html = html + "<option value='"+airList[i]["carrierCd"]+"'>" + airList[i]["carrierEnNm"] + "</option>";
								}
							}
						}
					}
					html = html + "</select>";
				}
				var tag = "#selectbox_airList" + idx;

				$(tag).html(html);

			},
			error : function(err) {
				console.log(err);
			},
			complete : function() {
			}
		});

	}

	function fn_getParam() {
		// 항공 PNR 관련 sendYn 처리 부분 Default 'N' 으로 처리함. 
		// 2017.04.27
		// 추후 변경 요구시 관리자에서 변경하면 된다고 함. 
		if(paxCnt > 0) {
			paxNo1 = $('#paxNo1').val();
			paxTy1 = $('#paxTy1').val();
			mileageNo1 = $('#mileageNo1').val();
			carrierCd1 = $("#carrierCd1 option:selected").val();
			sendYn1 = 'N';
		}

		if(paxCnt > 1) {
			paxNo2 = $('#paxNo2').val();
			paxTy2 = $('#paxTy2').val();
			mileageNo2 = $('#mileageNo2').val();
			carrierCd2 = $("#carrierCd2 option:selected").val();
			sendYn2 = 'N';
			
		}

		if(paxCnt > 2) {
			paxNo3 = $('#paxNo3').val();
			paxTy3 = $('#paxTy3').val();
			mileageNo3 = $('#mileageNo3').val();
			carrierCd3 = $("#carrierCd3 option:selected").val();
			sendYn3 = 'N';
			
		}

		if(paxCnt > 3) {
			paxNo4 = $('#paxNo4').val();
			paxTy4 = $('#paxTy4').val();
			mileageNo4 = $('#mileageNo4').val();
			carrierCd4 = $("#carrierCd4 option:selected").val();
			sendYn4 = 'N';
			
		}

		if(paxCnt > 4) {
			paxNo5 = $('#paxNo5').val();
			paxTy5 = $('#paxTy5').val();
			mileageNo5 = $('#mileageNo5').val();
			carrierCd5 = $("#carrierCd5 option:selected").val();
			sendYn5 = 'N';
			
		}		

		if(paxCnt > 5) {
			paxNo6 = $('#paxNo6').val();
			paxTy6 = $('#paxTy6').val();
			mileageNo6 = $('#mileageNo6').val();
			carrierCd6 = $("#carrierCd6 option:selected").val();
			sendYn6 = 'N';
			
		}	

		if(paxCnt > 6) {
			paxNo7 = $('#paxNo7').val();
			paxTy7 = $('#paxTy7').val();
			mileageNo7 = $('#mileageNo7').val();
			carrierCd7 = $("#carrierCd7 option:selected").val();
			sendYn7 = 'N';
			
		}	

		if(paxCnt > 7) {
			paxNo8 = $('#paxNo8').val();
			paxTy8 = $('#paxTy8').val();
			mileageNo8 = $('#mileageNo8').val();
			carrierCd8 = $("#carrierCd8 option:selected").val();
			sendYn8 = 'N';
			
		}		

		if(paxCnt > 8) {
			paxNo9 = $('#paxNo9').val();
			paxTy9 = $('#paxTy9').val();
			mileageNo9 = $('#mileageNo9').val();
			carrierCd9 = $("#carrierCd9 option:selected").val();
			sendYn9 = 'N';
			
		}	

		if(paxCnt > 9) {
			paxNo10 = $('#paxNo10').val();
			paxTy10 = $('#paxTy10').val();
			mileageNo10 = $('#mileageNo10').val();
			carrierCd10 = $("#carrierCd10 option:selected").val();
			sendYn10 = 'N';
			
		}									
	}
	
	// 항공 마일리지 유효성 체크 
	function fn_checkParam() {
		if(paxCnt > 0) {			
			if(mileageNo1 == '' || mileageNo1 == null) {
				alert("항공 마일리지 번호를 입력해 주세요.");
				$("#mileageNo1").focus();
				return false;
			}
		}

		if(paxCnt > 1) {			
			if(mileageNo2 == '' || mileageNo2 == null) {
				alert("항공 마일리지 번호를 입력해 주세요.");
				$("#mileageNo2").focus();
				return false;
			}
		}

		if(paxCnt > 2) {			
			if(mileageNo3 == '' || mileageNo3 == null) {
				alert("항공 마일리지 번호를 입력해 주세요.");
				$("#mileageNo3").focus();
				return false;
			}
		}

		if(paxCnt > 3) {			
			if(mileageNo4 == '' || mileageNo4 == null) {
				alert("항공 마일리지 번호를 입력해 주세요.");
				$("#mileageNo4").focus();
				return false;
			}
		}

		if(paxCnt > 4) {			
			if(mileageNo5 == '' || mileageNo5 == null) {
				alert("항공 마일리지 번호를 입력해 주세요.");
				$("#mileageNo5").focus();
				return false;
			}
		}

		if(paxCnt > 5) {			
			if(mileageNo6 == '' || mileageNo6 == null) {
				alert("항공 마일리지 번호를 입력해 주세요.");
				$("#mileageNo6").focus();
				return false;
			}
		}

		if(paxCnt > 6) {			
			if(mileageNo7 == '' || mileageNo7 == null) {
				alert("항공 마일리지 번호를 입력해 주세요.");
				$("#mileageNo7").focus();
				return false;
			}
		}

		if(paxCnt > 7) {			
			if(mileageNo8 == '' || mileageNo8 == null) {
				alert("항공 마일리지 번호를 입력해 주세요.");
				$("#mileageNo8").focus();
				return false;
			}
		}

		if(paxCnt > 8) {			
			if(mileageNo9 == '' || mileageNo9 == null) {
				alert("항공 마일리지 번호를 입력해 주세요.");
				$("#mileageNo9").focus();
				return false;
			}
		}

		if(paxCnt > 9) {			
			if(mileageNo10 == '' || mileageNo10 == null) {
				alert("항공 마일리지 번호를 입력해 주세요.");
				$("#mileageNo10").focus();
				return false;
			}
		}
		
		return true;
	}

	// 항공 마일리지 등록 
	function fn_saveMileage() {
		fn_getParam();
		if(fn_checkParam()) {
			var airMileageData = {
				// bodyDTO
				
			};
			airMileageData.bodyDTO = {
				"rsvSeqno"		: <%=rsvAir.getAirRsvSeqno()%>
			};

			airMileageData.bodyDTO.paxGroup = [];

			console.log("paxCnt : " + paxCnt);

			if(paxCnt > 0) {

				airMileageData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo1,
					"paxTy"				: paxTy1,
					"mileageNo"			: mileageNo1,
					"carrierCd"			: carrierCd1,
					"sendYn"			: sendYn1

				});
			}

			if(paxCnt > 1) {
				airMileageData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo2,
					"paxTy"				: paxTy2,
					"mileageNo"			: mileageNo2,
					"carrierCd"			: carrierCd2,
					"sendYn"			: sendYn2

				});
			}	

			if(paxCnt > 2) {
				airMileageData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo3,
					"paxTy"				: paxTy3,
					"mileageNo"			: mileageNo3,
					"carrierCd"			: carrierCd3,
					"sendYn"			: sendYn3

				});
			}	

			if(paxCnt > 3) {
				airMileageData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo4,
					"paxTy"				: paxTy4,
					"mileageNo"			: mileageNo4,
					"carrierCd"			: carrierCd4,
					"sendYn"			: sendYn4

				});
			}		

			if(paxCnt > 4) {
				airMileageData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo5,
					"paxTy"				: paxTy5,
					"mileageNo"			: mileageNo5,
					"carrierCd"			: carrierCd5,
					"sendYn"			: sendYn5

				});
			}	

			if(paxCnt > 5) {
				airMileageData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo6,
					"paxTy"				: paxTy6,
					"mileageNo"			: mileageNo6,
					"carrierCd"			: carrierCd6,
					"sendYn"			: sendYn6

				});
			}	

			if(paxCnt > 6) {
				airMileageData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo7,
					"paxTy"				: paxTy7,
					"mileageNo"			: mileageNo7,
					"carrierCd"			: carrierCd7,
					"sendYn"			: sendYn7

				});
			}	

			if(paxCnt > 7) {
				airMileageData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo8,
					"paxTy"				: paxTy8,
					"mileageNo"			: mileageNo8,
					"carrierCd"			: carrierCd8,
					"sendYn"			: sendYn8

				});
			}	

			if(paxCnt > 8) {
				airMileageData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo9,
					"paxTy"				: paxTy9,
					"mileageNo"			: mileageNo9,
					"carrierCd"			: carrierCd9,
					"sendYn"			: sendYn9

				});
			}		

			if(paxCnt > 9) {
				airMileageData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo10,
					"paxTy"				: paxTy10,
					"mileageNo"			: mileageNo10,
					"carrierCd"			: carrierCd10,
					"sendYn"			: sendYn10

				});
			}	

			console.log(airMileageData);

        	gfn_callAjax ('/fit/rsv/saveMileageAjax.do', airMileageData.bodyDTO, 'successMileage');				
		}																																							
	}

    function successMileage(_data) {

        var data = _data.result.data;
        
        if (data.length > 0) {
        }
        if(_data.result.code == 1) {
 	       alert("항공 마일리지가 등록되었습니다.");
		   closePopup();

        } else {
            alert("항공 마일리지가 등록되지 않았습니다.");
        }
    }

	function closePopup() {
		jQuery('html, body').css({'overflow':'auto'});
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
		};              
		// opener.focus();		
	}

	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		fn_AirPaxList();

	});

</script>

<div class='layerPopup'>
	<div class='layerPop'>
		<!-- 내용시작 -->
		<div class='popCon'>
			<div class='popHead'>
				<div class='popTpart'>
					<strong class='popTitle'>항공사 마일리지 등록</strong>
					<button type='button' class='layerClose'>
						<img src='/resources/images/btn/btn_exit.png' alt='레이어 닫기'>
					</button>
				</div>
			</div>
			<div class='cntain mileage'>
				<ul class='white2 dotlist2'>
					<li>항공 마일리지 번호를 남겨주시면 예약기록으로 등록해 드립니다.</li>
					<li>단, 항공사 전송 문제로 누락될 수 있으므로 공항에서 재확인 하시길 바립니다.</li>
					<li>항공권에 따라 적립이 불가할 수 있으니 규정을 꼭 확인바랍니다.</li>
				</ul>
				<dl class='pop_chk_list pop_chk_list2 mt7'>
					<dt class='ico_exclamat'>정보입력</dt>
					<dd>
						<!-- 항공 마일리지 입력 리스트 -->
						<div id="div_airMileageList" name="div_airMileageList"></div>
						<!-- 항공 마일리지 입력 리스트 -->
					</dd>
				</dl>
			</div>
		</div>
		<!-- 내용끝 -->
		<div class='popFoot'>
			<div class='layerBtns'>
				<button type='button' class='layerClose2' onclick="fn_saveMileage()">확인</button>
			</div>
		</div>
	</div>
</div>