<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/pageHeader.jsp"%>

<div class="container-sm mt-3">
	<div class="row">
		<div class="col-3">
			<h2 class="m-3">신고 내역</h2>
		</div>
		<div class="col-6"></div>
		<div class="col-2 mt-3 ml-3">
			<select name="selectSearchHandled" class="form-control">
				<option value="1" ${criteria.searchHandled eq '1' ? 'selected': ''}>모든 신고</option>
				<option value="0" ${criteria.searchHandled eq '0' ? 'selected': ''}>미처리</option>
			</select>
		</div>
	</div>
	<table class="table-sm table-bordered table-hover table-striped">
		<thead>
			<tr class="text-center">
				<th>신고번호</th>
				<th>신고자</th>
				<th style="width : 30%;">신고내역</th>
				<th>글번호</th>
				<th style="width : 150px;">글제목</th>
				<th style="width : 80px;">작성자</th>
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
							<div data-handle="${vo.bno}">
								<a class="go text-dark" href="${vo.bno}">
									${vo.title}
								</a>
							</div>
							<c:if test="${vo.handle==2}"><span class="badge-pill badge-danger">삭제됨</span></c:if>
						</td>
						<td class="originContent"><div data-handle="${vo.bno}">${vo.writer}</div>
							<c:if test="${vo.handle==2}">
								<span class="badge-pill badge-danger">삭제됨</span>
							</c:if>
						</td>
						<td class="spread">
							<c:if test="${vo.handle==1 || vo.handle==0}">
								<div data-handle="${vo.bno}">
									<a class="preview" href="${vo.bno}">펼치기</a>
								</div>
							</c:if>
							<c:if test="${vo.handle==2}"><span class="badge-pill badge-danger">삭제됨</span></c:if>
						</td>
						<td class="handling">
							<sec:authorize access="hasRole('ROLE_MEMBER') and !hasRole('ROLE_MANAGER')">
								<c:choose>
									<c:when test="${vo.handle=='0'}">
										대기중
									</c:when>
									<c:when test="${vo.handle=='1'}">
										<span class="badge-pill badge-success">신고 거부</span>
									</c:when>
									<c:when test="${vo.handle=='2'}">
										<span class="badge-pill badge-danger">삭제 완료</span>
									</c:when>
								</c:choose>
							</sec:authorize>
							<sec:authorize access="hasRole('ROLE_MANAGER')">
								<c:choose>
									<c:when test="${vo.handle=='0'}">
										<div class="dropdown" data-handle2="${vo.bno}">
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
										<span class="badge-pill badge-success">신고 거부</span>
									</c:when>
									<c:when test="${vo.handle=='2'}">
										<span class="badge-pill badge-danger">삭제 완료</span>
									</c:when>
								</c:choose>
							</sec:authorize>
						</td>
					</tr>
					<tr class="tr1 border-top-0" style="display:none">
						<td class="text-center">제목</td>
						<td colspan="7">
							<div class="p-2">${vo.title}</div>
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
</div>

<form class="pageForm" action="${ctxPath}/board/list">
	<input type="hidden" name="pageNum" value="${criteria.pageNum}">
	<input type="hidden" name="amount" value="${criteria.amount}">
	<input type="hidden" name="searchHandled" value="${criteria.searchHandled != null ? criteria.searchHandled : 1}">
</form>

<input type="hidden" name="direction" value="report"> <!-- reply.js에서 페이징이나 리스트에 사용(get이냐 recent냐) -->
<input type="hidden" class="replyWriterName" value="${authInfo.memberId}">

<%@ include file="../includes/footer.jsp"%>

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
	
	// 리스트 조건(미처리만 보기, 모두 보기) 변경
	$('[name="selectSearchHandled"]').change(function(){
		let changeSelect = $(this).val();
		$('[name="searchHandled"]').val(changeSelect);
		$('[name="pageNum"]').remove(); // 버그 방지
		$('[name="amount"]').remove();
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
			if(!confirm('해당 글의 신고를 거부 처리 합니다. 진행 하시겠습니까?')){ // 거부 확인하기
				return;
			}
			$('div[data-handle2="'+ bno +'"]').html('신고 거부').attr("class", "badge-pill badge-success");
		}else if(handle=='삭제 완료'){
			if(!confirm('해당 글과 관련된 내용들이 모두 삭제됩니다. 진행 하시겠습니까?')){ // 삭제 확인하기
				return;
			}
			$('div[data-handle="'+ bno +'"]').closest('tbody').find('.tr1').remove();
			$('div[data-handle="'+ bno +'"]').closest('tbody').find('.tr2').remove();
			$('div[data-handle="'+ bno +'"]').html('삭제됨').attr("class", "badge-pill badge-danger");
			$('div[data-handle2="'+ bno +'"]').html('삭제 완료').attr("class", "badge-pill badge-danger");
		}
		$.ajax({
			data : {bno : bno, handle : handle},
			url : '${ctxPath}/report/handle',
			type : 'post',
			success : function(result){
				console.log('success');
				alert(result);
			}
		});
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
