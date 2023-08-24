package com.hospital.board.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.hospital.board.domain.BoardAttachVO;
import com.hospital.board.repository.BoardAttachRepository;

@Component
public class FileCheckTask {

	@Autowired
	private BoardAttachRepository boardAttachRepository;
	
//	@Scheduled(cron = "0/30 * * * * *") // 초 분 시 일 월 (연)
	public void checkFile() {
		// DB에 저장된 파일 정보
		List<BoardAttachVO> fileList = boardAttachRepository.pastFiles();
		
		// 업로드 된 파일
		List<Path> fileListPath = fileList.stream()
				.map(vo->Paths.get("c:/storage", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName()))
				.collect(Collectors.toList());
		
		// 썸네일 파일 경로
		fileList.stream()
			.map(vo->Paths.get("c:/storage", vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName()))
			.forEach(e-> fileListPath.add(e));
		
		// 어제 날짜 폴더 경로
		File targetDir = Paths.get("c:/storage", getYesterdayFolder()).toFile();
		// 어제 날짜 폴더에 있는 모든 파일 순회
		// 데이터베이스에 기록된 파일이 아니면 삭제대상
		File[] delTargetList = targetDir.listFiles(file -> !fileListPath.contains(file.toPath()));
		Arrays.stream(delTargetList).forEach(file->{
			System.out.println(file);
			System.out.println(delTargetList);
			file.delete();
		});
	}
	
	// 어제 날짜의 폴더 경로
	private String getYesterdayFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		Calendar cal = Calendar.getInstance(); 
		cal.add(Calendar.DATE, -1);
		return sdf.format(cal.getTime()); 
	}
}
