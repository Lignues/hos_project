package com.hospital.board.service;

import java.util.List;

import com.hospital.board.domain.BoardVO;
import com.hospital.board.domain.Criteria;
import com.hospital.board.domain.LikeDTO;

public interface BoardService {

	public List<BoardVO> showList(Criteria criteria);
	
	public BoardVO get(Long bno);
	
	int totalCount(Criteria criteria);
	
	int write(BoardVO vo);
	
	int modify(BoardVO vo);
	
	int delete(Long bno);
	
	boolean hitLike(LikeDTO likeDTO);
}
