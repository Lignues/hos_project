<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<c:set var="highlight" value="docIntroduce"/>

<div class="container my-3">
	<div class="row">
		<div class="w-100 py-3">
			<h1 class="text-center"><b>원장 이력</b></h1>
		</div>
	</div>
</div>
<div class="container bg-light m-3 mb-5 w-75 mx-auto">
  <div class="row">
	  <div class="col-5 py-3">
		  <img class="border" src="${ctxPath}/resources/images/doc.jpg" style="width:300px;height:300px;">
	  </div>
	  <div class="p-3">
	      <h4><b>주요 경력</b></h4>
		  <p>OO대학교 OO학과 졸업</p>
		  <p>OO병원 전문의 수료</p>
		  <p>OO협회 정회원</p>
	  </div>
  </div>
</div>
<input type="hidden" name="highlight" value="docIntroduce">

<%@ include file="../includes/footer.jsp" %>