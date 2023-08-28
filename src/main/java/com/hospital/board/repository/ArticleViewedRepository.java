package com.hospital.board.repository;

import com.hospital.member.domain.ViewedDTO;

public interface ArticleViewedRepository {

	ViewedDTO get(ViewedDTO viewedDTO);
	
	int[] viewedList(String memberId);
	
	void viewed(ViewedDTO viewedDTO);
}
