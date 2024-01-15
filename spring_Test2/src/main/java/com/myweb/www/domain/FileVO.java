package com.myweb.www.domain;

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
public class FileVO {
	/*
	create table file(
			uuid varchar(256) not null,
			save_dir varchar(256) not null,
			file_name varchar(256) not null,
			file_type tinyint(1) default 0,
			bno bigint,
			file_size bigint,
			reg_at datetime default now(),
			primary key(uuid));
	*/
	
	//save_dir와 saveDir의 경우, 데이터베이스의 필드명과 Java 클래스의 변수명이 서로 다른 형식을 가지고 있습니다.
	//이에 대한 선택은 언어 및 관례에 따라 다를 수 있습니다.
	private String uuid;
	private String saveDir;
	private String fileName;
	private int fileType;
	private long bno;
	private long fileSize;
	private String regAt;
	
}
