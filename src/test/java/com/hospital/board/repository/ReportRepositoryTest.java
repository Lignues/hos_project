package com.hospital.board.repository;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.hospital.board.appTest;
import com.hospital.board.domain.ReportDTO;
import com.hospital.board.domain.ReportVO;

import lombok.extern.log4j.Log4j;

@Log4j
public class ReportRepositoryTest extends appTest{

	@Autowired
	private ReportRepository reportRepository;
	
	@Test
//	@Ignore
	public void testShowReport() {
		List<ReportDTO> list = reportRepository.showReportList();
		System.out.println(list);
	}

	@Test
	@Ignore
	public void testReport() {
		ReportVO vo = ReportVO.builder().bno(1L).reportContent("살려줘").reporter("kim").build();
		reportRepository.report(vo);
	}
	
	@Test
	@Ignore
	public void testHandleReport() {
		int report = reportRepository.handleReport(1L, 0);
		System.out.println(report);
	}
	
}
