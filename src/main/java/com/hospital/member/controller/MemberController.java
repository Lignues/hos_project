package com.hospital.member.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hospital.board.domain.BoardVO;
import com.hospital.board.domain.Criteria;
import com.hospital.board.domain.Pagination;
import com.hospital.board.domain.ReportDTO;
import com.hospital.board.service.BoardService;
import com.hospital.board.service.ReportService;
import com.hospital.common.exception.PasswordMismatchException;
import com.hospital.member.domain.MemberVO;
import com.hospital.member.service.MailSendService;
import com.hospital.member.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private ReportService reportService;
	
	@Autowired
	private MailSendService mailSendService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	// 로그인
	@RequestMapping("/login")
	public String loginPage(HttpServletRequest request, Authentication authentication, RedirectAttributes rttr) {
		String uri = request.getHeader("Referer"); // 로그인 전 사용자가 보던 페이지
		if(uri!=null && !uri.contains("/login") && !uri.contains("/join")) {
			request.getSession().setAttribute("prevPage", uri);
		}
		if (authentication!=null) {
			rttr.addFlashAttribute("duplicateLogin", "이미 로그인 중입니다.");
			if (uri==null) uri = "/";
			return "redirect:" + uri;
		}
		return "member/login";
	}
	
	// --------회원가입 관련---------
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
	
	// 이메일 인증
	@PreAuthorize("isAnonymous()")
	@GetMapping("/mailCheck")
	@ResponseBody
	public String mailCheck(String email) {
		return mailSendService.joinEmail(email);
	}
	
	// 회원가입 처리
	@PreAuthorize("isAnonymous()")
	@PostMapping("/member/join")
	public String join(MemberVO vo, RedirectAttributes rttr) {
		memberService.join(vo);
		rttr.addFlashAttribute("boardResult", "회원가입이 완료되었습니다. 다시 로그인 해주세요");
		return "redirect:/";
	}// ----- 회원가입 관련 끝 -------
	
	// 아이디 비밀번호 찾기
	// 아이디 찾기 페이지
	@PreAuthorize("isAnonymous()")
	@GetMapping("/findMemberInfo")
	public String findMemberInfo() {
		return "member/findMemberInfo";
	}
	
	// 아이디 찾기 처리
	@PreAuthorize("isAnonymous()")
	@PostMapping("/findMemberId")
	public String submitFindMemberInfo(MemberVO vo, RedirectAttributes rttr) {
		String message = mailSendService.findId(vo.getEmail(), vo.getMemberName());
		if(!message.contains("전송")) {
			rttr.addFlashAttribute("boardResult", message);
			return "redirect:/findMemberInfo";
		}
		rttr.addFlashAttribute("boardResult", message);
		return "redirect:/login";
	}
	
	// 비밀번호 재발급 처리
	@PreAuthorize("isAnonymous()")
	@PostMapping("/resetPassword")
	public String passwordReset(MemberVO vo, RedirectAttributes rttr) {
		String message = mailSendService.resetPassword(vo.getEmail(), vo.getMemberId());
		if(!message.contains("전송")) {
			rttr.addFlashAttribute("boardResult", message);
			return "redirect:/findMemberInfo";
		}
		rttr.addFlashAttribute("boardResult", message);
		return "redirect:/login";
	} // 아이디 비밀번호 찾기 끝
	
	// 마이페이지
	@PreAuthorize("isAuthenticated() and hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	@GetMapping({"mypage" ,"/mypage/{path}"})
	public String mypage(Model model, Principal principal, @PathVariable(required = false) String path, Criteria criteria) {
		String memberId = principal.getName();
		if(path==null) {
			MemberVO vo = memberService.read(memberId);
			model.addAttribute("vo", vo);
			return "member/mypage";
		}else if (path.equals("recent")) {
			criteria.setAmount(5);
			List<BoardVO> list = boardService.showListById(criteria, memberId); // 작성글
			model.addAttribute("list", list);
			model.addAttribute("p", new Pagination(criteria, boardService.totalCountById(memberId)));
		}else if (path.equals("report")) {
			criteria.setAmount(5);
			List<ReportDTO> list = reportService.showReportList();
			model.addAttribute("list", list);
			model.addAttribute("p", new Pagination(criteria, reportService.totalReportCount()));
		}
		return "member/" + path;
	}
	
	// 회원정보 변경
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/member/modify")
	public String modify(@ModelAttribute("vo") MemberVO vo, RedirectAttributes rttr, @RequestParam("currentPwd") String currentPwd) {
		boolean checkCurrentPwd = passwordEncoder.matches(currentPwd, memberService.read(vo.getMemberId()).getMemberPwd());
		if (!checkCurrentPwd) {
			rttr.addFlashAttribute("boardResult", "현재 비밀번호가 일치하지 않습니다. 다시 확인해 주세요");
		}else {
			memberService.modify(vo);
			rttr.addFlashAttribute("boardResult", "회원정보가 변경되었습니다");
		}
		return "redirect:/mypage";
	}
	
	
}
