package com.hospital.board.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.hospital.board.domain.BoardAttachVO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@RestController
@Log4j
@RequestMapping("/files")
public class FileUploadController {

	// 파일 업로드
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/upload")
	public ResponseEntity<List<BoardAttachVO>> upload(@RequestParam("uploadFile") MultipartFile[] multipartFiles) {
		List<BoardAttachVO> list = new ArrayList<BoardAttachVO>(); 
		File uploadPath = new File("C:/storage", getFolder());
		if(!uploadPath.exists()) {
			uploadPath.mkdirs(); 
		}
		for(MultipartFile multipartFile : multipartFiles) {
			BoardAttachVO attachVO = new BoardAttachVO();  

			String filName = multipartFile.getOriginalFilename(); // 파일이름
			String uuid = UUID.randomUUID().toString();
			File saveFile = new File(uploadPath,uuid + "_" + filName);
			
			log.info("filName : " + filName);
			log.info("savFile : " + saveFile);
			
			attachVO.setFileName(filName); 
			attachVO.setUuid(uuid);
			attachVO.setUploadPath(getFolder());
			
			try {
				if(checkImageType(saveFile)) { // 이미지일시 썸네일 생성
					attachVO.setFileType(true);
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath,"s_"+uuid+"_"+filName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 40, 40);
				}
				multipartFile.transferTo(saveFile); // 파일 저장
				list.add(attachVO);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} 
		}
		return new ResponseEntity<List<BoardAttachVO>>(list, HttpStatus.OK); 
	}
	
	// 썸네일 표시
	@GetMapping("/display")
	public ResponseEntity<byte[]> getFile(String fileName){
		File file = new File("C:/storage/"+fileName);
		ResponseEntity<byte[]> result = null;
		
		HttpHeaders headers = new HttpHeaders();
		try {
			headers.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}

	// 파일 삭제
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(BoardAttachVO vo){
		File file = new File("C:/storage/" + vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName());
		log.info(file);
		file.delete();
		if(vo.isFileType()) { // 섬네일 있을시 섬네일 제거
			file = new File("C:/storage/" + vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName());
		}
		return new ResponseEntity<String>("삭제 성공", HttpStatus.OK);
	}
	
	// 파일 다운로드
	@GetMapping("/download")
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName){
		Resource resource = new FileSystemResource("C:/storage/" + fileName);
		HttpHeaders headers = new HttpHeaders();
		
		if(!resource.exists()) {
			System.out.println("파일없음");
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		}
		String resourceName = resource.getFilename();
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_")+1); // 섬네일의 원래 파일명
		String downloadName = null;
		try {
			downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
			headers.add("Content-Disposition", "attachment; fileName=" + downloadName); // 다운로드시에 저장되는 이름
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<>(resource, headers, HttpStatus.OK);
	}
	
	// 이미지 파일 체크 여부
	private boolean checkImageType(File file) throws IOException {
		String contentType = Files.probeContentType(file.toPath());
		return contentType != null ? contentType.startsWith("image") : false;
	}

	// 날짜별 디렉토리 생성 
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		return sdf.format(new Date());  
	}
}
