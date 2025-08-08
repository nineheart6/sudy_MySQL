select *
from player;
select *
from team;

#team_id에 ailias를 주지 않으면 어떤 테이블에서 컬럼을 가져올 지 모르기 때문에 p.team_id 같이 지정.
select p.player_id ,p.player_name ,p.team_id 
from player p inner join team t on p.team_id = t.team_id;

select 
	p.player_id 
,	p.player_name
,	p.team_id 
,	t.team_id 
,	t.stadium_id 
,	t.region_name 
,	t.team_name 
from player p inner join team t on p.team_id = t.team_id;

select 
	p.player_id 
,	p.player_name
,	p.team_id 
,	t.team_id 
,	t.stadium_id 
,	t.region_name 
,	t.team_name 
from player p right outer join team t on p.team_id = t.team_id;

select count(*) from team;
select count(*) from player p right outer join team t on p.team_id = t.team_id;

#mySQL에는 full outer join 불가.
select 
	p.player_id 
,	p.player_name
,	p.team_id 
,	t.team_id 
,	t.stadium_id 
,	t.region_name 
,	t.team_name 
from player p full outer join team t on p.team_id = t.team_id;

#하는 법 full outer join = rigt + left 이므로
select 
	p.player_id 
,	p.player_name
,	p.team_id 
,	t.team_id 
,	t.stadium_id 
,	t.region_name 
,	t.team_name 
from player p right outer join team t on p.team_id = t.team_id
#union union all
union
select 
	p.player_id 
,	p.player_name
,	p.team_id 
,	t.team_id 
,	t.stadium_id 
,	t.region_name 
,	t.team_name 
from player p left outer join team t on p.team_id = t.team_id;

SELECT P.PLAYER_NAME 선수명, , P.BACK_NO 백넘버,
T.REGION_NAME 연고지, T.TEAM_NAME 팀명
FROM PLAYER P, TEAM T
#filter 조건 전부 where절을 사용. 권고 사항이다.
#어플리케이션의 관점에서 on절을 사용 시 가독성이 많이 떨어진다.
#예를 들어서 if문에 대해서 값을 받을 때 각 값에 따른 filter
#join 조건
WHERE P.TEAM_ID = T.TEAM_ID
#filter 조건
AND P.POSITION = ‘GK’
ORDER BY P.BACK_NO;

#on절의 형태.
select p.player_name ,p.player_id ,t.region_name ,t.team_id 
from player p inner join team t on p.team_id = t.team_id
where t.team_name = '울산현태'
order by p.player_id;

#pdf 185 두개씩만 join 되므로 ANSI로
select 
	p.player_name 	as '선수명'
,	t.region_name 	as '연고지'
,	t.team_name		as '팀명'
,	s.stadium_name  as '구장명'
from player p 	inner join team t 		on p.team_id 	= t.team_id 
				inner join stadium s 	on t.stadium_id = s.stadium_id
order by 선수명;

#minus 사용 mysql 지원안함.
select *
from player
minus(
select *
from player
where player_name = '자스민');

#pdf 198 실습
select e.emp_no , e.birth_date ,e.hire_date ,e.first_name ,e.last_name ,e.gender , de.dept_no
from employees e inner join dept_emp de on e.emp_no = de.emp_no; 

select *from dept_manager dm ;
select *from departments d  ;

select *
from employees e ,dept_manager dm
where e.emp_no = dm.emp_no;

# = 'Research' 처음으로 시작하면 더 빠르다?
select concat(e.first_name, ' ', e.last_name) as 성이름
from employees e ,dept_manager dm ,departments d 
where dm.dept_no = d.dept_no 
and e.emp_no = dm.emp_no
and d.dept_name = 'Research';

#202

select *
from employees e
where e.hire_date between '1999-01-01' and '1999-12-31';

select count(*) as '1998 남자 입사'
from employees e
where e.hire_date between '1998-01-01' and '1998-12-31'
and e.gender = 'M';

select * from titles;

select t.title, count(*) '수'
from titles t 
where t.To_date is null
group by t.title;

select gender, count(*) as 수
from employees e 
group by e.gender; 

select *
from departments d;
select *
from salaries s ;
select *
from employees e;
select *
from dept_emp de;
select *
from dept_manager dm
order by dm.emp_no;

select e.emp_no, s.salary  
from employees e 
inner join dept_emp de on e.emp_no = de.emp_no 
inner join salaries s on e.emp_no = s.emp_no
where s.To_date = '9999-01-01'
and de.dept_no = 'd005'
order by s.salary desc 
limit 5;

select  
	case  
		when e.gender = 'F' then '여'
		when e.gender = 'M' then '남'
	end	as '성'
,	count(*) as '수'
from employees e
group by e.gender;

select de.dept_no , AVG(s.salary) 
from dept_emp de inner join salaries s on de.emp_no = s.emp_no
where s.To_date = '9999-01-01'
group by de.dept_no
order by AVG(s.salary) 
limit 5;

select AVG(s.salary)
from salaries s 
where s.To_date = '9999-01-01';

select dm.emp_no , s.salary
from dept_manager dm inner join salaries s on dm.emp_no = s.emp_no 
where dm.to_date = '9999-01-01' and s.To_date ='9999-01-01'
order by s.salary desc;

#쿼리를 감싸는 summary로도 가능
select 
	case
		when s.salary >= 100000 then 1
		when s.salary >= 80000 then 2
		when s.salary >= 65000 then 3
		when s.salary >= 45000 then 4
		else 5
	end as 구간
,	count(*) as 직원수
from salaries s
where s.To_date = '9999-01-01'
group by 구간
order by 구간;