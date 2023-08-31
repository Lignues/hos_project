<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<c:set var="highlight" value="hosIntroduce"/>

<div class="container my-3">
	<div class="row">
		<div class="w-100 py-3">
			<h1 class="text-center"><b>병원 소개</b></h1>
		</div>
	</div>
</div>
<div class="container bg-light m-3 mb-5 w-75 mx-auto">
  <div class="row">
	  <div class="col-5 py-3">
		  <img class="border" src="${ctxPath}/resources/images/hosPic.jpg" style="width:300px;height:300px;">
	  </div>
	  <div class="p-3">
		  <h4>OO년 설립</h4>
		  <h4>OO전문</h4>
		  <h4>열심히 합니다</h4>
	  </div>
  </div>
</div>
<input type="hidden" name="highlight" value="hosIntroduce">
<%@ include file="../includes/footer.jsp" %>