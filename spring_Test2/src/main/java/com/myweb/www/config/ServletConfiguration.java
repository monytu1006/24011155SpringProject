package com.myweb.www.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@EnableWebMvc
@ComponentScan(basePackages = {"com.myweb.www.controller", "com.myweb.www.handler"})
public class ServletConfiguration implements WebMvcConfigurer{

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		// resources 경로 설정 / 나중에 파일 업로드 경로 설정 추가
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
		
		//지난 프로젝트servlet-context.xml 참고 
		registry.addResourceHandler("/upload/**").addResourceLocations("file:///D:\\_myProject\\_java\\_fileUpload\\");
		
	}
	/*
	 * 지난 프로젝트 강의의 servlet-context.xml 설정 참고
	 	<!-- Resolves views selected for rendering by @Controllers to .jsp resources in the /WEB-INF/views directory -->
	<beans:bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
		<beans:property name="prefix" value="/WEB-INF/views/" />
		<beans:property name="suffix" value=".jsp" />
	</beans:bean>
	
	<context:component-scan base-package="com.ezen.www" />
	 */
	
	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		// 뷰 경로 설정
		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		viewResolver.setPrefix("/WEB-INF/views/");
		viewResolver.setSuffix(".jsp");
		viewResolver.setViewClass(JstlView.class);
		
		registry.viewResolver(viewResolver);
		
	}
	
	//multipartResolver 설정
	// 빈 이름이 반드시 multipartResolver
	@Bean(name ="multipartResolver")
	public MultipartResolver getMultipartResilver() {
		StandardServletMultipartResolver multipartResolver = 
				new StandardServletMultipartResolver();
		return multipartResolver;
	}

}
















