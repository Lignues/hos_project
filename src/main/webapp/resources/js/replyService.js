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
		console.log('getList');
		let bno = param.bno;
		$.ajax({
			type : 'get',
			url : `${ctxPath}/replies/list/${bno}`,
			success : function(result){
				if(callback) callback(result);
			},error : function(xhr,status,er){
				if(error) error(er);
			}
		});
	}
}