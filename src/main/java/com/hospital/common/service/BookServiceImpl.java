package com.hospital.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hospital.common.domain.BookCalendar;
import com.hospital.common.domain.BookVO;
import com.hospital.common.domain.BookableDTO;
import com.hospital.common.repository.BookRepository;

@Service
public class BookServiceImpl implements BookService {

	@Autowired
	private BookRepository bookRepository;
	
	@Override
	public List<BookVO> checkBookList(BookCalendar bookCalendar) {
		return bookRepository.checkBookList(bookCalendar);
	}

	@Override
	public void booking(BookVO vo) {
		bookRepository.booking(vo);
	}

	@Override
	public void cancelBooking(BookVO vo) {
		bookRepository.cancelBooking(vo);
	}

	@Override
	public List<BookableDTO> countBookList(BookCalendar bookCalendar) {
		return bookRepository.countBookList(bookCalendar);
	}

	@Override
	public List<Integer> checkBookableTimes(String checkDate) {
		return bookRepository.checkBookableTimes(checkDate);
	}

	@Override
	public List<BookVO> bookingListByDate(BookCalendar bookCalendar) {
		return bookRepository.bookingListByDate(bookCalendar);
	}

	@Override
	public List<BookVO> bookingNextListByDate(BookCalendar bookCalendar) {
		return bookRepository.bookingNextListByDate(bookCalendar);
	}

	@Override
	public List<BookVO> bookListByMemberId(BookCalendar bookCalendar, String memberid) {
		return bookRepository.bookListByMemberId(bookCalendar, memberid);
	}

}
