<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<script>
	var address = "${address}";	
	function closePopup() {
		jQuery('html, body').css({'overflow':'auto'});
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
		};              
		// opener.focus();		
	}


	var openMap = function(addr){

		console.log(addr);

		$.ajax({
			url : "http://maps.googleapis.com/maps/api/geocode/json?sensor=false&language=ko&address="+addr,
			type : "GET",
			success : function(data){
				if(data.results.length < 1){
					alert("해당 위치를 알 수 없습니다.");
					return false;
				}
				
				lat = data.results[0].geometry.location.lat;
				lng = data.results[0].geometry.location.lng;
				
				var myLatLng = {
					lat : lat,
					lng : lng
				};
			    
				map = new google.maps.Map(document.getElementById('showMap'), {
					center : myLatLng,
					scrollwheel : false,
					zoom : 17
				});
				
				// Create a marker and set its position.
				var marker = new google.maps.Marker({
					position : myLatLng,
					map : map,
				    draggable: true,
				});
				
				marker.setMap(map);

				// $("#googleMapPop").click();
			},
			error : function(error) {
				console.log(error)
			}
		})
	}


     // [COMMON] 공통사항 
     $(document).ready(function() {

         // openMap(address);
         openMap(address);
	 });	
</script>

<div class="layerPopup">
	<div class="layerPop">
		<!-- 내용시작 -->
		<div class="popCon">
			<div class="popHead">
				<div class="popTpart">
					<strong class="popTitle">지도보기</strong>
					<button type="button" class="layerClose">
						<img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기">
					</button>
				</div>
			</div>
			<div class="cntain" id="showMap" name="showMap" style="height:40vh;">
			</div>
		</div>
		<!-- 내용끝 -->
		<div class="popFoot">
			<div class="layerBtns">
				<button type="button" class="layerClose1" onClick="closePopup()">확인</button>
			</div>
		</div>
	</div>
</div>