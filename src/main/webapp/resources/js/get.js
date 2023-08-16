$(function(){
	let boardResult = $('[name="boardResult"]').val();
	if(boardResult){
		alert(boardResult);	
	}

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
	
	// 로그인으로 이동
	$('textarea[name="goLogin"]').click(function(e){
		e.preventDefault();
		$('form').attr('action', `${ctxPath}/login`)
				.submit();
	})
});