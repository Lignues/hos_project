$(function(){
	let bnoVal = $('input[name="bno"]').val();
	let replyContainer = $('.reply');
	let pageNum = 1;
	let replyPagination = $('.replyPagination');
	let replyerName = $('.replyWriterName').val();
	
	// 댓글 페이징
	let replyPage = function(replyCount){
		let pagePow = 1;
		if($('[name="direction"]').val()=='recent') pagePow=2; // 최근글보기에서 페이지 갯수 2배
		let endNum = Math.ceil(pageNum/10.0)*10;
		let startNum = endNum - 10 +1;
		let tempEndNum = Math.ceil(replyCount/10.0*pagePow);
		
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
	
	// 댓글 목록 보기
	let showReply = function(page){
		let param = {bno : bnoVal, page : page||1};
		replyService.getList(param, function(replyCount, list){
			let replyList = '';
			
			if($('[name="direction"]').val()=='recent'){ // 최근작성글 글보기 양식
				if(list==null||list.length==0){
					replyContainer.html('등록된 댓글이 없습니다.');
					return;
				};
				replyList = `<table class="table-sm table-hover">
								<thead>
							      <tr>
							        <th>댓글내용</th>
							        <th>작성일</th>
							      </tr>
							    </thead>`;
				$.each(list, function(i, e){
					replyList += `
						  <tbody>
  					        <tr>
							  <div class="replyData mb-2" data-rno="${e.rno}" data-reply="${e.reply}" data-replyer="${e.replyer}">
						        <td class="col-1"><a class="goBoard text-dark" href="${e.bno}">${e.reply}</a></td>
						        <td class="col-1">${timeFormat(e.replyRegDate)}</td>
							  </div>
						    </tr>
						  </tbody>
				`});
				replyList += `</table>`;
				replyContainer.html(replyList);
				replyPage(replyCount);
				return;
			}
			
			if(page == -1){
				pageNum = Math.ceil(replyCount/10.0);
				showReply(pageNum);
				return;
			};
			if(list==null||list.length==0){
				replyContainer.html('등록된 댓글이 없습니다.');
				return;
			};
			
			$.each(list, function(i, e){
				replyList += `
					<div class="replyData card mb-2" data-rno="${e.rno}" data-reply="${e.reply}" data-replyer="${e.replyer}">
					  <div class="card-header">
					  	<div class=d-flex justify-content-between">
					  		<div class="${e.replyer=='admin' ? 'text-primary' : ''}">
						  		${e.replyer}
					  		</div>
					  		<div  class="ml-auto">
				 		  		${timeFormat(e.replyRegDate)}
					  		</div>`
					  		if(e.replyer==replyerName){
					  		replyList +=`
						  		<div class="ml-1">
						  			<a class="modifyReply text-dark" href="#">✏ 수정</a>
						  		</div>
						  		<div class="deleteDiv ml-1">
						  			<a class="deleteReply text-dark" href="#">🗑 삭제</a>
						  		</div>`
					  		}
					  		replyList +=`
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
		e.preventDefault(e);
		let targetPageNum = $(this).attr('href');
		pageNum = targetPageNum;
		showReply(pageNum);
	});
	
	// 댓글 등록
	$('.replyWriterForm').on('click', '.replySubmit',function(e){
		e.preventDefault();
		let replyContent = $(this).closest('.replyWriterForm').find('textarea').val();
		let reply = {
			bno : bnoVal,
			reply : replyContent,
			replyer : replyerName
		};
		if(replyContent.length==0){
			alert('내용을 입력하세요');
			return;
		}
		replyService.add(reply, function(result){
			showReply(-1);
			alert(result);
		});
		$(this).closest('.replyWriterForm').find('[name="content"]').val('');
	});
	
	// 댓글 삭제
	$('.reply').on('click', '.deleteReply', function(e){
		e.preventDefault();
		let rno = $(this).closest('.replyData').data('rno');
		replyService.remove(rno, function(result){
			alert(result);
		});
		showReply(-1);
	});
	
	// 댓글 수정 폼
	$('.reply').on('click', '.modifyReply', function(e){
		e.preventDefault();
		let replyData = $(this).closest('.replyData');
		let replyRno = replyData.data('rno');
		let replyContent = replyData.data('reply');
		let replyID = replyData.data('replyer');
		let replyUpdateForm = $('.replyWriterForm').clone(); // 댓글쓰기폼 복사
		replyUpdateForm.attr('class','replyUpdateForm mt-3') // 클래스명 변경
						.find('textarea').removeAttr('placeholder').val(replyContent); 
		let updateBtn = replyUpdateForm.find('.replySubmit')
									.attr('class', 'replyUpdateSubmit btn btn-primary').html('수정'); // 수정처리 버튼
		let replyUpdateFormLength = replyData.find('.replyUpdateForm').length; // 댓글수정폼 존재 여부
		if(replyUpdateFormLength>0) { // 댓글수정폼이 추가되어있다면 
			replyData.find('.replyUpdateForm').remove(); // 기존의 수정폼 삭제
			$(this).html('수정'); // 취소 버튼을 수정버튼으로 
			$(this).closest('div').next().find('a').show(); // 삭제 버튼 다시 보이게 
			return;
		} 
			
		$(this).closest('.replyData').append(replyUpdateForm); // 아래에 추가
		$(this).html('취소'); // 수정 버튼을 취소버튼으로 변경
		$(this).closest('div').next().find('a').hide(); // 삭제 버튼 숨김
		
		// 댓글 수정 처리
		updateBtn.click(function(){
			let replyVO = {rno : replyRno,
						 reply : $(this).closest('.replyUpdateForm').find('[name="content"]').val()};
			replyService.update(replyVO, function(result){
				showReply(pageNum);
				alert(result);
			});
		});
	});
	
	// 최근작성댓글 클릭시 해당 글 이동
	$('.reply').on('click', '.goBoard', function(e){
		e.preventDefault();
		$('[name=pageNum]').remove();
		$('[name=amount]').remove();
		let goBoardBno = $(this).attr('href');
		$('.pageForm').append($('<input>',{type:'hidden', name:'bno', value : goBoardBno}))
			.attr('action', `${ctxPath}/board/get`)
			.submit();
	});
		
	// 시간 포매팅
	function timeFormat(date){
		return date[0]+'-'+date[1]+'-'+date[2]+' '+date[3]+':'+date[4]+':'+date[5];
	};
	
	
});