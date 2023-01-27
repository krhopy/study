
파일 → 새로만들기 → 데이터베이스계층 → 데이터베이스 파일
    i:\java202207\database\20220822_01정렬.sql
    
////////////////////////////////////////////////////////////////////////////////

● [수업내용]
   - sort 정렬
   - 테이블 수정
   - 시퀀스
   
→ 데이터베이스에서 데이터를 가지고올 때 정렬을 해서 가져와야한다.
→ 그래야 자바나 JSP에서 사용하기 쉽다.
   
////////////////////////////////////////////////////////////////////////////////

● [Sort 정렬]
   - 특정값(keyfield)을 기준으로 순서대로 재배치
   - 오름차순(Ascending Sort)   ASC   : <생략하면 기본값>  
     -- 갈수록 숫자가 올라감 1→10, A→Z, a→z, ㄱ→ㅎ
   - 내림차순(Descending Sort)  DESC  
     -- 날짜기준으로 최신순으로 가장 위에 올리려면 내림차순 사용
     
    <형식>
    order by 칼럼명1                      --1차정렬 ex)남자,여자
    order by 칼럼명1, 칼럼명2, 칼럼명3, ~~~ --2차정렬(1차정렬을 기준으로 만들어야함) ex)남자10대, 여자10대
    

-- sungjuk테이블을 조회하시오.
select * from sungjuk;


-- 전체 레코드를 이름순으로 정렬해서 조회하시오. (기본은 오름차순)
select uname
from sungjuk
order by uname asc;  -- 오름차순 정렬

select uname
from sungjuk
order by uname;      -- asc 오름차순은 기본이기때문에 생략가능하다.

select uname
from sungjuk
order by uname desc; -- 내림차순 정렬



-- 국어점수 순으로 정렬해서 조회하시오.
select uname, kor
from sungjuk
order by kor;   -- 국어점수 동점인 사람들이 있다. ==> 2차정렬


-- 1차 정렬 : 국어점수순으로 정렬
-- 2차 정렬 : 국어점수가 같다면 이름을 기준으로 내림차순 정렬
select uname, kor
from sungjuk
order by kor, uname desc;


-- 1차(kor), 2차(eng), 3차(mat) 정렬
select uname, kor, eng, mat
from sungjuk
order by kor desc, eng desc, mat desc;   
-- 국어점수도 같고 영어점수도 같다면 수학점수 기준으로 내림차순

////////////////////////////////////////////////////////////////////////////////

select * from sungjuk;

-- 문제) 평균 70점 이하 행을 이름순으로 조회하시오

-- 1. 평균 70점 이하행 조회
   -- (한 번에 값을 조회하려 하지말고 한 줄씩 조회해가면서 확인하기.)
select uname, aver
from sungjuk
where aver<=70;

-- 2. 평균 70점 이하 + 이름 오름차순 조회
   -- 세미콜론은 하나의 덩어리가 끝났을 때 하나만 작성 (중간에 끼지않게 주의)
select uname, aver
from sungjuk
where aver<=70
order by uname;

-- 예외) 에러! ORA-00933
    -- 에러날 때 위의 이름으로 검색해보기.
select uname, aver
from sungjuk
order by uname
where aver<=70;   -- ★ 정렬은 후순위. 조건을 "먼저" 주고 정렬을 한다.

////////////////////////////////////////////////////////////////////////////////

● [alter 문] - 테이블의 구조 수정 및 변경
   --> 왼쪽에있는 접속 칸에서 테이블 수정할 수 있다.
1. 컬럼 추가
   형식) alter table table명 add (컬럼명 데이터타입);
   
   -- music 칼럼 추가
   alter table sungjuk add(music int null);
   select * from sungjuk;


2. 컬럼명 수정  -- 여기서는 as처럼 일시적 변경이 아닌 완전 변경된다.
   형식) alter table table명 rename column 원래컬럼명 to 바꿀컬럼명;
   
   -- 국어 칼럼 kor을 korea칼럼명으로 수정하시오.
   alter table sungjuk rename column kor to korea;
   select * from sungjuk;


3. 컬럼 데이터 타입 수정
   형식) alter table table명 modify(컬럼명 데이터타입);
   
   -- music 칼럼의 자료형을 varchar로 수정하시오.
   alter table sungjuk modify(music varchar(5));
   select * from sungjuk;
   

4. 컬럼 삭제
   형식)alter table table명 drop(컬럼명);
   
   -- music 칼럼을 삭제하시오.
   alter table sungjuk drop(music);
   select * from sungjuk;

