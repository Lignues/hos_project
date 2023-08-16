package com.hospital.board.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hospital.board.domain.BoardVO;
import com.hospital.board.domain.Criteria;

public interface BoardRepository {

	List<BoardVO> showList(Criteria criteria);
	
	BoardVO get(Long bno);
	
	int getTotalCount(Criteria criteria);
	
	int write(BoardVO vo);
	
	int modify(BoardVO vo);
	
	int delete(Long bno);
	
	void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
	
	void updateLikeCnt(@Param("bno") Long bno, @Param("amount") int amount);
}
