package com.hospital.board.repository;

import java.util.List;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.hospital.board.appTest;
import com.hospital.board.domain.Criteria;
import com.hospital.board.domain.ReplyVO;

import lombok.extern.log4j.Log4j;

@Log4j
public class ReplyRepositoryTest extends appTest{

	@Autowired
	private ReplyRepository replyRepository;
	
	@Test
	@Ignore
	public void testReplyList() {
		List<ReplyVO> replyList = replyRepository.replyList(2L, new Criteria());
		System.out.println(replyList);
	}

	@Test
	@Ignore
	public void testReplyInsert() {
		ReplyVO vo = ReplyVO.builder()
						.bno(1L).reply("실험1").replyer("실험자1").build();
		replyRepository.replyWrite(vo);
	}
	
	@Test
	@Ignore
	public void testReplyCount() {
		System.out.println(replyRepository.getReplyCount(1L));
	}
	
	@Test
	@Ignore
	public void testReplyUpdate() {
		ReplyVO vo = ReplyVO.builder().rno(1L).reply("댓글 추가 01 수정했다").build();
		replyRepository.replyUpdate(vo);
	}
	
	@Test
	@Ignore
	public void testGetReply() {
		ReplyVO reply = replyRepository.getReply(1L);
		System.out.println(reply);
	}
	
	@Test
	@Ignore
	public void testdeleteReply() {
		replyRepository.deleteReply(197L);
	}
	
	@Test
	@Ignore
	public void testdeleteReplyByBno() {
		replyRepository.deleteReplyByBno(181L);
	}
}
