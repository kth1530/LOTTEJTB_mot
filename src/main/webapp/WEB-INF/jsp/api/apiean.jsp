<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/commTagLib.jsp"%>
<head>
<script type="text/javascript">
	//  http://localhost:8080/ean/APInfoAjax.do?minorRev=30&locale=ko_KR&currencyCode=KRW&arrivalDate=10/17/2016&departureDate=10/19/2016&numberOfAdults=2&numberOfChildren=3&childAges=5,6,7&city=Boston&stateProvinceCode=MA&countryCode=US
	//  http://api.ean.com/ean-services/rs/hotel/v3/list?cid=500317&sig=d0d3bb8d3908675e8b4a9701046c7af8&minorRev=30&apiKey=42054h3uto03kvli4lpk1ls71f&locale=ko_KR&currencyCode=KRW&customerIpAddress=10.26.131.178&customerUserAgent=Mozilla/5.0+(Windows+NT+6.1;+Win64;+x64)+AppleWebKit/537.36+(KHTML,+like+Gecko)+Chrome/53.0.2785.116+Safari/537.36&customerSessionId=&xml=<HotelListRequest><departureDate>10/17/2016</departureDate><departureDate>10/19/2016</departureDate><RoomGroup><numberOfAdults>2</numberOfAdults><numberOfChildren>3</numberOfChildren><childAges>5,6,7</childAges></RoomGroup><city>Boston</city><stateProvinceCode>MA</stateProvinceCode><countryCode>US</countryCode><numberOfResults>1</numberOfResults></HotelListRequest>&_type=json
	var strHTML = "";
	var customerSessionId,roomReq,moreYn,cacheKey,cacheLocation;
	$(document).ready(function(){
		var url = "<c:url value='/CommAPInfoAjax.do' />";
		var formData = new FormData();
		formData.append("minorRev","30");
		//formData.append("locale","ko_KR");
		formData.append("locale","us_US");
		//formData.append("currencyCode","KRW");
		formData.append("currencyCode","USD");
		formData.append("arrivalDate","10/17/2016");
		formData.append("departureDate","10/19/2016");
		formData.append("numberOfAdults","2");
		formData.append("numberOfChildren","3");
		formData.append("childAges","5,6,7");
		formData.append("city","HongKong");
		formData.append("stateProvinceCode","MA");
		formData.append("countryCode","US");
		formData.append("numberOfResults","3");
		
		$.ajax({
	        url: url ,
	        type: 'POST',
	        data: formData,
	        async: false,
	        cache: false,
	        dataType : "json",
	        contentType: false,
	        processData: false,
	        success: function (data,status) {
	        	var dataStr = JSON.parse(data);
	        	dataStr     = dataStr.HotelListResponse;
	        	$.each(dataStr, function( key , value ){
	        		fn_ele_1_Depth(key,value);
	        	});
	        	for( intLoop=0;intLoop<=(cnt-1);intLoop++){
	        		if( intLoop==0 ) strHTML = "<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"1\" xmlns:fo=\"http://www.w3.org/1999/XSL/Format\"><tbody>";
	        		strHTML += "<tr>";
	        		strHTML += "  <td style='width:80px;font-weight:bold;text-align:top'>"
	        		strHTML += "    "+(intLoop+1);
	        		strHTML += "    <img src='http://images.travelnow.com"+thumImg[intLoop]+"' width='65' height='65' />";
	        		strHTML += "  </td>";
	        		strHTML += "  <td>&lt;hotel_id&gt;"+hotel_id[intLoop];
	        		if(valueAdds_description[intLoop] != undefined ){
	        			for( intSubLoop=0;intSubLoop<valueAdds_description[intLoop].length;intSubLoop++){
		        			strHTML += "      <br /> "+valueAdds_description[intLoop][intSubLoop];
		        		}
	        		}
	        		strHTML += "  </td>";
	        		strHTML += "  <td>&lt;name&gt;"+hotel_name[intLoop]+"</td>";
	        		strHTML += "  <td>&lt;city&gt;"+city[intLoop]+"</td>";
	        		strHTML += "  <td>&lt;airportCode&gt;"+airportCode[intLoop]+"</td>";
	        		strHTML += "  <td>&lt;latitude&gt;"+latitude[intLoop]+"<br />&lt;longitude&gt;"+longitude[intLoop]+"</td>";
	        		strHTML += "  <td>&lt;locationDescription&gt;"+locationDescription[intLoop]+"</td>";
	        		strHTML += "</tr>";
	        		if( intLoop==(cnt-1) ) strHTML += "</tbody></table>";
	        	}
	        	$("#Div_Hotel_List").html(strHTML);
	        },
	        error : function(request,status,error){
	        	var errMsg = "code:"+request.status+"<br />"+"message:"+request.responseText+"<br />"+"error:"+error;
	        	alert(errMsg);
    			//fn_error();
	        }
	    });
		
	});
	
	function fn_ele_1_Depth(key,value){
		if( key == "customerSessionId" )     customerSessionId = value;
		if( key == "numberOfRoomsRequested") roomReq = value;
		if( key == "moreResultsAvailable")   moreYn = value;
		if( key == "cacheKey")               cacheKey = value;
		if( key == "cacheLocation")          cacheLocation = value;
		if( key == "HotelList")  {
			$.each(value, function( key , value ){
				fn_ele_2_Depth(key,value);
			});
		}
	}
	
	function fn_ele_2_Depth(key,value){
		if( key == "@size" ) cnt = value;
		if( key == "HotelSummary" ){
			$.each(value, function( key , value ){
				fn_ele_3_Depth(key,value);
			});
		}
	}
	
	function fn_ele_3_Depth(key,value){
		// 리스트 갯수가 1이면  json 노드가 바로 시작하지만 1 이상이면 숫자  object 아래에 json 노드가 생겨남.
		if( cnt == 1 ){
			fn_ele_AttrInput(key,value,0,0);
		}else if ( cnt > 1 ){
			$.each(value, function( key , value ){ // 이 부분은 1이상이므로 바로  노드 숫자가 나오므로 바로  $.each문으로 ..패스한다.
				fn_ele_AttrInput(key,value,intLoop,0);
				if( key == "RoomRateDetailsList" && typeof value == "object" ){	
					$.each(value, function( key , value ){
						fn_ele_4_Depth(key,value,intLoop);
					});
					intLoop = intLoop + 1;
				}
			});
		}
	}
	
	function fn_ele_4_Depth(key,value,intLoop){
		var intLoop = 0;
		$.each(value, function( key , value ){
			if( key !="RateInfos" && typeof value !="object" ){
				fn_ele_AttrInput(key,value,intLoop,0);
			}else if ( key =="RateInfos" && typeof value =="object" ) {
				
			}else{
				fn_ele_5_Depth(key,value,intLoop,intLoop);
			}
		});
	}
	
	function fn_ele_5_Depth(key,value,intLoop){
		$.each(value, function( key , value ){
			if( key=="ValueAdd" && typeof value=="object" ){
				var intSubLoop = 0;
				$.each(value, function( key , value ){
					$.each(value, function( key , value ){  // 0 이 끼어 있어 바로 $.each 문으로
						if( key == "description" ){
							//alert(key+"["+intSubLoop+"] : "+value+" ["+intLoop+"]["+intSubLoop+"]");
							fn_ele_AttrInput("valueAdds_"+key,value,intLoop,intSubLoop);
							intSubLoop = intSubLoop + 1;
						}
					});
				});
			}
		});
	}
	
	/* 전역 변수 */
	var intLoop = 0;
	var hotel_id              = new Array();
	var hotel_name            = new Array();
	var hotel_addr            = new Array();
	var hotel_city            = new Array();
	var hotel_disp            = new Array();
	var latitude              = new Array();
	var longitude             = new Array();
	var thumImg               = new Array();
	var city                  = new Array();
	var airportCode           = new Array();
	var latitude              = new Array();
	var longitude             = new Array();
	var locationDescription   = new Array();
	var roomTypeCode          = new Array();
	var rateCode              = new Array();
	var maxRoomOccupancy      = new Array();
	var valueAdds_description = new Array();
	
	/* 전역변수에 세팅 */
	function fn_ele_AttrInput(key,value,intLoop,intSubLoop){
		if( key=="hotelId"                 && typeof value !="object" ) hotel_id[intLoop] = value;
		if( key=="name"                    && typeof value !="object" ) hotel_name[intLoop] = value;
		if( key=="address1"                && typeof value !="object" ) hotel_addr[intLoop] = value;
		if( key=="city"                    && typeof value !="object" ) hotel_city[intLoop] = value;
		if( key=="shortDescription"        && typeof value !="object" ) hotel_disp[intLoop] = value;
		if( key=="latitude"                && typeof value !="object" ) latitude[intLoop] = value;
		if( key=="longitude"               && typeof value !="object" ) longitude[intLoop] = value;
		if( key=="thumbNailUrl"            && typeof value !="object" ) thumImg[intLoop] = value;
		if( key=="city"                    && typeof value !="object" ) city[intLoop] = value;
		if( key=="airportCode"             && typeof value !="object" ) airportCode[intLoop] = value;
		if( key=="latitude"                && typeof value !="object" ) latitude[intLoop] = value;
		if( key=="longitude"               && typeof value !="object" ) longitude[intLoop] = value;
		if( key=="locationDescription"     && typeof value !="object" ) locationDescription[intLoop] = value;
		if( key=="roomTypeCode"            && typeof value !="object" ) rateCode[intLoop] = value;
		if( key=="maxRoomOccupancy"        && typeof value !="object" ) maxRoomOccupancy[intLoop] = value;
		if( key=="valueAdds_description"           && typeof value !="object" ) {
			if( Array.isArray(valueAdds_description[intLoop]) == false ){
				valueAdds_description[intLoop] = new Array();
			}
			valueAdds_description[intLoop][intSubLoop] = value;
			//alert("["+intLoop+"],["+intSubLoop+"]"+valueAdds_description[intLoop][intSubLoop]);
		}
	}
</script>
</head>
<body>
<div id="url">url</div>
<br /><br /><br /><br />
<br /><br /><br /><br />

<div id="contents"></div>

<br /><br /><br /><br />
<br /><br /><br /><br />

<div id="Div_Hotel_List"></div>

<div class="promoBox">
	<table width="100%" cellpadding="0" cellspacing="0" border="0" xmlns:fo="http://www.w3.org/1999/XSL/Format">
		<tbody>
		  <tr>
			<td valign="top" width="8"><b class="dkBlueBG">1</b></td>
			<td valign="top" width="64"><img src="http://images.travelnow.com/hotels/17000000/16080000/16075200/16075175/1830ca77_t.jpg" width="64" height="64" border="1" name="hotelImage" align="left"></td>
			<td valign="top" width="175" class="small">
					&lt;hotelId&gt;  <b class="red"><a href="" onmouseover="showRollTip('The EAN system unique hotel ID. Use this value in all EAN XML requests where the hotel ID is required.',event)" onmouseout="hideRollTip()">626838</a></b><br><b><a title="Get Hotel Information for Le Petit Rosedale Hotel Hong Kong" href="hotelInfo.asp?CID=500317&amp;apiKey=42054h3uto03kvli4lpk1ls71f&amp;minorRev=30&amp;customerIpAddress=10.26.131.178&amp;customerUserAgent=Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36&amp;customerSessionId=0ABAAA5A-DEDD-7791-5792-791C34793B70&amp;locale=en_US&amp;currencyCode=USD&amp;sig=51c943e9f9bd922e5b8424de7914e397&amp;hotelId=626838&amp;supplierType=E&amp;arrivalDate=10/27/2016&amp;departureDate=10/29/2016&amp;numberOfRooms=1&amp;city=Hong Kong&amp;countryCode=HK&amp;rateKey=&amp;numberOfAdults1=2">Le Petit Rosedale Hotel Hong Kong</a></b><br><b>7 Moreton Terrace</b><br><b>Hong Kong</b>,  <b>HK</b> &lt;expediaPropertyId&gt;  <b><a href="" onmouseover="showRollTip('The Expedia system mapped hotel ID',event)" onmouseout="hideRollTip()">16075175</a></b></td>
			<td valign="top" class="small" nowrap=""><a href="" onmouseover="showRollTip('an Expedia result indicates inventory that is contracted and sold through the Expedia system.<br /><br />supplierType=E',event)" onmouseout="hideRollTip()"><b class="dkBlueBG" style="padding:5px;">Expedia Result</b></a><br></td>
			<td valign="top" class="small">&lt;supplierType&gt;  <b class="red">E</b><br>&lt;hotelRating&gt;  <b class="red">3.5 stars</b><br>&lt;propertyCategory&gt;  <b>1</b><br><a href="" onmouseover="showRollTip('A confidence rating is applied to GDS inventory to determine how well or how quickly they pay commissions on non-prepaid bookings.  Does not apply to an Expedia booking.',event)" onmouseout="hideRollTip()">&lt;confidenceRating&gt;</a><b>0</b><br>&lt;tripAdvisorRating&gt;  <b>0.0</b><br>&lt;tripAdvisorRatingUrl&gt;  <b>http://www.tripadvisor.com/img/cdsi/img2/ratings/traveler/0.0-123456-4.gif</b></td>
			<td valign="top" class="small"><a href="" onmouseover="showRollTip('The high and low rate is a statistical value only and may not be a rate returned with the dates selected when requesting availability for booking.',event)" onmouseout="hideRollTip()">High and Low Rate</a><br>&lt;lowRate&gt;  <b>204.25</b><br>&lt;highRate&gt;  <b>255.30</b><br>&lt;rateCurrencyCode&gt;  <b>USD</b><br></td>
			<td valign="top" class="small" nowrap="">&lt;latitude&gt;  <b>22.27921</b><br>&lt;longitude&gt;  <b>114.18924</b><br>&lt;proximityDistance&gt;  <b>7.4879613</b><br>&lt;proximityUnit&gt;  <b>MI</b><br>&lt;hotelInDestination&gt;  <b>true</b></td>
			<td valign="top" class="small" width="150">&lt;locationDescription&gt;  <b>Near Times Square Shopping Mall</b><br><br><a href="" onmouseover="showRollTip('<p><b>Property Location</b> <br />With a stay at Le Petit Rosedale Hotel Hong Kong in Hong Kong (Causeway Bay), you ll be minutes from Hong Kong Central Library and Victoria Park.  This hotel is',event)" onmouseout="hideRollTip()" disable-output-escaping="yes">&lt;shortDescription&gt;</a>&nbsp;</td>
			<td valign="top" class="small" nowrap=""><a href="javascript: popUp('http://travel.ian.com/hotel/maps/626838?cid=500317');" title="Open a Map Window"><b>MAP</b></a><br><a href="javascript: popUp('http://travel.ian.com/hotel/tours/626838?cid=500317');" title="Open a Virtual Tour"><b>Virtual Tour</b></a><br><b><a title="Get Hotel Information for Le Petit Rosedale Hotel Hong Kong" href="hotelInfo.asp?CID=500317&amp;apiKey=42054h3uto03kvli4lpk1ls71f&amp;minorRev=30&amp;customerIpAddress=10.26.131.178&amp;customerUserAgent=Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36&amp;customerSessionId=0ABAAA5A-DEDD-7791-5792-791C34793B70&amp;locale=en_US&amp;currencyCode=USD&amp;sig=51c943e9f9bd922e5b8424de7914e397&amp;hotelId=626838&amp;supplierType=E&amp;arrivalDate=10/27/2016&amp;departureDate=10/29/2016&amp;numberOfRooms=1&amp;city=Hong Kong&amp;countryCode=HK&amp;rateKey=&amp;numberOfAdults1=2">Hotel Info</a></b><br><b><a href="http://www.travelnow.com/templates/500317/hotels/626838/overview?lang=en&amp;currency=USD&amp;standardCheckin=10/27/2016&amp;standardCheckout=10/29/2016&amp;roomsCount=1&amp;rooms[0].adultsCount=2" target="blank" title="Deep Link to Your Template Page">Deep Link</a></b></td>
			<td valign="top">
				<form action="http://devhub.ean.com/V3sandbox/roomAvailability.asp" method="post" name="rez1">
					<input type="hidden" name="CID" value="500317">
					<input type="hidden" name="apiKey" value="42054h3uto03kvli4lpk1ls71f">
					<input type="hidden" name="minorRev" value="30">
					<input type="hidden" name="customerIpAddress" value="10.26.131.178">
					<input type="hidden" name="customerUserAgent" value="Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36">
					<input type="hidden" name="customerSessionId" value="0ABAAA5A-DEDD-7791-5792-791C34793B70">
					<input type="hidden" name="locale" value="en_US">
					<input type="hidden" name="currencyCode" value="USD">
					<input type="hidden" name="sig" value="51c943e9f9bd922e5b8424de7914e397">
					<input type="hidden" name="arrivalDate" value="10/27/2016">
					<input type="hidden" name="departureDate" value="10/29/2016">
					<input type="hidden" name="hotelId" value="626838">
					<input type="hidden" name="city" value="Hong Kong">
					<input type="hidden" name="countryCode" value="HK">
					<input type="hidden" name="numberOfRooms" value="1">

					<input type="hidden" name="numberOfAdults1" value="2">
					<input type="submit" name="Submit" value="Get Rooms" class="dkBlueBG"><br>
					<a href="" onmouseover="showRollTip('Select an option before submitting if you want to receive hotel info along with the room results',event)" onmouseout="hideRollTip()"><img src="/QA/img/arrows/arrow-green.png" alt="Tip" width="12" height="12" hspace="5" align="middle">TIP</a>
					<select name="options" class="BGgreen" style="width:130px;"><option value=""> &lt;options&gt; </option>
					<option value=""></option>
					<option value="HOTEL_DETAILS">HOTEL_DETAILS</option>
					<option value="ROOM_TYPES">ROOM_TYPES</option>
					<option value="ROOM_AMENITIES">ROOM_AMENITIES</option>
					<option value="PROPERTY_AMENITIES">PROPERTY_AMENITIES</option>
					<option value="HOTEL_IMAGES">HOTEL_IMAGES</option>
					<option value="HOTEL_DETAILS,ROOM_TYPES,ROOM_AMENITIES,PROPERTY_AMENITIES,HOTEL_IMAGES">All Details</option>
					</select>
				</form>
			</td>
		  </tr>
		</tbody>
	</table>
	<table width="100%" cellpadding="0" cellspacing="3" xmlns:fo="http://www.w3.org/1999/XSL/Format">
		<tbody>
			<tr>
				<td valign="middle" width="250" class="BGyellowRate" style="padding-left:5px;">
					&lt;ValueAdd&gt;  <b class="BGblue">Free Wireless Internet</b><br>
					<span class="BGyellow">
						<a href="" onmouseover="showRollTip('The room description for the room rate info returned.',event)" onmouseout="hideRollTip()">&lt;roomDescription&gt;</a>
						<b>Deluxe Double or Twin Room</b><br>
						&lt;roomTypeCode&gt;  <b>201670651</b><br>&lt;rateCode&gt;  <b>208334016</b><br>
            			&lt;currentAllotment&gt;  
            			<b>2</b><br><b class="red">&lt;nonRefundable&gt;  false</b><br>&lt;propertyAvailable&gt;  
            			<b>true</b><br>&lt;propertyRestricted&gt;  
            			<b>false</b><br>
            		</span>
            	</td>
				<td>
					<table cellpadding="3" cellspacing="0" align="left" class="BGyellowRate">
					<tbody><tr>
					<td class="small" valign="top"><a href="" onmouseover="showRollTip('The rates for the room are returned for all Expedia properties and rooms',event)" onmouseout="hideRollTip()"><b class="red">&lt;RateInfo&gt;</b></a><br><a href="" onmouseover="showRollTip('Does the nightly rate change during the dates of stay or do they remain the same?',event)" onmouseout="hideRollTip()">rateChange</a> = <b>false</b><br><a href="" onmouseover="showRollTip('Is a promo rate available?',event)" onmouseout="hideRollTip()">promo</a> = <b>true</b><br><a href="" onmouseover="showRollTip('Is there a price breakdown for all surcharges, nightly rates, and total charges or is the data returned limited to a single nightly rate such as for a GDS property?',event)" onmouseout="hideRollTip()">priceBreakdown</a> = <b>true</b><br></td>
					<td valign="top" class="small"><a href="" onmouseover="showRollTip('Describes the sale for the promotional rates returned.',event)" onmouseout="hideRollTip()">&lt;promoDescription&gt;</a><b class="red">Book early and save 20%</b><br>&lt;promoId&gt;  <b>221523091</b><br>&lt;promoType&gt;  <b>Standard</b><br></td>
					<td class="small" valign="top"><a href="" onmouseover="showRollTip('Rate details and pricing that will be charged at booking on an Expedia property or paid directly to a GDS property at checkin/checkout ',event)" onmouseout="hideRollTip()"><b class="red">&lt;ChargeableRateInfo&gt;</b></a><br><a href="" onmouseover="showRollTip('Total Chargeable Amount',event)" onmouseout="hideRollTip()">total</a> = <b>463.64</b><br>surchargeTotal = <b>55.14</b><br>nightlyRateTotal = <b>408.50</b><br><a href="" onmouseover="showRollTip('Average nightly rate without a promo rate',event)" onmouseout="hideRollTip()">averageBaseRate</a> = <b>255.30</b><br><a href="" onmouseover="showRollTip('Average nightly rate if a promo rate is available',event)" onmouseout="hideRollTip()">averageRate</a> = <b>204.25</b><br><a href="" onmouseover="showRollTip('Highest nightly rate of all rates returned such as for a GDS property',event)" onmouseout="hideRollTip()">maxNightlyRate</a> = <b>204.25</b><br>currencyCode = <b>USD</b><br></td>
					<td class="small" valign="top"><b class="red">&lt;NightlyRatesPerRoom&gt;</b><br><b class="red">1. </b> promo = <b>true</b> <a href="" onmouseover="showRollTip('This is the promo rate if one is available',event)" onmouseout="hideRollTip()">rate</a> = <b>204.25</b> <a href="" onmouseover="showRollTip('This is the rate without a promotional discount applied',event)" onmouseout="hideRollTip()">baseRate</a> = <b>255.30</b><br><b class="red">2. </b> promo = <b>true</b> <a href="" onmouseover="showRollTip('This is the promo rate if one is available',event)" onmouseout="hideRollTip()">rate</a> = <b>204.25</b> <a href="" onmouseover="showRollTip('This is the rate without a promotional discount applied',event)" onmouseout="hideRollTip()">baseRate</a> = <b>255.30</b><br></td>
					<td class="small" valign="top"><b class="red">&lt;Surcharges&gt;</b><br><b class="red">1. </b> amount = <b>55.14</b> type = <b>TaxAndServiceFee</b><br></td>
					</tr>
					</tbody></table>
				</td>
			</tr>
		</tbody>
	</table>
	<br xmlns:fo="http://www.w3.org/1999/XSL/Format">
</div>
</body>