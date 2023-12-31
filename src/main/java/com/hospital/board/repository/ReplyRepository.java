package com.hospital.board.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hospital.board.domain.Criteria;
import com.hospital.board.domain.ReplyVO;

public interface ReplyRepository {

	public List<ReplyVO> replyList(@Param("bno") Long bno, @Param("criteria") Criteria criteria);
	
	public List<ReplyVO> replyListById(@Param("replyer") String replyer, @Param("criteria") Criteria criteria);
	
	public int replyWrite(ReplyVO replyVO);
	
	public int replyUpdate(ReplyVO replyVO);
	
	int getReplyCount(Long bno);
	
	int getReplyCountById(String replyer);
	
	ReplyVO getReply(Long rno);
	
	int deleteReply(Long rno);
	
	int deleteReplyByBno(Long Bno);
}
