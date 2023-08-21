<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/pageHeader.jsp" %>

<div class="container mt-3">

	<div class="mx-auto w-50 my-5">
		<h1 class="text-center py-3">회원정보 변경</h1>
		<form:form action="${ctxPath }/member/modify" id="joinForm" modelAttribute="vo">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<div class="form-group row">
				<div class="col-12">
					<h3>이메일</h3>
				</div>
				<div class="col-8 mt-3">
					<form:input class="form-control" path="email" readonly="true"/>
				</div>
				<div class="col-12 mt-4">
					<h3>아이디</h3>
				</div>
				<div class="col-8 mt-2">
					<form:input class="form-control" path="memberId" readonly="true"/>
				</div>
			</div>
			<div class="mt-4">
				<h3>이름</h3>
			</div>
			<div class="form-group">
				<form:input class="form-control" path="memberName" readonly="true"/>
			</div>
			<div class="mt-4">
				<h3>현재 비밀번호</h3>
			</div>
			<div class="form-group mt-3">
				<input type="password" class="currentPwd form-control" name="currentPwd" placeholder="4글자 이상"/>
			</div>
			<div class="mt-4">
				<h3>변경할 비밀번호</h3>
			</div>
			<div class="form-group mt-3">
				<form:password class="newPwd form-control" path="memberPwd" placeholder="4글자 이상"/>
			</div>
			<div class="form-group">
				<input type="password" class="form-control" name="memberPwdCheck" placeholder="비밀번호 확인"/>
				<span class="passwordCheckMessage"></span>
			</div>
			<button type="button" class="modify btn btn-outline-primary">수정</button>
		</form:form>
	</div>	
</div>

<%@ include file="../includes/footer.jsp" %>

<script>
$(function(){
	let passwordMatch = false; // 비밀번호 일치여부
	
	// 신규 비밀번호 일치 확인
	$('[name="memberPwdCheck"]').keyup(function(){
		let password = $('.newPwd').val();
		let passwordCheck = $('[name="memberPwdCheck"]').val();
		let passwordCheckMessage = $('.passwordCheckMessage');
		
		if(password.length<4){
			passwordCheckMessage.text('비밀번호는 최소 4글자 이상이어야 합니다.').css('color', 'red');
			return;
		}else if(password == passwordCheck){
			passwordCheckMessage.text('비밀번호가 일치합니다.').css('color', 'blue');
			passwordMatch = true;
		}
		if(password != passwordCheck){
			passwordCheckMessage.text('비밀번호가 일치하지 않습니다.').css('color', 'red');
			passwordMatch = false;
		}
	});
	
	// 회원정보 변경
	$('.modify').click(function(){
		$('#joinForm').submit();
	});
	
});
</script>
