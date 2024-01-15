package com.myweb.www.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@ToString
@Setter
@Getter
public class BoardVO {
	/*
	create table board(
			bno bigint not null auto_increment,
			title varchar(200) not null,
			writer varchar(100) not null,
			content text not null,
			reg_at datetime default now(),
			mod_at datetime default now(),
			read_count int default 0,
			cmt_qty int default 0,
			has_file int default 0,
			primary key(bno)
			);
			*/
	// reg_at datetime default now(), 
	//	=>private String regAt; 로 수정
	private long bno;
	private String title;
	private String writer;
	private String content ;
	private String regAt;
	private String modAt;
	private int readCount;
	private int cmtQty;
	private int hasFile;
	
	
}
