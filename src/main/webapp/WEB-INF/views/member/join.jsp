<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>

<div class="container">
	<div class="mx-auto w-50 my-5">
		<h1 class="text-center py-3">회원가입</h1>
		<form:form action="${ctxPath }/member/join" modelAttribute="memberVO">
			<div class="form-group row">
				<h3>아이디</h3>
				<div class="col-8 mt-3">
					<form:input class="form-control" path="email" placeholder="xxxx@xxx.xxx"/>
				</div>
				<div class="col-4 mt-3">
					<button type="button" class="sendEmailCheck btn btn-outline-info form-control">인증번호 전송</button>
				</div>
				<div class="col-8 mt-3">
					<input class="form-control" placeholder="인증번호"/>
				</div>
				<div class="col-4 mt-3">
					<button type="button" class="emailCheckBtn btn btn-outline-info form-control">인증번호 확인</button>
				</div>
				<div class="col-8 mt-3">
					<form:input class="form-control" path="memberId" placeholder="아이디"/>
				</div>
				<div class="col-4 mt-3">
					<button type="button" class="idCheck btn btn-outline-info form-control">ID중복확인</button>
				</div>
			</div>
			<div class="form-group">
				<form:password class="form-control" path="memberPwd" placeholder="비밀번호"/>
			</div>
			<div class="form-group">
				<form:input class="form-control" path="memberName" placeholder="이름"/>
			</div>
			<button type="button" class="btn btn-outline-primary join">회원가입</button>
		</form:form>
	</div>
</div>

<%@ include file="../includes/footer.jsp" %>

