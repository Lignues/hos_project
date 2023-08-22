<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>

<div class="container">
	<div class="mx-auto w-50 my-5">
		<h1 class="text-center py-3">아이디 찾기</h1>
		<form action="${ctxPath }/findMemberId" method="post">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<div class="form-group">
				<h3>이름</h3>
			</div>
			<div class="form-group">
				<input type="text" class="form-control" name="memberName" placeholder="이름"/>
			</div>
			<div class="form-group mt-2">
				<h3>이메일</h3>
			</div>
			<div class="form-group">
				<input type="email" class="form-control" name="email" placeholder="이메일"/>
			</div>
			<button class="btn btn-outline-primary findId">아이디 찾기</button>
		</form>
	</div>
	<div class="mx-auto w-50 my-5">
		<h1 class="text-center py-3">비밀번호 재발급</h1>
		<form action="${ctxPath }/resetPassword" method="post">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<div class="form-group">
				<h3>아이디</h3>
			</div>
			<div class="form-group">
				<input type="text" class="form-control" name="memberId" placeholder="아이디"/>
			</div>
			<div class="form-group mt-2">
				<h3>이메일</h3>
			</div>
			<div class="form-group">
				<input type="email" class="form-control" name="email" placeholder="이메일"/>
			</div>
			<button class="btn btn-outline-primary findId">비밀번호 재발급</button>
		</form>
	</div>
</div>

<%@ include file="../includes/footer.jsp" %>
