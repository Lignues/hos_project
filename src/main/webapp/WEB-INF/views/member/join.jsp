<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>

<div class="container">
	<div class="mx-auto w-50 my-5">
		<h1 class="text-center py-3">회원가입</h1>
		<form:form action="${ctxPath }/member/join" modelAttribute="memberVO">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<div class="form-group row">
				<div class="col-12">
					<h3>이메일 확인</h3>
				</div>
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
				<div class="col-12 mt-4">
					<h3>아이디</h3>
				</div>
				<div class="col-8 mt-2">
					<form:input class="form-control" path="memberId" placeholder="아이디"/>
				</div>
				<div class="col-4 mt-2">
					<button type="button" class="idCheck btn btn-outline-info form-control">ID중복확인</button>
				</div>
			</div>
				<div class="mt-4">
					<h3>비밀번호</h3>
				</div>
				<div class="form-group mt-3">
					<form:password class="form-control" path="memberPwd" placeholder="비밀번호"/>
				</div>
				<div class="form-group">
					<input type="password" class="form-control" name="memberPwdCheck" placeholder="비밀번호 확인"/>
					<span class="passwordCheckMessage"></span>
				</div>
				<div class="form-group">
					<form:input class="form-control" path="memberName" placeholder="이름"/>
				</div>
				<button type="button" class="btn btn-outline-primary join">회원가입</button>
		</form:form>
	</div>
</div>

<%@ include file="../includes/footer.jsp" %>

<script>
$(function(){
	let passwordMatch = false;
	let idOverlapCheck = false;
	let checkedId = ''; // #####TODO 밥먹고 submit시 checkedId와 제출하는 아이디가 다를 경우 경고문구 뜨게 하고 email인증 준비해라#######
	
	// 아이디 중복 확인
	$('.idCheck').click(function(){
		$.ajax({
			type : 'post',
			url : '${ctxPath}/member/idCheck',
			data : {memberId : memberId},
			success : function(result){
				if(result==true){
					alert('사용 가능한 아이디입니다.');
					idOverlapCheck = true;
					checkedId = memberId;
					console.log(checkedId);
				}else{
					alert('이미 사용중인 아이디 입니다.');
					idOverlapCheck = false;
					$('[name="memberId"]').focus();
					checkedId = '';
			}
		});
	});
	
	// 비밀번호 일치 확인
	$('[name="memberPwdCheck"]').keyup(function(){
		let password = $('[name="memberPwd"]').val();
		let passwordCheck = $('[name="memberPwdCheck"]').val();
		let passwordCheckMessage = $('.passwordCheckMessage');
		
		if(password == passwordCheck){
			passwordCheckMessage.text('비밀번호가 일치합니다.').css('color', 'blue');
			passwordMatch = true;
		}
		if(password != passwordCheck){
			paswordCheckMessage.text('비밀번호가 일치하지 않습니다.').css('color', 'red');
			passwordMatch = false;
		}
	});
});
</script>