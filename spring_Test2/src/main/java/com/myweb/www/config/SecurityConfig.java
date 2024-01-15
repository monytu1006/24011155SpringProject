package com.myweb.www.config;


import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.myweb.www.security.CustomAuthMemverservice;
import com.myweb.www.security.LoginFailureHandler;
import com.myweb.www.security.LoginSuccessHandler;

import lombok.extern.slf4j.Slf4j;
//WebSecurityConfiguration 상속받아 환경설정
//WebConfig 에 securityConfig.class 등록

@Slf4j
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{
	
	// 비밀번호 암호화 객체 PasswordEncoder, 빈 생성
	@Bean
	public PasswordEncoder bcPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	// SuccessHandler, 빈 생성	=> 사용자 커스텀 생성
	@Bean
	public AuthenticationSuccessHandler authenticationSuccessHandler() {
		return new LoginSuccessHandler();
	}
	
	@Bean
	// FailureHandler, 빈 생성	=> 사용자 커스텀 생성
	public AuthenticationFailureHandler authenticationFailureHandler() {
		return new LoginFailureHandler();
	}
	
	// UserDetail, 빈 생성	=> 사용자 커스텀 생성
	@Bean
	public UserDetailsService customUserService() {
		return new CustomAuthMemverservice();
	}
	

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		// 인증되는 객체 설정
		auth.userDetailsService(customUserService())
		.passwordEncoder(bcPasswordEncoder());
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		// 화면에서 설정되는 권한에 따른 주소 맵핑 설정
		//csrf() 공격에 대한 설정 막기
		http.csrf().disable();
		//csrf 공격 검색: 개요[편집] 사이트 간 요청 위조의 줄임말. 웹 애플리케이션 취약점 중 하나로 
		//사용자가 자신의 의지와 무관하게 공격자가 의도한 행동을 해서 특정 웹페이지를 보안에 취약하게 한다거나 수정, 삭제 등의 작업을 하게 만드는 공격 방법이다.
		
		// 승인 요청
		// antMatchers : 접근을 허용하는 값
		// permitAll() : 누구나 접근 가능하는 경로
		// authenticated() : 인증된 사용자만 가능
		http.authorizeRequests()
		.antMatchers("/member/list").hasRole("ADMIN")
		//.antMatchers("/member/list", "/결제요청", "/상품요청").hasRole("ADMIN"); 등등등
		.antMatchers("/", "/board/list","/board/detail", "/comment/**", "/upload/**", "/resources/**", "/member/register", "/member/login").permitAll()
		// "/", "/board/list","/board/detail", "/comment/**", "/upload/**", "/resources/**", "/member/register/**", "/member/login/**" 등등
		// 모두가 다 볼수 있게
		.anyRequest().authenticated();

		// 커스텀 로그인 페이지를 구성
		// Controller에 주소요청 맵핑이 같이 있어야 함(필수)
		http.formLogin()
		.usernameParameter("email")
		.passwordParameter("pwd")
		.loginPage("/member/login")
		.successHandler(authenticationSuccessHandler())
		.failureHandler(authenticationFailureHandler());
		
		// 로그이읏 페이지
		// 반드시 method = "post"
		http.logout()
		.logoutUrl("/member/logout")
		.invalidateHttpSession(true)
		.deleteCookies("JSESSIONID")
		.logoutSuccessUrl("/");
		
		
		
		
	}
	
	
	
	
	
}
