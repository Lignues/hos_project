$(function(){
	let bnoValue = $('[name="bno"]').val();
	let uploadResultList = [];
	let toBeDelList = [];
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
		
		let idx = 0; 
		if(toBeDelList.length>0){ // 삭제 대상 첨부파일이 있으면 
			$.each(toBeDelList, function(i,e){
				let bno = $('<input/>',{type:'hidden', name:`attachList[${i}].bno`, value:`${e.bno}`})
				let uuid = $('<input/>',{type:'hidden', name:`attachList[${i}].uuid`, value:`${e.uuid}`})
				let fileName = $('<input/>',{type:'hidden', name:`attachList[${i}].fileName`, value:`${e.fileName}`})
				let fileType = $('<input/>',{type:'hidden', name:`attachList[${i}].fileType`, value:`${e.fileType}`})
				let uploadPath = $('<input/>',{type:'hidden', name:`attachList[${i}].uploadPath`, value:`${e.uploadPath}`})
				$('.modifyForm')
					.append(bno)
					.append(uuid)
					.append(fileName)
					.append(fileType)
					.append(uploadPath);
				console.log(i);
				idx = ++i; 
			}); // each end
		} // if end	
		
		if(uploadResultList.length>0){ // 새로 추가한 첨부파일이 있으면  
			$.each(uploadResultList, function(i,e){
				console.log(idx+i)
				let uuid = $('<input/>',{type:'hidden', name:`attachList[${i+idx}].uuid`, value:`${e.uuid}`})
				let fileName = $('<input/>',{type:'hidden', name:`attachList[${i+idx}].fileName`, value:`${e.fileName}`})
				let fileType = $('<input/>',{type:'hidden', name:`attachList[${i+idx}].fileType`, value:`${e.fileType}`})
				let uploadPath = $('<input/>',{type:'hidden', name:`attachList[${i+idx}].uploadPath`, value:`${e.uploadPath}`})
				$('.modifyForm')
					.append(uuid)
					.append(fileName)
					.append(fileType)
					.append(uploadPath)
			}); // each end
		} // if end
		$('.modifyForm').submit();
	});
	
	// 목록 버튼
	$('.listBtn').click(function(){
		$('.modifyForm').attr('method', 'get')
			.attr('action', `${ctxPath}/board/list`)
			.html('')
			.submit();
	});
	
	// 첨부파일 업로드
	$('input[type="file"]').change(function(){
		let formData = new FormData();
		let files = this.files; // files는 type이 file인 input의 속성임. 첨부된 파일들을 나타냄 
		
		for(let f of files){
			if(!checkExtension(f.name, f.size)){
				$(this).val('');
				return;
			}
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
	
	// 기존 업로드된 파일 삭제
	$('.uploadResultDiv ul').on('change','.toBeDelFile',function(e){
		let listTag = $(this).closest('li');
		let uuid = listTag.data('uuid');
		if($(this).is(':checked')){
			$.ajax({
				type : 'get', 
				url : `${ctxPath}/board/getAttachFileInfo`, 
				data : {uuid : uuid}, 
				success : function(boardAttachVO){
					toBeDelList.push(boardAttachVO)
				}
			});
		} else {
			toBeDelList = toBeDelList.filter(e=> e.uuid != uuid);
		}
		console.log(toBeDelList); // 삭제 대상 파일 
		
	});
	
	// 파일 업로드 목록 생성
	let showUploadResult = function(attachList){
		let fileList = '';
		$.each(attachList, function(i,e){
			uploadResultList.push(e);
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
	
	// 첨부파일 목록 불러오기
	$.getJSON(`${ctxPath}/board/getAttachList`,{bno:bnoValue},function(attachList){
		let fileList = '';
		$(attachList).each(function(i,e){
			fileList += `<li class="list-group-item" data-uuid="${e.uuid}">
				<div class="float-left">`
			if(e.fileType){ // 이미지 파일인 경우 섬네일 표시
				let filePath = e.uploadPath+"/s_"+e.uuid+"_"+e.fileName; 
				let encodingFilePath = encodeURIComponent(filePath);
				fileList +=`
					<div class="thumnail d-inline-block mr-3">
						<img alt="" src="${ctxPath}/files/display?fileName=${encodingFilePath}">	
					</div>				
				`
			} else {
				fileList +=` 
					<div class="thumnail d-inline-block mr-3" style="width:40px">
						<img alt="" src="${ctxPath}/resources/images/attach.png" style="width: 100%">
					</div>`
			}
			fileList +=		
				`<div class="d-inline-block">
					${e.fileName}
				</div>
				</div>
				<div class="float-right">`
			if(e.fileType){
				fileList += `<a href="${e.uploadPath+"/"+e.uuid+"_"+e.fileName}" class="showIamge">원본보기</a>`
			}else{
				fileList += `<a href="${e.uploadPath+"/"+e.uuid+"_"+e.fileName}" class="download">다운로드</a>`
			} 
			fileList += `
					<div class="form-check-inline ml-2">
						<label class="form-check-label">
	    					<input type="checkbox" class="form-check-input toBeDelFile">
	    					<span>삭제</span>
						</label>		
					</div>
				</div>
			</li>`			
		});
		$('.uploadResultDiv ul').html(fileList);
	});
});