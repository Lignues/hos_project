package com.hospital.board.repository;

import com.hospital.board.domain.LikeDTO;

public interface ArticleLikeRepository {

	void insert(LikeDTO likeDTO);
	
	void delete(LikeDTO likeDTO);
	
	LikeDTO get(LikeDTO likeDTO);
	
}
