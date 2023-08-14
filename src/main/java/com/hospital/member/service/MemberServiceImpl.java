package com.hospital.member.service;

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

	@Override
	public void modify(MemberVO vo) {
		memberRepository.update(vo);
	}

	@Override
	public MemberVO read(String memberId) {
		return memberRepository.selectById(memberId);
	}

	@Transactional
	@Override
	public void changePassword(Map<String, String> memberMap) {
		String memberId = memberMap.get("memberId");
		String newPwd = memberMap.get("newPwd"); // 새로운 비밀번호(변경후) 4567
		String currentPwd = memberMap.get("currentPwd"); // 현재 비밀번호(변경전) 1234
		MemberVO vo = memberRepository.selectById(memberId);
		
		if (!passwordEncoder.matches(currentPwd, vo.getMemberPwd())) {
			throw new PasswordMismatchException();
		}
		memberRepository.updatePassword(memberId, passwordEncoder.encode(newPwd));
	}

}
