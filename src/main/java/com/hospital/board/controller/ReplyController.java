package com.hospital.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.hospital.board.domain.Criteria;
import com.hospital.board.domain.ReplyPageDTO;
import com.hospital.board.domain.ReplyVO;
import com.hospital.board.service.ReplyService;

@RestController
@RequestMapping("/replies")
public class ReplyController {

	@Autowired
	private ReplyService replyService;
	
	@PostMapping("/new")
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){
		int result = replyService.replyWrite(vo);
		return result==1 ? new ResponseEntity<String>("성공", HttpStatus.OK) : 
				new ResponseEntity<String>("실패", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping("/pages/{bno}/{page}")
	public ResponseEntity<ReplyPageDTO> replyList(@PathVariable Long bno, @PathVariable int page){
		Criteria criteria = new Criteria(page, 10);
		return new ResponseEntity<>(replyService.replyList(bno, criteria), HttpStatus.OK);
	}
}
