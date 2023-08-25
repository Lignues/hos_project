<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/pageHeader.jsp"%>

<div class="container-sm mt-3">
	<div class="row">
		<div class="col-3">
			<h2 class="m-3">신고내역</h2>
		</div>
	</div>
	<table class="table-sm table-bordered table-hover table-striped">
		<thead>
			<tr class="text-center">
				<th>신고번호</th>
				<th>신고자</th>
				<th class="w-50">신고내역</th>
				<th>글번호</th>
				<th>글제목</th>
				<th>작성자</th>
				<th>미리보기</th>
				<th>처리상태</th>
			</tr>
		</thead>

		<c:if test="${not empty list}">
			<c:forEach items="${list}" var="vo">
				<tbody>
					<tr class="handleStatus text-center">
						<td>${vo.rnum}</td>
						<td>${vo.reporter}</td>
						<td class="text-left">${vo.reportContent}</td>
						<td>${vo.bno}</td>
						<td class="originTitle text-left">
							<a class="go text-dark" href="${vo.bno}">
								${vo.title}
							</a>
							<c:if test="${vo.handle==2}">삭제됨</c:if>
						</td>
						<td class="originContent">${vo.writer}<c:if test="${vo.handle==2}">삭제됨</c:if></td>
						<td class="spread">
							<c:if test="${vo.handle==1 || vo.handle==0}"><a class="preview" href="${vo.bno}">펼치기</a></c:if>
							<c:if test="${vo.handle==2}">삭제됨</c:if>
						</td>
						<td class="handling">
							<sec:authorize access="hasRole('ROLE_MEMBER') and !hasRole('ROLE_ADMIN')">
								<c:choose>
									<c:when test="${vo.handle=='0'}">
										대기중
									</c:when>
									<c:when test="${vo.handle=='1'}">
										신고 거부
									</c:when>
									<c:when test="${vo.handle=='2'}">
										삭제 완료
									</c:when>
								</c:choose>
							</sec:authorize>
							<sec:authorize access="hasRole('ROLE_ADMIN')">
								<c:choose>
									<c:when test="${vo.handle=='0'}">
										<div class="dropdown">
											<button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown">
										    	대기중 
											</button>
											<div class="reportHandler dropdown-menu">
											  	<a class="cancelReport dropdown-item" href="신고 거부">신고 거부</a>
											  	<a class="handleReport dropdown-item" href="삭제 완료">삭제 완료</a>
											</div>
										</div>
									</c:when>
									<c:when test="${vo.handle=='1'}">
										신고 거부
									</c:when>
									<c:when test="${vo.handle=='2'}">
										삭제 완료
									</c:when>
								</c:choose>
							</sec:authorize>
						</td>
					</tr>
					<tr class="tr1 border-top-0" style="display:none">
						<td class="text-center">제목</td>
						<td colspan="7">
							<div class="p-2">${vo.writer}</div>
						</td>
					</tr>
					<tr></tr>
					<tr class="tr2" style="display:none">
						<td class="text-center">내용</td>
						<td colspan="7">
							<div class="p-2">${vo.content }</div>
						</td>
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

<input type="hidden" name="direction" value="report"> <!-- getList 호출 위치(get이냐 recent냐) -->
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
			.attr('target', '_blank')
			.submit();
	});
	
	// 페이지 이동
	$('.pagination a').click(function(e){
		e.preventDefault();
		let pageNum = $(this).attr('href');
		pageForm.find('input[name="pageNum"]').val(pageNum);
		pageForm.attr('action', '${ctxPath}/mypage/report')
				.removeAttr('target')
				.submit();
	});
	
	// 처리 드롭다운
	$('.reportHandler').on('click', '.dropdown-item', function(e){
		e.preventDefault();
		let handle = $(this).attr('href');
		let bno = $(this).closest('tbody').find('.preview').attr('href');
		let preview = $(this).closest('tbody').find('.spread');
		if(handle=='신고 거부'){
			$(this).closest('.dropdown').html('신고 거부'); // #############해당 bno 전부 기각표시 되도록 변경 삭제완료도 똑같이#############
			
			
		}else if(handle=='삭제 완료'){
			if(!confirm('해당 글과 관련된 내용들이 모두 삭제됩니다. 진행 하시겠습니까?')){ // 삭제 확인하기
				return;
			}
			$(this).closest('tbody').find('.tr1').remove();
			$(this).closest('tbody').find('.tr2').remove();
			$(this).closest('.dropdown').html('삭제 완료');
			preview.html('삭제됨');
		}
// 		$.ajax({  // ##################다만들고 주석 풀기 ###############
// 			data : {bno : bno, handle : handle},
// 			url : '${ctxPath}/report/handle',
// 			type : 'post',
// 			success : function(result){
// 				console.log('success');
// 				alert(result);
// 			}
// 		});
	});
	
	// 글 미리보기
	$('.preview').click(function(e){
		e.preventDefault();
		let preview = $(this).text();
		if(preview=='펼치기'){
			$(this).text('접기');
			$(this).closest('tbody').find('.tr1').removeAttr('style');
			$(this).closest('tbody').find('.tr2').removeAttr('style');
		}else if(preview=='접기'){
			$(this).text('펼치기');
			$(this).closest('tbody').find('.tr1').attr('style', 'display:none');
			$(this).closest('tbody').find('.tr2').attr('style', 'display:none');
		}
		
	});
	
	
});
</script>
