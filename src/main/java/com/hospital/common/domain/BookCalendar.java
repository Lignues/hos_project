package com.hospital.common.domain;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BookCalendar {

	private LocalDateTime today = LocalDateTime.of(2023, 9, 26, 0, 0); // 테스트용 날짜
//	private LocalDateTime today = LocalDateTime.now(); 				   // 오늘 날짜
	private LocalDateTime nextDay = LocalDateTime.now().plusDays(1);
	
	private DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yy/MM/dd");

    private String thisDate = today.format(dateTimeFormatter); // 오늘날짜 String
    private String nextDate = nextDay.format(dateTimeFormatter); // 오늘날짜 String
    
	
	private int thisYear = today.getYear();
	private int thisMonth = today.getMonthValue();
	private int thisDays = today.getDayOfMonth();
	private int thisHour = today.getHour();
	private int firstDOW = LocalDateTime.of(thisYear, thisMonth, 1, 0, 0).getDayOfWeek().getValue(); // 1일의 요일. 1:월 7:일
	
	private int bookableDate = thisDays + 13;
	private LocalDateTime bookableDateLocal = today.plusDays(13).withHour(23);
	
	private int lastDay = LocalDateTime.of(thisYear, thisMonth, 1, 0, 0).plusMonths(1).minusDays(1).getDayOfMonth(); // 마지막 일
	private int lastDOW = LocalDateTime.of(thisYear, thisMonth, 1, 0, 0).plusMonths(1).minusDays(1).getDayOfWeek().getValue(); // 마지막 요일

	// 다음달
	LocalDateTime nextMonthDay = LocalDateTime.now().plusMonths(1);
	
	String nextMonthDate = nextMonthDay.format(dateTimeFormatter); // 다음달날짜
	
	private int nextMonthYear = nextMonthDay.getYear();
	private int nextMonthMonth = nextMonthDay.getMonthValue();
	private int nextMonthfirstDOW = LocalDateTime.of(nextMonthYear, nextMonthMonth, 1, 0, 0).getDayOfWeek().getValue(); // 1일의 요일. 1:월 7:일
	private int nextMonthBookableDate;
	 
	private int nextMonthLastDay = LocalDateTime.of(nextMonthYear, nextMonthMonth, 1, 0, 0).plusMonths(1).minusDays(1).getDayOfMonth(); // 다음달 마지막 일
	private int nextMonthLastDOW = LocalDateTime.of(nextMonthYear, nextMonthMonth, 1, 0, 0).plusMonths(1).minusDays(1).getDayOfWeek().getValue(); // 다음달 마지막 요일

	public BookCalendar() {
		if(this.thisDays + 13 > lastDay) {
			int tempDate = bookableDate;
			bookableDate = lastDay;
			nextMonthBookableDate = tempDate - lastDay;
		}
	}
	
}
