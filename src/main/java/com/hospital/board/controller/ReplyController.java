package com.hospital.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PostAuthorize;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	
	// 댓글 작성
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/new", produces = "text/plain; charset=utf-8")
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){
		int result = replyService.replyWrite(vo);
		return result==1 ? new ResponseEntity<String>("댓글이 등록되었습니다", HttpStatus.OK) : 
				new ResponseEntity<String>("댓글등록 실패", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 댓글목록 가져오기
	@GetMapping("/pages/{bno}/{page}")
	public ResponseEntity<ReplyPageDTO> replyList(@PathVariable Long bno, @PathVariable int page){
		Criteria criteria = new Criteria(page, 10);
		return new ResponseEntity<>(replyService.replyList(bno, criteria), HttpStatus.OK);
	}
	
	// 댓글 수정
	@PostAuthorize("isAuthenticated() or hasRole('ROLE_ADMIN')")
	@PutMapping(value = "/{rno}", produces = "text/plain; charset=utf-8")
	public ResponseEntity<String> replyUpdate(@PathVariable Long rno, @RequestBody ReplyVO vo){
		vo.setRno(rno);
		System.out.println(vo);
		int result = replyService.replyUpdate(vo);
		return result==1 ? new ResponseEntity<String>("댓글이 수정되었습니다", HttpStatus.OK) :
				new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 댓글 삭제
	@PostAuthorize("isAuthenticated() or hasRole('ROLE_ADMIN')")
	@DeleteMapping(value = "/{rno}", produces = "text/plain; charset=utf-8")
	public ResponseEntity<String> replyDelete(@PathVariable Long rno){
		int result = replyService.deleteReply(rno);
		return result==1 ? new ResponseEntity<String>("댓글이 삭제되었습니다", HttpStatus.OK) :
					new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
				
	}
}
