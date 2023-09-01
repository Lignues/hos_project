package com.hospital.common.security;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import com.hospital.member.repository.MemberRepository;

import lombok.extern.log4j.Log4j;

@Component
@Log4j
public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler{
	
	@Autowired
	private MemberRepository memberRepository;
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		if (exception.getMessage().equals("정지된 사용자입니다.")) {
			String memberId = request.getParameter("memberId");
			request.setAttribute("memberId", memberId);
			request.setAttribute("LoginFail", "사용이 정지된 사용자입니다. <br>정지 해제 일시 : " + calcBanDate(memberRepository.checkBannedDay(memberId)));
			
		}
		if (exception instanceof BadCredentialsException) {
			String memberId = request.getParameter("memberId");
			request.setAttribute("memberId", memberId);
			request.setAttribute("LoginFail", "아이디 또는 비밀번호가 일치하지 않습니다.");
		}
		request.getRequestDispatcher("/login").forward(request, response);
	}

	private String calcBanDate(int banDay) { // 정지 해제되는 날 구하기
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 23시59분");
		Calendar calendar = Calendar.getInstance();
		
		Date today = new Date();
		
		calendar.setTime(today);
		calendar.add(Calendar.DAY_OF_YEAR, banDay);
		Date unbanDate = calendar.getTime();
		
		return sdf.format(unbanDate);
	}
	
}
