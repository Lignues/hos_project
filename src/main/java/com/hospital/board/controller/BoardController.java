package com.hospital.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
		System.out.println(model);
		model.addAttribute("list", boardService.showList(criteria));
		model.addAttribute("p", new Pagination(criteria, boardService.totalCount(criteria)));
	}
	
	@GetMapping("/get")
	public String get(Long bno, Model model, Criteria criteria) {
		System.out.println(model);
		model.addAttribute("vo", boardService.get(bno));
		return "board/get";
	}
	
	@GetMapping("/write")
	public void goWrite() {}
	
	@PostMapping("/write")
	public String write(BoardVO vo) {
		boardService.write(vo);
		return "redirect:/board/list";
	}
	
	@GetMapping("/modify")
	public void goModify(Long bno, Model model) {
		System.out.println(bno);
		BoardVO vo = boardService.get(bno);
		model.addAttribute("vo", vo);
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO vo) {
		boardService.modify(vo);
		return "redirect:/board/list";
	}
	
	@PostMapping("/delete")
	public String delete(Long bno) {
		boardService.delete(bno);
		return "redirect:/board/list";
	}
}
