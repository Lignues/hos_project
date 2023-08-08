package com.hospital.board.service;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.hospital.board.appTest;
import com.hospital.board.domain.BoardVO;
import com.hospital.board.domain.Criteria;

import lombok.extern.log4j.Log4j;

@Log4j
public class BoardServiceImplTest extends appTest{

	@Autowired
	private BoardService boardService; 
	
	@Test
	@Ignore
	public void testList() {
		List<BoardVO> list = boardService.showList(new Criteria());
		System.out.println(list);
	}
	
	@Test
	@Ignore
	public void testget() {
		BoardVO vo = boardService.get(50L);
		System.out.println(vo);
	}

	@Test
	@Ignore
	public void testWrite() {
		BoardVO vo = BoardVO.builder().title("repotesttitle").content("repotestcont").writer("repowriter").build();
		int vos = boardService.write(vo);
		System.out.println(vos);
	}
	
	@Test
	@Ignore
	public void testModify() {
		BoardVO vo = BoardVO.builder().title("수정제목1").content("수정내용1").bno(160L).build();
		int vos = boardService.modify(vo);
		System.out.println(vos);
	}
	
	@Test
	@Ignore
	public void testRemove() {
		Long bno = 168L;
		boardService.delete(bno);
	}
}
