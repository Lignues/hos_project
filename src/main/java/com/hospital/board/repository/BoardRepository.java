package com.hospital.board.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import com.hospital.board.domain.BoardVO;
import com.hospital.board.domain.Criteria;

public interface BoardRepository {

	List<BoardVO> showList(Criteria criteria);
	
	BoardVO get(Long bno);
	
	int getTotalCount(Criteria criteria);
	
	int getTotalCountById(String writer);
	
	int write(BoardVO vo);
	
	int modify(BoardVO vo);
	
	int delete(Long bno);
	
	void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
	
	void updateLikeCnt(@Param("bno") Long bno, @Param("amount") int amount);
	
	List<BoardVO> showListById(@Param("criteria") Criteria criteria, @Param("writer") String writer);
}
