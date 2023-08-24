package com.hospital.board.repository;

import java.io.File;
import java.util.List;

import com.hospital.board.domain.BoardAttachVO;

public interface BoardAttachRepository {

	void insert(BoardAttachVO vo);
	
	void delete(String uuid);
	
	List<BoardAttachVO> selectByBno(Long bno);
	
	BoardAttachVO selectByUuid(String uuid);
	
	void deleteAll(Long bno);
	
	List<BoardAttachVO> pastFiles();
	
	// 파일 지우기
	public default void deleteFiles(List<BoardAttachVO> delList) {
		delList.forEach(vo->{
			File file = new File("C:/storage/"+vo.getUploadPath(),vo.getUuid() + "_" + vo.getFileName());
			file.delete();
			if(vo.isFileType()) {
				file = new File("C:/storage/"+vo.getUploadPath(),"s_"+vo.getUuid() + "_" + vo.getFileName());
				file.delete();
			}
		});
	}
}
