-- 1. 부서코드가 노옹철 사원과 같은 소속의 직원 명단 조회하세요.
select
	dept_code
  from employee
 where emp_name like '노옹철';

select
	emp_name
  from employee
 where dept_code = (select
	dept_code
  from employee
 where emp_name like '노옹철');

-- 2. 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여를 조회하세요.
select
	avg(salary) as 'avg'
  from employee;
  
select
	emp_id
    , emp_name
    , job_code
    , salary
  from employee
 where salary > (select
	avg(salary) as 'avg'
  from employee);
 
-- 3. 노옹철 사원의 급여보다 많이 받는 직원의 사번, 이름, 부서코드, 직급코드, 급여를 조회하세요.
select
	emp_id
    , emp_name
    , dept_code
    , job_code
    , salary
  from employee
 where salary > (select
	salary
  from employee
 where emp_name like '노옹철');

-- 4. 가장 적은 급여를 받는 직원의 사번, 이름, 부서코드, 직급코드, 급여, 입사일을 조회하세요.
select
	emp_id
    , emp_name
    , dept_code
    , salary
    , HIRE_DATE
  from employee
 where salary = (select 
	min(salary) 
  from employee);

-- *** 서브쿼리는 SELECT, FROM, WHERE, HAVING, ORDER BY절에도 사용할 수 있다.

-- 5. 부서별 최고 급여를 받는 직원의 이름, 직급코드, 부서코드, 급여 조회하세요.
select
	max(salary)
    , dept_code
  from employee
 group by dept_code;

select
	emp_name
    , job_code
    , dept_code
    , salary
  from employee
 where (dept_code, salary) in (
select
	dept_code
    , max(salary)
  from employee
 group by dept_code);

-- *** 여기서부터 난이도 극상

-- 6. 관리자에 해당하는 직원에 대한 정보와 관리자가 아닌 직원의 정보를 추출하여 조회하세요.
-- 사번, 이름, 부서명, 직급, '관리자' AS 구분 / '직원' AS 구분
-- HINT!! is not null, union(혹은 then, else), distinct
select
	e.emp_id as '사번'
    , e.emp_name as '이름'
    , d.dept_title as '부서명'
    , j.job_name as '직급'
    , case
		when e.emp_id in (select distinct manager_id from employee)
        then '관리자'
        else '직원'
	end as '구분'
  from employee e
  left join department d on d.dept_id = e.dept_code
  left join job j using (job_code)
 order by
	case
		when e.emp_id in (select distinct manager_id from employee) then 1
        else 2
	end
    , e.emp_id;

-- 7. 자기 직급의 평균 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여를 조회하세요.
-- 단, 급여와 급여 평균은 만원단위로 계산하세요.
-- HINT!! round(컬럼명, -5)
select
	e.emp_id
    , e.emp_name
    , e.job_code
    , e.salary
  from employee e
  join
	(select
		job_code
		, round(avg(salary), -5) as avg_sal
	from employee
	group by job_code) as job_avg on e.job_code = job_avg.job_code
 where e.salary >= job_avg.avg_sal
 order by job_code;

-- 8. 퇴사한 여직원과 같은 부서, 같은 직급에 해당하는 직원의 이름, 직급코드, 부서코드, 입사일을 조회하세요.
select
	ent_yn
    , dept_code
    , job_code
  from employee
 where ent_yn = 'y';
 
select
	emp_name
    , job_code
    , dept_code
    , hire_date
  from employee
 where ent_yn = 'n'
 and (job_code, dept_code) in (
select
    job_code
    , dept_code
  from employee
 where ent_yn = 'y');

-- 9. 급여 평균 3위 안에 드는 부서의 부서 코드와 부서명, 평균급여를 조회하세요.
-- HINT!! limit
select
	e.dept_code
    , d.dept_title
    , avg(e.salary) as '평균급여'
  from employee e
  join department d on d.dept_id = e.dept_code
  group by e.dept_code
  limit 3;
  
-- 10. 부서별 급여 합계가 전체 급여의 총 합의 20%보다 많은 부서의 부서명과, 부서별 급여 합계를 조회하세요.
select
	d.dept_title
    , sum(e.salary)
  from employee e
  join department d on d.dept_id = e.dept_code
  group by d.dept_title
  where sum(e.salary) * 0.2 > (select
	d.dept_title
    , sum(e.salary)
  from employee e
  join department d on d.dept_id = e.dept_code
  group by d.dept_title);
    