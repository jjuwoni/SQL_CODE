-- 쿼리 내부의 또 다른 쿼리

-- SQL 기초 강의를 수강하는 학생들의 평균 점수보다 높은 점수를 받은 학생의 이름은 무엇인가?

-- 1. SQL 기초 강의 수강생들의 평균 점수 구하기 ex) 평균 85
-- 2. 1단계에서 도출된 85점 보다 높은 점수를 받은 학생 조회

SELECT * FROM wanted_lms.users;
-- where 조건절에서 사용하는 서브쿼리 
-- '홍길동' 사용자와 같은 해에 가입한 모든 사용자의 이름과 가입일 조회
-- 1. 
select name, created_at as '가입일' from users;
-- 2. 홍길동의 가입년도 파악
select year(created_at) from users where name = '홍길동';

-- 3. 1단계와 2단계 두 쿼리문를 합친 완성본
-- 해당 식은 단일 행 서브쿼리라고 불리운다.
-- 서브쿼리가 하나의 행, 하나의 열인 결과를 반환해야 한다.
select name, created_at as '가입일'
from users 
where year(created_at)=(select year(created_at) from users where name = '홍길동');

-- 다중 행 서브쿼리
-- 서브쿼리가 여러 개의 행을 결과로 반환할 때를 의미한다.
-- in, any, all 과 같은 연산자와 함께 사용한다.

-- 'Python' 태그가 붙은 과정을 수강 신청한 모든 학생의 user_id 와 name 조회하라.
-- enrollements, tags, courses join 이 연산됨.
-- 1. 
select 
	u.user_id,
    u.name,
    e.course_id
from users u
join enrollments e on u.user_id = e.user_id
where e.course_id in (
	-- 여기서 도출해야 하는 값은 course_id 가 Python 태그를 포함하고 있는 것을 판단
    select
		c.course_id
	from courses c
    join course_tags ct on (c.course_id = ct.course_id)
    join tags t on (ct.tag_id = t.tag_id)
    where t.name like '%Python%'
);

-- from 절에 사용하는 서브쿼리 (인라인 View)
-- from 테이블 
-- 마치 하나의 테이블처럼 쿼리의 결과를 사용하는 것이다.

-- 각 교육자별로 개설한 과정 수를 계산한 결과를 가상 테이블로 만들고,
-- 이 가상 테이블과 users 테이블을 조인하여, 교육자 이름과 개설 과정 수를 조회하라.
select 
	u.name as '교육자 이름',
    author_stats.course_count as '개설 과정 수'
from users u
join ( 
		select 
			author_id,
            count(*) as course_count
		from courses
        group by author_id
) as author_stats on u.user_id = author_stats.author_id
order by 
	`개설 과정 수` desc;

