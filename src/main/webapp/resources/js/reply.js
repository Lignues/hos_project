$(function(){
	let bnoVal = $('input[name="bno"]').val();
	let replyContainer = $('.reply');
	let pageNum = 1;
	let replyPagination = $('.replyPagination');
	
	let replyPage = function(replyCount){
		let endNum = Math.ceil(pageNum/10.0)*10;
		let startNum = endNum - 9;
		let tempEndNum = Math.ceil(replyCount/10.0);
		
		let prev = startNum !=1; 
		let next = endNum < tempEndNum;
		if(endNum>tempEndNum) endNum = tempEndNum;
		
		let pagination = '<ul class="pagination justify-content-center">';
		
		if(prev){ // 이전 버튼 
			pagination += `<li class="page-item">
					<a class="page-link" href="${startNum-1}">이전</a></li>`
		}
		for(let pageLink=startNum; pageLink<= endNum ; pageLink++){ // 페이지 버튼
			let active = (pageNum==pageLink) ? 'active':''; // 현재페이지버튼 활성화
			pagination += `<li class="page-item ${active}">
					<a class="page-link" href="${pageLink}">${pageLink}</a></li>`
		}
		if(next){ // 다음 버튼 
			pagination += `<li class="page-item">
					<a class="page-link" href="${endNum+1}">다음</a></li>`
		}
		pagination += '</ul>'
		replyPagination.html(pagination);
	}
	
	let showReply = function(page){
		let param = {bno : bnoVal, page : page||1};
		replyService.getList(param, function(replyCount, list){
			if(page == -1){
				pageNum = Math.ceil(replyCount/10.0);
				showReply(pageNum);
				return;
			};
			if(list==null||list.length==0){
				replyContainer.html('등록된 댓글이 없습니다.');
				return;
			};
			
			let replyList = '';
			$.each(list, function(i, e){
				replyList += `
					<div class="card mb-2">
					  <div class="card-header">
					  	<div class="d-flex justify-content-between">
					  		<div>
						  		${e.replyer}
					  		</div>
					  		<div class="ml-auto">
				 		  		<tf:formatDateTime value="${e.replyRegDate}" pattern="yyyy-MM-dd HH:mm:ss"/><!-- 이거 왜안되는거지 -->
				 		  		${e.replyRegDate[0]}-${e.replyRegDate[1]}-${e.replyRegDate[2]} ${e.replyRegDate[3]}:${e.replyRegDate[4]}:${e.replyRegDate[5]}
					  		</div>
					  		<div class="ml-1">
					  			<a class="text-dark" href="${e.rno}">수정</a>
					  		</div>
					  		<div class="ml-1">
					  			<a class="text-dark" href="${e.rno}">삭제</a>
					  		</div>
					  	</div>
					  </div>
					  <div class="card-body">
					  	${e.reply}
					  </div>
					</div>`
				
			});
			replyContainer.html(replyList);
			replyPage(replyCount);
		});
	}	
	showReply(1);
	
	// 페이지 이동 이벤트
	replyPagination.on('click','li a',function(e){ // 메서드 생성 후 a가 생성돼서 on메서드로 처리해야 함
	//$('.page-link').click(function(e){
		e.preventDefault(e);
		let targetPageNum = $(this).attr('href');
		pageNum = targetPageNum;
		showReply(pageNum);
	});
	
	// 댓글 등록
	$('.replyDiv').on('click', 'button',function(e){
		e.preventDefault();
		let newReply = $('[name="content"]').val();
		console.log(newReply);
		if(!newReply){
			alert('내용을 입력하세요');
			return;
		}
		$('form').attr('action', `${ctxPath}/replies/new`).attr('method', 'post').submit();
	});
	
	
	
});