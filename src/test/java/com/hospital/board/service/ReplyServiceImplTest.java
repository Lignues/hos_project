package com.hospital.board.service;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

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
//	@Ignore
	public void testReplyList() {
		ReplyPageDTO replyList = replyService.replyList(1L, new Criteria());
		System.out.println(replyList);
	}
	
	@Test
	@Ignore
	public void testInsert() {
		ReplyVO vo = ReplyVO.builder()
				.bno(1L).reply("실험2").replyer("실험자2").build();
		int replyWrite = replyService.replyWrite(vo);
		System.out.println(replyWrite);
	}
	
}