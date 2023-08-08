$(function(){
	// 수정으로 가기
	$('.modifyBtn').click(function(){
		$('form').attr('action', `${ctxPath}/board/modify`).submit();
	});
	
	// 목록으로
	$('.listBtn').click(function(){
		$('form').html('').submit();
	});
	
	// 삭제하기
	$('.deleteBtn').click(function(){
		$('form').attr('method', 'post').attr('action', `${ctxPath}/board/delete`)
				.submit();
	});
});