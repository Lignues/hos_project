$(function(){
	// 글쓰기
	$('.writeBtn').click(function(){
		let title = $('input[name="title"]').val();
		let content = $('[name="content"]').val();
		
		if(title == ''){
			alert('제목을 입력하세요');
			return;
		}
		if(content == ''){
			alert('내용을 입력하세요');
			return;
		}
		$('.writeForm').attr('action', `${ctxPath}/board/write`).submit();
	});
	
	// 리스트 가기
	$('.listBtn').click(function(){
		$('.writeForm').html('').attr('method', 'get').attr('action', `${ctxPath}/board/list`).submit();;
	});
	
});