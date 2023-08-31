package com.hospital.common.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import com.hospital.common.exception.BannedUserException;
import com.hospital.member.domain.MemberVO;
import com.hospital.member.repository.AuthRepository;
import com.hospital.member.repository.MemberRepository;

@Component
public class CustomUserDetailService implements UserDetailsService{

	@Autowired
	private MemberRepository memberRepository;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException, BannedUserException  {
		MemberVO vo = memberRepository.read(username);
		
		if(vo==null) {
			throw new UsernameNotFoundException("User not found with username : " + username);
		}
		
		int bannedDay = memberRepository.checkBannedDay(vo.getMemberId()); // 정지기간
		if (bannedDay > 0) {
			throw new BannedUserException("정지된 사용자입니다.");
		}
		
		return new CustomUser(vo);
	}

}
