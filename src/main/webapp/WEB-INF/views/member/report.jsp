<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/pageHeader.jsp"%>

<div class="container-sm mt-3">
	<div class="row">
		<div class="col-3">
			<h2 class="m-3">신고내역##나중에 신고자용과 관리자용 분리할것##</h2>
		</div>
	</div>
	<table class="table-sm table-bordered table-hover table-striped">
		<thead>
			<tr class="text-center">
				<th>신고번호</th>
				<th>신고자</th>
				<th class="w-50">신고내역</th>
				<th>글번호</th>
				<th>작성자</th>
				<th>글제목</th>
				<th>글내용</th>
				<th>처리상태</th>
			</tr>
		</thead>

		<c:if test="${not empty list}">
			<c:forEach items="${list}" var="vo">
				<tbody>
					<tr class="text-center">
						<td>${vo.rnum}</td>
						<td>${vo.reporter}</td>
						<td>${vo.reportContent}</td>
						<td>${vo.bno}</td>
						<td class="text-left">
							<a class="go text-dark" href="${vo.bno}">
								${vo.title}
							</a>
						</td>
						<td>${vo.writer} 글내용과 글 제목은 클릭시 해당 글 아래 출력하도록 할것(댓글 수정창처럼)</td>
						<td>${vo.content}</td>
						<td>${vo.handle} 드롭다운으로 바꿔서 누르면 처리하도록 만들것</td><!-- ############# script부분 하나도 안고쳤다 다시해라 ################### -->
					</tr>
				</tbody>
			</c:forEach>
		</c:if>
	</table>
	<ul class="pagination justify-content-center mt-3">
		<c:if test="${p.prev}">
			<li><a class="page-link" href="${p.startPage-1}">이전</a></li>
		</c:if>
		<c:forEach begin="${p.startPage}" end="${p.endPage}" var="pageVal">
			<li class="page-item ${pageVal == criteria.pageNum ? 'active' : '' }"><a
				class="page-link" href="${pageVal}">${pageVal}</a></li>
		</c:forEach>
		<c:if test="${p.next }">
			<li><a class="page-link" href="${p.endPage+1}">다음</a></li>
		</c:if>
	</ul>
	<div class="row">
		<div class="col-4">
			<h2 class="m-3">최근 작성댓글</h2>
		</div>
	</div>
	<div class="reply container mt-2">
		<div class="card">
		  <div class="card-header">
		  	<div class="d-flex justify-content-between">
		  		<div>
			  		등록된 댓글이 없습니다.
		  		</div>
		  	</div>
		  </div>
		  <div class="card-body">
		  	리플
		  </div>
		</div>
	</div>
	<div class="container mt-3">
		<div class="replyPagination"></div>
	</div>
</div>

<form class="pageForm" action="${ctxPath}/board/list">
	<input type="hidden" name="pageNum" value="${criteria.pageNum}">
	<input type="hidden" name="amount" value="${criteria.amount}">
</form>

<input type="hidden" name="direction" value="recent"> <!-- getList 호출 위치(get이냐 recent냐) -->
<input type="hidden" class="replyWriterName" value="${authInfo.memberId}">

<%@ include file="../includes/footer.jsp"%>
<script src="${ctxPath}/resources/js/replyService.js"></script>
<script src="${ctxPath}/resources/js/reply.js"></script>

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
			.attr('action', '${ctxPath}/board/get')
			.submit();
	});
	
	// 페이지 이동
	$('.pagination a').click(function(e){
		e.preventDefault();
		let pageNum = $(this).attr('href');
		pageForm.find('input[name="pageNum"]').val(pageNum);
		pageForm.attr('action', '${ctxPath}/mypage/recent')
				.submit();
	});
	
});
</script>
