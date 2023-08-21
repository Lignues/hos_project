package com.hospital.member.repository;

import com.hospital.member.domain.MemberVO;

public interface MemberRepository {

	MemberVO read(String memberId);
	
	void insert(MemberVO vo);
	
	void update(MemberVO vo);

	MemberVO selectById(String memberId);
	
	String selectByEmail(String email);
	
}
