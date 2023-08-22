$(function(){
	let bno = $('[name="bno"]').val();

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
	
	// 추천수 갱신
	function hitRenew(){
		$.ajax({
			data : {bno : bno},
			type : 'get',
			url : `${ctxPath}/board/hitRenew`,
			success : function(hit){
				$('.likeBtn').html('👍 ' + hit);
			}
		});
	};
	
	// 추천하기
	$('.likeBtn').click(function(e){
		e.preventDefault();
		let memberId = $('.replyWriterName').val();
		if(memberId==''){
			alert('로그인이 필요합니다');
			return;
		}
		$.ajax({
			type : 'post',
			url : `${ctxPath}/board/like`,
			data : {bno : bno, memberId : memberId},
			success : function(message){
				alert(message);
				hitRenew();
			}
		});
	});
	
});