<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>

<div class="container">
	<div class="mx-auto w-50 my-5">
		<h1 class="text-center py-3">로그인</h1>
		<form action="${ctxPath }/member/login" method="post">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<div class="form-group">
				<h3>아이디</h3>
			</div>
			<div class="form-group">
				<input type="text" class="form-control" name="memberId" placeholder="아이디"/>
			</div>
			<div class="form-group mt-2">
				<h3>비밀번호</h3>
			</div>
			<div class="form-group">
				<input type="password" class="form-control" name="memberPwd" placeholder="비밀번호"/>
			</div>
			<label>
				<input type="checkbox" name="remember-me">　로그인 상태 유지
			</label><br>
			<button class="btn btn-outline-primary login">로그인</button>
			<a class="btn btn-outline-primary join" href="${ctxPath}/member/join">회원가입</a>
			<c:if test="${not empty LoginFail }">
				<p style="color: red;">${LoginFail}</p>
			</c:if>
		</form>
	</div>
</div>

<%@ include file="../includes/footer.jsp" %>
