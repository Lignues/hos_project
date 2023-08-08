package com.hospital.board.service;

import java.util.List;

import com.hospital.board.domain.Criteria;
import com.hospital.board.domain.ReplyPageDTO;
import com.hospital.board.domain.ReplyVO;

public interface ReplyService {

	public ReplyPageDTO replyList(Long bno, Criteria criteria);
	
	public int replyWrite(ReplyVO vo);
}
