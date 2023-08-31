<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<c:set var="highlight" value="howToCome"/>

<div class="container my-3">
	<div class="row">
		<div class="w-100 py-3">
			<h1 class="text-center"><b>오시는 길</b></h1>
		</div>
	</div>
</div>
<div class="container mx-auto bg-light m-3 mb-5">
	<div class="media py-3">
	  <div class="border" id="map" style="width:300px;height:300px;"></div>
	  <div class="media-body m-3">
	    <h4>대구 중구 경상감영길 177 중앙직업전문학교</h4>
	    <p>지하철 1호선 중앙로역 3번출구 도보 5분거리</p>
	  </div>
	</div>
</div>

<input type="hidden" name="highlight" value="howToCome">
<%@ include file="../includes/footer.jsp" %>

<script>
var mapOptions = {
    center: new naver.maps.LatLng(35.872240, 128.597233),
    zoom: 17
};

var map = new naver.maps.Map('map', mapOptions);

var marker = new naver.maps.Marker({
    position: new naver.maps.LatLng(35.872240, 128.597233),
    map: map
});

</script>