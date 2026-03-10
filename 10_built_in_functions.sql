-- 문자열, 숫자, 날짜, 조건 함수 등
-- 가장 많이 쓰이는 내장 함수를 학습한다.

-- 문자열 관련 내장 함수
-- concat : 여러 문자열을 하나로 합치기
-- user 테이블에서 사용자의 이름, 이메일, 이름 + 이메일을 조회하라
select name, email, concat(name, '(', email, ')') as '이름(이메일)'
from users;

-- substring : 문자열의 일부를 잘라낸다. 
-- substring(문자열, 시작위치, 길이)
-- locate : 특정 문자열이 다른 문자열 내부에서 처음으로 나타나는 위치 반환
-- raccoon@helloworldlabs.kr
-- raccoon
select email, substring(email, 1, locate('@', email)- 1 )
from users;

-- length / char_length
-- 바이트 단위 / 글자 수 단위
select name, length(name) as '이름(byte)', char_length(name) as '이름 글자수'
from users;

-- replace : 문자열의 일부를 다른 문자열로 바꾼다.
select email, replace(email, 'example.com', 'wanted.co.kr') as '변경 후'
from users;

-- 숫자 관련 내장 함수
-- round, ceil, floor
-- 반올림, 올림, 내림
select score, round(score), round(score,1), ceil(score), floor(score)
from grades
where grade_id = 7;

-- 날짜/시간 관련 

-- now, curdate, curtime
select now(), curdate(), curtime();

select created_at as 원본날짜, year(created_at), month(created_at), day(created_at)
from users;

-- date__format : 날짜 데이터를 원하는 문자열 형식으로 변환
-- (포멧팅 형식 : %Y(4자리년도), %m 월, %d 일, %H 24시, %i 분, %s 초)
-- 저런 포멧 형식 실제 정규표현식 에 기반한다. 정규표현식은 절대 외우지 말고
-- 우리가 날짜를 변환해야 할 때 정규표현식을 쓰
select
	created_at,
	date_format(created_at, '%Y년 %m월 %d일') as 가입일
from users;

-- 조건 함수 (빈도 높을 수 있음)
-- if-else

-- user_profiles 테이블에서 bio(자기소개) null 인 경우,
-- null 대신 '자기소개서 미작성' 이라고 표시해보자.
select user_id, ifnull(bio, '자기소개서 미작성') as '자기소개'
from user_profiles;

-- case : 복잡한 조건부 로직을 작성한다.
-- courses 테이블의 status 값에 따라 '게시됨', '초안' 으로 알아보기 쉽게 조회
select title, status,
	   case
			when status = 'published' then '게시됨'
            when status = 'draft' then '초안'
            else '기타'
	   end as '과정 상태'
from courses;

-- grades 테이블의 점수에 따라서 95점 이상 A+, 90 A, 85 B+, 80 B, 70 C / d
-- 예상 결과 : 조평훈 97 A+
select * from grades;
select u.name, g.score,
		case
        when score >=95 then 'A+'
        when score between 94 and 90 then 'A'
        when score between 89 and 85 then 'B+'
        when score between 84 and 80 then 'B'
        when score between 79 and 70 then 'C'
        else 'D'
        end as '등급'
from grades g join users u where  u.user_id = g.user_id;
