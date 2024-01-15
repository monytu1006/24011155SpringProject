- java Config 설정 프로젝트
1. pom.xml
2. 패키지 생성/ 폴더 생성=
3. WebConfig.java => 전반적인 설정
4. servletConfig.java => 화면/ 경로 관련 설정
5. rootConfig.java => DB관련 설정
===============================

DB생성
my workbench
--워크벤치 유저 갱신
mysql.infoschema
mysql.session
mysql.sys
root
springUser 제외 삭제

--schema 갱신
sakila
springdb
springtest
sys
world 제외 삭제

-------
1. User 생성/ BD 생성
-- root 계정으로 db생성, User 생성

*db생성구문
create database mywebdb;

-- user생성 구문
create user 'mywebUser '@'localhost'
identified by 'mysql';

-- user 권한 부여
grant all privileges on mywebdb.* to
'mywebUser'@'localhost' with grant option;

-- 권한 설정 완료
flush privileges;

- 테이블 생성
create table member(
email varchar(100) not null,
pwd varchar(100) not null,
nick_name varchar(100) not null,
reg_at datetime default now(),
last_login datetime default null,
primary key(email));

create table auth_member(
email varchar(100) not null,
auth varchar(50) not null );

alter table auth_member add constraint fk_auth foreign key(email) references member(email);

