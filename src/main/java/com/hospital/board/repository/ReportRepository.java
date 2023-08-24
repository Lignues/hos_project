package com.hospital.board.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hospital.board.domain.ReportDTO;
import com.hospital.board.domain.ReportVO;

public interface ReportRepository {

	List<ReportDTO> showReportList();
	
	int report(ReportVO vo);
	
	int handleReport(@Param("bno") Long bno, @Param("handle") int handle);
	
	int getTotalReportCount();
}
