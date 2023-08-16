package com.hospital.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hospital.board.domain.BoardVO;
import com.hospital.board.domain.Criteria;
import com.hospital.board.repository.BoardRepository;
import com.hospital.board.repository.ReplyRepository;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardRepository boardRepository; 
	
	@Autowired
	private ReplyRepository replyRepository;
	
	@Override
	public List<BoardVO> showList(Criteria criteria) {
		return boardRepository.showList(criteria);
	}

	@Override
	public BoardVO get(Long bno) {
		return boardRepository.get(bno);
	}

	@Override
	public int totalCount(Criteria criteria) {
		return boardRepository.getTotalCount(criteria);
	}

	@Override
	public int write(BoardVO vo) {
		return boardRepository.write(vo);
	}

	@Override
	public int modify(BoardVO vo) {
		return boardRepository.modify(vo);
	}

	@Override
	public int delete(Long bno) {
		return boardRepository.delete(bno);
	}

}
