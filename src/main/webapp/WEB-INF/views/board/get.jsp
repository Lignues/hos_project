<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<div class="container mt-5">
	<div class="card">
	  <div class="card-header">

	  	<div class="d-flex justify-content-start">
	  		${vo.title}
	  	</div>
	  </div>
	  <div class="card-header">
	  	<div class="d-flex justify-content-between">
	  		<div>
		  		${vo.writer}
	  		</div>
	  		<div>
		  		<tf:formatDateTime value="${vo.regDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
	  		</div>
	  	</div>
	  </div>
	  <div class="card-body">
	  	${vo.content}
	  </div>
	</div>
	<span class="float-right m-2">
	  <button type="button" class="modifyBtn btn btn-primary">수정(권한설정해라 나중에)</button>
	  <button type="button" class="deleteBtn btn-primary">삭제</button>
	  <button type="button" class="listBtn btn btn-primary">목록으로</button>
	</span>
</div>


<form action="${ctxPath}/board/list">
	<input type="hidden" name="bno" value="${vo.bno}">
	<!-- 나중에 criteria도 넣어라 -->
</form>

<div class="container mt-5">
	<div class="card">
		<div class="card-header">
			<p>🗨 댓글</p>
		</div>
	</div>
</div>
<!-- 리플넣을자리 -->
<div class="reply container mt-2">
	<div class="card">
	  <div class="card-header">
	  	<div class="d-flex justify-content-between">
	  		<div>
		  		리플들어갈곳
	  		</div>
	  		<div>
<%-- 		  		<tf:formatDateTime value="" pattern="yyyy-MM-dd HH:mm"/> --%>
	  		</div>
	  	</div>
	  </div>
	  <div class="card-body">
	  	리플코인
	  </div>
	</div>
</div>


<%@ include file="../includes/footer.jsp" %>
<script src="${ctxPath}/resources/js/replyService.js"></script>
<script src="${ctxPath}/resources/js/reply.js"></script>
<script src="${ctxPath}/resources/js/get.js"></script>
