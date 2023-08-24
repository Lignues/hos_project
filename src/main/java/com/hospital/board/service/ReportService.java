package com.hospital.board.service;

import java.util.List;

import com.hospital.board.domain.ReportDTO;
import com.hospital.board.domain.ReportVO;

public interface ReportService {
	
	List<ReportDTO> showReportList();
	
	int report(ReportVO vo);
	
	int handleReport(Long bno, int handle);
	
	int totalReportCount();
}
