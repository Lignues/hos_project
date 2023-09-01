package com.hospital.common.domain;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BookCalendar { // 이렇게 만들어도 되나? 아니면 생성자에 때려박아야 하나? 생성자에 해야되는 거 같다 옮겨라... 

	private LocalDateTime today = LocalDateTime.now();
	private DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy/MM/dd/HH");

    private String thisDate = today.format(dateTimeFormatter); // 오늘날짜
	
	private int thisYear = today.getYear();
	private int thisMonth = today.getMonthValue();
	private int thisDays = today.getDayOfMonth();
	private int thisHour = today.getHour();
	private int firstDOW = LocalDateTime.of(thisYear, thisMonth, 1, 0, 0).getDayOfWeek().getValue(); // 1일의 요일. 1:월 7:일
	
	private int bookableDate = thisDays+14;
	
	private int lastDay = LocalDateTime.of(thisYear, thisMonth, 1, 0, 0).plusMonths(1).minusDays(1).getDayOfMonth(); // 마지막 일
	private int lastDOW = LocalDateTime.of(thisYear, thisMonth, 1, 0, 0).plusMonths(1).minusDays(1).getDayOfWeek().getValue(); // 마지막 요일

	// 다음달
	LocalDateTime nextMonthDay = LocalDateTime.now();
	
	String nextMonthDate = today.format(dateTimeFormatter); // 다음달날짜
	
	private int nextMonthYear = today.getYear();
	private int nextMonthMonth = today.getMonthValue();
	private int nextMondthDays = today.getDayOfMonth();
	private int nextMonthBookableDate = 0;
	 
	private int nextMonthLastDay = LocalDateTime.of(nextMonthYear, nextMonthMonth, 1, 0, 0).plusMonths(1).minusDays(1).getDayOfMonth(); // 다음달 마지막 일
	private int nextMonthLastDOW = LocalDateTime.of(nextMonthYear, nextMonthMonth, 1, 0, 0).plusMonths(1).minusDays(1).getDayOfWeek().getValue(); // 다음달 마지막 요일

	public BookCalendar() {
		if(this.thisDays+14 > lastDay) {
			int tempDate = bookableDate;
			bookableDate = lastDay;
			nextMonthBookableDate = tempDate - lastDay;
		}
	}
}
