$(function(){
	let result = '${result}';
	let pageForm = $('.pageForm');
	let searchForm = $('#searchForm');
	
	// 클릭시 해당 글로 이동
	$('.go').click(function(e){
		e.preventDefault();
		bnoValue = $(this).attr('href');
		pageForm.append($('<input>',{type:'hidden', name:'bno', value : bnoValue}))
			.attr('action', `${ctxPath}/board/get`)
			.submit();
	});
	
	// 페이지 이동
	$('.pagination a').click(function(e){
		e.preventDefault();
		let pageNum = $(this).attr('href');
		pageForm.find('input[name="pageNum"]').val(pageNum);
		pageForm.submit();
	});
	
	// 검색
	$('#searchForm button').click(function(e){
		e.preventDefault();
		if(!searchForm.find('option:selected').val()){
			alert('검색종류를 선택하세요');
			return;
		}
		if(!searchForm.find('[name="keyword"]').val()){
			alert('키워드를 선택하세요');
			return;
		}
		searchForm.find('[name="pageNum"]').val(1);
		searchForm.submit();
	});
	
	// 글쓰기 이동
	$('.writeBtn').click(function(){
		pageForm.attr('action', `${ctxPath}/board/write`);
		pageForm.submit();
	});
	
});