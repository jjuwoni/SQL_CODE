-- index : 쿼리의 성능을 좌우하는 index

-- 100만명의 users 테이블 중에서 홍길동 이라는 이름을 가진 사람을 찾아야 한다.
-- 만약 인덱스가 없다면, 데이터베이스는 첫번째 행부터 마지막 행까지 하나씩 비교하며 스캔을 하게 된다. 이를 full table scan 이라고 한다.

-- index 는 책으로 따지면 목차와 같은 개념이다.
-- 특정 컬럼(name)의 값과 해당 데이터의 물리적 위치를 미리 정렬 된 구조로 저장해둔다.
-- 이렇게 저장을 해두면, 쿼리 실행 시 목차를 통해 원하는 데이터 위치로 즉시 이동을 한다.

-- index 는 양날의 검이다. trade-off 
-- index 는 면접 단골 질문

-- index 단점
-- 1. 저장 공간 비용
-- 인덱스는 테이블 데이터와 별도의 공간을 차지하는 데이터 구조체이다.
-- 따라서 인덱스를 많이 만들수록 전체 용량은 커진다.
-- ex) 목차 10~20 page 
-- 2. DML(INSERT, UPDATE, DELETE) 성능 저하
-- 가장 중요한 요인
-- 인덱스는 SELECT 의 성능은 향상 시키지만, 데이터 변경 작업 성능은 저하시킨다.

-- insert : 새로운 데이터 추가 시, 인덱스 테이블에도 정렬된 위치를 찾아 새로운 항목을 추가해야 함.
-- delete : 테이블에서 데이터 삭제 시, 인덱스 테이블에서도 해당 항목을 찾아 삭제해야 함.
-- update : 만약 인덱스가 걸린 컬럼의 값이 수정되면, 최악의 상황이 발생한다.
--          기존 데이터를 삭제하고, 새로운 데이터를 다시 정렬된 위치에 삽입하는 작업이 모두 필요하다. (삭제 + 삽입 작업 동시 발생)

-- 성능 체크 관련 문법
-- explain : 쿼리의 실행 계획을 볼 수 있는 키워드
explain select * from users where name = '홍길동';

-- 인덱스 생성하기 : create index
-- users 테이블에 name 이라는 컬럼에 index 를 적용하겠다.
create index idx_users_name on users(name);

-- rows 컬럼에는 스캔한 전체 행의 개수가 표시된다.
-- 인덱스 전 -> 120 row 스캔
-- 인덱스 후 -> 1 row 스캔
explain select * from users where name = '홍길동';

-- 테이블의 인덱스 목록 확인하기
-- 1개의 인덱스만 만들었다. 그러나 user_id, email에도 index가 적용됨.
-- pk, unique 제약조건은 자동으로 테이블 생성시 인덱스를 생성한다. (drop 안됨)
show index from users;

-- 인덱스 삭제 : drop index
drop index idx_users_name on users;




