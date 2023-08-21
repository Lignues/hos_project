<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/pageHeader.jsp" %>

<div class="container mt-3">
	 <div class="row">
    <div class="col-3">
    	<h2 class="m-3">최근 작성글</h2>
    </div>
  </div>
  <table class="table table-bordered table-hover table-striped">
    <thead>
      <tr class="text-center">
        <th>글번호</th>
        <th class="w-50">제목</th>
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
		        <td class="text-left"><a class="go text-dark" href="${vo.bno}">${vo.secretContent == 1 ? '🔒 ' : '' }${vo.title} ${vo.replyCnt==0 ? '' : [vo.replyCnt]}</a></td>
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
</form>

<%@ include file="../includes/footer.jsp" %>

<script>
$(function(){
	
	let result = '${result}';
	let pageForm = $('.pageForm');
	
	// 클릭시 해당 글로 이동
	$('.go').click(function(e){
		e.preventDefault();
		bnoValue = $(this).attr('href');
		$('[name=bno]').remove();
		pageForm.append($('<input>',{type:'hidden', name:'bno', value : bnoValue}))
			.attr('action', `${ctxPath}/board/get`)
			.submit();
	});
	
	// 페이지 이동
	$('.pagination a').click(function(e){
		e.preventDefault();
		let pageNum = $(this).attr('href');
		pageForm.find('input[name="pageNum"]').val(pageNum);
		pageForm.attr('action', `${ctxPath}/board/list`)
				.submit();
	});
	
});
</script>
