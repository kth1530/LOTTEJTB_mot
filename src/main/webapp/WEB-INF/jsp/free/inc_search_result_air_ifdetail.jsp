<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : inc_search_result_air_ifdetail.jsp
	// 설명 : 항공권 상세조건
%>


<div class="layerPopup">
	<div class="layerPop">
		<!-- 내용시작 -->
		<div class="popCon">
			<div class="popHead">
				<div class="popTpart">
					<strong class="popTitle">상세조건</strong>
					<button type="button" class="layerClose">
						<img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기">
					</button>
				</div>
			</div>
			<div class="cntain cldarpart">
				<dl class="pop_chk_list">
					<dt>경유</dt>
					<dd>
						<p class="chkbox">
							<span><input id="fil_via_type01" ar_att="filter_chk" name="fil_via_type" value="ALL" checked="checked" type="checkbox" data-role="none" /></span>
							<label for="check01">전체</label>
						</p>
					</dd>					
					<dd>
						<p class="chkbox">
							<span><input id="fil_via_type02" ar_att="filter_chk" title="직항" name="fil_via_type" value="N" type="checkbox"  data-role="none" /></span>
							<label for="check01" via_type="direct"></label>
						</p>
					</dd>
					<dd>
						<p class="chkbox">
							<span><input id="fil_via_type03" type="checkbox" title="1번 경유" ar_att="filter_chk" name="fil_via_type" value="Y1"/></span>
							<label for="check01" via_type="via1"></label>
						</p>
					</dd>
					<dd>
						<p class="chkbox">
							<span><input id="fil_via_type04" type="checkbox" title="2번 경유" ar_att="filter_chk" name="fil_via_type" value="Y2" /></span>
							<label for="check01" via_type="via2"></label>
						</p>
					</dd>
				</dl>
				<dl class="pop_chk_list" ft-att="fil_cabinClas_div">
					<dt>좌석등급</dt>
					<dd>
						<p class="chkbox">
							<span><input id="fil_class_type01" type="checkbox" ar_att="filter_chk" name="fil_class_type" value="ALL" checked="checked" /></span>
							<label for="check01">전체</label>
						</p>
					</dd>
				</dl>
				<dl class="pop_chk_list" ft-att="fil_airline_div">
					<dt>항공사</dt>
					<dd>
						<p class="chkbox">
							<span><input id="filter_chk01" type="checkbox" title="전체"  ar_att="filter_chk" name="fil_air_line" value="ALL" checked="checked" /></span>
							<label for="check01">전체</label>
						</p>
					</dd>					
				</dl>
				<dl class="pop_chk_list pop_chk_list2">
					<dt>출발시간</dt>
					<dd>
						<p class="chkbox">
							<span><input id="fil_dep_tm01" title = '전체' type="checkbox" ar_att="filter_chk" name="fil_dep_tm" value="ALL" checked="checked"/></span> 
							<label for="check01">전체</label>
						</p>
					</dd>					
					<dd>
						<p class="chkbox">
							<span><input id="fil_dep_tm02" title = '오전' type="checkbox" ar_att="filter_chk" name="fil_dep_tm" value="0312"/></span> 
							<label for="check01">오전(am 03:00~am 11:59)</label>
						</p>
					</dd>
					<dd>
						<p class="chkbox">
							<span><input id="chk_if14" title = '오후'  type="checkbox" ar_att="filter_chk" name="fil_dep_tm" value="1217"/></span> 
							<label for="check01">오후(pm 12:00~pm 05:59)</label>
						</p>
					</dd>
					<dd>
						<p class="chkbox">
							<span><input id="chk_if15" title = '저녁' type="checkbox" ar_att="filter_chk" name="fil_dep_tm" value="1703" /></span> 
							<label for="check01">저녁(pm 05:00~am 02:59)</label>
						</p>
					</dd>
				</dl>
				<!-- dl class="pop_chk_list">
					<dt>요금구분</dt>
					<dd>
						<p class="chkbox">
							<span><input id="chk_if16" type="checkbox"
								data-role="none" /></span> <label for="chk_if16">성인</label>
						</p>
					</dd>
					<dd>
						<p class="chkbox">
							<span><input id="chk_if17" type="checkbox"
								data-role="none" /></span> <label for="chk_if17">학생</label>
						</p>
					</dd>
					<dd>
						<p class="chkbox">
							<span><input id="chk_if18" type="checkbox"
								data-role="none" /></span> <label for="chk_if18">장애인</label>
						</p>
					</dd>
				</dl -->
			</div>
		</div>
		<!-- 내용끝 -->
		<div class="popFoot pf2">
			<div class="layerBtns">
				<button type="button" class="layerClose1" onClick="fn_act_filter_init()">초기화</button>
			</div>
			<div class="layerBtns">
				<button type="button" class="layerClose2" onClick="fn_act_filter()">적용</button>
			</div>
		</div>
	</div>
</div>