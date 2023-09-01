package com.hospital.common.domain;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class BookVO {

	private String memberId;
	private String bookReason;
	
	@DateTimeFormat(pattern = "yyyy/MM/dd/HH")
	private LocalDateTime bookTime;
	
}
