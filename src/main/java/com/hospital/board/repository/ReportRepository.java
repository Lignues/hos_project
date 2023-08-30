package com.hospital.board.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hospital.board.domain.Criteria;
import com.hospital.board.domain.ReportDTO;
import com.hospital.board.domain.ReportVO;

public interface ReportRepository {

	List<ReportDTO> showReportList(@Param("criteria") Criteria criteria);
	
	List<ReportDTO> showReportListByReporter(@Param("criteria") Criteria criteria , @Param("reporter") String reporter);
	
	int report(ReportVO vo);
	
	int handleReport(@Param("bno") Long bno, @Param("handle") int handle);
	
	int getTotalReportCount(@Param("criteria") Criteria criteria);
	
	int getTotalReportCountById(@Param("reporter") String reporter, @Param("criteria") Criteria criteria);
}
