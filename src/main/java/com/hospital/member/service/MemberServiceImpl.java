package com.hospital.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hospital.board.domain.Criteria;
import com.hospital.common.exception.PasswordMismatchException;
import com.hospital.member.domain.AuthVO;
import com.hospital.member.domain.MemberAuthDTO;
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
	public List<MemberAuthDTO> memberList(Criteria criteria) {
		return memberRepository.memberList(criteria);
	}

	@Transactional
	@Override
	public void setAuth(AuthVO authVO) { // 권한부여
		authRepository.deleteAuthById(authVO.getMemberId());
		switch (authVO.getAuth()) {
		case "ROLE_BOSS" :
			authVO.setAuth("ROLE_BOSS");
			authRepository.insert(authVO);
		case "ROLE_MANAGER" : 
			authVO.setAuth("ROLE_MANAGER");
			authRepository.insert(authVO);
		case "ROLE_MEMBER" :
			authVO.setAuth("ROLE_MEMBER");
			authRepository.insert(authVO);
			break;
		}
	}

	@Override
	public List<AuthVO> getAuthList(String memberId) {
		return authRepository.getAuthList(memberId);
	}

	@Transactional
	@Override
	public void deleteById(String memberId) {
		authRepository.deleteAuthById(memberId);
		memberRepository.deleteById(memberId);
	}

	@Override
	public int totalMemberCount() {
		return memberRepository.totalMemberCount();
	}

	@Transactional
	@Override
	public Integer changeBanDay(Integer banDay, String memberId) {
		if (banDay==0) {
			memberRepository.cancelBan(memberId);
		}else {
			memberRepository.banById(memberId, banDay);
		}
		return memberRepository.checkBannedDay(memberId);
	}

}
