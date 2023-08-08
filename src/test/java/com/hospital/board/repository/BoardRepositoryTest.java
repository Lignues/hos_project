package com.hospital.board.repository;

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
public class BoardRepositoryTest extends appTest{

	@Autowired
	private BoardRepository boardRepository;
	
	@Test
	@Ignore
	public void testList() {
		List<BoardVO> list = boardRepository.showList(new Criteria());
		System.out.println(list);
	}
	
	@Test
	@Ignore
	public void testget() {
		BoardVO vo = boardRepository.get(2L);
		System.out.println(vo);
	}
	
	@Test
	@Ignore
	public void testTotalCount() {
		int totalCount = boardRepository.getTotalCount(new Criteria());
		System.out.println(totalCount);
	}

	@Test
	@Ignore
	public void testWrite() {
		BoardVO vo = BoardVO.builder().title("repotesttitle").content("repotestcont").writer("repowriter").build();
		int vos = boardRepository.write(vo);
		System.out.println(vos);
	}
	
	@Test
	@Ignore
	public void testModify() {
		BoardVO vo = BoardVO.builder().title("수정제목").content("수정내용").bno(160L).build();
		int vos = boardRepository.modify(vo);
		System.out.println(vos);
	}
	
	@Test
	@Ignore
	public void testRemove() {
		Long bno = 169L;
		boardRepository.delete(bno);
	}
}
