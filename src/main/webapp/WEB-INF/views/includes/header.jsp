<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags" %>

<c:set var="ctxPath" value="${pageContext.request.contextPath }" />
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal"/>
	<sec:authentication property="principal.memberVO" var="authInfo"/>
	<sec:authentication property="principal.memberVO.authList" var="authList"/>
</sec:authorize>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원입니다</title>
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
</script>
</head>
<body>
<div>
	<div class="row">
		<div class="col-3">
			
			<a class="text-dark text-center font-bold display-4" href="${ctxPath}/">제목이다</a>
			
		</div>
		<div class="col-9">
			<div class="row" style="height:50px;">
				<div class="border col-5" style="height:50px;">
				</div>
				<div class="col-7 border h-20">
					<nav class="navbar navbar-expand-sm bg-light justify-content-end">
					  <!-- Links -->
					  <ul class="navbar-nav mx-auto font-weight-bold">
					    <sec:authorize access="isAnonymous()">
					    	<li class="nav-item">
					     		<a class="nav-link text-dark" href="${ctxPath}/login">로그인</a>
						    </li>
						    <li class="nav-item">
			  		      		<a class="nav-link text-dark" href="${ctxPath}/member/join">회원가입</a>
						    </li>
				    	</sec:authorize>
				    	<sec:authorize access="isAuthenticated()">
				    		<span class="small mt-2"><b>${authInfo.memberId}</b>님 환영합니다.</span>
					    	<li class="nav-item">
					    		<form class="logoutBtn" action="${ctxPath}/member/logout" method="post">
					    			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
					     			<a class="nav-link text-dark" href="#">로그아웃</a>
					    		</form>
						    </li>
						    <li class="nav-item">
			  		      		<a class="nav-link text-dark" href="${ctxPath}/member/mypage">마이페이지</a>
						    </li>
				    	</sec:authorize>
					  </ul>
					</nav>
				</div>
			</div>
			<div>
				<div class="border col-6">
				</div>
				
				<nav class="navbar navbar-expand-sm bg-light justify-content-center">
				  <!-- Links -->
				  <ul class="navbar-nav mx-auto font-weight-bold">
				    <li class="nav-item px-4">
				      <a class="nav-link text-dark " href="#">Link 1</a>
				    </li>
				    <li class="nav-item px-4">
				      <a class="nav-link text-dark" href="#">Link 2</a>
				    </li>
				    <li class="nav-item px-4">
				      <a class="nav-link text-dark" href="#">Link 3</a>
				    </li>
				    <li class="nav-item px-4">
				      <a class="nav-link text-dark" href="#">Link 4</a>
				    </li>
				    <li class="nav-item px-4">
				      <a class="nav-link text-dark" href="#">Link 5</a>
				    </li>
				    <li class="nav-item px-4">
				      <a class="nav-link text-dark" href="${ctxPath}/board/list">상담 게시판</a>
				    </li>
				  </ul>
				</nav>
				
			</div>
			
		</div>
	
	</div>

</div>
<script>
$(function(){
	$('.logoutBtn').click(function(e){
		e.preventDefault();
		$(this).submit();
	});
});
</script>