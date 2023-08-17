$(function(){

	let secret = $('[name="secret"]').val();
	if(secret==1){
		$('[name="secretContent"]').attr('checked', 'true');
		$('[name="secret"]').remove();
	}

	// 수정하기 버튼
	$('.modifyBtn').click(function(){
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
		$('.modifyForm').submit();
	});
	
	// 리스트로 버튼
	$('.listBtn').click(function(){
		$('.modifyForm').attr('method', 'get')
			.attr('action', `${ctxPath}/board/list`)
			.html('')
			.submit();
	});
	
});