package com.hospital.board.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hospital.board.domain.BoardVO;
import com.hospital.board.domain.Criteria;
import com.hospital.board.domain.Pagination;
import com.hospital.board.service.BoardService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@GetMapping("/list")
	public void list(Model model, Criteria criteria){
		model.addAttribute("list", boardService.showList(criteria));
		model.addAttribute("p", new Pagination(criteria, boardService.totalCount(criteria)));
	}
	
	@GetMapping("/get")
	public String get(Long bno, Model model, Criteria criteria) {
		BoardVO vo = boardService.get(bno);
		model.addAttribute("vo", boardService.get(bno));
		return "board/get";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/write")
	public void goWrite() {}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/write")
	public String write(BoardVO vo) {
		boardService.write(vo);
		return "redirect:/board/list";
	}
	
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
	
	@PreAuthorize("isAuthenticated() and principal.username== #vo.writer or hasRole('ROLE_ADMIN')")
	@PostMapping("/modify")
	public String modify(BoardVO vo, RedirectAttributes rttr, Criteria criteria) {
		if(boardService.modify(vo)==1) {
			rttr.addAttribute("result", vo.getBno()); // 없어도 될것같다 밑에도
		}
		return "redirect:/board/list"+criteria.getListLink();
	}
	
	@PreAuthorize("isAuthenticated() and principal.username== #writer or hasRole('ROLE_ADMIN')")
	@PostMapping("/delete")
	public String delete(Long bno, RedirectAttributes rttr, Criteria criteria, String writer) {
		if(boardService.delete(bno)==1) {
			rttr.addFlashAttribute("result", bno);
		}
		return "redirect:/board/list"+criteria.getListLink();
	}
}
