<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>

<div class="container">
	<div class="mx-auto w-50 my-5">
		<h1 class="text-center py-3">회원가입</h1>
		<form:form action="${ctxPath }/member/join" id="joinForm" modelAttribute="memberVO">
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
					<input class="emailCode form-control" placeholder="인증번호"/>
				</div>
				<div class="col-4 mt-3">
					<button type="button" class="emailCheckBtn btn btn-outline-info form-control">인증번호 확인</button>
				</div>
				<div class="col-12 mt-2">
					<p class="timer text-primary"></p>
				</div>
				<div class="col-12 mt-4">
					<h3>아이디</h3>
				</div>
				<div class="col-8 mt-2">
					<form:input class="form-control" path="memberId" placeholder="최대 12글자"/>
				</div>
				<div class="col-4 mt-2">
					<button type="button" class="idCheck btn btn-outline-info form-control">ID중복확인</button>
				</div>
			</div>
			<div class="mt-4">
				<h3>비밀번호</h3>
			</div>
			<div class="form-group mt-3">
				<form:password class="form-control" path="memberPwd" placeholder="4글자 이상"/>
			</div>
			<div class="form-group">
				<input type="password" class="form-control" name="memberPwdCheck" placeholder="비밀번호 확인"/>
				<span class="passwordCheckMessage"></span>
			</div>
			<div class="mt-4">
				<h3>이름</h3>
			</div>
			<div class="form-group">
				<form:input class="form-control" path="memberName" placeholder="10자 이하 한글"/>
			</div>
			<div class="mt-4">
				<h3>이용약관</h3>
			</div>
			<div class="form-group">
				<div class="jumbotron p-1 m-0">
				<label class="mt-1 ml-1">
					<input type="checkbox" id="agreeAll"> 모두 동의
				</label>
				</div>
			</div>
			<div class="form-group">
			
				<label class="ml-2">
					<input type="checkbox" id="agreeService"> 서비스 이용 약관(필수)
					<button type="button" class="modalBtn btn btn-primary" data-toggle="modal" data-target="#agreeModal" data-agree="service">보기</button>
				</label>
			</div>
			<div class="form-group">
				<label class="ml-2">
					<input type="checkbox" id="agreeData"> 개인정보 수집 및 이용 동의(필수)
					<button type="button" class="modalBtn btn btn-primary" data-toggle="modal" data-target="#agreeModal" data-agree="data">보기</button>
				</label>
			</div>
			<button type="button" class="join btn btn-outline-primary">회원가입</button>
		</form:form>
	</div>
</div>

<%@ include file="../includes/footer.jsp" %>

<!-- The Modal -->
  <div class="modal" id="agreeModal">
    <div class="modal-dialog">
      <div class="modal-content">
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">서비스 이용 약관</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <!-- Modal body -->
        <div class="modal-body">
          약관 들어갈 자리
        </div>
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
        </div>
      </div>
    </div>
  </div>

<script>
$(function(){
	let code = null; // 이메일 인증 코드
	let email = null; // 인증 당시 이메일
	let isAuth = false; // 이메일 인증 확인여부
	let checkedId = ''; // 아이디 중복확인 당시 아이디
	let idOverlapCheck = false; // 아이디 중복확인 여부
	let passwordMatch = false; // 비밀번호 일치여부
	let agreement = {
		service : false,
		data : false
	}
	let sec = 120;
	
	// 아이디 중복 확인
	$('.idCheck').click(function(){
		let memberId = $('#memberId').val();
		if(memberId.length<3){ // 글자수 체크
			alert('아이디는 3글자 이상 12글자 이하여야 합니다');
			$('[name="memberId"]').focus();
			return;
		}
		
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
			}
		});
	});
	
	// 비밀번호 일치 확인
	$('[name="memberPwdCheck"]').keyup(function(){
		let password = $('[name="memberPwd"]').val();
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
	
	// 이메일 확인 전송
	$('.sendEmailCheck').click(function(){
		let tempEmail = $('#email').val();
		if(!tempEmail.length>0){
			alert('이메일을 입력해 주세요');
			return;
		}
		$.ajax({
			type : 'get',
			url : '${ctxPath}/mailCheck?email='+tempEmail,
			success : function(result){
				email = tempEmail;
				code = result;
				alert('인증번호가 전송되었습니다');
				setTimer();
			}
		});
		
	});
	
	// 메일인증 타이머
	function setTimer(){
		let timer = $('.timer');
		sec=60;
		let interval = setInterval(function(){
			console.log(sec);
			if(sec==10){
				timer.attr('class', 'timer text-danger');
			}
			if(sec>0){
				timer.text('인증 잔여 시간 : '+sec);
				sec--;
			}else if(sec==0){
				timer.text('인증 가능 시간이 지났습니다. 다시 시도해 주세요');
				code = null;
				isAuth = false;
				clearInterval(interval);
				return;
			}else if(sec<0){
				timer.attr('class', 'timer text-primary').text('인증 성공');
				clearInterval(interval);
				return;
			}
			
		},
		1000);
	}
	
	// 이메일 인증 일치 확인
	$('.emailCheckBtn').click(function(){
		let emailCode = $('.emailCode').val();
		let tempEmail = $('#email').val();
		
		if(sec==0){
			alert('인증 시간이 만료되었습니다. 인증번호를 다시 요청해 주세요');
		}else if(code==emailCode && email==tempEmail){
			isAuth = true;
			sec=-1;
			alert('인증이 완료되었습니다');
		}else if(email!=tempEmail){
			isAuth = false;
			alert('이메일이 변경되었습니다. 다시 인증해 주세요');
		}else{
			isAuth = false;
			alert('인증번호가 틀렸습니다. 다시 작성해 주세요');
		}
	});
	
	// 모두 동의 버튼
	$('#agreeAll').click(function(){
	    let checkAll = $('#agreeAll').is(':checked');
	    if(checkAll){
	        $('#agreeService').prop('checked', true);
	        $('#agreeData').prop('checked', true);
	        agreement.service = true;
	        agreement.data = true;
	    }else{
	        $('#agreeService').prop('checked', false);
	        $('#agreeData').prop('checked', false);
	        agreement.service = false;
	        agreement.data = false;
	    }
	    console.log(agreement.service);
	    console.log(agreement.data);
	});
	
	// 서비스 동의 여부
	$('#agreeService').change(function(){
		agreement.service = $(this).is(':checked');
		updateAgreement();
	});
	
	// 정보 동의 여부
	$('#agreeData').change(function(){
		agreement.data = $(this).is(':checked');
		updateAgreement();
	});
	
	// 정보동의 체크
	function updateAgreement(){ // attr('checked', 'checked') 이렇게 쓰면 버그걸린다 prop('checked', true) 이걸로 써야함
		let serviceCheck = $('#agreeService').is(':checked');
		let dataCheck = $('#agreeData').is(':checked');
		if(serviceCheck && dataCheck){
			$('#agreeAll').prop('checked', true);
		}else{
			$('#agreeAll').prop('checked', false);
		}
		agreement.service = serviceCheck;
		agreement.data = dataCheck;
		console.log(agreement.service);
		console.log(agreement.data);
	}
	
	// 회원가입 제출
	$('.join').click(function(){ // 이메일관련, 아이디관련, 비밀번호관련, 약관동의, 빈칸확인
		// 제출 당시 입력창에 적혀있는 내역들(인증받은 내용과 같은지 확인용)
		let tempEmail = $('#email').val();  
		let emailCode = $('.emailCode').val(); 
		let memberId = $('#memberId').val();
		let password = $('[name="memberPwd"]').val();
		let generalCondition = $('#generalCondition').val();
		let index = 1;
		let errorMessage = '';
		
		if(!tempEmail.length>0){ // 이메일
			errorMessage += index + ' : 이메일을 입력해 주세요\n';
			index++;
		}else if(!isAuth){
			errorMessage += index + ' : 이메일 인증이 필요합니다\n';
			index++;
		}else if(email!=tempEmail){
			errorMessage += index + ' : 이메일이 변경되었습니다. 다시 인증해 주세요\n';
			index++;
			isAuth = false;
		}else if(emailCode!=code){
			errorMessage += index + ' : 코드가 일치하지 않습니다. 다시 확인하거나 새로 인증받아 주세요\n';
			index++;
			isAuth = false;
		}
		
		if(!memberId.length>0){ // 아이디
			errorMessage += index + ' : 아이디를 입력해 주세요\n';
			index++;
		}else if(checkedId!=memberId){
			errorMessage += index + ' : 아이디 중복 확인을 하지 않았습니다. 다시 시도해 주세요\n';
			index++;
			idOverlapCheck = false;
		}
		
		if(!password.length>0){ // 비밀번호
			errorMessage += index + ' : 비밀번호를 입력해 주세요\n';
			index++;
		}else if(password.length<4){
			errorMessage += index + ' : 비밀번호는 최소 4글자 이상이어야 합니다\n';
			index++;
		}else if(!passwordMatch){
			errorMessage += index + ' : 비밀번호가 일치하지 않습니다. 다시 확인해 주세요\n';
			index++;
		}
		
		if(!agreement.service){ // 약관1
			errorMessage += index + ' : 서비스 이용 약관에 동의해 주세요\n';
			index++;
		}
		
		if(!agreement.data){ // 약관2
			errorMessage += index + ' : 개인정보 이용에 동의해 주세요\n';
			index++;
		}
		
		if(errorMessage.length>0){ // 에러 목록
			errorMessage += '!! 위의 목록을 다시 작성해 주세요 !!';
			alert(errorMessage);
			return;
		}
		
		$('#joinForm').submit();
	});
	
	// 약관창 모달
	$('.modalBtn').click(function(){
		let agree = $(this).data('agree');
		let modalTitle = $('.modal-title');
		let modalBody = $('.modal-body');
		let longSentence = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.';
		
		if(agree=='service'){
			modalTitle.html('서비스 이용 약관');
			modalBody.html('서비스 이용 약관 내용'+longSentence);
		}else if(agree=='data'){
			modalTitle.html('개인정보 수집 안내');
			modalBody.html('개인정보 수집 및 이용 동의 내용'+longSentence);
		}
		
	});
	
});
</script>