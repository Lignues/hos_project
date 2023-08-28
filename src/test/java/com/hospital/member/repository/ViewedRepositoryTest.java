package com.hospital.member.repository;

import static org.junit.Assert.*;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.hospital.board.appTest;
import com.hospital.member.domain.ViewedDTO;

public class ViewedRepositoryTest extends appTest{

	@Autowired
	private ViewedRepository viewedRepository;
	
	@Test
//	@Ignore
	public void testInsert() {
		viewedRepository.viewed(new ViewedDTO(189L, "scott"));
	}

}
