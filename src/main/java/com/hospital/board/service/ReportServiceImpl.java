package com.hospital.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hospital.board.domain.BoardAttachVO;
import com.hospital.board.domain.Criteria;
import com.hospital.board.domain.ReportDTO;
import com.hospital.board.domain.ReportVO;
import com.hospital.board.repository.BoardAttachRepository;
import com.hospital.board.repository.BoardRepository;
import com.hospital.board.repository.ReplyRepository;
import com.hospital.board.repository.ReportRepository;

@Service
public class ReportServiceImpl implements ReportService {

	@Autowired
	private	ReportRepository reportRepository;
	
	@Autowired
	private BoardRepository boardRepository;
	
	@Autowired
	private ReplyRepository replyRepository;
	
	@Autowired
	private BoardAttachRepository boardAttachRepository;
	
	@Override
	public List<ReportDTO> showReportList(Criteria criteria) {
		return reportRepository.showReportList(criteria);
	}

	@Override
	public int report(ReportVO vo) {
		return reportRepository.report(vo);
	}

	@Transactional
	@Override
	public int handleReport(Long bno, int handle) { // handle값 0=미처리, 1=처리완료(삭제안함), 2=처리완료(삭제)
		if(handle==2) {
			List<BoardAttachVO> attachList = boardAttachRepository.selectByBno(bno);
			if(attachList!=null) {
				boardAttachRepository.deleteFiles(attachList);
				boardAttachRepository.deleteAll(bno);
			}
			if(replyRepository.getReplyCount(bno)!=0) {
				replyRepository.deleteReplyByBno(bno);
			}
			boardRepository.delete(bno);
		}
		return reportRepository.handleReport(bno, handle);
	}

	@Override
	public int totalReportCount(Criteria criteria) {
		return reportRepository.getTotalReportCount(criteria);
	}

	@Override
	public List<ReportDTO> showReportListByReporter(Criteria criteria, String reporter) {
		return reportRepository.showReportListByReporter(criteria, reporter);
	}

	@Override
	public int totalReportCountById(String reporter, Criteria criteria) {
		return reportRepository.getTotalReportCountById(reporter, criteria);
	}

}
