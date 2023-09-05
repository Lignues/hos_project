<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/pageHeader.jsp"%>

<c:if test="${not empty authList[0]}"> <!-- 로그인한 사용자의 등급 -->
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

<div class="container-sm mt-3 mb-5">
	<div class="row">
		<div class="col-3">
			<h2 class="m-3">예약 관리</h2>
		</div>
	</div>
	<sec:authorize access="hasRole('ROLE_MANAGER')">
		<c:if test="${not empty thisList}">
			<h4>오늘 예약 ${thisList[0].bookDate}</h4>
			<table class="table-sm table-hover table-striped table-bordered">
				<thead>
					<tr class="text-center">
						<th>시간</th>
						<th class="w-25">아이디</th>
						<th>이름</th>
						<th class="w-25">상담사유</th>
					</tr>
				</thead>
				<c:forEach items="${thisList}" var="vo">
					<tbody>
						<tr class="text-center">
							<td>${vo.bookTime}:00</td>
							<td>${vo.memberId}</td>
							<td>${vo.memberName}</td>
							<td>${vo.bookReason}</td>
						</tr>
					</tbody>
				</c:forEach>
			</table>
		</c:if>
		<c:if test="${not empty nextList}">
			<br>
			<h4>내일 예약 ${nextList[0].bookDate}</h4>
			<table class="table-sm table-bordered table-hover table-striped">
				<thead>
					<tr class="text-center">
						<th>시간</th>
						<th class="w-25">아이디</th>
						<th>이름</th>
						<th class="w-25">상담사유</th>
						<sec:authorize access="hasRole('ROLE_BOSS')">
							<td>관리자버튼넣자</td>
						</sec:authorize>
					</tr>
				</thead>
				<c:forEach items="${nextList}" var="vo">
					<tbody>
						<tr class="text-center">
							<td>${vo.bookTime}:00</td>
							<td>${vo.memberId}</td>
							<td>${vo.memberName}</td>
							<td>${vo.bookReason}</td>
						</tr>
					</tbody>
				</c:forEach>
			</table>
		</c:if>
	</sec:authorize>
	<sec:authorize access="!hasRole('ROLE_MANAGER')">
	<c:if test="${not empty list}">
			<table class="table-sm table-bordered table-hover table-striped">
				<thead>
					<tr class="text-center">
						<th class="w-25">상담일</th>
						<th>시간</th>
						<th>이름</th>
						<th class="w-25">상담사유</th>
						<th class="w-25">상담취소</th>
					</tr>
				</thead>
				<c:forEach items="${list}" var="vo">
					<tbody>
						<tr class="text-center">
							<td>${vo.bookDate}</td>
							<td>${vo.bookTime}:00</td>
							<td>${vo.memberName}</td>
							<td>${vo.bookReason}</td>
							<td><button type="button" class="cancelBtn btn btn-primary" data-date="${vo.bookDate}" data-time="${vo.bookTime}">취소하기</button></td>
						</tr>
					</tbody>
				</c:forEach>
			</table>
		</c:if>
	</sec:authorize>
</div>

<form action="${ctxPath}/member/booking/cancel" method="post" name="cancelForm">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	<input type="hidden" name="memberId" value="${authInfo.memberId}">
	<input type="hidden" name="bookDate" value="">
	<input type="hidden" name="bookTime" value="">
</form>

<input type="hidden" name="direction" value="booking"> 

<%@ include file="../includes/footer.jsp"%>

<script>
$(function(){
	let memberId = '${authInfo.memberId}';
	
	$('.cancelBtn').click(function(){
		if(!confirm('상담예약을 취소하시겠습니까?')){
			return;
		}
		let bookDate = $(this).data('date');
		let bookTime = $(this).data('time');
		$('[name="bookDate"]').val(bookDate);
		$('[name="bookTime"]').val(bookTime);
		$('[name="cancelForm"]').submit();
	});
});
</script>
