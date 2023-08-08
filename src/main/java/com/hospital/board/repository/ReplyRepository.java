package com.hospital.board.repository;

import java.util.List;

import com.hospital.board.domain.ReplyVO;

public interface ReplyRepository {

	public List<ReplyVO> replyList(Long bno);
	
	public int replyWrite(ReplyVO replyVO);
}
