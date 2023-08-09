<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags" %>

<c:set var="ctxPath" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
	let ctxPath = '${ctxPath}';
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
				<div class="border col-9" style="height:50px;">
				</div>
				<div class="col-3 border h-20">
					<nav class="navbar navbar-expand-sm bg-light justify-content-end">
					  <!-- Links -->
					  <ul class="navbar-nav mx-auto font-weight-bold">
					    <li class="nav-item">
					      <a class="nav-link text-dark" href="#">로그인</a>
					    </li>
					    <li class="nav-item">
					      <a class="nav-link text-dark" href="#">회원가입</a>
					    </li>
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