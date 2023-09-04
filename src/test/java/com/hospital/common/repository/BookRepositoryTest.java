package com.hospital.common.repository;

import static org.junit.Assert.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.hospital.board.appTest;
import com.hospital.common.domain.BookCalendar;
import com.hospital.common.domain.BookVO;
import com.hospital.common.domain.BookableDTO;

import lombok.extern.log4j.Log4j;

@Log4j
public class BookRepositoryTest extends appTest{

	@Autowired
	private BookRepository bookRepository;
	
	@Test
	@Ignore
	public void testbookList() {
		List<BookVO> list = bookRepository.checkBookList(new BookCalendar());
		System.out.println(list);
	}
	
	@Test
	@Ignore
	public void testBookCount() {
		List<BookableDTO> list = bookRepository.countBookList(new BookCalendar());
		System.out.println(list);
	}
	
	
	@Test
	@Ignore
	public void bookingTest() {
		LocalDateTime bookTime = LocalDateTime.of(23, 9, 15, 17, 0);
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yy/MM/dd");

	    String thisBookDate = bookTime.format(dateTimeFormatter); // 오늘날짜
		BookVO vo = BookVO.builder()
					.memberId("test")
					.bookReason("두통")
					.bookDate(thisBookDate)
					.bookTime(bookTime.getHour())
					.build();
		bookRepository.booking(vo);
	}
	
	@Test
	@Ignore
	public void cancelBookingTest() {
		LocalDateTime bookTime = LocalDateTime.of(23, 9, 6, 12, 0);
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yy/MM/dd");

	    String thisBookDate = bookTime.format(dateTimeFormatter); // 오늘날짜
		
		BookVO vo = BookVO.builder()
				.memberId("test")
				.bookDate(thisBookDate)
				.bookTime(bookTime.getHour())
				.build();
		bookRepository.cancelBooking(vo);
	}

	@Test
//	@Ignore
	public void checkBookTimeTest() {
		List<Integer> list = bookRepository.checkBookableTimes("23/09/07");
		System.out.println(list);
	}
	
}
