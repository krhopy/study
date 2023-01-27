
파일 → 새로만들기 → 데이터베이스계층 → 데이터베이스 파일
    i:\java202207\database\20220823_02오라클함수.sql
    
////////////////////////////////////////////////////////////////////////////////

● [오라클 함수]

1. 문자열 함수

-- 가상테이블 : dual
-- 테이블을 잠깐 확인할 때 가상으로 확인할 수 있도록 도와줌. 임시폴더

select lower('Hello World') from dual;          -- 전부 소문자로 변환
select upper('Hello World') from dual;          -- 전부 대문자로 변환
select length('Hello World') from dual;         -- 글자 개수
select substr('Hello World', 1, 5) from dual;    -- 문자열 자르기 (첫번째 글자부터 5개 자르기)
select instr('HelloWorld', '\') from dual;     -- 특정문자 위치 5
select lpad('SKY', 5, '*') from dual;           -- 5칸내에서 출력하고 왼쪽 빈칸은 *로 채움
select rpad('SKY', 5, '*') from dual;           -- 5칸내에서 출력하고 오른쪽 빈칸은 *로 채움
select replace('happy', 'p', 'k') from dual;    -- 특정문자 변환


-- ASCll 문자변환
select chr(65) from dual;   -- A
select chr(66) from dual;   -- B
select chr(97) from dual;   -- a
select chr(98) from dual;   -- b
-- ASCll : 아스키문자
-- 알파벳에 정수값을 붙여넣은 것


-- concat() : 문자열 붙여줌, 연결하기
select concat('로미오', '줄리엣') from dual;  --로미오줄리엣
select concat(uname, '의 평균은'), concat(aver, '입니다.') from sungjuk;   
--concat(칼럼명, '문자열')로 테이블에 문장처럼 넣을 수 있다.


-- || 결합연산자
select uname || '의 평균은 ' || aver || '입니다.' from sungjuk;
select uname || '의 평균은 ' || aver || '입니다.' as str from sungjuk;

////////////////////////////////////////////////////////////////////////////////

2. 숫자 관련 함수

select abs(-7) from dual;           -- 7    / 절대값      
select mod(5,3) from dual;          -- 2    / 나머지 연산자      
select ceil(12.4) from dual;        -- 13   / 올림함수
select trunc(13.56, 1) from dual;   -- 13.5 / 내림함수

select avg(kor) from sungjuk;           -- 66.3636363636363636363636
select ceil(avg(kor)) from sungjuk;     -- 67
select trunc(avg(kor), 2) from sungjuk; -- 66.36
select round(avg(kor), 2) from sungjuk; -- 66.36


-- to_number('숫자형태의 문자열')
select to_number('123')+1 from dual;    -- 124
select '100'+1 from dual;               -- 124, 내부적으로 자동으로 to_number()함수 호출된다.
-- 자바스크립트에서는 문자열 + 숫자 1은 '1001' 로 도출되지만 오라클에선 자동으로 숫자로 변경되어 계산된다.

////////////////////////////////////////////////////////////////////////////////

3. 날짜 관련 함수 [sysdate - extract]

select sysdate from dual;   -- 시스템의 현재 날짜와 시간 정보를 리턴하는 함수


-- sysdate에서 년월일 추출하기
select extract(year from sysdate) from dual;     --2022
select extract(month from sysdate) from dual;    --8
select extract(day from sysdate) from dual;      --23
-- extract : 발췌, 초록, 추출


--날짜데이터의 연산
select sysdate+100 from dual;    -- 현재 날짜에서 100일 후 추가됨
select sysdate-100 from dual;    -- 현재 날짜에서 100일 전 날짜 출력됨


-- 두 개의 날짜데이터에서 며칠, 몇개월 차이가 나는지  months_
select months_between('2022-08-23', '2022-05-25') from dual;    --  2.93
select months_between('2022-08-23', '2022-12-25') from dual;    -- -4.06


-- 문자열을 날짜형으로 변환 to_date
select to_date('2022-10-25') from dual;                         -- 22/10/25
select to_date('2022-10-25') - to_date('2022-10-30')from dual;  -- -5

////////////////////////////////////////////////////////////////////////////////

● [ nvl() 함수 ] - null값을 다른값으로 바꿈 ★ 많이  사용하는 함수
   - 0 값은 replce함수로 변경
   
-- 문제) 주소가 'Incheon'인 행의 국어점수 최대값, 인원수을 조회하시오
select max(kor), count(*)
from sungjuk
where addr='Incheon';       --최대값(null), 인원수(0)


select count(*)+1           -- 0+1
from sungjuk
where addr='Incheon';


select max(kor)+1           -- null+1 = null  → null값과 연산할 수 없다.
from sungjuk
where addr='Incheon';


select nvl(max(kor), 0)     -- null값이면 0으로 대체해주세요.
from sungjuk
where addr='Incheon';


select nvl(max(kor), 0)+1
from sungjuk
where addr='Incheon';


select nvl(max(kor), 0)+1 as max_kor   -- as 이름 임시 변경
from sungjuk
where addr='Incheon';

////////////////////////////////////////////////////////////////////////////////

● [모조 칼럼]
   - 진짜는 아니지만 진짜처럼 사용할 수 있는 칼럼
   - 칼럼: 테이블을 구성하고 있는 한 칸, 같은 성격의 유형끼리 모아놓은
   
   - ★ rownum : 행번호
   - rowid     : 행의 주소값
   
-- sno은 시퀀스에서 번호를 뽑아오는 것, 우리가 필요해서 번호를 넣은것, 우리가 물리적으로 붙여주는 것.
-- rownum 은 그냥 행에다 번호붙여주는 것, 겹치지않게 해준다. 오라클DB에서 붙여주는 값.
   
   
select sno, uname, addr, rownum, rowid
from sungjuk;


select sno, uname, addr, rownum
from sungjuk
where rownum>=1 and rownum<=5; 
-- rownum이 1보다 크고 5보다 작은 숫자 도출
   
   
select sno, uname, addr, rownum
from sungjuk
where addr='Seoul';
-- 그냥 현재 있는 행에 순서대로 번호를 붙여줌


select sno, uname, addr, rownum
from sungjuk
order by uname;
-- rownum 순서 뒤죽박죽함.
-- oreder by 와 함께 붙이면 자신의 행번호를 포함해서 정렬된다.






