
파일 → 새로만들기 → 데이터베이스계층 → 데이터베이스 파일
    i:\java202207\database\20220826_01테이블조인.sql
    
////////////////////////////////////////////////////////////////////////////////


● [테이블 조인]
   - 여러 테이블을 하나의 테이블처럼 사용하는 조인
   - 두 개 이상의 테이블을 결합하여 데이터를 추출하는 기법
   - 두 테이블의 공통값을 이용하여 컬럼을 조합하는 수단
   
   [형식]
          select 칼럼명
          from 테이블1 join 테이블2 
          on 조건절;                      -- ANSI (표준) SQL문

          
          select 칼럼명
          from 테이블1, 테이블2 
          on 조건절;                      -- Oracle DB SQL문
          
          
          select T1.*, T2.*               -- T1.모든칼럼, T2.모든칼럼
          from T1 join T2
          on T1.x=T2.x;                   --테이블명, 칼럼명


          select T1.*, T2.*, T3.*
          from T1 join T2
          on T1.x=T2.x join T3            --3개 테이블 조인
          on T1.y=T3.y;


          select T1.*, T2.*, T3.*, T4.*   --4개 테이블 조인
          from T1 join T2
          on T1.x=T2.x join T3         
          on T1.y=T3.y join T4
          on T1.z=T4.z;


● [조건절] 
     - where 조건절
     - having 조건절
     - on 조건절       --  (같은 칼럼을 찾는 것)


● 물리적 테이블과 논리적 테이블은 서로 동등한 관계이다.
    - 물리적 테이블 : 실제 create table한 테이블
    - 논리적 테이블 : SQL문에 의해 가공된 테이블
    
    select * from tb_student;          -- 물리적 테이블
    select count(*) from tb_student;   -- 논리적 테이블
    
////////////////////////////////////////////////////////////////////////////////


● inner join 연습

-- 학번을 기준으로 수강테이블과 학생테이블 조인
select tb_sugang.*, tb_student.*
from tb_sugang join tb_student
on tb_sugang.hakno = tb_student.hakno;


-- inner join : 두 테이블간의 교집합 조인. inner 생략가능. 가장 기본. default 
select tb_sugang.*, tb_student.*
from tb_sugang inner join tb_student
on tb_sugang.hakno = tb_student.hakno;


-- 수강신청한 학생들의 학번, 과목코드, 이름, 이메일 조회하시오 
select tb_sugang.*, tb_student.uname, tb_student.email
from tb_sugang inner join tb_student
on tb_sugang.hakno = tb_student.hakno;


select tb_sugang.hakno, tb_sugang.gcode, tb_student.uname, tb_student.email
from tb_sugang inner join tb_student
on tb_sugang.hakno = tb_student.hakno;


-- 과목코드를 기준으로 수강테이블과 과목테이블 조인

select tb_sugang.*, tb_gwamok.gname, tb_gwamok.ghakjum
from tb_sugang inner join tb_gwamok
on tb_sugang.gcode=tb_gwamok.gcode;


-- 3개 테이블 조인 : 수강테이블 + 학생테이블 (이름) + 과목테이블 (과목명)
select tb_sugang.*, tb_student.uname, tb_gwamok.gname
from tb_sugang join tb_student
on tb_sugang.hakno=tb_student.hakno join tb_gwamok
on tb_sugang.gcode=tb_gwamok.gcode;


-- 테이블명의 alias(별칭)도 가능하다 (테이블명 변경 가능)
-- 대소문자 구분하지않고 모두 적용됨
select SU.*, ST.uname, ST.email
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno;


select SU.*, GW.gname, GW.ghakjum
from tb_sugang SU join tb_gwamok GW
on SU.gcode=GW.gcode;


select SU.*, ST.uname, ST.email, GW.gname, GW.ghakjum
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno join tb_gwamok GW
on SU.gcode=GW.gcode;



-- 조회시 테이블간에 중복되지 않은 칼럼명은 테이블명을 생략할 수 있다.
select SU.*, uname, email, gname, ghakjum
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno join tb_gwamok GW
on SU.gcode=GW.gcode;


-- 중복되는 칼럼명(hakno, gcode)은 소속테이블명이 정확히 명시해야한다.
-- ORA-00918: 열의 정의가 애매합니다
select hakno, gcode, uname, email, gname, ghakjum
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno join tb_gwamok GW
on SU.gcode=GW.gcode;


select SU.hakno, SU.gcode, uname, email, gname, ghakjum
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno join tb_gwamok GW
on SU.gcode=GW.gcode;

////////////////////////////////////////////////////////////////////////////////


● [테이블 조인 연습]

-- 전체 행 갯수
select count(*) from tb_student;    -- 6
select count(*) from tb_gwamok;     -- 9
select count(*) from tb_sugang;     -- 13



문1)수강신청을 한 학생들 중에서 '제주'에 사는 학생들만 학번, 이름, 주소를 조회하시오

-- (1) 수강신청을 한 학생들 중에서 = inner join 사용해야함
-- (2) [수강테이블]과 학번,이름,주소 칼럼이 있는 [학생테이블]을 join
-- (3) '제주'에 사는 학생들만 = where 절 사용


-- 수강신청한 학생들 목록 보기 // 학생테이블에서 주소 끌어와야함
select * from tb_sugang;


-- 수강테이블 + 학생테이블
select SU.*, ST.uname, ST.address
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno;


-- '제주'만 조회하기
select SU.*, ST.uname, ST.address
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno
where address='제주';


-- 칼럼을 오픈시키고 *을  써도되는데, 칼럼명이 숨겨짐
select SU.hakno, SU.gcode, uname, address
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno;


-- 가공된 논리적 테이블의 이름을 AA라고 지정하고, 다시 재가공 할 수 있다.
select AA.hakno, AA.gcode, AA.uname, AA.address      -- AA.email은 from안 select 조회 목록에 없기때문에 쓸 수 없음.
from (
        select SU.hakno, SU.gcode, uname, address
        from tb_sugang SU join tb_student ST
        on SU.hakno=ST.hakno
     ) AA
where AA.address='제주';



-- ORA-00904: "AA"."EMAIL": 부적합한 식별자
-- ST 테이블에서 email 칼럼을 가져오지 않았음
select AA.hakno, AA.gcode, AA.uname, AA.address, AA.email
from (
        select SU.hakno, SU.gcode, uname, address
        from tb_sugang SU join tb_student ST
        on SU.hakno=ST.hakno
     ) AA
where AA.address='제주';


-- AA 별칭 생략가능 / 하지만 별칭을 붙여주는게 식별하기 쉽다.
select hakno, gcode, uname, address
from (
        select SU.hakno, SU.gcode, uname, address
        from tb_sugang SU join tb_student ST
        on SU.hakno=ST.hakno
     ) 
where address='제주';


-- select * 도 가능하지만 from 안에 칼럼이 자세히 노출되어있어야 가능하다.
-- select SU.hakno, SU.gcode, ... (O)
-- select SU.* ST.* ...           (X)
select *
from (
        select SU.hakno, SU.gcode, uname, address
        from tb_sugang SU join tb_student ST
        on SU.hakno=ST.hakno
     ) 
where address='제주';



--------------------------------------------------------------------------------


문2) 지역별로 수강신청 인원수, 지역을 조회하시오
     서울 2명
     제주 1명
--1) 수강테이블 조회
select * from tb_sugang;


--2) 수강 신청한 학생들의 명단 (학번)
  -- 수강신청한 사람 4명
select * from tb_sugang order by hakno;


--3) 수강 신청한 학생들의 명단 (학번)과 수강신청한 사람들 그룹짓기
select hakno from tb_sugang order by hakno;
select distinct(hakno) from tb_sugang order by hakno;
select hakno from tb_sugang group by hakno; -- group by절은 내부적으로 정렬을 갖고있음


--4) 수강신청한 학번(AA)들의 주소를 학생테이블에서 가져오기
select AA.hakno, ST.address
from (
        select hakno from tb_sugang group by hakno
     ) AA join tb_student ST
on AA.hakno=ST.hakno;

 
--5) 4번의 결과를 BB테이블로 만든 후 주소별 그룹 후 행 개수 구하기 (최종)
select BB.address, count(*) || '명' as cnt
from (
        select AA.hakno, ST.address
        from (
               select hakno from tb_sugang group by hakno
             ) AA join tb_student ST
        on AA.hakno=ST.hakno
     ) BB 
group by BB.address;



-------------------------------------------- (1)

select AA.address, count(*) || '명'
from(
    select SU.hakno, address
    from tb_sugang SU join tb_student ST
    on SU.hakno = ST.hakno
    group by SU.hakno, address
     ) AA
group by AA.address;


--------------------------------------------- (2)

select ST.address, count(distinct(ST.hakno))
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno
group by address;

--------------------------------------------- (3)

SELECT
    address,
    count(*)
FROM
    (
        SELECT
            DISTINCT SU.hakno,
            address
        FROM
            tb_sugang SU
            JOIN tb_student ST ON SU.hakno = ST.hakno
    )
GROUP BY
    address;


     
select ST.address, count(*)
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno
group by address;


--------------------------------------------------------------------------------
     

문3) 과목별 수강 신청 인원수, 과목코드, 과목명를 조회하시오 
     d001 HTML   2명 
     d002 포토샵   1명
     p001 OOP    2명

--1) 수강테이블에서 과목코드 정렬해서 조회하기     
select * from tb_sugang order by gcode;


--2) 수강테이블에서 과목코드가 동일한 행을 그룹
     -- gcode만 보고는 과목명이 무엇인지 알 수 없음
select gcode, count(*)
from tb_sugang
group by gcode;

-- 3) 2번의 결과를 AA테이블로 생성하고

select AA.gcode, GW.gname, concat(AA.cnt, '명')
from (
        select gcode, count(*) as cnt
        from tb_sugang
        group by gcode
     )AA join tb_gwamok GW
on AA.gcode=GW.gcode
order by AA.gcode;
     
     
     

-- 내가 작성한 코드 
select GW.gcode, GW.gname, count(*) || '명'as cnt
from tb_gwamok GW join tb_sugang SU
on GW.gcode=SU.gcode
group by GW.gcode, GW.gname
order by GW.gcode;
     
     

--------------------------------------------------------------------------------

     
문4) 학번별 수강신청과목의 총학점을 학번별순으로 조회하시오
     g1001  홍길동  9학점
     g1002  홍길동  6학점
     g1005  진달래  9학점
     
    
-- 1) 수강테이블에서 학번별로 조회
-- 학점을 가져오려면 과목테이블을 조인해야함.
select hakno, gcode from tb_sugang order by hakno;


-- 2) 수강테이블에 과목코드가 일치하는 학점을 과목테이블에서 가져와서 붙이기
select SU.hakno, SU.gcode, GW.ghakjum
from tb_sugang SU join tb_gwamok GW
on SU.gcode=GW.gcode;


-- 학번이 같은 애들끼리 그룹을 묶고 학점을 sum(더하기)을 주면 된다.
-- 3) 2번의 결과를 AA테이블로 만들고, 학번별로 그룹화한 후, 학점의 합계를 구하기
select AA.hakno, sum(ghakjum)
from (
        select SU.hakno, SU.gcode, GW.ghakjum
        from tb_sugang SU join tb_gwamok GW
        on SU.gcode=GW.gcode
      )AA 
group by AA.hakno;
-- 이름이 없다.
-- BB테이블을 만들어서 학생테이블을 조인해준다.


-- 4) 3번의 결과를 BB테이블로 만들고, 학번을 기준으로 학생테이블에서 이름 가져와서 붙이기
select BB.hakno, concat(BB.hap, '학점'), ST.uname
from (
        select AA.hakno, sum(ghakjum) as hap
        from (
               select SU.hakno, SU.gcode, GW.ghakjum
               from tb_sugang SU join tb_gwamok GW
               on SU.gcode=GW.gcode
            )AA 
        group by AA.hakno
     ) BB join tb_student ST
on BB.hakno=ST.hakno;



-- 이건 내가 만든 코드.. ㅠㅠ 틀렸음
select ST.hakno, ST.uname, count(*) || '학점'
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno join tb_gwamok GW
on SU.gcode=GW.gcode
group by ST.hakno, ST.uname
order by ST.hakno;
     

--------------------------------------------------------------------------------

문4)의 또다른 방법

-- 1) 수강테이블 + 학생테이블 + 과목테이블 3개 테이블 한꺼번에 조인
select SU.hakno, SU.gcode, ST.uname, GW.ghakjum
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno join tb_gwamok GW
on SU.gcode=GW.gcode
order by SU.hakno;

-- 학번 같은 애들끼리 그룹을 짓고, 학점을 sum(합치기)하면 된다.
-- 2) 1차그룹 (학번), 2차 그룹(이름)으로 그룹화하고, 총학점 구하기
--    학번을 기준으로 1차정렬하고, 이름을 기준으로 2차정렬을 한다. 
select SU.hakno, ST.uname, sum(GW.ghakjum) || '학점' as hap
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno join tb_gwamok GW
on SU.gcode=GW.gcode
group by SU.hakno, ST.uname
order by SU.hakno;


--------------------------------------------------------------------------------
     

문5) 학번 g1001이 수강신청한 과목을 과목코드별로 조회하시오
     g1001  p001  OOP
     g1001  p003  JSP  
     g1001  d001  HTML
     
     
-- 1) 수강테이블 + 과목테이블 조인
select SU.hakno, SU.gcode, GW.gname
from tb_sugang SU join tb_gwamok GW
on SU.gcode=GW.gcode;


-- 2) 학번 g1001이 신청한 정보 조회하기
select SU.hakno, SU.gcode, GW.gname
from tb_sugang SU join tb_gwamok GW
on SU.gcode=GW.gcode
where SU.hakno='g1001'               -- 실제 자바코드에서 학번을 변수처리한다.
order by SU.gcode;



select SU.hakno, GW.gcode, GW.gname
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno join tb_gwamok GW
on SU.gcode=GW.gcode
where SU.hakno='g1001'
order by GW.gcode;

    
--------------------------------------------------------------------------------
     

문6)수강신청을 한 학생들의 학번, 이름 조회

-- 1) 수강신청을 한 학생들의 학번 조회 (서브쿼리 사용)

select hakno from tb_sugang;
select distinct(hakno) from tb_sugang;
select hakno from tb_sugang group by hakno;


-- 2) or 연산자 (비추)
select hakno, uname
from tb_student
where hakno='g1001' or hakno='g1002' or hakno='g1005' or hakno='g1006';



-- 3) in 연산자 (비추)
select hakno, uname
from tb_student
where hakno in ('g1001', 'g1002', 'g1005', 'g1006');



-- 4) 3번의 in 안에 1번 마지막 코드 넣으면 똑같이 도출된다.
select hakno, uname
from tb_student
where hakno in (select hakno from tb_sugang group by hakno);



select SU.hakno, ST.uname
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno
group by SU.hakno, ST.uname
order by SU.hakno;


--------------------------------------------------------------------------------



문7)수강신청을 하지 않은 학생들의 학번, 이름 조회
select * from tb_student;
select * from tb_sugang;


-- 문7의 4)에서 not만 붙이면 된다.
select hakno, uname 
from tb_student
where hakno not in (select hakno from tb_sugang group by hakno);









select ST.hakno, ST.uname
from tb_student ST left join tb_sugang SU
on ST.hakno=SU.hakno
where SU.hakno is null;











select ST.hakno, ST.uname
from tb_student ST left join tb_sugang SU
on ST.hakno=SU.hakno
where SU.hakno is null;



select ST.hakno, ST.uname
from tb_student ST join tb_sugang SU
on ST.hakno=SU.hakno;
where SU.hakno not in (
                        select ST.hakno, ST.uname
                        from tb_student ST join tb_sugang SU
                        on ST.hakno=SU.hakno
                        );





s