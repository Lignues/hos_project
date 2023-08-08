package com.hospital.board.repository;

import java.util.List;

import com.hospital.board.domain.BoardVO;
import com.hospital.board.domain.Criteria;

public interface BoardRepository {

	List<BoardVO> showList(Criteria criteria);
	
	BoardVO get(Long bno);
	
	int getTotalCount(Criteria criteria);
	
	int write(BoardVO vo);
	
	int modify(BoardVO vo);
	
	int delete(Long bno);
}
