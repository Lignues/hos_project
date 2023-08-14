<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>

<div class="container mt-5">
	<div class="card">
		<form class="writeForm" action="${ctxPath}/board/write" method="post">
		  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		  <div class="card-header">
		  	<div class="form-group justify-content-start">
		  	  <p>제목</p>
		  	</div>
		  </div>
		  <div class="card-body">
		  	<div class="form-group justify-content-start">
		  	  <input class="form-control" name="title" type="text">
		  	</div>
		  </div>
		  <div class="card-header">
		  	<p>내용</p>
		  </div>
		  <div class="card-body">
		  	<div class="form-group d-flex justify-content-between">
		  	  <div class="form-group">
		  		<textarea class="form-control" name="content" rows="20" cols="200"></textarea>
		  	  </div>
		  	</div>
		  </div>
		  <div class="form-group justify-content-start">
		  	<input class="form-control" name="writer" type="text" value="${authInfo.memberId}" readonly="readonly">
		  </div>
		  <span class="float-right m-2">
	  		<button type="button" class="writeBtn btn btn-primary">등록</button>
		  	<button type="button" class="listBtn btn btn-primary">목록으로</button>
		  </span>
		</form>
	</div>
</div>

<input type="hidden" name="pageNum" value="${param.pageNum}">
<input type="hidden" name="amount" value="${param.amount}">
<input type="hidden" name="type" value="${param.type}">
<input type="hidden" name="keyword" value="${param.keyword}">

<%@ include file="../includes/footer.jsp" %>
<script src="${ctxPath}/resources/js/write.js"></script>