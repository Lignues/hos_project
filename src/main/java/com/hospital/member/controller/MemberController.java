package com.hospital.member.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hospital.member.domain.MemberVO;
import com.hospital.member.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	// 로그인폼
	@PreAuthorize("isAnonymous()")
	@RequestMapping("/login")
	public String loginPage(HttpServletRequest request, Authentication authentication, RedirectAttributes rttr) {
		String uri = request.getHeader("Referer"); // 로그인 전 사용자가 보던 페이지
		if(uri!=null && !uri.contains("/login")) {
			request.getSession().setAttribute("prevPage", uri);
		}
		
		if (authentication!=null) {
			rttr.addFlashAttribute("duplicateLogin", "이미 로그인 중입니다.");
			if (uri==null) uri = "/";
			return "redirect:" + uri;
		}
		
		return "member/login";
	}
	
	// 회원가입폼
	@PreAuthorize("isAnonymous()")
	@GetMapping("/member/join")
	public void join(MemberVO vo) {}
	
	// 아이디 중복 검사
	@PostMapping("/member/idCheck")
	@ResponseBody
	public ResponseEntity<Boolean> idCheck(String memberId){
		MemberVO vo = memberService.read(memberId);
		return vo == null ? new ResponseEntity<Boolean>(Boolean.TRUE, HttpStatus.OK) :
				new ResponseEntity<Boolean>(Boolean.FALSE, HttpStatus.OK);
	}
	
	// 마이페이지
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	@GetMapping("/member/mypage")
	public String mypage() {
		return "member/mypage";
	}
	
			
	
}
