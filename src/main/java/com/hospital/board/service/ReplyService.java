package com.hospital.board.service;

import java.util.List;

import com.hospital.board.domain.ReplyVO;

public interface ReplyService {

	public List<ReplyVO> replyList(Long bno);
	
	public int replyWrite(ReplyVO vo);
}
