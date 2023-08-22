package com.hospital.board.service;

import static org.junit.Assert.*;

import java.util.Iterator;
import java.util.List;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.hospital.board.appTest;
import com.hospital.board.domain.Criteria;
import com.hospital.board.domain.ReplyPageDTO;
import com.hospital.board.domain.ReplyVO;

import lombok.extern.log4j.Log4j;

@Log4j
public class ReplyServiceImplTest extends appTest{

	@Autowired
	private ReplyService replyService;
	
	@Test
	@Ignore
	public void testReplyList() {
		ReplyPageDTO replyList = replyService.replyList(1L, new Criteria());
		System.out.println(replyList);
	}
	
	@Test
	@Ignore
	public void testInsert() {
		ReplyVO vo = ReplyVO.builder()
				.bno(194L).reply("실험2").replyer("scott").build();
		for (int i = 0; i < 102; i++) {
			replyService.replyWrite(vo);
		}
		
	}
	
	@Test
	@Ignore
	public void testReplyUpdate() {
		ReplyVO vo = ReplyVO.builder().rno(1L).reply("댓글 추가 02 수정했다두번").build();
		replyService.replyUpdate(vo);
	}
	
	@Test
	@Ignore
	public void testGetReply() {
		ReplyVO reply = replyService.getReply(1L);
		System.out.println(reply);
		
	}
	
	@Test
	@Ignore
	public void testdeleteReply() {
		replyService.deleteReply(195L);
	}
	
	
}

