use employee;

select * from employee;

select EMP_ID, EMP_NAME from employee;

select * from employee
where DEPT_CODE = 'D9';

select EMP_ID, EMP_NAME, DEPT_CODE, SALARY
from employee
where SALARY >= 3000000;

select EMP_NAME, DEPT_CODE, SALARY
from employee
where DEPT_CODE = 'D6' and SALARY > 2000000;

select EMP_ID, EMP_NAME, SALARY
from employee
where BONUS is null;

select EMP_NO, EMP_NAME, DEPT_CODE, JOB_CODE
from employee
where SALARY >= 3500000 and SALARY <= 5500000;

select EMP_NO, EMP_NAME, HIRE_DATE
from employee
where EMP_NAME like '김%';

select EMP_NAME, EMP_NO, DEPT_CODE
from employee
where EMP_NAME like '%하%';

select EMP_ID, EMP_NAME, PHONE
from employee
where PHONE like '___9%';

select EMP_ID, EMP_NAME, PHONE
from employee
where PHONE like '___9_______';

select EMP_NAME, DEPT_CODE, SALARY
from employee
where DEPT_CODE in ('D6', 'D8');

select EMP_ID, EMP_NAME, EMAIL
from employee
where not EMP_NAME like '이%';

select EMP_NAME, SALARY, JOB_CODE
from employee
where (JOB_CODE = 'J2' and SALARY >= 2000000)
	or JOB_CODE = 'J7';
    
select EMP_NAME, SALARY, JOB_CODE
from employee
where (JOB_CODE in ('J7', 'J2')) and SALARY >= 2000000;

select 
	EMP_NAME as '사원명', 
	SUBSTR(EMP_NO, 1, 2) AS '생년',
	SUBSTR(EMP_NO, 3, 2) AS '생월',
	SUBSTR(EMP_NO, 5, 2) AS '생일'
from employee;

select 
	EMP_NAME as '사원명',
    date_format(HIRE_DATE, '%Y') as '입사년도',
    date_format(HIRE_DATE, '%m') as '입사월',
    date_format(HIRE_DATE, '%d') as '입사날짜'
from employee;
	
select * from employee
where EMP_NO like '%-2%';

select EMP_NAME as '사원 번호', CONCAT(SUBSTR(EMP_NO, 1, 7), '*******') as '주민번호'
from employee;

select EMP_NAME, substr(EMAIL, 1, instr(EMAIL, '@')) as 'ID'
from employee; 

select EMP_NAME, HIRE_DATE, date_add(HIRE_DATE, INTERVAL 6 month) as '입사 후 6개월'
from employee;

select date_format(HIRE_DATE, '%Y') from employee;

select * 
from employee
where HIRE_DATE + interval 20 year < '2026-01-01';

select EMP_NAME, HIRE_DATE, datediff(curdate(), HIRE_DATE) as '근무일수'
from employee; 

select (2026-date_format(HIRE_DATE, '%Y')) as '근무년수'
from employee;

select * 
from employee
where mod(EMP_ID, 2) = 1;