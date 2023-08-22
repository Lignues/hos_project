package com.hospital.member.service;

import java.security.SecureRandom;
import java.util.Random;

import javax.annotation.Generated;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.hospital.member.domain.MemberVO;
import com.hospital.member.repository.MemberRepository;

@Component
@PropertySource(value = "classpath:/database/emailDB.properties") // ignore해놨으니 새로 만들어서 사용할것
public class MailSendService {

	@Autowired
	JavaMailSenderImpl mailSender;
	
	@Autowired
	private MemberRepository memberRepository;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	private int authNumber;
	
	@Value("${email.id}")
	private String emailId;
	
	public void makeRandomNumber() {
		//111111 ~ 999999 (6자리 난수)
		Random r = new Random();
		int checkNum = r.nextInt(888888) + 111111;
		System.out.println("인증번호 : " + checkNum);
		authNumber = checkNum;
	}
		
	// 회원가입 인증 메일 양식 
	public String joinEmail(String email) {
		makeRandomNumber();
		String setFrom = emailId; // 발신자  
		String toMail = email; // 수신자
		String title = "회원 가입 인증 이메일 입니다.";  
		String content = "인증 번호는 " + authNumber + "입니다." + "<br>" + 
			    "해당 인증번호를 인증번호 확인란에 기입하여 주세요."; //이메일 내용 삽입
		mailSend(setFrom, toMail, title, content);
		System.out.println(authNumber);
		return Integer.toString(authNumber);
	}
		
	// 아이디 찾기 메일 양식
	@Transactional
	public String findId(String email, String memberName) {
		MemberVO vo = memberRepository.selectByEmailAndName(email, memberName);
		if (vo==null) {
			return "아이디와 이메일이 일치하지 않습니다. 다시 한번 확인해 주세요";
		}
		String missingId = vo.getMemberId();
		mailSend(emailId, email, "OO병원 아이디 찾기 안내", "분실하신 아이디는 "+ missingId +" 입니다.");
		return "아이디가 이메일로 전송되었습니다";
	}
	
	// 비밀번호 재발급
	@Transactional
	public String resetPassword(String email, String memberId) {
		MemberVO vo = memberRepository.read(memberId);
		if(vo==null) {
			return "존재하지 않는 아이디입니다.";
		}else if (!vo.getEmail().equals(email)) { 
			System.out.println(email);
			System.out.println(vo.getEmail());
			return "아이디와 이메일이 일치하지 않습니다. 다시 한번 확인해 주세요";
		}
		String newPassword = generateTempPassword();
		String encodedPassword = passwordEncoder.encode(newPassword);
		vo.setMemberPwd(encodedPassword);
		memberRepository.update(vo);
		mailSend(emailId, email, "OO병원 비밀번호 재발급 안내", "임시 비밀번호는 "+ newPassword +" 입니다. 로그인 후 꼭 비밀번호를 변경하여 주십시오");
		System.out.println("헬로");
		return "임시 비밀번호가 이메일로 전송되었습니다";
	}
	
	//이메일 전송 메소드
	public void mailSend(String setFrom, String toMail, String title, String content) { 
		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message,true,"utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content,true); // true : html 형식으로 전송
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
	
	// 임시 비밀번호 생성
	public String generateTempPassword() {
		StringBuilder charSb = new StringBuilder();
		for (char c = 48; c < 122; c++) {
			if(c>58 && c<=64 || c>91 && c<=88) continue;
			charSb.append(c);
		}
		String characters = charSb.toString();
		Random random = new SecureRandom();
		
		StringBuilder sb = new StringBuilder(12);
		for (int i = 0; i < 12; i++) {
			int randomIdx = random.nextInt(characters.length()); // 0~18
			char randomChar = characters.charAt(randomIdx);
			sb.append(randomChar);
		}
		return sb.toString();
	}
}
