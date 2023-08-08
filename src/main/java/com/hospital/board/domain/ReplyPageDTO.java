package com.hospital.board.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
public class ReplyPageDTO {

	private int replyCount;
	private List<ReplyVO> list;
}
