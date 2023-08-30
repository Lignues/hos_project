<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/pageHeader.jsp"%>

<c:if test="${not empty authList[0]}"> <!-- 권한 구하기 -->
	<c:set var="highestAuth" value="ROLE_MEMBER"/>
	<c:if test="${not empty authList[1]}">
		<c:set var="highestAuth" value="ROLE_MANAGER"/>
		<c:if test="${not empty authList[2]}">
			<c:set var="highestAuth" value="ROLE_BOSS"/>
			<c:if test="${not empty authList[3]}">
				<c:set var="highestAuth" value="ROLE_ADMIN"/>
			</c:if>
		</c:if>
	</c:if>
</c:if>

<div class="container-sm mt-3">
	<div class="row">
		<div class="col-3">
			<h2 class="m-3">회원 관리</h2>
		</div>
	</div>
	<table class="table-sm table-bordered table-hover table-striped">
		<thead>
			<tr class="text-center">
				<th class="w-25">아이디</th>
				<th>이름</th>
				<th class="w-25">이메일</th>
				<th>가입일</th>
				<th>등급</th>
			</tr>
		</thead>

		<c:if test="${not empty list}">
			<c:forEach items="${list}" var="vo">
				<tbody>
					<tr class="text-center">
						<td>${vo.memberId}</td>
						<td>${vo.memberName}</td>
						<td>${vo.email}</td>
						<td><tf:formatDateTime value="${vo.regDate}" pattern="yyyy-MM-dd HH:mm"/></td>
						<td>
						<c:choose>
							<c:when test="${vo.authCount==1}">
								<c:set var="voHighestAuth" value="고객"/>
							</c:when>
							<c:when test="${vo.authCount==2}">
								<c:set var="voHighestAuth" value="직원"/>
							</c:when>
							<c:when test="${vo.authCount==3}">
								<c:set var="voHighestAuth" value="사장"/>
							</c:when>
							<c:when test="${vo.authCount==4}">
								<c:set var="voHighestAuth" value="관리자"/>
							</c:when>
						</c:choose>
							<div class="dropdown">
								<c:choose>
									<c:when test="${(highestAuth eq 'ROLE_ADMIN' and (voHighestAuth eq '사장' or voHighestAuth eq '직원' or voHighestAuth eq '고객')) 
										 or (highestAuth eq 'ROLE_BOSS' and (voHighestAuth eq '직원' or voHighestAuth eq '고객'))}">
										<button type="button" class="changeAuthBtn btn ${voHighestAuth eq '사장' ? 'btn-primary' : ''}
													 ${voHighestAuth eq '직원' ? 'btn-info' : ''} ${voHighestAuth eq '고객' ? 'btn-secondary' : ''} 
													 dropdown-toggle" data-toggle="dropdown">
									    	${voHighestAuth}
										</button>
									</c:when>
									<c:otherwise>
									    <span class="btn ${voHighestAuth eq '관리자' ? 'btn btn-warning' : ''} 
									    			${voHighestAuth eq '사장' ? 'btn-primary' : ''}
									    			 ${voHighestAuth eq '직원' ? 'btn-info' : ''} ${voHighestAuth eq '고객' ? 'btn-secondary' : ''} ">
									    	${voHighestAuth}
									    </span>
									</c:otherwise>
								</c:choose>
								<div class="changeAuth dropdown-menu" data-memberId="${vo.memberId}">
									<c:if test="${highestAuth eq 'ROLE_BOSS' or highestAuth eq 'ROLE_ADMIN'}">
										<a class="kickMember dropdown-item" href="kick">삭제</a>
										<a class="changeToMember dropdown-item" href="ROLE_MEMBER">고객</a>
									  	<a class="changeToManager dropdown-item" href="ROLE_MANAGER">직원</a>
								  	</c:if>
									<c:if test="${highestAuth eq 'ROLE_ADMIN'}">
									  	<a class="changeToBoss dropdown-item" href="ROLE_BOSS">사장</a>
									</c:if>
								</div>
							</div>
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
</form>

<input type="hidden" name="direction" value="control"> <!-- reply.js에서 페이징이나 리스트에 사용(get이냐 recent냐) -->
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
			.submit();
	});
	
	// 페이지 이동
	$('.pagination a').click(function(e){
		e.preventDefault();
		let pageNum = $(this).attr('href');
		pageForm.find('input[name="pageNum"]').val(pageNum);
		pageForm.attr('action', '${ctxPath}/mypage/control')
				.submit();
	});
	
	// 등급변경 드롭다운
	$('.changeAuth').on('click', '.dropdown-item', function(e){
		e.preventDefault();
		let clickedAuth = $(this).attr('href');
		let clickedMemberId = $(this).closest('.changeAuth').attr('data-memberId');
		let memberPath; 
		if(clickedAuth != 'kick'){
			memberPath = 'auth';
		}else{ // 추방일시 경로 변경
			memberPath = 'kick';
		}
		
		if(clickedAuth=='ROLE_MEMBER'){
			$(this).closest('div').prev().attr('class', 'changeAuthBtn btn btn-secondary dropdown-toggle');
			$(this).closest('div').prev().text($(this).text());
		}else if(clickedAuth=='ROLE_MANAGER'){
			$(this).closest('div').prev().attr('class', 'changeAuthBtn btn btn-info dropdown-toggle');
			$(this).closest('div').prev().text($(this).text());
		}else if(clickedAuth=='ROLE_BOSS'){
			$(this).closest('div').prev().attr('class', 'changeAuthBtn btn btn-primary dropdown-toggle');
			$(this).closest('div').prev().text($(this).text());
		}else if(clickedAuth){
			if(!confirm('회원 정보가 모두 삭제됩니다. 삭제 하시겠습니까?')){
				return;
			}
			$(this).closest('div').prev().attr('class', 'btn-danger');
			$(this).closest('div').prev().text($(this).text()+'됨');
		}
		
		$.ajax({
			data : {memberId : clickedMemberId, auth : clickedAuth},
			url : '${ctxPath}/member/'+memberPath,
			type : 'post',
			success : function(result){
				console.log('변경 완료');
				alert(result);
			}
		});
	});
	
});
</script>
