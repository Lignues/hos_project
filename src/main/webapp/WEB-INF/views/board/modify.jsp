<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<div class="container mt-5">
	<div class="card">
		<form class="modifyForm" action="${ctxPath}/board/modify" method="post">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
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
						<textarea class="form-control" name="content" rows="20" cols="200" style="resize: none;">${vo.content}</textarea>
					</div>
				</div>
				<div class="form-group justify-content-start">
					<input class="form-control" name="writer" type="text" readonly="readonly" value="${vo.writer}">
				</div>
			</div>
			<div class="custom-control custom-switch float-left m-2 ml-4"> 
				<input type="checkbox" name="secretContent" class="custom-control-input" id="secretSwitch" value="1">
				<label class="custom-control-label" for="secretSwitch"> 🔒 비밀글로 등록하기</label>
			</div>
			<span class="float-right m-2">
				
			</span>
			<input type="hidden" name="bno" value="${vo.bno }">
		</form>
		<div class="form-group container">
			<div class="custom-file form-control mt-3">
				<input type="file" class="custom-file-input" id="customFile" name="uploadFile" multiple="multiple">
				<label class="custom-file-label" for="customFile">🔗 파일 선택</label>
			</div>
			<div class="uploadResultDiv form-group mt-2"><br>
				<ul class="list-group">
				</ul>
			</div>
			<span class="float-right mt-4">
				<button type="button" class="modifyBtn btn btn-primary">✂ 수정</button>
				<button type="button" class="listBtn btn btn-primary">🗑 목록으로</button>
			</span>
		</div>
	</div>
</div>

<input type="hidden" name="secret" value="${vo.secretContent}">
<input type="hidden" name="pageNum" value="${criteria.pageNum}">
<input type="hidden" name="amount" value="${criteria.amount}">
<input type="hidden" name="type" value="${criteria.type}">
<input type="hidden" name="keyword" value="${criteria.keyword}"><!-- 이거 써지긴 하나? -->
<%@ include file="../includes/footer.jsp" %>
<script src="${ctxPath}/resources/js/modify.js"></script>