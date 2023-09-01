package com.hospital.member.service;

import java.util.List;
import java.util.Map;

import com.hospital.board.domain.Criteria;
import com.hospital.member.domain.AuthVO;
import com.hospital.member.domain.MemberAuthDTO;
import com.hospital.member.domain.MemberVO;

public interface MemberService {

	void join(MemberVO vo);
	
	void modify(MemberVO vo);
	
	MemberVO read(String memberId);
	
	List<MemberAuthDTO> memberList(Criteria criteria);
	
	void setAuth(AuthVO authVO);
	
 	List<AuthVO> getAuthList(String memberId);
 	
 	void deleteById(String memberId);
 	
 	int totalMemberCount();
 	
 	Integer changeBanDay(Integer banDay, String memberId);
}
