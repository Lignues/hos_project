package com.hospital.member.repository;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.hospital.board.appTest;
import com.hospital.member.domain.AuthVO;
import com.hospital.member.domain.MemberVO;

import lombok.extern.log4j.Log4j;

@Log4j
public class MemberRepositoryTest extends appTest{

	@Autowired
	private MemberRepository memberRepository;
	
	@Autowired
	private AuthRepository authRepository;
	
	@Test
	@Ignore
	public void test() {
		MemberVO vo = MemberVO.builder().memberId("admin").memberPwd("1234").memberName("김관리").email("test@naver.com").build();
		memberRepository.insert(vo);
	}

	@Test
	@Ignore
	public void testRead() {
		MemberVO vo = memberRepository.read("scott");
		System.out.println(vo);
	}
	
	@Test
	@Ignore
	public void testAuth() {
		List<AuthVO> list = authRepository.getAuthList("scott");
		System.out.println(list);
	}
	
	@Test
//	@Ignore
	public void banTest() {
		int bannedDay = memberRepository.checkBannedDay("4작성자");
		System.out.println(bannedDay);
	}
}
