$(function(){
	let bno = $('[name="bno"]').val();
	let memberId = $('.replyWriterName').val(); // 로그인한 유저 아이디
	
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
	
	// 비회원이 댓글작성 클릭시 로그인으로 이동
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
	
	// 첨부파일 리스트
	$.getJSON(`${ctxPath}/board/getAttachList`, {bno : bno}, function(attachList){
		if(!attachList.length>0){ // 첨부 없으면 리턴
			return;
		}
		// 첨부파일 목록 추가 및 이미지가 있을 시 이미지 출력
		let imageView = $('.imageView');
		let imageList = ``;
		let fileList = ` 
			<button type="button" class="btn btn-sm dropdown-toggle font-weight-bold" data-toggle="dropdown">🔗 첨부파일 다운받기</button>
			<div class="dropdown-menu">`;
		$.each(attachList, function(i,e){
			fileList += `
				<a class="dropdown-item download" href="${e.uploadPath + "/" + e.uuid + "_" + e.fileName}">${e.fileName}</a>`
			if(e.fileType){ // 이미지 여부 확인
				imageView.attr('class', 'imageView card-body');
				let filePath = e.uploadPath + "/" + e.uuid + "_" + e.fileName; 
				let encodingFilePath = encodeURIComponent(filePath);
				imageList += `
					<img alt="${e.fileName}" src="${ctxPath}/files/display?fileName=${encodingFilePath}" class="mb-3">`;
			}
		});
		fileList += `</div>`;
		imageView.html(imageList);
		$('.attachDownloadList').html(fileList);
	});
	
	// 첨부 파일 다운로드
	$('.attachDownloadList').on('click', '.download', function(e){
		e.preventDefault();
		self.location = `${ctxPath}/files/download?fileName=${$(this).attr('href')}`;
	});
	
	// 신고 모달창
	$('.reportModal').click(function(){
		let reportReason = $('[name="reportReason"]').val(); // 신고 사유
		$.ajax({
			data : {bno : bno, reportContent : reportReason, reporter : memberId},
			url : `${ctxPath}/report/submit`,
			type : 'post',
			success : function(result){
				alert(result);
			} 
		});
	});
	
});