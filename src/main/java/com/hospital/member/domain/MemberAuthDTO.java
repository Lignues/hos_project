package com.hospital.member.domain;

import java.time.LocalDateTime;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class MemberAuthDTO {

	private String memberId;
	private String memberPwd;
	private String memberName;
	private String email;
	private boolean enabled;
	
	private LocalDateTime regDate;
	private LocalDateTime updateDate;
	
	private int AuthCount;
}
