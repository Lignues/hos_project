package com.hospital.member.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hospital.board.domain.Criteria;
import com.hospital.member.domain.MemberAuthDTO;
import com.hospital.member.domain.MemberVO;

public interface MemberRepository {

	MemberVO read(String memberId);
	
	void insert(MemberVO vo);
	
	void update(MemberVO vo);

	MemberVO selectById(String memberId);
	
	MemberVO selectByEmailAndName(@Param("email") String email, @Param("memberName") String memberName);
	
	List<MemberAuthDTO> memberList(Criteria criteria);
	
	void deleteById(String memberId);
	
	int totalMemberCount();
	
	int checkBannedDay(String memberId);
	
	void banById(String memberId, int banDay);
}
