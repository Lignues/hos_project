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
		
		let pagination = '<ul class="pagination">';
		
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
					<div class="card">
					  <div class="card-header">
					  	<div class="d-flex justify-content-between">
					  		<div>
						  		${e.replyer}
					  		</div>
					  		<div>
				 		  		<tf:formatDateTime value="${e.replyRegDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
					  		</div>
					  	</div>
					  </div>
					  <div class="card-body">
					  	${e.reply}
					  </div>
					</div>`
				
			});
			replyContainer.html(replyList);
		});
	}	
	showReply(1);
});