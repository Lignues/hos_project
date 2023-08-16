package com.hospital.member.domain;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class AuthVO  implements Serializable{

	private static final long serialVersionUID = -2449825292686501359L;
	
	String memberId;
	String auth;
}
