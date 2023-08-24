package com.hospital.board.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReportDTO{

	private Long rnum;
	private Long bno;
	private String reportContent;
	private String reporter;
	private int handle;
	private String title;
	private String content;
	private String writer;
	
}
