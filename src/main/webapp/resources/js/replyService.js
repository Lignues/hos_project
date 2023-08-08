var replyService = {
	add : function(reply, callback, error){
		console.log('add');
		$.ajax({
			type : 'post',
			url : `${ctxPath}/replies/new`,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result){
				if(callback) callback(result);
			},
			error : function(xhr, status, er){
				if(error) error(er);
			}
		});
	},
	
	getList : function(param, callback, error){
		let bno = param.bno;
		let page = param.page || 1;
		$.ajax({
			type : 'get',
			url : `${ctxPath}/replies/pages/${bno}/${page}`,
			success : function(replyPageDTO){
				if(callback) callback(replyPageDTO.replyCount, replyPageDTO.list);
			},error : function(xhr,status,er){
				if(error) error(er);
			}
		});
	}
}