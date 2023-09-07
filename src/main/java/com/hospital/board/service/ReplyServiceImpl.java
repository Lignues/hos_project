package com.hospital.board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hospital.board.domain.Criteria;
import com.hospital.board.domain.ReplyPageDTO;
import com.hospital.board.domain.ReplyVO;
import com.hospital.board.repository.BoardRepository;
import com.hospital.board.repository.ReplyRepository;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyRepository replyRepository;
	
	@Autowired
	private BoardRepository boardRepository;
	
	@Override
	public ReplyPageDTO replyList(Long bno, Criteria criteria) {
		return new ReplyPageDTO(replyRepository.getReplyCount(bno), replyRepository.replyList(bno, criteria));
	}
	
	@Transactional
	@Override
	public ReplyPageDTO replyListById(String replyer, Criteria criteria) {
		return new ReplyPageDTO(replyRepository.getReplyCountById(replyer), replyRepository.replyListById(replyer, criteria));
	}

	@Transactional
	@Override
	public int replyWrite(ReplyVO vo) {
		boardRepository.updateReplyCnt(vo.getBno(), 1);
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

	@Transactional
	@Override
	public int deleteReply(Long rno) {
		ReplyVO vo = replyRepository.getReply(rno);
		boardRepository.updateReplyCnt(vo.getBno(), -1);
		return replyRepository.deleteReply(rno);
	}

	@Override
	public int deleteReplyByBno(Long bno) {
		return replyRepository.deleteReplyByBno(bno);
	}

}
