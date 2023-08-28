package com.hospital.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hospital.common.exception.PasswordMismatchException;
import com.hospital.member.domain.AuthVO;
import com.hospital.member.domain.MemberVO;
import com.hospital.member.repository.AuthRepository;
import com.hospital.member.repository.MemberRepository;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberRepository memberRepository; 
	
	@Autowired
	private AuthRepository authRepository;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	
	@Transactional
	@Override
	public void join(MemberVO vo) {
		vo.setMemberPwd(passwordEncoder.encode(vo.getMemberPwd()));
		AuthVO authVO = new AuthVO(vo.getMemberId(), "ROLE_MEMBER");
		memberRepository.insert(vo);
		authRepository.insert(authVO);
	}

	@Transactional
	@Override
	public void modify(MemberVO vo) {
		vo.setMemberPwd(passwordEncoder.encode(vo.getMemberPwd()));
		memberRepository.update(vo);
	}

	@Override
	public MemberVO read(String memberId) {
		return memberRepository.selectById(memberId);
	}

	@Override
	public List<MemberVO> memberList() {
		return memberRepository.memberList();
	}

	@Override
	public void setAuth(AuthVO authVO) {
		authRepository.insert(authVO);
	}


}
