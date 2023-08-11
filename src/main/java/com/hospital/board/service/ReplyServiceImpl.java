package com.hospital.board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hospital.board.domain.Criteria;
import com.hospital.board.domain.ReplyPageDTO;
import com.hospital.board.domain.ReplyVO;
import com.hospital.board.repository.ReplyRepository;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyRepository replyRepository;
	
	@Override
	public ReplyPageDTO replyList(Long bno, Criteria criteria) {
		return new ReplyPageDTO(replyRepository.getReplyCount(bno), replyRepository.replyList(bno, criteria));
	}

	@Override
	public int replyWrite(ReplyVO vo) {
		return replyRepository.replyWrite(vo);
	}

	@Override
	public int replyUpdate(ReplyVO vo) {
		return replyRepository.replyUpdate(vo);
	}

	@Override
	public ReplyVO getReply(Long rno) {
		return replyRepository.getReply(rno);
	}

	@Override
	public int deleteReply(Long rno) {
		return replyRepository.deleteReply(rno);
	}

	
}
