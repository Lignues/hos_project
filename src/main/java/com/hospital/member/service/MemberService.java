package com.hospital.member.service;

import java.util.List;
import java.util.Map;

import com.hospital.member.domain.AuthVO;
import com.hospital.member.domain.MemberVO;

public interface MemberService {

	void join(MemberVO vo);
	
	void modify(MemberVO vo);
	
	MemberVO read(String memberId);
	
	List<MemberVO> memberList();
	
	void setAuth(AuthVO authVO);
}
