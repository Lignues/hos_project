package com.hospital.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hospital.member.domain.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {

	@GetMapping("/join")
	public void join(MemberVO vo) {}
}
