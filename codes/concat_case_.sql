#concatenation의 사용은 dbms마다 모두 다르다. 선수명단 -> alias
select CONCAT(PLAYER_NAME, '선수(', TEAM_ID, '소속)') '선수명단' from PLAYER;

select * from departments;

select CONCAT('insert into departments values (', dept_no,', ' , dept_name ,');') 
from departments;

select * from stadium;

select CONCAT(stadium_name, '(', seat_count, '석)') from stadium;

select player_name
from player
where player_id = '2012134';

select player_id, team_id
from player
where player_name = '레오';

select stadium_name 
from stadium 
where seat_count >= 40000;

select player_name
from player
where player_name like '장%';

select CONCAT(first_name, ' ', last_name ) as 'full_name'
from employees
where first_name like 'P%';

select *
from employees
where last_name like '__p%';

select CONCAT(first_name, ' ', last_name ) as 'full_name'
from employees
where gender = 'M';

#성능을 위해 함수 사용 X
select *
from employees
where birth_date between '1955-01-01' and '1960-12-31 23:59:59';

select CONCAT(first_name, ' ', last_name ) as 'full_name'
from employees
where last_name like '%F%'
or first_name like '%F%';

select CONCAT(first_name, ' ', last_name ) as 'full_name'
from employees
where emp_no >= 15000;

select dept_no, dept_name 
from departments
where dept_name in ('Marketing', 'Sales');

select emp_no 
from titles
where title in ('Staff');

select emp_no 
from titles
where title = 'Staff';

create table player2 as select * from player;

select * from player1;

update player1
set team_id = 'kor';

update player2
set team_id = 'kor'
where team_id = 'k01'

delete from player1
where team_id = 'kor';

show create table player;
CREATE TABLE `player4` (
  `player_id` varchar(7) NOT NULL,
  `player_name` varchar(5) NOT NULL,
  `team_id` varchar(3) NOT NULL,
  PRIMARY KEY (`player_id`)
);

#CTAS
insert into player4 (select * from player); 
select * from player4;

select now();
select SYSDATE();

SELECT EMP_NO AS ‘사원번호’, BIRTH_DATE AS ’생일’, FIRST_NAME AS
‘성’, LOWER(LAST_NAME) AS ‘이름’, GENDER AS ‘성별’, HIRE_DATE AS ‘입사일자’
FROM EMPLOYEES

SELECT EMP_NO AS ‘사원번호’, BIRTH_DATE AS ’생일’, LOWER(CONCAT(FIRST_NAME,' ', LAST_NAME)) AS ‘이름’, GENDER AS ‘성별’, HIRE_DATE AS ‘입사일자’
FROM EMPLOYEES

select 	emp_no as '사원번호' , SUBSTR(first_name ,1 ,1) as '성의 첫 자리' 
		,last_name as '이름' ,gender as '성별' ,birth_date as '생일' ,hire_date as '고용일'
from employees

select emp_no ,LOWER(CONCAT(first_name ,last_name)) as '이름' ,length(CONCAT(first_name ,last_name)) as '이름 길이' 
,gender ,birth_date ,hire_date
from employees

select dept_no as '부서번호'
, 	case dept_no 
	when 'd001' then '마케팅'
	when 'd002' then '재무'
	when 'd003' then '인사'
	when 'd004' then '상품'
	when 'd005' then '개발'
	when 'd006' then '품질'
	when 'd007' then '영업'
	when 'd007' then '연구'
	when 'd008' then '고객서비스'
	end as '부서명'
from dept_emp;

select 
	case dept_no 
	when 'd001' then '마케팅'
	when 'd002' then '재무'
	when 'd003' then '인사'
	when 'd004' then '상품'
	when 'd005' then '개발'
	when 'd006' then '품질'
	when 'd007' then '영업'
	when 'd008' then '연구'
	when 'd009' then '고객서비스'
	end as '부서명'
from dept_emp;

select distinct dept_no as '부서번호'
,	case when dept_no = 'd001' then '마케팅'
		 when dept_no = 'd002' then '재무'
		 when dept_no = 'd003' then '인사'
		 when dept_no = 'd004' then '상품'
		 when dept_no = 'd005' then '개발'
		 when dept_no = 'd006' then '품질'
		 when dept_no = 'd007' then '영업'
		 when dept_no = 'd008' then '연구'
		 when dept_no = 'd009' then '고객서비스'
	end as '부서명'
from dept_emp
where dept_no >= 'd003';

select CONCAT(first_name ,' ' , last_name) as 'full name'
from employees
where first_name = 'king';

insert into player1 (select * from player);
select * from player1;

show create table player1;
# nullable로 테이블 전환
alter table k_sample.player1 modify column player_name varchar(5) null;

update player1 set player_name = null
where player_id = 2012131;


select * from player1
where player_name is null;

#null값을 포함해서 계산
select count(*) from player1;
#null값을 제외하여 계산
select COUNT(player_name) from player1;

select MIN(player_name) from player1;

select COUNT(*) '전체 행수', COUNT()
from player1;

select gender ,COUNT(*) '사원 수'
from employees
group by gender;

select 
	case 
		when gender = 'M' then '남자'
		when gender = 'F' then '여자'
	end '성별'
,	COUNT(*) '사원수'
from employees
group by gender
having count(*) > 150000;

select first_name ,	COUNT(*) '사원수'
from employees
group by first_name
having 사원수 > 270;

select first_name ,	COUNT(*) '사원수'
from employees
group by first_name
having count(*) > 270;

select emp_no, salary 
from salaries
order by salary desc;

select emp_no, salary
from salaries
order by emp_no, salary desc;

select emp_no, MAX(salary)
from salaries
group by emp_no
order by emp_no, MAX(salary) desc;

select *
from salaries;

#카테시안 조인(절대 사용하지 말 것)
select *
from player ,team ;
select count(*) from player;
select count(*) from team;
select 12*15;

#inner join. where절로 양쪽데이터가 모두 존재할 경우만 출력했다.
select *
from player p, team t
where p.team_id = t.team_id;

#outer join 오라클에서 큰 쪽을 기준으로 출력 my sql에서 오류
select *
from player p ,team t 
where p.team_id = t.team_id(+);

#outer join, right join #15개
select *
from player p right outer join team t on p.team_id = t.team_id;

#outer join, left join #12개 오른 쪽에 다 들어가는 것이기에 동일
select *
from player p left outer join team t on p.team_id = t.team_id;

#inner join. 다른 문법 같은 결과 ANSI SQL (안시 쿼리) 가독성 좋다.
select *
from player p inner join team t on p.team_id = t.team_id;
#join이 추가로 늘어나야 할 때 and 사용. 컴럼은 예시를 위해서 적었다.
select *
from player p inner join team t on p.team_id = t.team_id and p.column = t.column

#outer join, ifnull 사용.(is null 조건)
SELECT 
  p.player_id,
  ifNULL(p.player_name, '이름없음'),
  t.team_name
FROM player p
RIGHT OUTER JOIN team t ON p.team_id = t.team_id;