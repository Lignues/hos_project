package com.hospital.board.domain;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Builder
public class ReportVO {

	private Long rnum;
	private Long bno;
	private String reportContent;
	private String reporter;
	private int handle;
	
}
