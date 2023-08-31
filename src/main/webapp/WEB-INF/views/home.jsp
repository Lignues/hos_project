<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/header.jsp" %>

<div class="container my-5">
	
		<div id="demo" class="carousel slide mx-auto border" data-ride="carousel">
	
		  <!-- Indicators -->
		  <ul class="carousel-indicators bg-dark">
		    <li data-target="#demo" data-slide-to="0" class="active"></li>
		    <li data-target="#demo" data-slide-to="1"></li>
		    <li data-target="#demo" data-slide-to="2"></li>
		  </ul>
		  
		  <!-- The slideshow -->
		  <div class="carousel-inner">
		    <div class="carousel-item active">
		      <img src="${ctxPath}/resources/images/home1.png" alt="home1" width="100%" height="550">
		    </div>
		    <div class="carousel-item">
		      <img src="${ctxPath}/resources/images/home2.png" alt="home2" width="100%" height="550">
		    </div>
		    <div class="carousel-item">
		      <img src="${ctxPath}/resources/images/home3.png" alt="home3" width="100%" height="550">
		    </div>
		  </div>
		  
		  <!-- Left and right controls -->
		  <a class="carousel-control-prev" href="#demo" data-slide="prev">
		    <span class="carousel-control-prev-icon bg-dark"></span>
		  </a>
		  <a class="carousel-control-next" href="#demo" data-slide="next">
		    <span class="carousel-control-next-icon bg-dark"></span>
		  </a>
		</div>
</div>

<%@include file="/WEB-INF/views/includes/footer.jsp" %>
