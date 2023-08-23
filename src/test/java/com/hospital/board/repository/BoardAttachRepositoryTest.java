package com.hospital.board.repository;

import java.util.List;
import java.util.UUID;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.hospital.board.appTest;
import com.hospital.board.domain.BoardAttachVO;

import lombok.extern.log4j.Log4j;

@Log4j
public class BoardAttachRepositoryTest extends appTest{

	@Autowired
	private BoardAttachRepository boardAttachRepository;
	
	@Test
	@Ignore
	public void testInsert() {
		BoardAttachVO vo = new BoardAttachVO();
		vo.setBno(1L);
		vo.setFileName("test01.txt");
		vo.setFileType(false);
		vo.setUploadPath("c:/upload");
		String uuid = UUID.randomUUID().toString();
		vo.setUuid(uuid);
		boardAttachRepository.insert(vo);
	}

	@Test
	@Ignore
	public void testSelectByBno() {
		List<BoardAttachVO> list = boardAttachRepository.selectByBno(1L);
		System.out.println(list);
	}
	
	@Test
	@Ignore
	public void testDelete() { // uuid=0d57bab4-c274-4f4e-ad1d-7ead1fa64cb8
		String uuid = "0d57bab4-c274-4f4e-ad1d-7ead1fa64cb8";
		boardAttachRepository.delete(uuid);
	}
	
}
