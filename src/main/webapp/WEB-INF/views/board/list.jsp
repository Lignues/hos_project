<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<div class="container mt-3">
  <div class="row">
    <div class="col-3">
    	<h2 class="m-3">상담 게시판</h2>
    </div>
    <div class="col-9">
    	<span class="float-right mt-3 mx-2">
	  		<a href="${ctxPath}/board/list" class="btn btn-primary">새로고침</a>
    	</span>
    	<span class="float-right mt-3">
	  		<button class="writeBtn btn btn-primary">글쓰기</button>
    	</span>
    </div>
  </div>
  <table class="table table-bordered table-hover table-striped">
    <thead>
      <tr class="text-center">
        <th>글번호</th>
        <th class="w-50">제목</th>
        <th>조회수</th>
        <th>추천수</th>
        <th>글쓴이</th>
        <th>작성일</th>
      </tr>
    </thead>
    <c:if test="${not empty list}">
    	<c:forEach items="${list}" var="vo">
		    <tbody>
		      <tr class="text-center">
		        <td>${vo.bno}</td>
		        <td class="text-left">
		        	<a class="go text-dark" href="${vo.bno}">
		        		${vo.secretContent == 1 ? '🔒 ' : '' }${vo.title} ${vo.replyCnt==0 ? '' : [vo.replyCnt]}
		        	</a>
		        </td>
		        <td>${vo.views}</td>
		        <td>${vo.likeHit}</td>
		        <td>${vo.writer}</td>
		        <td>
			        <tf:formatDateTime value="${vo.regDate}" pattern="yyyy-MM-dd HH:mm"/>
		        </td>
		      </tr>
		    </tbody>
    	</c:forEach>
    </c:if>
  </table>
  <form id="searchForm" action="${ctxPath}/board/list">
  	<div class="d-inline-block">
  		<select name="type" class="form-control">
  			<option value="" ${criteria.type == null ? 'selected' : ''}>검색조건</option>
  			<option value="T" ${criteria.type eq 'T' ? 'selected' : ''}>제목</option>
  			<option value="W" ${criteria.type eq 'W' ? 'selected' : ''}>글쓴이</option>
  			<option value="C" ${criteria.type eq 'C' ? 'selected' : ''}>내용</option>
  			<option value="TW" ${criteria.type eq 'TW' ? 'selected' : ''}>제목+글쓴이</option>
  			<option value="WC" ${criteria.type eq 'WC' ? 'selected' : ''}>글쓴이+내용</option>
  			<option value="CT" ${criteria.type eq 'CW' ? 'selected' : ''}>제목+내용</option>
  			<option value="TWC" ${criteria.type eq 'TWC' ? 'selected' : ''}>제목+내용+글쓴이</option>
  		</select>
  	</div>
    <input name="keyword" type="text" value="${criteria.keyword}">
	<button type="submit"class="btn btn-primary">검색</button>
    <input type="hidden" name="pageNum" value="${criteria.pageNum}">
	<input type="hidden" name="amount" value="${criteria.amount}">
  </form>
	  <ul class="pagination justify-content-center">
	  	<c:if test="${p.prev}">
	   	 	<li><a class="page-link" href="${p.startPage-1}">이전</a></li>
	  	</c:if>
	    <c:forEach begin="${p.startPage}" end="${p.endPage}" var="pageVal">
		    <li class="page-item ${pageVal == criteria.pageNum ? 'active' : '' }"><a class="page-link" href="${pageVal}">${pageVal}</a></li>
	    </c:forEach>
	  	<c:if test="${p.next }">
	   	 	<li><a class="page-link" href="${p.endPage+1}">다음</a></li>
	  	</c:if>
	  </ul>
  </div>
<form class="pageForm" action="${ctxPath}/board/list">
	<input type="hidden" name="pageNum" value="${criteria.pageNum}">
	<input type="hidden" name="amount" value="${criteria.amount}">
	<input type="hidden" name="type" value="${criteria.type}">
	<input type="hidden" name="keyword" value="${criteria.keyword}">
</form>

<%@ include file="../includes/footer.jsp" %>
<script src="${ctxPath}/resources/js/list.js"></script>
