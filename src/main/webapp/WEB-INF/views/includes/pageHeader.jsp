<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="container mt-3">
	<form action="${ctxPath}/mypage" class="myPageForm">
		<div class="btn-group">
		  <button type="button" id="modifyForm" class="btn btn-outline-primary">회원정보 변경</button>
		  <button type="button" id="recentForm" class="btn btn-outline-primary">최근 작성글</button>
		  <button type="button" id="tempForm" class="btn btn-outline-primary">공사중</button>
		</div>
	</form>
</div>
<input type="hidden" name="path" value="${path}">
<script>
$(function(){
	
	// 활성화된 메뉴에 불들어오기
	let path = $('[name="path"]').val();
	if(path=='recent'){
		$('#recentForm').attr('class', 'btn btn-outline-primary active');
	}else if(path=='temp'){
		$('#tempForm').attr('class', 'btn btn-outline-primary active');
	}else{
		$('#modifyForm').attr('class', 'btn btn-outline-primary active');
	}
		
	// 메뉴 이동
	myPageForm = $('.myPageForm');
	$('#modifyForm').click(function(){
		myPageForm.attr('action', '${ctxPath}/mypage').submit();
	});
	$('#recentForm').click(function(){
		myPageForm.attr('action', '${ctxPath}/mypage/recent').submit();
	});
	$('#tempForm').click(function(){
		myPageForm.attr('action', '${ctxPath}/mypage/temp').submit();
	});
});
</script>