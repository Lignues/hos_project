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
//	@Ignore
	public void testJoin() {
		MemberVO vo = MemberVO.builder().memberId("aaaa").memberPwd("1234").memberName("작성자").email("writer@naver.com").build();
		memberService.join(vo);
		vo = MemberVO.builder().memberId("bbbb").memberPwd("1234").memberName("작성자").email("writer@naver.com").build();
		memberService.join(vo);
		vo = MemberVO.builder().memberId("cccc").memberPwd("1234").memberName("작성자").email("writer@naver.com").build();
		memberService.join(vo);
		vo = MemberVO.builder().memberId("dddd").memberPwd("1234").memberName("작성자").email("writer@naver.com").build();
		memberService.join(vo);
		vo = MemberVO.builder().memberId("eeee").memberPwd("1234").memberName("작성자").email("writer@naver.com").build();
		memberService.join(vo);
		vo = MemberVO.builder().memberId("ffff").memberPwd("1234").memberName("작성자").email("writer@naver.com").build();
		memberService.join(vo);
		vo = MemberVO.builder().memberId("gggg").memberPwd("1234").memberName("작성자").email("writer@naver.com").build();
		memberService.join(vo);
		vo = MemberVO.builder().memberId("hhhh").memberPwd("1234").memberName("작성자").email("writer@naver.com").build();
		memberService.join(vo);
		vo = MemberVO.builder().memberId("iiii").memberPwd("1234").memberName("작성자").email("writer@naver.com").build();
		memberService.join(vo);
		vo = MemberVO.builder().memberId("jjjj").memberPwd("1234").memberName("작성자").email("writer@naver.com").build();
		memberService.join(vo);
		vo = MemberVO.builder().memberId("kkkk").memberPwd("1234").memberName("작성자").email("writer@naver.com").build();
		memberService.join(vo);
		vo = MemberVO.builder().memberId("llll").memberPwd("1234").memberName("작성자").email("writer@naver.com").build();
		memberService.join(vo);
		vo = MemberVO.builder().memberId("mmmm").memberPwd("1234").memberName("작성자").email("writer@naver.com").build();
		memberService.join(vo);
		vo = MemberVO.builder().memberId("nnnn").memberPwd("1234").memberName("작성자").email("writer@naver.com").build();
		memberService.join(vo);
		vo = MemberVO.builder().memberId("oooo").memberPwd("1234").memberName("작성자").email("writer@naver.com").build();
		memberService.join(vo);
		vo = MemberVO.builder().memberId("pppp").memberPwd("1234").memberName("작성자").email("writer@naver.com").build();
		memberService.join(vo);
		vo = MemberVO.builder().memberId("qqqq").memberPwd("1234").memberName("작성자").email("writer@naver.com").build();
		memberService.join(vo);
	}
	
	@Test
	@Ignore
	public void testAuth() {
		AuthVO vo = new AuthVO("test", "ROLE_BOSS");
		authRepository.insert(vo);
	}
	
}
