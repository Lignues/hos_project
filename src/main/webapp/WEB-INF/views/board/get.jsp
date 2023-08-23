<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<div class="container my-5">
	<div class="card">
		<div class="card-header">
			<div class="d-flex justify-content-start">${vo.secretContent == 1 ? '🔒 ' : '' }${vo.title}
			</div>
		</div>
		<div class="card-header">
			<div class="d-flex justify-content-between">
				<div class="${vo.writer=='admin' ? 'text-primary' : ''}">
					${vo.writer}
				</div>
				<div>
					조회수 : ${vo.views}회&nbsp;
					<c:if test="${vo.regDate == vo.updateDate}">
						<tf:formatDateTime value="${vo.regDate}" pattern="yyyy-MM-dd HH:mm:ss"/> 작성됨
		  			</c:if>
					<c:if test="${vo.regDate != vo.updateDate}">
						<tf:formatDateTime value="${vo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/> 수정됨
  					</c:if>
				</div>
			</div>
		</div>
		<sec:authorize access="#vo.secretContent==0 or ((#vo.secretContent==1 and hasRole('ROLE_ADMIN')) or (isAuthenticated() and principal.username == #vo.writer))">
			<div class="imageView">
			</div>
			<div class="card-body">
				${vo.content}
			</div>
		</sec:authorize>
		<sec:authorize access="#vo.secretContent==1 and (isAnonymous() or (isAuthenticated() and principal.username != #vo.writer and !hasRole('ROLE_ADMIN')))"><!-- 권한때문에 !가 안먹는다 -->
			<div class="card-header">
				<br><br><br><br>
				<p class="text-center">
					<b>🔒 비밀글입니다. 작성자와 관리자만 내용을 확인할 수 있습니다. 🔒</b>
				</p>
				<br><br><br><br>
			</div>
		</sec:authorize>
	</div>
	<sec:authorize access="#vo.secretContent==0 or ((#vo.secretContent==1 and hasRole('ROLE_ADMIN')) or (isAuthenticated() and principal.username == #vo.writer))">
		<div class="attachDownloadList dropdown float-right">
		</div>
		<div class="text-center mt-3">
			<h4>
				<button class="likeBtn btn btn-outline-primary">👍 ${vo.likeHit}</button>
			</h4>
		</div>
	</sec:authorize>
	<c:if test="${vo.secretContent == 1 }">
		<span class="float-left m-2">🔒 비밀글입니다</span>
	</c:if>
	<span class="float-right m-2">
		<sec:authorize access="isAuthenticated() and principal.username == #vo.writer or hasRole('ROLE_ADMIN')">
			<button type="button" class="modifyBtn btn btn-primary">수정</button>
			<button type="button" class="deleteBtn btn btn-primary">삭제</button>
		</sec:authorize>
		<button type="button" class="listBtn btn btn-primary">목록으로</button>
	</span>
</div>


<form action="${ctxPath}/board/list">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	<input type="hidden" name="bno" value="${vo.bno}">
	<input type="hidden" name="writer" value="${vo.writer}">
	<!-- 나중에 criteria도 넣어라 -->
</form>
<br>

<!-- 비밀글시 사라짐 -->
<sec:authorize access="#vo.secretContent==0 or ((#vo.secretContent==1 and hasRole('ROLE_ADMIN')) or (isAuthenticated() and principal.username == #vo.writer))">
	<div class="container mt-5">
		<div class="card">
			<div class="card-header">🗨 댓글</div>
		</div>
	</div>
	<!-- 리플넣을자리 -->
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
		  </div>
		</div>
	</div>
	
	<div class="replyWriterForm container">
		<div class="card mb-2">
		  <div class="card-header">
		  	<div class="d-flex justify-content-between">
		  		<div>${authInfo.memberId}</div>
		  		<input type="hidden" class="replyWriterName" value="${authInfo.memberId}">
		  		<div>
		  			<sec:authorize access="isAuthenticated()">
			  			<button class="replySubmit btn btn-primary">등록</button>
		  			</sec:authorize>	
		  		</div>
		  	</div>
		  </div>
		  <div class="form-group">
		  	<sec:authorize access="isAuthenticated()">
		  		<textarea class="form-control" name="content" rows="4" cols="200" placeholder="댓글을 작성하세요" style="resize: none;"></textarea>
		  	</sec:authorize>	
		  	<sec:authorize access="isAnonymous()">
		  		<textarea class="form-control" name="goLogin" rows="4" cols="200" placeholder="댓글을 작성하시려면 로그인 해 주세요" style="resize: none;"></textarea>
		  	</sec:authorize>	
		  </div>
		</div>
	</div>
	<div class="container mt-3">
		<div class="replyPagination"></div>
	</div>
</sec:authorize><!-- 비밀글 사라짐 종료 -->

<input type="hidden" name="direction" value="get"> <!-- getList 호출 위치(get이냐 recent냐) -->

<!-- 		비밀컨텐츠(비밀글+작성자가 아닌 사람이거나  관리자가 아닌 경우) 비밀글+비회원, 비밀글+다른사람+관리자아님 일때만 보여야함 -->
<%-- 	<sec:authorize access="#vo.secretContent==1 and (isAnonymous() or (isAuthenticated() and principal.username != #vo.writer and !hasRole('ROLE_ADMIN')))"> --%>
<!-- 		권한있을때 보이는 컨텐츠 -->
<%-- 	<sec:authorize access="#vo.secretContent==0 or ((#vo.secretContent==1 and hasRole('ROLE_ADMIN')) or (isAuthenticated() and principal.username == #vo.writer))"> --%>


<%@ include file="../includes/footer.jsp" %>
<script src="${ctxPath}/resources/js/replyService.js"></script>
<script src="${ctxPath}/resources/js/reply.js"></script>
<script src="${ctxPath}/resources/js/get.js"></script>
