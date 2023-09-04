package com.hospital.common.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hospital.common.domain.BookCalendar;
import com.hospital.common.domain.BookVO;
import com.hospital.common.domain.BookableDTO;

public interface BookRepository {

	List<BookVO> checkBookList(@Param("book") BookCalendar bookCalendar);
	
	void booking(BookVO vo);
	
	void cancelBooking(BookVO vo);
	
	List<BookableDTO> countBookList(@Param("book") BookCalendar bookCalendar);
	
	List<Integer> checkBookableTimes(String CheckDate);
}
