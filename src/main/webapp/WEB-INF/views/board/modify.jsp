<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<div class="container mt-5">
	<div class="card">
		<form class="modifyForm" action="${ctxPath}/board/modify" method="post">
		  <div class="card-header">
		  	<div class="form-group justify-content-start">
		  	  <p>제목</p>
		  	</div>
		  </div>
		  <div class="card-body">
		  	<div class="form-group justify-content-start">
		  	  <input class="form-control" name="title" type="text" value="${vo.title}">
		  	</div>
		  </div>
		  <div class="card-header">
		  	<p>내용</p>
		  </div>
		  <div class="card-body">
		  	<div class="form-group d-flex justify-content-between">
		  	  <div class="form-group">
		  		<textarea class="form-control" name="content" rows="20" cols="200">${vo.content}</textarea>
		  	  </div>
		  	</div>
		  </div>
		  <div class="form-group justify-content-start">
		  	<input class="form-control" name="writer" type="text" readonly="readonly" value="${vo.writer}">
		  </div>
		  <span class="float-right m-2">
	  		<button type="button" class="modifyBtn btn btn-primary">수정</button>
		  	<button type="button" class="listBtn btn btn-primary">목록으로</button>
		  </span>
		  <input type="hidden" name="bno" value="${vo.bno }">
		</form>
	</div>
</div>


<input type="hidden" name="pageNum" value="${param.pageNum}">
<input type="hidden" name="amount" value="${param.amount}">
<input type="hidden" name="type" value="${param.type}">
<input type="hidden" name="keyword" value="${param.keyword}"><!-- 이거 써지긴 하나? -->
<%@ include file="../includes/footer.jsp" %>
<script src="${ctxPath}/resources/js/modify.js"></script>