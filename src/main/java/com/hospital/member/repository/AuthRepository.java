package com.hospital.member.repository;

import java.util.List;

import com.hospital.member.domain.AuthVO;

public interface AuthRepository {

	void insert(AuthVO vo);
	
	List<AuthVO> getAuthList(String memberId);
	
	void deleteAuthById(String memberId);
}
