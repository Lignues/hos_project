package com.hospital.board.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hospital.board.domain.BoardVO;
import com.hospital.board.domain.Criteria;
import com.hospital.board.domain.Pagination;
import com.hospital.board.service.BoardService;
import com.hospital.board.service.ReplyService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@Autowired
	private ReplyService replyService;
	
	// 글목록 조회
	@GetMapping("/list")
	public void list(Model model, Criteria criteria){
		model.addAttribute("list", boardService.showList(criteria));
		model.addAttribute("p", new Pagination(criteria, boardService.totalCount(criteria)));
	}
	
	// 글 조회
	@GetMapping("/get")
	public String get(Long bno, Model model, Criteria criteria) {
		BoardVO vo = boardService.get(bno);
		model.addAttribute("vo", boardService.get(bno));
		return "board/get";
	}
	
	// 글 작성페이지
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/write")
	public void goWrite() {}
	
	// 글 작성 처리
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/write")
	public String write(BoardVO vo, RedirectAttributes rttr) {
		boardService.write(vo);
		rttr.addAttribute("bno", vo.getBno()); // useGeneratedKeys 사용으로 bno 가져옮
		rttr.addFlashAttribute("boardResult", "글 작성이 완료되었습니다");
		return "redirect:/board/get";
	}
	
	// 글 수정 페이지
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/modify")
	public void goModify(Long bno, Model model, Authentication auth) {
		BoardVO vo = boardService.get(bno);
		String username = auth.getName(); // 인증된 사용자 계정
		if(!vo.getWriter().equals(username) && // 글 작성자가 아닌 경우
				!auth.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"))) { // 관리자가 아닌 경우
			throw new AccessDeniedException("Access denied");
		}
		model.addAttribute("vo", vo);
	}
	
	// 글 수정 처리
	@PreAuthorize("isAuthenticated() and principal.username == #vo.writer or hasRole('ROLE_ADMIN')")
	@PostMapping("/modify")
	public String modify(BoardVO vo, RedirectAttributes rttr) {
		if(boardService.modify(vo)==1) {
			rttr.addAttribute("bno", vo.getBno());
			rttr.addFlashAttribute("boardResult", "수정되었습니다.");
		}
		return "redirect:/board/get";
	}
	
	// 글 삭제
	@Transactional
	@PreAuthorize("isAuthenticated() and principal.username == #writer or hasRole('ROLE_ADMIN')")
	@PostMapping("/delete")
	public String delete(Long bno, RedirectAttributes rttr, String writer) {
		if (replyService.replyList(bno, new Criteria())!=null) { // 댓글이 있으면 해당 bno의 모든 댓글 삭제
			replyService.deleteReplyByBno(bno);
		}
		if(boardService.delete(bno)==1) {
			rttr.addFlashAttribute("boardResult", bno+"번 글이 삭제 되었습니다.");
		}
		return "redirect:/board/list";
	}
	
}
