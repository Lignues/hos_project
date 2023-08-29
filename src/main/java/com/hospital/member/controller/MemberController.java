package com.hospital.member.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
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
import com.hospital.member.domain.AuthVO;
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
	
	// 마이페이지(정보변경, 최근작성글, 신고내역) 관리자는 회원관리 추가
	@PreAuthorize("isAuthenticated() and hasRole('ROLE_MEMBER')")
	@GetMapping({"mypage" ,"/mypage/{path}"})
	public String mypage(Model model, Principal principal, @PathVariable(required = false) String path, Criteria criteria) {
		String memberId = principal.getName();
		int authSize = memberService.getAuthList(memberId).size();
		
		if(path==null) { // 회원정보 변경 탭
			MemberVO vo = memberService.read(memberId);
			model.addAttribute("vo", vo);
			return "member/mypage";
			
		}else if (path.equals("recent")) { // 최근 작성글
			criteria.setAmount(5);
			List<BoardVO> list = boardService.showListById(criteria, memberId); // 작성글
			model.addAttribute("list", list);
			model.addAttribute("p", new Pagination(criteria, boardService.totalCountById(memberId)));
			
		}else if (path.equals("report")) { // 신고내역
			criteria.setAmount(5);
			List<ReportDTO> list;
			int totalCount = 0;
			if(authSize>=2) { // 관리자-신고내역 다 보기
				list = reportService.showReportList(criteria);
				totalCount = reportService.totalReportCount();
			}else { // 관리자가 아닌 사람-자기가 신고한 내역만 보기
				list = reportService.showReportListByReporter(criteria, memberId);
				totalCount = reportService.totalReportCountById(memberId);
			}
			model.addAttribute("list", list);
			model.addAttribute("p", new Pagination(criteria, totalCount));
			
		}else if(path.equals("control")) { // 회원관리(회원접속금지)
			if(authSize==1) {
				throw new AccessDeniedException("권한이 없습니다.");
			}
			List<MemberVO> list = memberService.memberList(criteria);
			model.addAttribute("list", list);
			model.addAttribute("p", new Pagination(criteria, memberService.totalMemberCount())); // 멤버 토탈카운트 만들것
		}
		return "member/" + path;
	}
	
	// 신고 처리하기
	@PreAuthorize("hasRole('ROLE_MANAGER')")
	@PostMapping(value = "/report/handle", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public ResponseEntity<String> reportHandling(Long bno, String handle){
		if(handle.equals("신고 거부")) {
			System.out.println("거부한거" +reportService.handleReport(bno, 1));
		}else if(handle.equals("삭제 완료")) {
			System.out.println("삭제한거" + reportService.handleReport(bno, 2));
		}
		return new ResponseEntity<String>("게시글 처리 완료", HttpStatus.OK);
	}
	
	
	// 회원정보 변경
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/member/modify")
	public String modify(@ModelAttribute("vo") MemberVO vo, RedirectAttributes rttr, @RequestParam("currentPwd") String currentPwd) {
		boolean checkCurrentPwd = passwordEncoder.matches(currentPwd, memberService.read(vo.getMemberId()).getMemberPwd());
		if (!checkCurrentPwd) { // 정보 변경 시도 중 비밀번호가 일치하지 않을 시
			rttr.addFlashAttribute("boardResult", "현재 비밀번호가 일치하지 않습니다. 다시 확인해 주세요");
		}else {
			memberService.modify(vo);
			rttr.addFlashAttribute("boardResult", "회원정보가 변경되었습니다");
		}
		return "redirect:/mypage";
	}
	
	// 회원 추방
	@PreAuthorize("hasRole('ROLE_MANAGER')")
	@PostMapping(value = "/member/kick", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public ResponseEntity<String> kickMember(String memberId){
		memberService.deleteById(memberId);
		return new ResponseEntity<String>("회원 추방 완료", HttpStatus.OK);
	}
	
	// 회원 탈퇴
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/member/quit")
	public String quitMember(String memberId, RedirectAttributes rttr, HttpServletRequest request, HttpServletResponse response){
		memberService.deleteById(memberId);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		new SecurityContextLogoutHandler().logout(request, response, auth); // 로그아웃
		rttr.addFlashAttribute("boardResult", "탈퇴 완료");
		return "redirect:/";
	}
	
	
	// 권한 변경
	@PreAuthorize("hasRole('ROLE_BOSS')")
	@PostMapping(value = "/member/auth", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public ResponseEntity<String> setAuth(AuthVO authVO){
		memberService.setAuth(authVO);
		return new ResponseEntity<String>("변경 완료", HttpStatus.OK);
	}
	
	
}
