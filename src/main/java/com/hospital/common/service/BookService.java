package com.hospital.common.service;

import java.util.List;

import com.hospital.common.domain.BookCalendar;
import com.hospital.common.domain.BookVO;
import com.hospital.common.domain.BookableDTO;

public interface BookService {
	
	List<BookVO> checkBookList(BookCalendar bookCalendar);
	
	void booking(BookVO vo);
	
	void cancelBooking(BookVO vo);
	
	List<BookableDTO> countBookList(BookCalendar bookCalendar);
	
	List<Integer> checkBookableTimes(String checkDate);
}
