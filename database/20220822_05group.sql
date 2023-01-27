
파일 → 새로만들기 → 데이터베이스계층 → 데이터베이스 파일
    i:\java202207\database\20220822_05group.sql
    
////////////////////////////////////////////////////////////////////////////////

● [데이터 그룹화]

-- sungjuk_seq시퀀스 삭제
drop sequence sungjuk_seq;

-sungjuk테이블에서 사용할 시퀀스 생성
create sequence sungjuk_seq;

--sungjuk테이블 삭제
drop table sungjuk;

--sungjuk테이블 생성
create table sungjuk(
     sno   int         primary key  
    ,uname varchar(50) not null     
    ,kor   int         check(kor between 0 and 100) 
    ,eng   int         check(eng between 0 and 100)
    ,mat   int         check(mat between 0 and 100)
    ,addr  varchar(20) check(addr in('Seoul', 'Jeju', 'Busan', 'Suwon'))
    ,tot   int         default 0
    ,aver  int         default 0   
    ,wdate date        default sysdate 
);


-- sungjuk테이블 입력 데이터
※ 참조 i:\java202207\database\20220822_03성적테이블.sql

insert into sungjuk(sno, uname, kor, eng, mat, addr, wdate)
values(sungjuk_seq.nextval,'솔데스크', 90, 85, 95, 'Seoul',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'무궁화',40,50,20,'Seoul',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'진달래',90,50,90,'Jeju',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'개나리',20,50,20,'Jeju',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'봉선화',90,90,90,'Seoul',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'나팔꽃',50,50,90,'Suwon',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'선인장',70,50,20,'Seoul',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'소나무',90,60,90,'Busan',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'참나무',20,20,20,'Jeju',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'홍길동',90,90,90,'Suwon',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'무궁화',80,80,90,'Suwon',sysdate);

commit;
select count(*) from sungjuk;   --전체 레코드 개수
select * from sungjuk;

////////////////////////////////////////////////////////////////////////////////


● [distinct]
   - 칼럼에 중복 내용이 있으면 대표값 1개만 출력
   - 형식) distinct 칼럼명
   
select addr from sungjuk;   
select addr from sungjuk order by addr;      -- asc 생략가능
select addr from sungjuk order by addr asc;  -- 오름차순 
select addr from sungjuk order by addr desc; -- 내림차순

select distinct(addr) from sungjuk;
-- 중복값 1개씩만 나옴. 'Seoul', 'Jeju', 'Busan', 'Suwon' 4개만 출력된다.
select distinct(uname) from sungjuk;   
select uname from sungjuk;   
-- 이름은 중복값이 별로 없기 때문에 데이터 칼럼의 속성에 따라 사용성을 판단해야 한다.

////////////////////////////////////////////////////////////////////////////////

● [group by] ★ 자주쓰이는 명령어
   - 칼럼에 동일 내용끼리 그룹화 시킴
   - 형식) group by 칼럼1, 칼럼2, 칼럼3, ~~~
   
   -- 칼럼1= 1차, 칼럼2= 2차, 칼럼3= 3차 그룹
   -- 그룹으로 묶고 통계,집계 낼 때 사용
   
   
-- 주소가 동일한 값을 그룹화 시키고 주소를 조회
select addr           -- ★ group by는 통계를 내는 것이기 때문에 select에는 결과값이 1개만 올 수 있다.
from sungjuk
group by addr;        -- distinct와 결과값 동일
-- 예를들어 ) 서울 지역을 묶고 국어점수 합계를 통계 내면 결과값은 1개만 나온다. 2개가 나올 수 없다. 당연함.

select addr, uname    
from sungjuk
group by addr;        -- 에러
-- ORA-00979: GROUP BY 표현식이 아닙니다. 00979. 00000 -  "not a GROUP BY expression"
-- uname 칼럼에서 이름은 중복값이 별로 없기 때문에 대표값 한개를 도출할 수 없다.
-- 따라서 그룹시키고 결과값이 1개만 나올 수 있는 칼럼만 조회가 가능하다.



SELECT [GROUP BY 절에 지정된 컬럼1] [GROUP BY별로 집계할 값] 
FROM [테이블 명] 
GROUP BY [ 그룹으로 묶을 컬럼 값 ]



--함수 종류
count(*) - 개수 카운트 (+1씩)
sum() - 합계 (1+4+2...)
distinct() - 중복값 합치기




////////////////////////////////////////////////////////////////////////////////

select addr 
from sungjuk 
order by addr;

-- 문1) 주소별 인원수를 조회하시오 //논리적 테이블, 재가공도 가능
select addr, count(*)
from sungjuk
group by addr;

select addr, count(*) as cnt    -- 칼럼명 임시 변경
from sungjuk
group by addr;

select addr, count(*) cnt       -- as 생략 가능
from sungjuk
group by addr;


-- 주소별 오름차순 정렬해서 조회
select addr
from sungjuk
group by addr 
order by addr;

-- 주소별 인원수를 내림차순으로 정렬해서 조회
select addr, count(*)
from sungjuk
group by addr 
order by count(*) desc;

select addr, count(*) as cnt    -- 해석순서 3)
from sungjuk                    -- 해석순서 1)
group by addr                   -- 해석순서 2)
order by count(*) desc;         -- 해석순서 4)

////////////////////////////////////////////////////////////////////////////////


● [집계함수]

-- 문2) 주소별 국어점수에 대해서 집계하시오.
-- 개수 count(), 최대값 max(), 최소값 min(), 합계 sum(), 평균 avg()
select addr, count(*), max(kor), min(kor), sum(kor), avg(kor)
from sungjuk
group by addr;

-- 주소순으로 정렬
select addr, count(*), max(kor), min(kor), sum(kor), avg(kor)
from sungjuk
group by addr
order by addr;

-- [round(값, 0)] 소수점 이하값에서 반올림하고 소수점 없음
-- [round(값, 1)] 소수점 00.0 까지 나옴.
select addr, count(*), max(kor), min(kor), sum(kor), round(avg(kor), 0)
from sungjuk
group by addr
order by addr;
-- 여기서 값을 다 만들어서(소수점 등) 자바로 가져오면 자바에서 할 일 덜어짐.


-- 국어 평균을 소수점 없이 반올림하고 내림차순으로 정렬해서 조회하시오
select addr, count(*), max(kor), min(kor), sum(kor), round(avg(kor), 0)
from sungjuk
group by addr
order by round(avg(kor), 0) desc;


-- 칼럼명 변경
select addr
    , count(*) as cnt
    , max(kor) as max_kor
    , min(kor) as min_kor
    , sum(kor) as sum_kor
    , round(avg(kor), 0) as avg_kor
from sungjuk
group by addr
order by round(avg(kor), 0) desc;

////////////////////////////////////////////////////////////////////////////////

--문3) 총점(tot), 평균(aver) 구하시오
update sungjuk set tot=kor+eng+mat, aver=(kor+eng+mat)/3;
select * from sungjuk;
-- 기존에 있던 것에 추가하는 것이 update



--문4) 평균(aver)이 80점이상 행을 대상으로 주소별 인원수를 인원수순으로 조회하시오.
-- (1) 평균이 80점 이상인 사람을 먼저 확인한다.
select addr,aver
from sungjuk
where aver>=80
order by aver desc;

-- (2) 주소별 인원수를 확인한다.
select addr, count(*)   -- 작성순서 4)
from sungjuk            -- 작성순서 1)
where aver>=80          -- 작성순서 2)
group by addr           -- 작성순서 3)
order by count(*);      -- 작성순서 5)

////////////////////////////////////////////////////////////////////////////////

● [2차그룹]

-- 주소별 순으로 조회하시오
select addr, kor, eng, mat 
from sungjuk 
order by addr, kor;


-- 주소별(1차) 그룹을 하고, 주소가 같다면 국어점수(2차)로 그룹화 하기
select addr, kor    -- group by는 select 할 때 그룹지어진 목록만 볼 수 있음.
from sungjuk
group by addr, kor
order by addr;


-- 1차로 그룹지어진 값을 또 조회하기
-- 제주도에 20점 맞은 사람 몇 명인지, 서울에서 90점 맞은 사람이 몇 명인지
select addr, kor, count(*) 
from sungjuk
group by addr, kor
order by addr;


select kor, eng, mat, count(*)
from sungjuk
group by kor, eng, mat    -- 국,영,수 점수가 같은 것 끼리 묶기 (=동점자 몇명인지 체크할 수 있음)
order by kor, eng, mat;

////////////////////////////////////////////////////////////////////////////////

● [having 조건절] + group by
   -- where 조건절 / on 조건절
   - where 조건절 쓰듯이 쓰면됨
   - having 조건절은 group by 와 같이 사용하는 조건절
   - 그룹화를 하고 난 후에 조건절을 추가
   
   -- where과 having의 차이
   -- where - group by : 조건 먼저 준 후 그룹화, 전체 테이블 자체에 먼저 조건을 줄 수 있다.
   -- group by - having : 그룹화 먼저 시킨 후 조건, 그룹화 되어진 새로운 테이블에 조건을 준다.
   
     <형식> having 조건절


--주소별 인원수를 조회하시오
select addr, count(*)
from sungjuk
group by addr;

--주소별 인원수가 3인 행을 조회하시오
select addr, count(*)
from sungjuk
group by addr
having count(*)=3;

-- 주소별 인원수가 3이상인 행을 조회하시오
select addr, count(*)
from sungjuk
group by addr
having count(*)>=3;




--문5) 주소별 국어평균값이 50이상 행을 조회하시오
--    (단, 평균값은 소수점없이 반올림)

1) 주소별 국어 평균값 구하기
select addr, avg(kor)
from sungjuk
group by addr;
-- 소수점이 떨어지지 않는다.


2) 국어 평균값 소수점 반올림하고 소수점은 없애기
select addr, round(avg(kor), 0)
from sungjuk
group by addr;
-- group by에 의해 도출된 테이블에서 조건을 추가한다.


3) 2번 결과에서 국어평균값이 50점 이상인(탤런트X) 조건 추가하기 (최최최종.sql)
select addr, round(avg(kor), 0)
from sungjuk
group by addr
having round(avg(kor), 0)>=50;
---> 이 값을 자바로 옮기는 것이당.


4) 3번 결과에서 국어평균값 기준으로 정렬하기 (진짜_최최최최종.sql)
select addr, round(avg(kor), 0)
from sungjuk
group by addr
having round(avg(kor), 0)>=50
order by round(avg(kor), 0) desc;


5) 4번 결과에서 국어평균값 칼럼명을 avg_kor로 변경 (진짜_진짜_최최최최종.sql)
select addr, round(avg(kor), 0) as avg_kor
from sungjuk
group by addr
having round(avg(kor), 0)>=50
order by round(avg(kor), 0) desc;




--문6) 평균(aver)이 70이상 행을 대상으로 주소별 인원수를 구한후
--     그 인원수가 2미만 행을 인원수 순으로 조회하시오

1) 전체 행을 조회해서 데이터를 파악한다.
select * from sungjuk; 
-- 전체데이터 11명을 대상으로 하는 것이 아닌 
-- aver 평균값에서 70이상인 데이터를 추려야함 (where 조건절 써야함)


2)  평균(aver)이 70이상 행을 대상
select *
from sungjuk
where aver>=70;
-- 6명으로 줄어든다.


3) 평균(aver)값이 70점 이상인 6명을 대상으로 주소별 인원수 그룹을 시킨다.
select addr, count(*)
from sungjuk
where aver>=70
group by addr;


4) 3번의 결과에서 그 인원수가 2미만 행 조회
select addr, count(*)
from sungjuk
where aver>=70
group by addr
having count(*)<2;


5) 4번의 결과를 인원수 순으로 조회
select addr, count(*) as cnt
from sungjuk
where aver>=70
group by addr
having count(*)<2
order by cnt;       --order by count(*) 써도됨

////////////////////////////////////////////////////////////////////////////////

● [CASE WHEN ~ THEN END 구문]
   <형식>
     CASE WHEN 조건1 THEN 조건만족시 값1
          WHEN 조건2 THEN 조건만족시 값2
          WHEN 조건3 THEN 조건만족시 값3
             ...
          ELSE 값
     END 결과컬럼명


-- 이름, 주소를 조회하시오
select uname, addr from sungjuk;


    -- 데이터베이스에 정보를 저장할 때 남자/여자를 구분하고싶을 때 코드화시켜서 저장해야한다.
    -- 여자면 f, 남자면 m ==> 용량의 차이가 생긴다
    -- 사용자에게 보여줄 땐 여자, 남자로 보이도록 해준다.
    -- ==> 구분코드

    -- 영화예매 사이트 ==> 액션, 코믹, 애니메이션, 스릴러 등등 장르가 구분되어있다
    -- 한글로 쓰지않고 코드화 시킨다. act, com, ani, thr 

    -- 의류쇼핑몰 ==> 남/여 옷 구분, 아우터,상의,하의,악세사리 등
    
    -- 한글은 통계내기 어렵다. 구분코드로 바꿔서 저장하기
    
    
-- 이름, 주소를 조회하시오 (단, 주소는 한글로 바꿔서 조회)
select uname, addr, case when addr='Seoul' then '서울'
                         when addr='Busan' then '부산'
                         when addr='Suwon' then '수원'
                         when addr='Jeju'  then '제주'
                    end as juso
from sungjuk;





--문7)이름, 국어, 학점을 조회하시오
      학점 : 국어점수 90이상 'A학점'
                     80이상 'B학점'
                     70이상 'C학점'
                     60이상 'D학점'
                     나머지 'F학점'

1)        
select uname, kor, case when kor>=90 then 'A학점'
                        when kor>=80 then 'B학점'
                        when kor>=70 then 'C학점'
                        when kor>=60 then 'D학점'
                        else 'F학점'
                    end as grade
from sungjuk;


2)
select uname, kor, case when kor>=90 then 'A학점'
                        when kor>=80 then 'B학점'
                        when kor>=70 then 'C학점'
                        when kor>=60 then 'D학점'
                        else 'F학점'
                    end as 국어학점     --칼럼명 한글도 가능
from sungjuk;


3) between - and - 연산자도 쌉가능
select uname, kor, case when kor between 90 and 100 then 'A학점'
                        when kor between 80 and  89 then 'B학점'
                        when kor between 70 and  79 then 'C학점'
                        when kor between 60 and  69 then 'D학점'
                        else 'F학점'
                    end as 국어학점     --칼럼명 한글도 가능
from sungjuk;


4) 국어학점순으로 정렬하기
select uname, kor, case when kor between 90 and 100 then 'A학점'
                        when kor between 80 and  89 then 'B학점'
                        when kor between 70 and  79 then 'C학점'
                        when kor between 60 and  69 then 'D학점'
                        else 'F학점'
                    end as 국어학점     --칼럼명 한글도 가능
from sungjuk
order by 국어학점 desc;







