package com.hospital.member.repository;

import com.hospital.member.domain.ViewedDTO;

public interface ViewedRepository {

	void viewed(ViewedDTO viewedDTO);
	
	ViewedDTO getViewed(ViewedDTO viewedDTO); 
	
	int[] viewedList(String memberId);
}
