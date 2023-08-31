<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags" %>

<c:set var="ctxPath" value="${pageContext.request.contextPath }"/>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal"/>
	<sec:authentication property="principal.memberVO" var="authInfo"/>
	<sec:authentication property="principal.memberVO.authList" var="authList"/>
</sec:authorize>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>OO병원</title>
<%@ include file="apiKey.jsp" %> <!-- 네이버 지도 api <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=아이디"></script> -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
	let ctxPath = '${ctxPath}';
	let duplicateLogin = '${duplicateLogin}';
	
	if(duplicateLogin){
		alert(duplicateLogin);
	}
	
	let csrfHeaderName = "${_csrf.headerName}"; 
	let csrfTokenValue = "${_csrf.token}";
	
	$(document).ajaxSend(function(e, xhr, options){ // 모든 ajax요청에 토큰 전송
		xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
	})
	
	function checkExtension(fileName, fileSize){
		let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");	// 업로드 불가능한 파일 형식 지정
		let maxSize = 1048576*50; // 50MB
		if(fileSize > maxSize) {
			alert('파일크기는 최대 50MB까지 업로드 가능합니다.');
			return false; 
		}
		
		if(regex.test(fileName)) {
			alert('해당 종류의 파일은 업로드 할 수 없습니다.');
			return false; 
		}
		return true;
	}
	
</script>
</head>
<body>
<div class="bg-light">
	<div class="row border">
		<div class="col-3 border" style="text-align: center;">
			<a class="text-dark font-bold display-4 mx-auto" href="${ctxPath}" style="line-height: 100px; text-decoration: none;">OO병원</a>
		</div>
		<div class="col-9 p-0">
			<div class="row" style="height:50px;">
				<div class="col-5" style="height:50px;">
				</div>
				<div class="col-7 h-20">
					<nav class="navbar navbar-expand-sm justify-content-end">
					  <ul class="navbar-nav mx-right font-weight-bold">
					    <sec:authorize access="isAnonymous()">
					    	<li class="nav-item">
					     		<a class="nav-link text-primary" href="${ctxPath}/login">로그인</a>
						    </li>
						    <li class="nav-item">
			  		      		<a class="nav-link text-primary" href="${ctxPath}/member/join">회원가입</a>
						    </li>
				    	</sec:authorize>
				    	<sec:authorize access="isAuthenticated()">
				    		<span class="small mt-2"><b>${authInfo.memberId}</b>님 환영합니다.</span>
					    	<li class="nav-item">
					    		<form class="logoutBtn" action="${ctxPath}/member/logout" method="post">
					    			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
					     			<a class="nav-link text-primary" href="#">로그아웃</a>
					    		</form>
						    </li>
						    <li class="nav-item">
			  		      		<a class="nav-link text-primary" href="${ctxPath}/mypage">마이페이지</a>
						    </li>
				    	</sec:authorize>
					  </ul>
					</nav>
				</div>
			</div>
			<div>
				<nav class="navbar navbar-expand-sm border justify-content-center">
				  <!-- Links -->
				  <ul class="navbar-nav mx-auto font-weight-bold">
				    <li class="nav-item px-4">
				      <a class="nav-link text-dark" id="hosIntroduce" href="${ctxPath}/introduce/hosIntroduce">병원 소개</a>
				    </li>
				    <li class="nav-item px-4">
				      <a class="nav-link text-dark" id="docIntroduce" href="${ctxPath}/introduce/docIntroduce">원장 이력</a>
				    </li>
				    <li class="nav-item px-4">
				      <a class="nav-link text-dark" id="subjects" href="${ctxPath}/introduce/subjects">진료 과목</a>
				    </li>
				    <li class="nav-item px-4">
				      <a class="nav-link text-dark" id="" href="#">예약 안내</a>
				    </li>
				    <li class="nav-item px-4">
				      <a class="nav-link text-dark" id="howToCome" href="${ctxPath}/introduce/howToCome">오시는 길</a>
				    </li>
				    <li class="nav-item px-4">
				      <a class="nav-link text-dark" id="list" href="${ctxPath}/board/list">상담 게시판</a>
				    </li>
				  </ul>
				</nav>
			</div>
		</div>
	</div>
</div>

<input type="hidden" name="boardResult" value="${boardResult}">
<script>
$(function(){
	let boardResult = $('[name="boardResult"]').val();	
	let highlight = $('[name="highlight"]').val();
	
	// 알림문구 작동
	if(boardResult){
		alert(boardResult);	
	}
	
	// 로그인버튼 활성화
	$('.logoutBtn').click(function(e){
		e.preventDefault();
		$(this).submit();
	});
	
	// 활성화된 메뉴창 색바꾸기
	$('[id="'+highlight+'"]').attr('class', 'nav-link text-primary');
});

</script>