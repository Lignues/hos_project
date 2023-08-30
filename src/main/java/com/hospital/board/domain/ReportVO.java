package com.hospital.board.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Builder
@AllArgsConstructor
@RequiredArgsConstructor
public class ReportVO {

	private Long rnum;
	private Long bno;
	private String reportContent;
	private String reporter;
	private int handle;
	
}
