package com.hospital.board.repository;

import java.util.List;

import com.hospital.board.domain.BoardAttachVO;

public interface BoardAttachRepository {

	void insert(BoardAttachVO vo);
	
	void delete(String uuid);
	
	List<BoardAttachVO> selectByBno(Long bno);
}
