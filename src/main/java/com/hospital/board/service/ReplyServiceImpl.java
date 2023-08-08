package com.hospital.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hospital.board.domain.ReplyVO;
import com.hospital.board.repository.ReplyRepository;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyRepository replyRepository;
	
	@Override
	public List<ReplyVO> replyList(Long bno) {
		return replyRepository.replyList(bno);
	}

	@Override
	public int replyWrite(ReplyVO vo) {
		return replyRepository.replyWrite(vo);
	}

	
}
