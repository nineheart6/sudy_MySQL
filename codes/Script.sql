
create database k_test;

show databases;
#명시적으로 스키마 지정.
create table k_test.BTC
(ID VARCHAR(10)
, NAME VARCHAR(20)
, ADDR VARCHAR(50)
, PHONE_NUM INTEGER
, CLASS VARCHAR(5)
);

drop table k_test.BTC; 

#primary키의 경우 무조건 not null이 적용된다.
CREATE TABLE BTC_1
( ID VARCHAR(10)
, NAME VARCHAR(20)
, ADDR VARCHAR(50)
, PHONE_NUM INTEGER
, CLASS VARCHAR(5)
, PRIMARY KEY(ID)
);
#primary키의 경우2 위와 동일.
CREATE TABLE BTC_1_1
( ID VARCHAR(10) PRIMARY KEY
, NAME VARCHAR(20)
, ADDR VARCHAR(50)
, PHONE_NUM INTEGER
, CLASS VARCHAR(5)
);

#table 확인
show create table BTC_1_1;

#unique key, nullable 가능
create table BTC_2(
ID VARCHAR(10)
, NAME VARCHAR(20)
, ADDR VARCHAR(50)
, PHONE_NUM INTEGER
, CLASS VARCHAR(5)
, primary KEY(ID)
, unique KEY(PHONE_NUM)
);

#들어올 데이터의 값을 지정
create table BTC_3(
ID VARCHAR(10)
, NAME VARCHAR(20)
, ADDR VARCHAR(50) not null
, PHONE_NUM INTEGER
, CLASS VARCHAR(5) check (class in ('BTC-1','BTC-2'))
, primary KEY(ID)
, unique KEY(PHONE_NUM)
);
#테이블 제거
drop table btc_3;

#줄맞추어 사용하면 보기 편하다.
create table member
( mem_id 		char(8) 	primary key 
, mem_name 		VARCHAR(10) not null
, mem_number 	INTEGER 	not null
, addr 			CHAR(2) 	not null 
, phone1		CHAR(3)
, phone2 		CHAR(13)
, height 		smallint
, debut_date 	date 
);

#alter를 통한 코멘트 추가.
alter table `member` modify column mem_id 
char(8) not null comment "사용자 아이디(PK)";

#코멘트와 함께 생성
create table member_1
( mem_id 		char(8) 	not null comment '사용자 아이디' primary key 
, mem_name 		VARCHAR(10) not null comment '사용자 이름'
, mem_number 	INTEGER 	not null comment '사용자 번호'
, addr 			CHAR(2) 	not null comment '주소'
, phone1		CHAR(3)				 comment '전화번호 국번'
, phone2 		CHAR(13)			 comment '전화번호'
, height 		smallint			 comment '키'
, debut_date 	date 				 comment '데뷔날짜'
);

create table test1(
id varchar(10) 
, name varchar(20) not null
, addr varchar(10) not null
);

#컴럼리스트 미작성으로 입력
insert into test1 values ('111', '홍길동', '서울특별시');
#개수가 맞지 않아 오류.
insert into test1 (id, name) values ('111', '홍길동', '서울특별시');
#not null이여서 오류.
insert into test1 (id, name) values ('111', '홍길동');
#처리방법1 '' 오라클과 달리 null이 아닌 비어있다라는 값이 들어간다.
insert into test1 (id, name, addr) values ('111', '홍길동', '');
#null 선언. not null이여서 오류.
insert into test1 (id, name, addr) values ('111', '홍길동', null);
#확인
select * from test1;

create table test2(
id varchar(10) 
, name varchar(20) not null
, addr varchar(10)
, phone integer
);
#addr이 nullable이기 때문에 가능
insert into test2 (id, name, phone) values ('111', '홍길동', 12345678);
select * from test2;

#10회 데이터 넣기.
insert into BTC VALUES('1', '홍길동', '부산시', '01012345678', 'BTC-1');
select * from btc;

#1회 데이터 넣기. 한번 더 진행시 오류 -> primary key의 중복에 의해.
insert into BTC_1 VALUES('1', '홍길동', '부산시', '01012345678', 'BTC-1');
#정상적으로 제이터가 동작.
INSERT INTO BTC_1 VALUES('2', '강감찬', '부산시', '01013579990', 'BTC-1');
INSERT INTO BTC_1 VALUES('3', '이순신', '부산시', '01043532535', 'BTC-1');
INSERT INTO BTC_1 VALUES('4', '김유신', '부산시', '01076568766', 'BTC-2');
INSERT INTO BTC_1 VALUES('5', '손오공', '부산시', '01087649273', 'BTC-2');
INSERT INTO BTC_1 VALUES('6', '사오정', '부산시', '01065352829', 'BTC-2');

select * from btc_1;

#2번에서 오류, phne number에 유니크 키 선언해서.
INSERT INTO BTC_2 VALUES('1', '홍길동', '부산시', '01012345678', 'BTC-1');
INSERT INTO BTC_2 VALUES('2', '강감찬', '부산시', '01012345678', 'BTC-1');
#오류 안난다.
INSERT INTO BTC_2 VALUES('2', '강감찬', '부산시', '01012345679', 'BTC-1');

#auto_increment는 반드시 integer로 선언해야한다.
create table test3(
	id 	  integer(10) auto_increment primary key
, 	name  varchar(20) not null
, 	addr  varchar(10)
, 	phone integer
);

#()안은 컬럼리스트 auto_increment로 primary 생략가능
INSERT INTO TEST3 (name, addr, phone) VALUES('홍길동', '서울시', 123456);

#not null에 대한 default insert
create table test4(
	id 	  integer(10) auto_increment primary key
, 	name  varchar(20) 
, 	addr  varchar(10) not null default '강남구'
, 	phone integer
);

INSERT INTO TEST4 (name, phone) VALUES('홍길동', 123456);
select * from test4;
#default는 오류를 굳이 발생시킬 필요가 없는 곳에 추가.


#null로 인해 error
INSERT INTO BTC_3 VALUES('1', '홍길동', null, 01012345678, 'BTC-1');
#class에 대한 check로 인해 오류
INSERT INTO BTC_3 VALUES('1', '홍길동', '부산시', 01012345678, 'BTC-3');
#정상작동.
INSERT INTO BTC_3 VALUES('1', '홍길동', '부산시', 01012345678, 'BTC-1');

#실습
create table employees(
	emp_no 		integer 	not	null	comment '사원번호'
, 	birth_date 	date 		not null 	comment '생년월일'
,	first_name 	varchar(14) not null 	comment '성'
,	last_name 	varchar(16) not null 	comment '이믈'
,	gender 		char(1) 	not null 	comment '성별'
,	hire_date 	date 		not null 	comment '입사일'
,	primary key (emp_no)
);
#한번에 쓰기
INSERT INTO employees
VALUES 	(0001, '2022-01-01', '강', '감찬', 'M', '2000-01-01')
,		(0002, '2022-02-01', '이', '순신', 'M', '2001-01-01')
, 		(0003, '2022-03-01', '유', '관순', 'F', '2002-01-01')
, 		(0004, '2022-04-01', '김', '유신', 'M', '2003-01-01')
, 		(0005, '2022-05-01', '정', '약용', 'M', '2004-01-01')
, 		(0006, '2022-06-01', '윤', '봉길', 'M', '2005-01-01');
#date 데이터에 대한 두가지 입력방식.
INSERT INTO employees VALUES(0007, '2022-01-01', '강', '감찬', 'M', 20000101);

#내부 데이터 삭제.
delete from employees;
select * from employees;

#새 스키마 생성 ppt71
create database k_sample;
show databases;
use k_sample;

#사전 설정.
create table employees(
	emp_no 		integer 	not	null	comment '사원번호'
, 	birth_date 	date 		not null 	comment '생년월일'
,	first_name 	varchar(14) not null 	comment '성'
,	last_name 	varchar(16) not null 	comment '이믈'
,	gender 		char(1) 	not null 	comment '성별'
,	hire_date 	date 		not null 	comment '입사일'
,	primary key (emp_no)
);

create table departments(
	dept_no 	char(4) 	not null comment '부서번호'
, 	dept_name 	varchar(40) not null comment '부서명'
,	unique key	dept_name (dept_name)
,	primary key (dept_no)
);

create table dept_manager(
	emp_no 		integer not null 	comment '사원번호'
,	dept_no 	char(4) not null 	comment '부서번호'
,	from_date	date 				comment '발령일시'
,	to_date 	date 				comment '발령종료일시'
,	PRIMARY KEY (emp_no, dept_no)
);

drop table dept_emp;
create table dept_emp(
	emp_no 		integer 	not null 	comment '사원번호'
,	dept_no		char(4)		not null 	comment '부서번호'
,	from_date 	date 		not null 	comment '발령일시'
,	to_date 	date 		NOT null    
,	primary key (emp_no, dept_no)	
);

create table titles(
	emp_no		integer		not null 	comment '사원번호'
,	title		varchar(50)	not null	comment '직책이름'
,	from_date 	date		not null	comment '발령일시' 
,	To_date		date 					comment '종료일시'
,	primary key (emp_no, title, from_date)
);

create table salaries(
	emp_no		integer		not null 	comment '사원번호'
,	salary		integer		not null	comment '급여액'
,	from_date 	date		not null	comment '발령일시' 
,	To_date		date 					comment '종료일시'
,	primary key (emp_no, from_date)
);
drop table salaries;
#ERD그리기 ERWIN(유료), DASHABI?

#alter로 foregin키 선언
alter table dept_emp
add constraint fk_dept_emp
foreign key (emp_no)
references employees(emp_no);

alter table dept_emp
add constraint fk_emp_dept
foreign key (dept_no)
references departments (dept_no);

alter table dept_manager
add constraint fk_man_emp
foreign key (emp_no)
references employees (emp_no);

alter table dept_manager
add constraint fk_man_dept
foreign key (dept_no)
references departments (dept_no);

alter table titles
add constraint fk_title_emp
foreign key (emp_no)
references employees (emp_no);

alter table salaries 
add constraint fk_salaries_emp
foreign key (emp_no)
references employees (emp_no);

#ppt 84 실습
create table stadium(
	stadium_id 		varchar(3)	not null 
,	stadium_name	varchar(10)	not null
,	seat_count		integer		not null 
,	primary key (stadium_id)
);

create table player(
	player_id	varchar(7)	not null
,	player_name	varchar(5)	not null 
,	team_id		varchar(3)	not null
,	primary key (player_id)
);

create table team(
	team_id		varchar(3)	not null
,	team_name	varchar(10)	not	null
,	region_name	varchar(5)	not	null
,	stadium_id	varchar(3)	not	null
,	primary key (team_id)
);

alter table player
add constraint fk_player_team
foreign key (team_id)
references team(team_id);

alter table team
add constraint fk_team_stadium
foreign key (stadium_id)
references stadium(stadium_id);

