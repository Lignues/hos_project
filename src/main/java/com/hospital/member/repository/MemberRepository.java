package com.hospital.member.repository;

import org.apache.ibatis.annotations.Param;

import com.hospital.member.domain.MemberVO;

public interface MemberRepository {

	MemberVO read(String memberId);
	
	void insert(MemberVO vo);
	
	void update(MemberVO vo);

	MemberVO selectById(String memberId);
	
	String selectByEmail(String email);
	
	void updatePassword(
			@Param("memberId") String memberId,  
			@Param("memberPwd") String memberPwd);
}
