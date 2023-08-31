<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>

<div class="container my-3">
	<div class="row">
		<div class="w-100 py-3">
			<h1 class="text-center"><b>진료 과목</b></h1>
		</div>
	</div>
</div>
<div class="container bg-light m-3 mb-5 w-75 mx-auto">
  <div class="row">
	  <div class="py-3">
		  <img class="border" src="${ctxPath}/resources/images/sub1.jpg" style="width:300px; height:300px;">
	  </div>
	  <div class="p-3">
		  <h4><b>정형외과</b></h4>
		  <p>열심히 합니다</p>
	  </div>
  </div>
  <div class="row">
	  <div class="col-3 p-3 float-left">
		  <h4><b>내과</b></h4>
		  <p>열심히 합니다</p>
	  </div>
	  <div class="col-9 py-3 float-right">
		  <img class="border float-right" src="${ctxPath}/resources/images/sub2.jpg" style="width:300px; height:300px;">
	  </div>
  </div>
</div>
<input type="hidden" name="highlight" value="subjects">
<%@ include file="../includes/footer.jsp" %>