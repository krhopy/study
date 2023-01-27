
파일 → 새로만들기 → 데이터베이스계층 → 데이터베이스 파일
    i:\java202207\database\20220823_01서브쿼리.sql
    
////////////////////////////////////////////////////////////////////////////////

● [서브쿼리]
   - SQL문 속 또 다른 SQL문
   - 테이블 내에서 다시 한 번 쿼리문에 의해 레코드 조회 및 검색

   - 괄호를 잘 사용해야함.
   
-- 국어점수의 평균을 조회하시오
select kor from sungjuk;                -- 국어점수 조회
select avg(kor) from sungjuk;           -- 국어점수의 평균 조회(함수사용)
select round(avg(kor), 0) from sungjuk; -- 국어점수의 평균점수 반올림, 소수점 제거 (함수사용)
select round(avg(kor), 0) as avg_kor from sungjuk;          -- 칼럼명 임시 변경


-- 문1) 국어점수 평균 (66점)보다 잘한 국어점수를 조회하시오

-- (1) 먼저 66점보다 높은 국어점수 조회하기
select uname, kor
from sungjuk
where kor>=66;
--7명 나옴
-- 숫자 데이터는 가변적으로 변경될 수 있기때문에 단순히 평균 숫자를 넣는게 아닌 함수를 넣어야 값이 바뀌어도 평균보다 높은점수 도출할 수 있다.

-- (2) 함수를 넣기
select uname, kor
from sungjuk
where kor>=(select round(avg(kor), 0) from sungjuk;);
-- 66결과값 나오는 select - round - from 문장 넣어주면 된다.



-- 문2) 서울지역의 국어점수 평균을 구하고, 국어 평균보다 잘한 점수가 있는 지역, 이름, 국어점수를 서울 지역을 제외하고 조회하시오.

-- (1)서울지역의 국어점수 평균 구하기
select avg(kor) from sungjuk where addr='Seoul';
select round(avg(kor),0) from sungjuk where addr='Seoul'; -- 73점


-- (2)평균보다 잘한 점수가 있는지
select addr, uname, kor
from sungjuk
where kor>=(select round(avg(kor),0) from sungjuk where addr='Seoul');




-- 문3) 서울지역의 국어점수 평균보다 잘한 국어점수가 다른 지역에 있는지 조회하시오
select addr, uname, kor
from sungjuk
where kor>=(select round(avg(kor),0) from sungjuk where addr='Seoul')
and addr<>'Seoul';  --addr !='Seoul' 과 동일





-- 문4)국어점수의 최소값보다 이하 점수가 수학 또는 영어점수에 있는지 조회하시오

-- (1) 국어점수의 최소값
select min(kor) from sungjuk;   -- 20

-- (2) 수학 또는 영어점수에 있는지 
select uname, kor, eng, mat
from sungjuk
where mat<=20 or eng<=20;

          ↓
 
select uname, kor, eng, mat
from sungjuk
where mat<=(select min(kor) from sungjuk) 
      or 
      eng<=(select min(kor) from sungjuk);


















