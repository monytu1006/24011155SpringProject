package com.myweb.www.service;

import com.myweb.www.security.MemberVO;

public interface MemberService {

	int register(MemberVO mvo);

	Boolean updateLastLogin(String authEmail);

}
