package com.myweb.www.security;

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
public class AuthVO {
//	create table auth_member(
//			email varchar(100) not null,
//			auth varchar(50) not null );
	
	private String email;
	private String auth;

}
