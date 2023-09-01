package com.hospital.member.task;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.hospital.member.repository.MemberRepository;

@Component
public class BanCheckTask {

	@Autowired
	private MemberRepository memberRepository;
	
//	@Scheduled(cron = "0/30 * * * * *") // 테스팅용 30초마다 발생
//	@Scheduled(cron = "0 59 23 * * *") // 초 분 시 일 월 (연)
	public void checkBan() {
		memberRepository.decreaseBanDay();
		System.out.println("정지일자 갱신 완료");
		
	}
	
}
