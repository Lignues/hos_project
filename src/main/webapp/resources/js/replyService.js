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
		let direction = $('[name="direction"]').val();
		
		if(direction=='get'){ // 게시글에서 댓글
			$.ajax({
				type : 'get',
				url : `${ctxPath}/replies/pages/get/${bno}/${page}`,
				success : function(replyPageDTO){
					if(callback) callback(replyPageDTO.replyCount, replyPageDTO.list);
				},error : function(xhr,status,er){
					if(error) error(er);
				}
			});
		}else if(direction=='recent'){ // 최근작성댓글
			let replyer = $('.replyWriterName').val();
			$.ajax({
				type : 'get',
				url : `${ctxPath}/replies/pages/recent/${replyer}/${page}`,
				success : function(replyPageDTO){
					if(callback) callback(replyPageDTO.replyCount, replyPageDTO.list);
				},error : function(xhr,status,er){
					if(error) error(er);
				}
			});
		}
	},
	
	update : function (reply, callback, error){
		$.ajax({
			type : 'put', 
			url : `${ctxPath}/replies/${reply.rno}`, 
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
	
	remove : function(rno,callback,error){
		$.ajax({
			type : 'delete', 
			url : `${ctxPath}/replies/${rno}`, 
			success : function(result){
				if(callback) callback(result);
			}, 
			error : function(xhr, status, er){
				if(error) error(er);
			}
		});
	},
	
	get : function (rno, callback, error){
		$.getJSON(`${ctxPath}/replies/${rno}`,function(data){
			if(callback) callback(data);	
		}).fail(function(xhr, status, er){
			if(error) error(er);
		});
	}
}