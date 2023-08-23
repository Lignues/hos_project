$(function(){
	let uploadResultList = [];
	let writeForm = $('.writeForm');
	
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
		console.log(uploadResultList);
		if(uploadResultList.length>0){ // 첨부파일이 있으면 
			$.each(uploadResultList, function(i,e){
				let uuid = $('<input/>',{type:'hidden', name:`attachList[${i}].uuid`, value:`${e.uuid}`})
				let fileName = $('<input/>',{type:'hidden', name:`attachList[${i}].fileName`, value:`${e.fileName}`})
				let fileType = $('<input/>',{type:'hidden', name:`attachList[${i}].fileType`, value:`${e.fileType}`})
				let uploadPath = $('<input/>',{type:'hidden', name:`attachList[${i}].uploadPath`, value:`${e.uploadPath}`})
				writeForm.append(uuid)
					.append(fileName)
					.append(fileType)
					.append(uploadPath)
			})
		}
		writeForm.attr('action', `${ctxPath}/board/write`).submit();
	});
	
	// 리스트 가기
	$('.listBtn').click(function(){
		writeForm.html('').attr('method', 'get').attr('action', `${ctxPath}/board/list`).submit();
	});
	
	// 첨부파일 업로드
	$('input[type="file"]').change(function(){
		let formData = new FormData();
		let files = this.files; // files는 type이 file인 input의 속성임. 첨부된 파일들을 나타냄 
		
		for(let f of files){
			formData.append('uploadFile', f);
		}
		
		$.ajax({
			url : `${ctxPath}/files/upload`,
			type : 'post',
			processData : false,
			contentType : false,
			data : formData,
			dataType : 'json',
			success : function(attachList){
				uploadResultList = attachList;
				showUploadResult(attachList);
			}
		});
	});
	
	// 첨부파일 삭제
	$('.uploadResultDiv ul').on('click', '.delete', function(e){
		e.preventDefault();
		let uuid = $(this).closest('li').data('uuid');
		let targetFileIdx = -1;
		let targetFile = null;
		
		$.each(uploadResultList, function(i,e){
			if(e.uuid == uuid){
				targetFileIdx = i;
				targetFile = e;
				return;
			}
		});
		
		if(targetFileIdx != -1) uploadResultList.splice(targetFileIdx, 1); // index위치부터 배열 1개 제거
		console.log(uploadResultList);
		 
		console.log('삭제 대상 파일 객체 : ');
		console.log(targetFile);
		
		$.ajax({
			type : 'post',
			url : `${ctxPath}/files/deleteFile`,
			data : targetFile,
			success : function(result){
				console.log(result);
			}
		});
		$(this).closest('li').remove();
	});
	
	// 파일 업로드 목록 생성
	let showUploadResult = function(attachList){
		let fileList = '';
		$.each(attachList, function(i,e){
			// uploadResultList.push(e); // ############### 넣어야하나 뺴야하나 확인 ###############
			fileList += `
			<li class="list-group-item" data-uuid="${e.uuid}">
				<div class="float-left">`
					if(e.fileType){ // 섬네일 표시
						let filePath = e.uploadPath + "/s_" + e.uuid + "_" + e.fileName;
						let encodingFilePath = encodeURIComponent(filePath); // uri 인코딩
						fileList += `
						<div class="thumnail d-inline-block mr-3" style="width:40px">
							<img alt="" src="${ctxPath}/files/display?fileName=${encodingFilePath}">
						</div>`
					}else{ // 범용섬네일 표시
						fileList += `
						<div class="thumnail d-inline-block mr-3" style="width:40px">
							<img alt="" src="${ctxPath}/resources/images/attach.png" style="width: 100%">
						</div>`
					}
					fileList += 
					`<div class="d-inline-block">
						<a href="#">${e.fileName}</a>
					</div>
				</div>
				<div class="float-right">
					<a href="#" class="delete">삭제</a>
				</div>
			</li>`
					
		});
		$('.uploadResultDiv ul').append(fileList);
	}
});