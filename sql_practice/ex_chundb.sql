use chundb;

select * from tb_department;
select * from tb_student;
select * from tb_professor;
select * from tb_class_professor;
select * from tb_class;
select * from tb_grade;

select department_name as 학과명, category as 계열
from tb_department;

select concat(department_name, '의 정원은 ', capacity, ' 명 입니다.') as '학과별 정원'
from tb_department;

select s.student_name
from tb_student as s
where s.absence_yn = 'Y' 
	and s.student_ssn like '%-2%' 
	and (s.department_no = (select department_no
							from tb_department
							where department_name = '국어국문학과'));

select s.student_name
from tb_student as s
where s.student_no in ('A513079', 'A513090', 'A513091', 'A513110', 'A513119')
order by s.student_name desc;

select d.department_name, d.category
from tb_department as d
where d.capacity between 20 and 30;

select professor_name
from tb_professor
where department_no is null;

select * 
from tb_student
where department_no is null;

select class_no
from tb_class
where PREATTENDING_CLASS_NO is not null;

select distinct category
from tb_department
order by category;

select student_no, student_name, student_ssn
from tb_student
where student_address like '%전주%'
and absence_yn = 'N'
and year(entrance_date) = '2019'
order by student_name;

-- leverl 2

select student_no as '학번' , student_name as '이름', entrance_date as '입학년도'
from tb_student
where department_no = 002
order by entrance_date;

select professor_name, professor_ssn
from tb_professor
where professor_name not like '___';

select professor_name as '교수이름', (100-substr(professor_ssn, 1, 2)+26) as '나이'
from tb_professor
order by `나이` ;

select substr(professor_name, 2) as '이름'
from tb_professor;

select student_no, student_name
from tb_student
where ((100-substr(student_ssn, 1, 2)) + date_format(entrance_date,'%Y')) > 21
or (((100-substr(student_ssn, 1, 2)) + date_format(entrance_date,'%Y')) = 21 
and substr(student_ssn, 3, 4) > date_format(entrance_date, '%m%d'));


select weekday('2020-12-25'),
	case 
    when weekday('2020-12-25') = 0 then '일요일'
    when weekday('2020-12-25') = 1 then '월요일'
    when weekday('2020-12-25') = 2 then '화요일'
    when weekday('2020-12-25') = 3 then '수요일'
    when weekday('2020-12-25') = 4 then '목요일'
    when weekday('2020-12-25') = 5 then '금요일'
    when weekday('2020-12-25') = 6 then '토요일'
	end as '요일';

select STR_TO_DATE('49/10/11', '%y/%m/%d');

select point as '평점'
from tb_grade
where student_no = 'A51718';
