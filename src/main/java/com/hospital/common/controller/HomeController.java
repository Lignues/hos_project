package com.hospital.common.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hospital.common.domain.BookCalendar;
import com.hospital.common.domain.BookVO;
import com.hospital.common.domain.BookableDTO;
import com.hospital.common.service.BookService;

@Controller
public class HomeController {

	@Autowired
	private BookService bookService;
	
	@GetMapping("/")
	public String home() {
		return "home";
	}
	
	@GetMapping("/introduce/howToCome")
	public void howToGo() {}
	
	@GetMapping("/introduce/docIntroduce")
	public void docIntroduce() {}
	
	@GetMapping("/introduce/hosIntroduce")
	public void hosIntroduce() {}
	
	@GetMapping("/introduce/subjects")
	public void hosSubjects() {}
	
	@GetMapping("/introduce/book")
	public void book(BookCalendar bookCalendar, @RequestParam(value = "changeMonth", required = false) Integer changeMonth) {
		
	}
	
	@GetMapping("/accessDenied")
	public String accessDenied() {
		return "accessError";
	}
	
	@GetMapping("/introduce/bookableList")
	@ResponseBody
	public ResponseEntity<List<BookableDTO>> bookableList(Integer changeMonth){
		BookCalendar bookCalendar = new BookCalendar(changeMonth);
		return new ResponseEntity<List<BookableDTO>>(bookService.countBookList(bookCalendar), HttpStatus.OK);
	}
	
	@GetMapping("/introduce/bookableTime")
	@ResponseBody
	public ResponseEntity<List<Integer>> bookableTime(String checkDate){
		return new ResponseEntity<List<Integer>>(bookService.checkBookableTimes(checkDate), HttpStatus.OK);
	}
	
	@PostMapping("introduce/booking")
	public String bookingFinish(BookVO vo, RedirectAttributes rttr) {
		bookService.booking(vo);
		rttr.addFlashAttribute("boardResult", "예약이 완료되었습니다");
		return "redirect:/introduce/book";
	}
}
