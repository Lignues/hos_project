package com.hospital;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.junit.Test;

import com.hospital.board.appTest;

public class tester extends appTest{

	
	
	@Test
	public void test() {
		LocalDateTime today = LocalDateTime.now();
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy/MM/dd/HH");

		String thisDate = today.format(dateTimeFormatter); // 오늘날짜
		
		int thisYear = today.getYear();
		int thisMonth = today.getMonthValue();
		int thisDays = today.getDayOfMonth();
		int thisHour = today.getHour();
		int dow = today.getDayOfWeek().getValue(); // 요일. 1:월 7:일
		
		int lastDay = LocalDateTime.of(thisYear, thisMonth, 1, 0, 0).minusDays(1).getDayOfMonth(); // 마지막 일

		LocalDateTime ldTime = LocalDateTime.of(2023, 9, 1, 0, 0).minusDays(1);
	}
}
