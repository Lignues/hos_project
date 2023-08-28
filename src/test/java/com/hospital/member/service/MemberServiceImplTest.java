package com.hospital.member.service;

import static org.junit.Assert.*;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.hospital.board.appTest;
import com.hospital.member.domain.AuthVO;
import com.hospital.member.domain.MemberVO;
import com.hospital.member.repository.AuthRepository;

import lombok.extern.log4j.Log4j;

@Log4j
public class MemberServiceImplTest extends appTest{

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private AuthRepository authRepository;
	
	@Test
	@Ignore
	public void testJoin() {
		MemberVO vo = MemberVO.builder().memberId("4작성자").memberPwd("1234").memberName("작성자").email("writer@naver.com").build();
		memberService.join(vo);
	}
	
	@Test
//	@Ignore
	public void testAuth() {
		AuthVO vo = new AuthVO("test", "ROLE_BOSS");
		authRepository.insert(vo);
	}
	
}
